//
//  BeefDataEntryReviewDataIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 26/03/25.
//

import Foundation
import UIKit
import DropDown
import CoreData

// MARK: - CLASS
class BeefDataEntryReviewDataIpad: UIViewController{
    
    // MARK: - IB OUTLETS
    @IBOutlet weak var ascendingImgView: UIImageView!
    @IBOutlet weak var descendingImgView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var emailCheckImg: UIImageView!
    @IBOutlet weak var cartByView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
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
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var sortByBeefView: UIView!
    @IBOutlet weak var sortByDairyView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var earTagImgView: UIImageView!
    @IBOutlet weak var barcodeImgView: UIImageView!
    @IBOutlet weak var ascendingBtnOutlet: UIButton!
    @IBOutlet weak var decendingBtnOutlet: UIButton!
    @IBOutlet weak var sortByAscendingImgView: UIImageView!
    @IBOutlet weak var sortByDescendingImgView: UIImageView!
    @IBOutlet weak var sortByAscendingBrazilImgView: UIImageView!
    @IBOutlet weak var sortByDescendingBrazilImgView: UIImageView!
    @IBOutlet weak var sortByBrazilView: UIView!
    @IBOutlet weak var sortByBrazilBarcodeBtn: UIButton!
    @IBOutlet weak var sortByBrazilBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByAnimalIDBtn: UIButton!
    @IBOutlet weak var sortByAnimalIDImgView: UIImageView!
    @IBOutlet weak var sortByRGNBtn: UIButton!
    @IBOutlet weak var sortByRGNImgView: UIImageView!
    @IBOutlet weak var sortBySeriesImgView: UIImageView!
    @IBOutlet weak var sortBySeriesBtn: UIButton!
    
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
    var ascendingFound = Bool()
    
    
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
            self.cartByView.isHidden = true
        }
    }
    
    // MARK: - INITIAL UI AND OTHER METHODS
    func setButtonState(button : UIButton, isOn : Bool) {
        if isOn {
            button.isSelected = true
            button.backgroundColor = UIColor(red: 1, green: 92/255, blue: 6/255, alpha: 1.0)
            button.layer.borderColor = UIColor.clear.cgColor
            button.setTitleColor(UIColor.white, for: .selected)
        }
        else {
            button.isSelected = false
            button.backgroundColor = UIColor.clear
            button.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
            button.setTitleColor(UIColor.black, for: .normal)
            
        }
    }
    func setInitialUI(){
        searchTextField.setLeftPaddingPoints(20.0)
        bottomView.layer.shadowColor = UIColor.gray.cgColor
        bottomView.layer.shadowOpacity = 5
        bottomView.layer.shadowOffset = CGSize.zero
        bottomView.layer.shadowRadius = 35
        emailMeEnterData.text = ButtonTitles.emailEnteredData.localized
        let perfernce = UserDefaults.standard.value(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue) as? String
        
        if perfernce == LocalizedStrings.animalTagStr.localized{
            self.clickOnDropDown = LocalizedStrings.animalTagStr
            
        } else if perfernce == keyValue.barcode.rawValue || pviduser == 6 && perfernce == keyValue.capsFarmId.rawValue{
            self.clickOnDropDown = ButtonTitles.barcodeText
            
        } else if perfernce == ButtonTitles.earTagText || perfernce == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
            self.clickOnDropDown = ButtonTitles.earTagText
            
        }
        else if perfernce == NSLocalizedString(LocalizedStrings.RGNText, comment: ""){
            self.clickOnDropDown = LocalizedStrings.RGNText
            
        }  else if perfernce == NSLocalizedString(LocalizedStrings.RGDText, comment: "") || perfernce == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
            self.clickOnDropDown = LocalizedStrings.RGDorAnimalIDText
            
        } else if perfernce == NSLocalizedString(LocalizedStrings.seriesText, comment: "") {
            self.clickOnDropDown = LocalizedStrings.seriesText
            
        }
        
        if pviduser == 7 && (perfernce == "" || perfernce == nil){
            self.clickOnDropDown = LocalizedStrings.animalTagStr
            
        }
        if pviduser == 5 && (perfernce == "" || perfernce == nil){
            self.clickOnDropDown = ButtonTitles.earTagText
            
        }
        if pviduser == 6 && (perfernce == "" || perfernce == nil){
            self.clickOnDropDown = ButtonTitles.barcodeText
            
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
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
        let vc = UIStoryboard.init(name: "DataEntryBeefiPad", bundle: Bundle.main).instantiateViewController(withIdentifier: "DataEntryBeefViewAnimalList") as? DataEntryBeefViewAnimalList
        vc?.delegateCustom = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func sortByAction(_ sender: UIButton) {
        
        if pviduser == 6{
            sortByBrazilView.isHidden = false
            self.backgroundView.isHidden = false
            sortByView.isHidden = true
        } else {
            sortByView.isHidden = false
            self.backgroundView.isHidden = false
            sortByBrazilView.isHidden = true
        }
        
    }
    @IBAction func sortByEarTagAction(_ sender: UIButton) {
        if earTagImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.barcodeImgView.image = UIImage(named: "radioBtn")
            self.earTagImgView.image = UIImage(named: "radioSeletedBtn")
            UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
        }
        
        
        
    }
    @IBAction func sortByBarCodeTagAction(_ sender: UIButton) {
        if barcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.barcodeImgView.image = UIImage(named: "radioSeletedBtn")
            self.earTagImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
        }
    }
    @IBAction func sortByAscending(_ sender: UIButton) {
        if sender.tag == 100{
            ascendingFound = false
            self.sortByAscendingImgView.image = UIImage(named: "radioBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioSeletedBtn")
        }
        else {
            ascendingFound = true
            self.sortByAscendingImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioBtn")
        }
    }
    @IBAction func sortByDecending(_ sender: UIButton) {
        if sender.tag == 100{
            ascendingFound = false
            self.sortByAscendingImgView.image = UIImage(named: "radioBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioSeletedBtn")
        }
        else {
            ascendingFound = true
            self.sortByAscendingImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioBtn")
        }
    }
    @IBAction func sortCrossButtonAction(_ sender: UIButton) {
        self.sortByView.isHidden = true
        self.backgroundView.isHidden = true
    }
    @IBAction func sortDoneButtonAction(_ sender: UIButton) {
        self.sortByView.isHidden = true
        self.backgroundView.isHidden = true
        
        
        
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        if pviduser == 4 {
            sortByBeefView.isHidden = false
            sortByDairyView.isHidden = true
        } else {
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                sortByBeefView.isHidden = false
            } else {
                sortByBeefView.isHidden = true
            }
        }
        if UserDefaults.standard.object(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue) as? String == keyValue.barcode.rawValue {
            self.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:ascendingFound,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId,flag:3, listId: self.listIdGet) as! [DataEntryBeefAnimaladdTbl]
            self.collectionView.reloadData()
            
        } else if UserDefaults.standard.object(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue) as? String == ButtonTitles.earTagText {
            
            self.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:ascendingFound,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId,flag: 2, listId: self.listIdGet) as! [DataEntryBeefAnimaladdTbl]
            self.collectionView.reloadData()
        }
        
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
    }
    //MARK: SORTING BRAZIL BEEF
    @IBAction func sortAscendingBrazilAction(_ sender: UIButton) {
        if sender.tag == 100{
            ascendingFound = false
            self.sortByAscendingBrazilImgView.image = UIImage(named: "radioBtn")
            self.sortByDescendingBrazilImgView.image = UIImage(named: "radioSeletedBtn")
        }
        else {
            ascendingFound = true
            self.sortByAscendingBrazilImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByDescendingBrazilImgView.image = UIImage(named: "radioBtn")
        }
    }
    @IBAction func sortBySeriesAction(_ sender: Any) {
        if sortBySeriesImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortBySeriesImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(false, forKey: "brazilBarcode")
            UserDefaults.standard.set(true, forKey: "series")
            UserDefaults.standard.set(LocalizedStrings.seriesText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
        }
        
    }
    
    @IBAction func sortByRGNAction(_ sender: Any) {
        if sortByRGNImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(LocalizedStrings.RGNText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
        }
    }
    
    
    
    @IBAction func sortByAnimalIDAction(_ sender: Any) {
        if sortByAnimalIDImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioSeletedBtn")
            UserDefaults.standard.set(LocalizedStrings.RGDText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
        }
    }
    
    @IBAction func sortByBrazilBarcodeAction(_ sender: Any) {
        if sortByBrazilBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
            UserDefaults.standard.set(true, forKey: "brazilBarcode")
        }
    }
    @IBAction func sortBrazilDoneButtonAction(_ sender: UIButton) {
        self.sortByBrazilView.isHidden = true
        self.backgroundView.isHidden = true
        
        
        
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        if UserDefaults.standard.object(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue) as? String == LocalizedStrings.seriesText {
            
            self.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:ascendingFound,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId,flag: 5, listId: self.listIdGet) as! [DataEntryBeefAnimaladdTbl]
            collectionView.reloadData()
            
        } else if UserDefaults.standard.object(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue) as? String == LocalizedStrings.RGNText {
            self.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:ascendingFound,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId,flag: 6, listId: self.listIdGet) as! [DataEntryBeefAnimaladdTbl]
            collectionView.reloadData()
            
        } else if UserDefaults.standard.object(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue) as? String == LocalizedStrings.RGDText {
            self.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:ascendingFound,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId,flag: 7, listId: self.listIdGet) as! [DataEntryBeefAnimaladdTbl]
            collectionView.reloadData()
        } else {
            self.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:ascendingFound,userId:userID ?? 0,farmId :self.searchTextField.text ?? "",customerId: currentCustomerId,flag:1, listId: self.listIdGet) as! [DataEntryBeefAnimaladdTbl]
            collectionView.reloadData()
        }
    }
    
    @IBAction func sortBrazilCrossButtonAction(_ sender: UIButton) {
        self.sortByBrazilView.isHidden = true
        self.backgroundView.isHidden = true
    }
    @IBAction func backBtnNavigateToAnimal(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DataEntryBeefiPad", bundle: Bundle.main)
        
        if pviduser == 5 {
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "DataEntryInheritBeefVC") as! DataEntryInheritBeefVC
            self.navigationController?.pushViewController(secondViewController, animated: false)
            
        }
        else if pviduser == 6 {
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "DEBrazilBeefVCIpad") as! DEBrazilBeefVCIpad
            self.navigationController?.pushViewController(secondViewController, animated: false)
        }
    }
    
    @IBAction func sortByDropDownAction(_ sender: UIButton) {
        sortByView.isHidden = false
        self.backgroundView.isHidden = false
        if pviduser == 4 {
            sortByBeefView.isHidden = false
            sortByDairyView.isHidden = true
        } else {
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                sortByBeefView.isHidden = false
            } else {
                sortByBeefView.isHidden = true
            }
        }
        
        
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
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
            
        } else {
            if self.unchecked  {
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.noEmailSent, comment: ""), preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default) { (action:UIAlertAction!) in
                    
                }
                alertController.addAction(cancelAction)
                let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action:UIAlertAction!) in
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 2, position: .top)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    }
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
                
                
            } else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 2, position: .top)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
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
            emailCheckImg.image = UIImage(named: "Incremental_Check")
        } else {
            unchecked = true
            emailCheckImg.image = UIImage(named: "incrementalCheckIpad")
   
        }
    }
}

