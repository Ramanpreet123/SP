//
//  DataEntryReviewDataiPadVC.swift
//  SearchPoint
//
//  Created by Rajni on 14/03/25.
//

import Foundation
import UIKit
import DropDown
import CoreData

// MARK: - CLASS

class DataEntryReviewDataiPadVC: UIViewController{
    
    // MARK: - OUTLETS
    @IBOutlet weak var descendingImgView: UIImageView!
    @IBOutlet weak var ascendingImgView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var descendingBtn: UIButton!
    @IBOutlet weak var ascendingBtn: UIButton!
    @IBOutlet weak var sortByOfficialIDImgView: UIImageView!
    @IBOutlet weak var sortByFarmIdImgVřew: UIImageView!
    @IBOutlet weak var sortByEarTagImgView: UIImageView!
    @IBOutlet weak var sortByBarcodeDairyImgView: UIImageView!
    @IBOutlet weak var sortByBarcodeBeefImgView: UIImageView!
    @IBOutlet weak var sortByBarcodeBeefbtn: UIButton!
    @IBOutlet weak var sortByEarTagbtn: UIButton!
    @IBOutlet weak var sortByOfficialIdbtn: UIButton!
    @IBOutlet weak var sortByFarmdIdbtn: UIButton!
    @IBOutlet weak var sortByBarcodeDairybtn: UIButton!
    @IBOutlet weak var sortByBeefView: UIView!
    @IBOutlet weak var sortByDairyView: UIView!
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var cartByView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totalAnimalTitleLbl: UILabel!
    @IBOutlet weak var animalLblCount: UILabel!
    @IBOutlet weak var reviewDataTitle: UILabel!
    @IBOutlet weak var backBtnOutlet: customButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sortByDropDownOutlet: UIButton!
    @IBOutlet weak var saveListOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var emailCheckImg: UIImageView!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var appStatusText: UILabel!
    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartButtonOutlet: UIButton!
    @IBOutlet weak var bckkkBtnOutlet: customButton!
    @IBOutlet weak var emailMeEnterData: UILabel!
    @IBOutlet weak var emailMeEnteredBtnOutlet: UIButton!
    @IBOutlet weak var statusBtn: UIButton!
    
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
        
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let animalCount =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false", listid: Int64(self.listIdGet ), custmerId: Int64(currentCustomerId), providerId: (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)))
        notificationCountLbl.text = String(animalCount.count)
        animalLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationCountLbl.isHidden = true
            self.cartByView.isHidden = true
        } else {
            notificationCountLbl.isHidden = false
            self.cartByView.isHidden = false
        }
    }
    
    // MARK: - INITIAL UI AND OTHER METHODS
    
    func setInitialUI(){
        bottomView.layer.shadowColor = UIColor.gray.cgColor
        bottomView.layer.shadowOpacity = 5
        bottomView.layer.shadowOffset = CGSize.zero
        bottomView.layer.shadowRadius = 35
        self.searchTextField.setLeftPaddingPoints(20.0)
        reviewDataTitle.text = NSLocalizedString(ButtonTitles.reviewDataText, comment: "")
        emailMeEnterData.text = LocalizedStrings.emailEnteredData.localized
        saveListOutlet.setTitle(LocalizedStrings.saveList.localized, for: .normal)
    
        currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        self.navigationController?.navigationBar.isHidden = true
        initialNetworkCheck()
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        reviewListArray = fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryAnimalAddTbl,customerId:currentCustomerId, listId: Int64(self.listIdGet)) as!  [DataEntryAnimaladdTbl]
        
        if pviduser == 4 {
            if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == keyValue.barcode.rawValue {
                clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
                
                self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    self.sortByBarcodeBeefImgView.image = UIImage(named: "radioSeletedBtn")
                } else {
                    self.sortByBarcodeDairyImgView.image = UIImage(named: "radioSeletedBtn")
                }
    
            }
            
            else if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == ButtonTitles.earTagText {
                clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
                } else {
                    self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
                }
            } else {
                clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
                } else {
                    self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
                }
            }
        }
        
        else if pviduser == 2 {
            clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
            self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
            } else {
                self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
            }
        }
        
        else {
          
            if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == keyValue.barcode.rawValue {
                clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
                
                self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    self.sortByBarcodeBeefImgView.image = UIImage(named: "radioSeletedBtn")
                } else {
                    self.sortByBarcodeDairyImgView.image = UIImage(named: "radioSeletedBtn")
                }
            }
            
            else if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String  == "officialId"{
                clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
                self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
                } else {
                    self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
                }
            }
            else if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String  == "farmid" {
                clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                self.sortByFarmIdImgVřew.image = UIImage(named: "radioSeletedBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
                } else {
                    self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
                }
            }
            
            else if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == ButtonTitles.earTagText {
                clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
                } else {
                    self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
                }
            } else {
                
                if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                    clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                    self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                    self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
                    self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                    if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                        self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
                    } else {
                        self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
                    }
                } else {
                    clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                    self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
                    self.sortByFarmIdImgVřew.image = UIImage(named: "radioSeletedBtn")
                    self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                    if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                        self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
                    } else {
                        self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
                    }
                }
                
            }
            
            
        }
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == "Connected".localized
        {
            self.statusBtn.isHidden = true
            self.connectionImg.image = UIImage(named: "status_online_sign")
        }
        else{
            
            self.statusBtn.isHidden = false
            self.connectionImg.image = UIImage(named: "status_offline")
            
        }
    }
    
    func setButtonState(button : UIButton, isOn : Bool) {
        button.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        if isOn {
            button.isSelected = true
         
        }
        else {
            button.isSelected = false
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
    @IBAction func bckBtnClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    @IBAction func bckBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    
    @IBAction func cartBttnAction(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "DataEntryiPad", bundle: Bundle.main).instantiateViewController(withIdentifier: "DataEntryListViewAnimalListiPadVC") as? DataEntryListViewAnimalListiPadVC
        vc?.delegateCustom = self
        vc!.dateEnteryReviewScreen = true
        vc!.animalBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func sortByEarTag(_ sender: UIButton) {
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
        
        UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
        self.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag: 4, listId: self.listIdGet) as! [DataEntryAnimaladdTbl]
        self.collectionView.reloadData()
        self.sortByBarcodeBeefImgView.image = UIImage(named: "radioBtn")
        self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
    }
    @IBAction func sortByFarmId(_ sender: UIButton) {
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
        
        UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
        
        self.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId :self.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:1, listId: self.listIdGet) as! [DataEntryAnimaladdTbl]
        self.collectionView.reloadData()
        self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
        self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
        self.sortByFarmIdImgVřew.image = UIImage(named: "radioSeletedBtn")
        
    }
    @IBAction func sortByOfficialID(_ sender: UIButton) {
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
        
        UserDefaults.standard.set("officialId", forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
        self.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId :self.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:2, listId: self.listIdGet) as! [DataEntryAnimaladdTbl]
        self.collectionView.reloadData()
        self.sortByBarcodeDairyImgView.image = UIImage(named: "radioBtn")
        self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
        
    }
    
    @IBAction func sortByBarcodeBeef(_ sender: UIButton) {
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        
        UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
        self.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:3, listId: self.listIdGet) as! [DataEntryAnimaladdTbl]
        self.collectionView.reloadData()
        self.sortByBarcodeBeefImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
        
    }
    
    @IBAction func sortByBarcodeDairy(_ sender: UIButton) {
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        
        UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
        self.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId : self.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:3, listId: self.listIdGet) as! [DataEntryAnimaladdTbl]
        self.collectionView.reloadData()
        self.sortByBarcodeDairyImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
        self.sortByFarmIdImgVřew.image = UIImage(named: "radioBtn")
        
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        sortByView.isHidden = true
        self.backgroundView.isHidden = true
    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        sortByView.isHidden = true
        self.backgroundView.isHidden = true
    }
    
    @IBAction func sortByAction(_ sender: UIButton) {
        
        sortByView.isHidden = false
        self.backgroundView.isHidden = false
        if pviduser == 4 {
            sortByBeefView.isHidden = false
            sortByDairyView.isHidden = true
        } else {
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                sortByBeefView.isHidden = false
                sortByDairyView.isHidden = true
            } else {
                sortByBeefView.isHidden = true
                sortByDairyView.isHidden = false
            }
        }
        
    }
    
    @IBAction func backBtnNavigateToAnimal(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
        if pviduser == 4 {
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "DEOAnimalVCGirlando") as! DEOAnimalVCGirlando
            self.navigationController?.pushViewController(secondViewController, animated: false)
            
        }else {
            
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "DataEntryOrderingAnimalVCIpad") as! DataEntryOrderingAnimalVCIpad
            self.navigationController?.pushViewController(secondViewController, animated: false)
        }
        
    }
    
    @IBAction func sortByDropDownAction(_ sender: UIButton) {
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
            if self.farmId == 0{
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryAnimaladdTbl]
                self.setButtonState(button: descendingBtn, isOn: false)
                self.setButtonState(button: ascendingBtn, isOn: true)
                self.ascendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.descendingImgView.image = UIImage(named: "radioBtn")
                self.farmId = 1
                self.collectionView.reloadData()
            }
            else {
                self.setButtonState(button: descendingBtn, isOn: true)
                self.setButtonState(button: ascendingBtn, isOn: false)
                self.descendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.ascendingImgView.image = UIImage(named: "radioBtn")
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet ))  as! [DataEntryAnimaladdTbl]
                self.farmId = 0
                self.collectionView.reloadData()
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
            if self.offcialId == 0{
                self.setButtonState(button: descendingBtn, isOn: false)
                self.setButtonState(button: ascendingBtn, isOn: true)
                self.ascendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.descendingImgView.image = UIImage(named: "radioBtn")
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.offcialId = 1
                self.collectionView.reloadData()
                
            }
            
            else{
                self.setButtonState(button: descendingBtn, isOn: true)
                self.setButtonState(button: ascendingBtn, isOn: false)
                self.descendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.ascendingImgView.image = UIImage(named: "radioBtn")
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                self.offcialId = 0
                self.collectionView.reloadData()
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "") {
            if self.barCodeId == 0{
                self.setButtonState(button: descendingBtn, isOn: false)
                self.setButtonState(button: ascendingBtn, isOn: true)
                self.ascendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.descendingImgView.image = UIImage(named: "radioBtn")
                
                self.reviewListArray = fetchDataEntryDropDownBarcode(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.barCodeId = 1
                self.collectionView.reloadData()
            }
            
            else{
                self.setButtonState(button: descendingBtn, isOn: true)
                self.setButtonState(button: ascendingBtn, isOn: false)
                self.descendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.ascendingImgView.image = UIImage(named: "radioBtn")
                self.reviewListArray = fetchDataEntryDropDownBarcode(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                self.barCodeId = 0
                self.collectionView.reloadData()
                
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
            if self.earTag == 0{
                self.setButtonState(button: descendingBtn, isOn: false)
                self.setButtonState(button: ascendingBtn, isOn: true)
                self.ascendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.descendingImgView.image = UIImage(named: "radioBtn")
                self.reviewListArray = fetchDataEntryDropDownEarTagg(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.earTag = 1
                self.collectionView.reloadData()
                
            }
            else{
                
                self.setButtonState(button: descendingBtn, isOn: true)
                self.setButtonState(button: ascendingBtn, isOn: false)
                self.descendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.ascendingImgView.image = UIImage(named: "radioBtn")
                self.reviewListArray = fetchDataEntryDropDownEarTagg(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.earTag = 0
                self.collectionView.reloadData()
                
            }
        }
        else {
            if self.farmId == 0{
                
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.setButtonState(button: descendingBtn, isOn: false)
                self.setButtonState(button: ascendingBtn, isOn: true)
                self.ascendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.descendingImgView.image = UIImage(named: "radioBtn")
                self.farmId = 1
                self.collectionView.reloadData()
            }
            
            else {
                
                self.setButtonState(button: descendingBtn, isOn: true)
                self.setButtonState(button: ascendingBtn, isOn: false)
                self.descendingImgView.image = UIImage(named: "radioSeletedBtn")
                self.ascendingImgView.image = UIImage(named: "radioBtn")
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet ))  as! [DataEntryAnimaladdTbl]
                self.farmId = 0
                self.collectionView.reloadData()
            }
        }
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
    
    @IBAction func saveListAction(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() {
            heartBeatViewModel?.callGetHearBeatData()
            
            if unchecked  {
                self.objApiSync.delegeteSyncApi = self
                showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.listSyncProgress, comment: ""), and: "")
                self.objApiSync.postListData(listId:Int64(listIdGet),custmerId:Int64(currentCustomerId))
            }
            else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 1, position: .top)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    
                    let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
        }
        
        else {
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
            }
            else {
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
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.dataEntryModeText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
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

// MARK: - OBJECT PICK CART SCREEN EXTENSION
extension DataEntryReviewDataiPadVC : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
        
    }
}

