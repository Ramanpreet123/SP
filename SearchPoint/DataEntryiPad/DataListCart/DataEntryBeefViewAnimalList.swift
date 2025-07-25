//
//  DataEntryBeefViewAnimalList.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 26/03/25.
//

import Foundation
import UIKit
import Alamofire
import CoreData

// MARK: - CLASS
class DataEntryBeefViewAnimalList: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var noOrderLbl: UILabel!
    @IBOutlet weak var cartBttnOutlet: UIButton!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var networkImgStatus: UIImageView!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var cartTitle: UILabel!
    @IBOutlet weak var APPsTATUSlbl: UILabel!
    @IBOutlet weak var noAnimalToast: UILabel!
    @IBOutlet weak var clearOrderOutlet: UIButton!
    @IBOutlet weak var offlineBtnOutlet: UIButton!
    @IBOutlet weak var bckBtnOutlet: customButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var chekvale = String()
    var viewAnimalArray = NSArray()
    var delegateCustom : objectPickCartScreen?
    var screenBackSave = Bool()
    var productBackSave = Bool()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var listIdGet = Int()
    var listName = String()
    var customerId = Int()
    let beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    var objApiSync = ApiSyncList()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        initialNetworkCheck()
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        
        self.viewAnimalArray = beefFetchAllDataWithListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderStatus:"false",pvid :beefPvid,listid:Int64(listIdGet),custmerId:Int64(customerId))
        notificationLblCount.text = String(viewAnimalArray.count)
    }
    
    // MARK: - INITIAL UI AND OTHER METHODS
    func setInitialUI(){
        self.navigationController?.navigationBar.isHidden = true
    //    cartImage.isHidden = true
        UserDefaults.standard.setValue(nil, forKey: keyValue.submitTypeSelection.rawValue)
    //    clearOrderOutlet.setTitle("Clear List".localized, for: .normal)
        noAnimalToast.text = LocalizedStrings.noAnimalAdded.localized
    //    cartTitle.text = "List".localized
     //   bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
     //   APPsTATUSlbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtnOutlet.isUserInteractionEnabled = false
            networkImgStatus.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            networkImgStatus.image = UIImage(named: ImageNames.statusOfflineImg)
            self.offlineBtnOutlet.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification){
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
    
    @objc  func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtnOutlet.isUserInteractionEnabled = false
            networkImgStatus.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.offlineBtnOutlet.isUserInteractionEnabled = true
            networkImgStatus.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    // MARK: - IB ACTIONS
    @IBAction func backBtnClk(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderSaveViewController.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        if viewAnimalArray.count == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        else {
            self.delegateCustom?.anOptionalMethod?(check: true)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func clearOrder(_ sender: UIButton) {
        self.DeleteData(msg: LocalizedStrings.clearTheListStr)
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATE
extension DataEntryBeefViewAnimalList: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewAnimalArray.count
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ViewAnimalCelliPad = self.collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.beefCartCell, for: indexPath as IndexPath) as! ViewAnimalCelliPad
        let animalVal  =  viewAnimalArray[indexPath.row] as! DataEntryBeefAnimaladdTbl
        
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
                
           //     cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }
            else{
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
        }
        
        cell.barcodetitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if pvid == 5{
            cell.officialIdLbl.text = animalVal.animalTag
         //   cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeSeperator.isHidden = true
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
//          if animalVal.animalTag == "" || animalVal.animalTag ==  nil{
//            cell.innnerView.layer.borderColor = UIColor.red.cgColor
//          }
//           else if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
//                cell.innnerView.layer.borderColor = UIColor.red.cgColor
//            }
//            else {
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
          //  }
            cell.rgnLbl.isHidden = true
            cell.rgdTitleLabel.isHidden = true
       //     cell.rgdColonLbl.isHidden = true
        }
        
        if pvid == 7{
            cell.earTagLbl.text = NSLocalizedString(LocalizedStrings.animalTagTattoo, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
//            if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
//                cell.innnerView.layer.borderColor = UIColor.red.cgColor
//            }
//            else {
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
          //  }
        }
        
        if pvid == 6 {
            cell.setViewForBeef()
            cell.dobTtileLbl.isHidden = false
            cell.dobTitle.isHidden = false
         //   cell.dobColonLbl.isHidden = false
            cell.sexTitle.isHidden = false
            cell.sexTitleLbl.isHidden = false
       //     cell.sexColonLbl.isHidden = false
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
//            if animalVal.animalTag == "" || animalVal.animalTag == nil {
//                cell.innnerView.layer.borderColor = UIColor.red.cgColor
//            }
//            else {
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
           // }
        }
        
        if pvid == 13 {
            cell.earTagLbl.text = NSLocalizedString(ButtonTitles.uniqueIdText, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.barcodetitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
//            if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
//                cell.innnerView.layer.borderColor = UIColor.red.cgColor
//            }
//            else if animalVal.animalTag?.count ?? 0 < 15 ||  animalVal.animalTag?.count ?? 0 > 16 {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
         //   }
           // else {
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
          //  }
            cell.rgnLbl.text = animalVal.sireIDAU
            cell.rgnTitle.text = "Visual ID".localized
           // cell.rgdColonLbl.isHidden = false
            cell.sexTitleLbl.isHidden = true
            cell.sexTitle.isHidden = true
            cell.dobTtileLbl.isHidden = true
            cell.dobTitle.isHidden = true
        }
        cell.deleteAction = { [unowned self] ( error) in
            if viewAnimalArray.count == 1{
                    self.DeleteData(msg: LocalizedStrings.deleteLastAnimalStr)
            } else {
                let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalStr, comment: ""), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                }))
                
                refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
                        
                        let animalVal = self.viewAnimalArray[indexPath.row] as! DataEntryBeefAnimaladdTbl
                        self.objApiSync.postListDataDeleteBeef(listId:Int64(self.listIdGet),custmerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                        
                        if !Connectivity.isConnectedToInternet() {
                            saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: self.listIdGet, customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "", speciesID: SpeciesID.beefSpeciesId)
                        }
                        deleteDataWithProductBeefDelete(Int(animalVal.animalId))
                        deleteDataWithSubProductAnimalId(Int(animalVal.animalId))
                        beefDeleteDataWithAnimalDataEntryAnimalId(animalId: Int(animalVal.animalId))
                        self.viewAnimalArray = beefFetchAllDataWithListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderStatus:"false",pvid :self.beefPvid,listid:Int64(self.listIdGet),custmerId:Int64(self.customerId))
                        self.notificationLblCount.text = String(self.viewAnimalArray.count)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalRemovedStr, comment: ""), duration: 1, position: .bottom)
                        
                        if self.viewAnimalArray.count == 0 {
                            deleteDataProductWithListid(entityName: Entities.dataEntryBeefAnimalAddTblEntity,status: "false",listId:self.listIdGet)
                            deleteDataProduct(entityName:Entities.productAdonAnimlBeefTblEntity,status:"false")
                            deleteDataProduct(entityName:Entities.subProductBeefTblEntity, status: "false")
                            UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
                            UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
                            UserDefaults.standard.set("", forKey: keyValue.dataEntryNZBeeftsu.rawValue)
                            UserDefaults.standard.set("", forKey: keyValue.dataEntrygenotypeTissueBttn.rawValue)
                            updateProductTablStatus(entity: Entities.getProductBeefTblEntity)
                            updateProductTablStatus(entity: Entities.getAdonTblEntity)
                            UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
                            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryBeefbreed.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.dataEntryBeeftsu.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.dataEntryInheritBeefbreedClear.rawValue)
                            UserDefaults.standard.set("", forKey: keyValue.dataEntryNZBeeftsuClear.rawValue)
                            UserDefaults.standard.setValue(nil, forKey: keyValue.dataEntryBeefbreedClear.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.dataEntryBeefInheritTsuClear.rawValue)
                            UserDefaults.standard.setValue(nil, forKey: keyValue.dataEntryBeeftsuClear.rawValue)
                            UserDefaults.standard.set("", forKey: keyValue.dataEntrytissueBttnClear.rawValue)
                            UserDefaults.standard.set("", forKey: keyValue.dataEntrygenotypeTissueBttnClear.rawValue)
                            UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
                            deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.dataEntrytissueBttn.rawValue)
                            UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                            self.bckBtnOutlet.isEnabled = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                                
                            }
                            self.cartBttnOutlet.isHidden = true
                            self.notificationLblCount.isHidden = true
                         //   self.clearOrderOutlet.isHidden = true
                            self.noAnimalToast.isHidden = false
                          //  self.cartImage.isHidden = false
                        }
                        else {
                            self.noAnimalToast.isHidden = true
                            self.cartBttnOutlet.isHidden = false
                            self.notificationLblCount.isHidden = false
                         //   self.clearOrderOutlet.isHidden = false
                         //   self.cartImage.isHidden = true
                            
                        }
                    collectionView.reloadData()
                  
                }))
                present(refreshAlert, animated: true, completion: nil)
            }

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animalVal  =  viewAnimalArray[indexPath.row] as! DataEntryBeefAnimaladdTbl
        self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
            let storyboard = UIStoryboard(name: "DataEntryBeefiPad", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DataEntryInheritBeefVC") as! DataEntryInheritBeefVC
            navigationController?.pushViewController(vc,animated: false)
        }
        else if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6{
            let storyboard = UIStoryboard(name: "DataEntryBeefiPad", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DEBrazilBeefVCIpad") as! DEBrazilBeefVCIpad
            navigationController?.pushViewController(vc,animated: false)
        }
        else {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefAnimalNZVC) as! DataEntryBeefAnimalNZ_VC
            navigationController?.pushViewController(vc,animated: false)
        }
    }
}