// MARK: - TEXTFIELD DELEGATES
extension BeefDataEntryReviewDataIpad : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        
        collectionView.isHidden = false
        if newString != ""{
            
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                if pviduser == 6 {
                    reviewListArray = fetchDataEntryBarcodeBrazill(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                    
                    
                }else {
                    reviewListArray = fetchDataEntryBarcode(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                }
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == LocalizedStrings.animalTagStr || self.clickOnDropDown == LocalizedStrings.tatuagemAnimal{
                reviewListArray = fetchDataEntryOfficalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                reviewListArray = fetchDataEntryEarTagBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGNText, comment: ""){
                reviewListArray = fetchDataEntryDropDownRGN(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0,listId:Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "") {
                reviewListArray = fetchDataEntryDropDownRGd(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0,listId:Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.seriesText, comment: "") {
                reviewListArray = fetchDataEntryDropDownSeries(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    collectionView.isHidden = true
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
        collectionView.reloadData()
        return true
    }
}

// MARK: - SIDE MENU UI EXTENSION
extension BeefDataEntryReviewDataIpad : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension BeefDataEntryReviewDataIpad : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reviewListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ViewAnimalCelliPad = self.collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.beefCartCell, for: indexPath as IndexPath) as! ViewAnimalCelliPad
        let animalVal  =  reviewListArray[indexPath.row] as! DataEntryBeefAnimaladdTbl
        
        if  UserDefaults.standard.object(forKey: keyValue.chkValue.rawValue    ) as? String == "true" {
            if animalVal.isUpadte == "true"{
                if  animalVal.ageConf == "true" {
                    cell.sampleconLbl.text = ButtonTitles.ageLess35Days
                }
                else if animalVal.bothConf == "true" {
                    cell.sampleconLbl.text = ButtonTitles.differentSampleTypeAndAge
                }
                else if animalVal.sampTypeConf == "true" {
                    cell.sampleconLbl.text = ButtonTitles.differentSampleType
                }
                
            }
            else{
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
        }
        
        cell.barcodetitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if pvid == 5{
            cell.officialIdLbl.text = animalVal.animalTag
            cell.barcodeSeperator.isHidden = true
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            cell.rgnLbl.isHidden = true
            cell.rgdTitleLabel.isHidden = true
        }
        
        if pvid == 7{
            cell.earTagLbl.text = NSLocalizedString(LocalizedStrings.animalTagTattoo, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if pvid == 6 {
            cell.setViewForBeef()
            cell.dobTtileLbl.isHidden = false
            cell.dobTitle.isHidden = false
            cell.sexTitle.isHidden = false
            cell.sexTitleLbl.isHidden = false
            cell.earTagLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.barcodetitle.text = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
            cell.barcodeLbl.text = animalVal.offsireId
            cell.rgnLbl.text = animalVal.offPermanentId
            cell.rgdLbl.text = animalVal.offDamId
            cell.rgdTitleLabel.text  = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
            cell.rgnTitle.text = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
            cell.dobTtileLbl.text  = NSLocalizedString("DOB", comment: "")
            cell.dobTitle.text = animalVal.date != "" ? animalVal.date : NSLocalizedString("N/A", comment: "")
            cell.sexTitleLbl.text = NSLocalizedString(ButtonTitles.sexTest, comment: "")
            if animalVal.gender == NSLocalizedString(ButtonTitles.femaleText, comment: "")  ||  animalVal.gender == ButtonTitles.femaleText   {
                cell.sexTitle.text =  "F"
            }  else {
                cell.sexTitle.text =  "M"
            }
            cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if pvid == 13 {
            cell.earTagLbl.text = NSLocalizedString(ButtonTitles.uniqueIdText, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.barcodetitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            cell.rgnLbl.text = animalVal.sireIDAU
            cell.rgnTitle.text = "Visual ID".localized
            cell.sexTitleLbl.isHidden = true
            cell.sexTitle.isHidden = true
            cell.dobTtileLbl.isHidden = true
            cell.dobTitle.isHidden = true
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        if pvid == 5 || pvid == 13 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 120)
        }
        else if pvid == 7 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 100 )
        }
        
        else if pvid == 6 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 320)
        }
        
        else {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 150)
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

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension BeefDataEntryReviewDataIpad:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - SYNC API VIEW EXTENSION
extension BeefDataEntryReviewDataIpad : syncApi {
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
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        }
        
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
}

// MARK: - OBJECT PICK CART EXTENSION
extension BeefDataEntryReviewDataIpad : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
        
    }
}