// MARK: - TEXTFIELD DELEGATE
extension DataEntryReviewDataiPadVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        collectionView.isHidden = false
        
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                reviewListArray = fetchDataEntryBarcode(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                reviewListArray = fetchDataEntryOfficalId(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") || self.clickOnDropDown == "" {
                reviewListArray =
                fetchDataEntryfarmId(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    
                    collectionView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                reviewListArray =  fetchDataEntryEaarTag(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0,listId:Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                if reviewListArray.count > 0{
                    collectionView.reloadData()
                }
                else{
                    
                    collectionView.isHidden = true
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
            collectionView.reloadData()
        }
        
        return true
    }
}

// MARK: - SIDE MENU UI EXTENSION
extension DataEntryReviewDataiPadVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
//MARK: COLLECTION VIEW DELEGATE AND DATASOURCES
extension DataEntryReviewDataiPadVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reviewListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ViewAnimalCelliPad = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ViewAnimalCelliPad
        let animalVal =  reviewListArray[indexPath.row] as! DataEntryAnimaladdTbl
        
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        if pviduser == 4 {
            cell.officialIdLbl.text = animalVal.animalbarCodeTag
            cell.farmIDLbl.text = animalVal.earTag
            cell.barcodeLbl.isHidden = true
            cell.barcodeLbl.isHidden = true
            cell.barcodeTtileLbl.isHidden = true
            cell.onFarmIdTitle.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        else {
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.barcodeLbl.isHidden = false
            cell.barcodeLbl.isHidden = false
            cell.barcodeTtileLbl.isHidden = false
            cell.onFarmIdTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodeTtileLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if pviduser == 4 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 120)
        }
        else if pviduser == 8 {
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


// MARK: - OFFLINE CUSTOMVIEW EXTENSION
extension DataEntryReviewDataiPadVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - SYNC API EXTENSION
extension DataEntryReviewDataiPadVC : syncApi {
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
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        }
        
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
    
}