// MARK: - DELETE DATA AND LIST METHODS
extension DataEntryBeefViewAnimalList {
    
    func DeleteData(msg: String){
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        
        if Connectivity.isConnectedToInternet() {
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
            } else {
                let animalCount1 = fetchAnimalCountAccrodingToOrderWise(entityName: Entities.beefAnimalAddTblEntity, listId:Int64(listIdGet ),customerId:Int64(customerId ),orderId:orderId ,orderstatus:"false")
                
                if animalCount1.count > 0{
                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.cannotDeleteList, comment: ""), preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                    })
                    alert.addAction(ok)
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    
                    let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: msg.localized, preferredStyle: UIAlertController.Style.alert)
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                        refreshAlert .dismiss(animated: true, completion: nil)
                    }))
                    
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { [self] (action: UIAlertAction!) in
                        let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                        if !Connectivity.isConnectedToInternet() {
                            for animal in self.viewAnimalArray{
                                let animalVal = animal as! DataEntryAnimaladdTbl
                                saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: self.listIdGet, customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "",speciesID: SpeciesID.beefSpeciesId)
                            }
                        }
                        
                        deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listIdGet ), customerId: customerId ,userId:userId )
                        deleteList(listName:listName ,customerId:Int(Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))))
                        
                        let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet ))
                        
                        if animalData.count > 0 {
                            for i in 0 ..< animalData.count {
                                let ad = animalData[i] as! BeefAnimaladdTbl
                                deleteDataWithProductBeefDelete(Int(ad.animalId))
                                deleteDataWithSubProductAnimalId(Int(ad.animalId))
                            }
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryListId.rawValue) as? Int == listIdGet {
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListId.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                            }
                            deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listIdGet ), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                        }
                        
                        let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryBeefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet ))
                        if animalData1.count > 0 {
                            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryBeefAnimalAddTblEntity, listId: Int(listIdGet ), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                        }
                        self.collectionView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.listDeleted, comment: ""), duration: 2, position: .bottom)
                    }))
                    self.present(refreshAlert, animated: true, completion: nil)
                }
            }
        }
        
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
    
    func deleteList(listName:String, customerId:Int) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
        }
    }
}

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension DataEntryBeefViewAnimalList : offlineCustomView {
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}
