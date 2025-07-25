//
//  BeefAnimalNZ_VC.swift
//  SearchPoint
//
//  Created by "" on 08/03/20.
//

import UIKit
//import BarcodeScanner
import Vision
import VisionKit
class BeefAnimalNZ_VC: UIViewController,/*BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate*/UIScrollViewDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate,VNDocumentCameraViewControllerDelegate  {
    
    
    var validateDateFlag = true
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var scanAnimalTagTextField: UITextField!
    var barAutoPopu = false
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var methReturn = String()
    var checkBarcode = Bool()
    
    @IBOutlet weak var dobTitleLbl: UILabel!
    @IBOutlet weak var orderingAddAnimaltitleLbl: UILabel!
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    @IBOutlet weak var scrolView: UIScrollView!
    var providerSelectionCountryCode = String()
    
    @IBOutlet weak var appstatusLbl: UILabel!
    @IBOutlet weak var continueBttn: UIButton!
    @IBOutlet weak var addanimalBttn: UIButton!
    @IBOutlet weak var breedRegLbl: UILabel!
    @IBOutlet weak var breedRegAssociationBttn: customButton!
    @IBOutlet weak var earTagView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var breedRegTextfield: UITextField!
    @IBOutlet weak var dateBttnOutlet: UIButton!
    @IBOutlet weak var breedBtnOutlet: customButton!
    @IBOutlet weak var male_femaleBttnOutlet: UIButton!
    @IBOutlet weak var tissueBttnOutlet: customButton!
    @IBOutlet weak var tissueLbl: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var animalNameTextfield: UITextField!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderbkg: UIView!
    
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    
    let tapRec = UITapGestureRecognizer()
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var sireRegTextfield: UITextField!
    
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var damRegTextfield: UITextField!
    @IBOutlet weak var dateBtnOutlet: UIView!
    
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    
    var barcodeEnable = Bool()
    var timeStampString = String()
    var lblTimeStamp = String()
    var barcodeflag = Bool()
    var scanAnimalText = String()
    var farmIdText = String()
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    var animalTag = true
    var sireIdBool = true
    var offPmidBool = true
    var barCodeIdBool = true
    var damIdBool = true
    var farmIdTagBool = true
    var idAnimal = Int()
    var isUpdate = Bool()
    var msgUpatedd = Bool()
    var animalSucInOrder = String()
    
    var animalIdBool = Bool()
    let buttonbg2 = UIButton ()
    // var droperTableView  = UITableView ()
    var breedArr = NSArray()
    var breedRegArr = NSArray()
    var breedId = String()
    var tissuId = Int()
    var animalId1 = Int()
    var tissueArr = NSArray()
    var btnTag = Int()
    var identify = Bool()
    var identify1 = Bool()
    var msgcheckk  = Bool()
    var isautoPopulated = false
    var statusOrder = Bool()
    var updateOrder = Bool()
    var editIngText = Bool()
    var autoD = Int()
    var editAid = Int()
    var messageCheck = Bool()
    var msgAnimalSucess = Bool()
    var addContiuneBtn = Int()
    
    @IBOutlet weak var breedDropDownIcon: UIImageView!
    
    @IBOutlet weak var angusDropDownIcon: UIImageView!
    
    var datePicker : UIDatePicker!
    var selectedDate = Date()
    var InheritSelectedDate = Date()
    var InheritSireSelectedDate = Date()
    var InheritDamSelectedDate = Date()
    let toolBar = UIToolbar()
    var droperTableView  = UITableView ()
    var genderString = String()
    var inheritGenderString = String()
    var genderToggleFlag : Int = 0
    var inheritGenderToggleFlag : Int = 0
    
    var dateComp = Int()
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    var orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
    
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
    var checkboxPerfernceSave = Bool()
    
    
    @IBOutlet weak var importListMainView: UIView!
    @IBOutlet weak var importBackroundView: UIView!
    
    @IBOutlet weak var importFromListOutlet: UIButton!
    
    @IBOutlet weak var importTblView: UITableView!
    
    @IBOutlet weak var selectListTitleLbl: UILabel!
    var importListArray = [DataEntryList]()
    var listId = Int()
    var listNameString = String()
    
    @IBOutlet weak var mergeListBtnOulet: UIButton!
  let langCode : String = UserDefaults.standard.object(forKey: "lngCode") as! String
    @IBAction func mergeListBtnClick(_ sender: Any) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AnimalMergePopUpVC") as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
        
    }
    
    
    
    
    @IBAction func importFromListAction(_ sender: Any) {
        
      
        view.endEditing(true)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        importListArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId, providerId: pvid) as!  [DataEntryList]
        
        if importListArray.count == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("There is no list to be imported. Please create a list first.", comment: ""))
            
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
         conflictArr.removeAll()
        showIndicator(self.view, withTitle: NSLocalizedString("Loading...", comment: ""), and: "")
        
        let data1 = fetchAllDataWithOrderID(entityName: Entities.beefAnimalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            
            var animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                
               // let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Product selection will be cleared if you want to import list. Do you want to continue?", comment: ""), preferredStyle: .alert)
                
               // let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    
                 //   self.importListMainView.isHidden = true
                //    self.importBackroundView.isHidden = true
               //     return
             //   })
             //   alert.addAction(cancel)
                
              //  let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                    
                //    updateProductTablDataaid(entity: Entities.getProductBeefTblEntity, status: "false")
                 //   updateProductTablDataaid(entity: Entities.getAdonTblEntity, status: "false")
                  //  for j in 0 ..< data1.count {
                 //       let animal = data1.object(at: j) as! BeefAnimaladdTbl
                        
                    //    updateAnimalTblDataDairystatus(entity: Entities.productAdonAnimlBeefTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                       // updateAnimalTblDataDairystatus(entity: Entities.beefAnimalAddTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                    //    updateProductTablDataaid(entity: Entities.subProductBeefTblEntity, status: "false")
                        
                 //   }
                   // if self.importListArray.count != 0 {
                        self.importListMainView.isHidden = false
                        self.importBackroundView.isHidden = false
                        self.importTblView.reloadData()
                        
                //    }
              //  })
              //  alert.addAction(ok)
                
              //  DispatchQueue.main.async(execute: {
             // /      self.present(alert, animated: true)
                //})
                
            }else {
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblView.reloadData()
                    
                }
            }
        }else {
            
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                importTblView.reloadData()
                
            }
        }
        self.hideIndicator()
        
        
    }
    
    @IBOutlet weak var crossBtnOutlet: UIButton!
    @IBAction func crossBtnAction(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Removing list will remove its animals from the order as well. Do you want to continue?", comment: ""), preferredStyle: .alert)
            
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            
        })
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            
            var titleLbl = self.importFromListOutlet.titleLabel?.text
            self.listId = UserDefaults.standard.value(forKey: "dataEnteryListId") as? Int ?? 0
           
            
            
            let listArray = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0))
            
           for i in 0 ..< listArray.count{
                
                let listObj = listArray[i] as! MergeDataEntryList
                var listId = listObj.listId
                let custId = listObj.customerId

            let animalData =  fetchDataEnteryAnimalTblBeef(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
            
            if animalData.count > 0 {
                
                for i in 0 ..< animalData.count {
                       let ad = animalData[i] as! BeefAnimaladdTbl
                    deleteDataWithProductBeefDelete(Int(ad.animalId))
                    deleteDataWithSubProductAnimalId(Int(ad.animalId))
                   
               }
                deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listObj.listId), customerId:  Int(listObj.customerId),userId:self.userId)
            }
        }
          //  deleteRecordFromDatabase(entityName: "MergeDataEntryList")
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))

            let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import From List", comment: ""), attributes: self.attrs)
            self.importFromListOutlet.setAttributedTitle(attributeString, for: .normal)

            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            self.importFromListOutlet.isEnabled = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false

            }
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count == 0 {
                
                self.mergeListBtnOulet.isHidden = true
            } else {
                self.mergeListBtnOulet.isHidden = false
            }
            self.crossBtnOutlet.isHidden = true
            
        })
        alert.addAction(ok)

        DispatchQueue.main.async(execute: {
               self.present(alert, animated: true)
       })
    }
    var conflictArr = [DataEntryBeefAnimaladdTbl]()
    
  // MARK: - NavigateToBeefOrderingScreen
  
  func NavigateToBeefOrderingScreen() {
    let animalArray = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId ?? 0,listId:Int64(self.listId ),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
    let dataListAnimals : [DataEntryBeefAnimaladdTbl] = animalArray as! [DataEntryBeefAnimaladdTbl]
    let animals = dataListAnimals.filter({ $0.animalTag == "" || $0.animalTag == nil })
   
     if animals.count > 0 {
       
       let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: "Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
      
       let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
         
        // self.viewAnimalClick(<#UIButton#>)
//          barcodeScreen = false
//          selectedDate = Date()
//          // InheritSelectedDate = Date()
         let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
         // vc?.delegateCustom = self
         vc!.screenBackSave = false
         vc!.productBackSave = false
         self.navigationController?.pushViewController(vc!, animated: true)
     })
       alert.addAction(ok)
       DispatchQueue.main.async(execute: {
           self.present(alert, animated: true)
       })
     } else {
       self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
       
     }
  }
  
  // MARK: - ShowAlertforwithoutBarcodeAnimal
  func showAlertforwithoutBarcodeAnimal(importListAnimal: [DataEntryBeefAnimaladdTbl]) {
   
     let animals = importListAnimal.filter({$0.animalTag == "" || $0.animalTag == nil})
    
      if animals.count > 0 {
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: "Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
       
        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
          
         // self.viewAnimalClick(<#UIButton#>)
//          barcodeScreen = false
//          selectedDate = Date()
//          // InheritSelectedDate = Date()
          let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
          // vc?.delegateCustom = self
          vc!.screenBackSave = false
          vc!.productBackSave = false
          self.navigationController?.pushViewController(vc!, animated: true)
      })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
  
  }
    @IBAction func okBtnClickImportView(_ sender: Any) {
        
        
        if listId == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please select list to import.", comment: "") )
            
        } else {
            
            let allDataAnimalTbl1 = fetchAllDataAnimalAnimalIgnoreCase(entityName: "DataEntryBeefAnimaladdTbl",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :self.userId,listId:Int64(self.listId))

             if allDataAnimalTbl1.count == 0 {
                 CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
                 importListMainView.isHidden = true
                 importBackroundView.isHidden = true
                 return
             }
            
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:self.pvid)
            
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let animalTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataAnimalDatarderIdDateEntrycheckBeef(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ?? 0),providerId:pvid,earTag: animalTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                   
                    if dataEntryVALE.count > 0 {
                        
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                        
                    }
                }
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
                    
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                        
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true
                        
                    })
                    alert.addAction(cancel)
                    let ok = UIAlertAction(title: "Ignore", style: .default, handler: { [self] action in
                        
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                        if fetchData11.count != 0 {
                            
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                                
                               
                                
                                let fetchCountGirlando = fetchAllDataAnimalNzImport(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                
                                if fetchCountGirlando.count == 0 {
                                    
                                  let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true", ordrId: self.autoD, customerID: self.custmerId)
                                    if data12333.count > 0{
                                        
                                        if self.dateComp >= 35{
                                            
                                            if self.tissueBttnOutlet.titleLabel!.text! == "Allflex (TSU)" || tissueBttnOutlet.titleLabel!.text! == "Allflex (TST)" || tissueBttnOutlet.titleLabel!.text! == "Caisley (TSU)" {//}|| tissuId == 16 || tissuId == 18 {
                                                
                                                
                                                saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "" , barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "", update: "true" , permanentId: dataGet.offPermanentId ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD, orderSataus: dataGet.orderstatus ?? "", breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), age: Int(dataGet.diffAge), productId: Int(dataGet.productId), samconflict: dataGet.sampTypeConf ?? "", ageConf: dataGet.ageConf ?? "", bothConf: dataGet.bothConf ?? "", custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "")
                                                
                                                UserDefaults.standard.set(dataGet.tissuName, forKey: "NZBeeftsu")
                                                tissueBttnOutlet.setTitle(dataGet.tissuName, for: .normal)
                                                
                                            }
                                            else {
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                                
                                                // Create the actions
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    self.byDefaultSetting()
                                                    
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    NSLog("Cancel Pressed")
                                                    UserDefaults.standard.set("", forKey: "NZBeeftsu")
                                                    
                                                    deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                                    deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                                    deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                
                                                // Add the actions
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                
                                                // Present the controller
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the age of animal is less than 35 days. Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                            // Create the actions
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                                
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                NSLog("Cancel Pressed")
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                                self.notificationLblCount.text = String(animalCount.count)
                                                self.byDefaultSetting()
                                                return
                                            }
                                            
                                            // Add the actions
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            
                                            // Present the controller
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        
                                        
                                        saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "" , barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "", update: "true" , permanentId: dataGet.offPermanentId ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD, orderSataus: dataGet.orderstatus ?? "", breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), age: Int(dataGet.diffAge), productId: Int(dataGet.productId), samconflict: dataGet.sampTypeConf ?? "", ageConf: dataGet.ageConf ?? "", bothConf: dataGet.bothConf ?? "", custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "")
                                        
                                        
                                        UserDefaults.standard.set(dataGet.tissuName, forKey: "NZBeeftsu")
                                        tissueBttnOutlet.setTitle(dataGet.tissuName, for: .normal)

                                        
                                    }
                                    
                                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:self.orderId,userId:self.userId)
                                    let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                                   // let product = fetchproviderProductDataBreedId(entityName: Entities.getProductBeefTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)

                                    for k in 0 ..< animalData.count{
                                        
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        
                                        for i in 0 ..< product.count {
                                            
                                            let data = product[i] as! GetProductTblBeef
                                            
                                            saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            
                                            for j in 0 ..< addonArr.count {
                                                
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                if data12333.count > 0 {
                                                    
                                                    if addonDat.adonName == "BVDV"{ //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                                
                                                let message = NSLocalizedString("Animal added successfully.", comment: "")
                                                self.statusOrder = false
                                                UserDefaults.standard.removeObject(forKey: "review")
                                                self.animalSucInOrder = ""
                                                
                                            }
                                        }
                                    }
                                    if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        
                                        saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        
                                        }
                                        
                                        var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
                                        if fetchObj.count != 0 {

                                            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                            let obj = objectFetch?.listName
                                            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            mergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            mergeListBtnOulet.isHidden = false
                                        }
                                        }
                                }
                                let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                
                                if fetchCheckListId.count == 0{
                                    self.view.makeToast(NSLocalizedString("No animals added to the order.", comment: ""), duration: 2, position: .top)
                                }
                            }
                            
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                            self.notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                            } else {
                                
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                            }
                            
                        }
                        
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true

                    })
                    
                    alert.addAction(ok)
                    self.importBackroundView.isHidden = true
                    self.importListMainView.isHidden = true

                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                    if fetchData11.count != 0 {
                        
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                            
                          
                            
                            var fetchCountGirlando = fetchAllDataAnimalNzImport(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            
                            if fetchCountGirlando.count == 0 {
                                
                              let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true", ordrId: self.autoD, customerID: self.custmerId)
                                if data12333.count > 0{
                                    
                                    if self.dateComp >= 35{
                                        
                                        if self.tissueBttnOutlet.titleLabel!.text! == "Allflex (TSU)" || tissueBttnOutlet.titleLabel!.text! == "Allflex (TST)" || tissueBttnOutlet.titleLabel!.text! == "Caisley (TSU)" {//}|| tissuId == 16 || tissuId == 18 {
                                            
                                            
                                            saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "" , barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "", update: "true" , permanentId: dataGet.offPermanentId ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD, orderSataus: dataGet.orderstatus ?? "", breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), age: Int(dataGet.diffAge), productId: Int(dataGet.productId), samconflict: dataGet.sampTypeConf ?? "", ageConf: dataGet.ageConf ?? "", bothConf: dataGet.bothConf ?? "", custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "")
                                            
                                            UserDefaults.standard.set(dataGet.tissuName, forKey: "NZBeeftsu")
                                            tissueBttnOutlet.setTitle(dataGet.tissuName, for: .normal)

                                            
                                        }
                                        else {
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                            
                                            // Create the actions
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                                
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                NSLog("Cancel Pressed")
                                                UserDefaults.standard.set("", forKey: "NZBeeftsu")
                                                
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                                self.notificationLblCount.text = String(animalCount.count)
                                                self.byDefaultSetting()
                                                return
                                            }
                                            
                                            // Add the actions
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            
                                            // Present the controller
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else{
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the age of animal is less than 35 days. Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                        // Create the actions
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.byDefaultSetting()
                                            
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            NSLog("Cancel Pressed")
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                            self.notificationLblCount.text = String(animalCount.count)
                                            self.byDefaultSetting()
                                            return
                                        }
                                        
                                        // Add the actions
                                        alertController.addAction(okAction)
                                        alertController.addAction(cancelAction)
                                        
                                        // Present the controller
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    
                                    //       if self.dateVale == "" {
                                    //          self.dateComp = 0
                                    //     }
                                    
                                    saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "" , barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "", update: "true" , permanentId: dataGet.offPermanentId ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD, orderSataus: dataGet.orderstatus ?? "", breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), age: Int(dataGet.diffAge), productId: Int(dataGet.productId), samconflict: dataGet.sampTypeConf ?? "", ageConf: dataGet.ageConf ?? "", bothConf: dataGet.bothConf ?? "", custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "")
                                    
                                    UserDefaults.standard.set(dataGet.tissuName, forKey: "NZBeeftsu")
                                    tissueBttnOutlet.setTitle(dataGet.tissuName, for: .normal)
                                    
                                    
                                    
                                    
                                }
                                
                                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:self.orderId,userId:self.userId)
                                let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                               // let product = fetchproviderProductDataBreedId(entityName: Entities.getProductBeefTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                for k in 0 ..< animalData.count{
                                    
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    
                                    for i in 0 ..< product.count {
                                        
                                        let data = product[i] as! GetProductTblBeef
                                        
                                        saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        
                                        for j in 0 ..< addonArr.count {
                                            
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data12333.count > 0 {
                                                
                                                if addonDat.adonName == "BVDV"{ //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                            
                                            let message = NSLocalizedString("Animal added successfully.", comment: "")
                                            self.statusOrder = false
                                            UserDefaults.standard.removeObject(forKey: "review")
                                            self.animalSucInOrder = ""

                                        }
                                    }
                                }
                                if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                    
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    
                                    }
                                    
                                    var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
                                    if fetchObj.count != 0 {

                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        mergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        mergeListBtnOulet.isHidden = false
                                    }
                                    }
                            }
                            self.crossBtnOutlet.isHidden = false
                            //let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                           // self.importFromListOutlet.setAttributedTitle(attributeString, for: .normal)
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                            importFromListOutlet.isEnabled = true
                            self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)

                            
                        }
                        
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        self.notificationLblCount.text = String(animalCount.count)
                        if animalCount.count == 0{
                            self.notificationLblCount.isHidden = true
                            self.countLbl.isHidden = true
                        } else {
                            
                            self.notificationLblCount.isHidden = false
                            self.countLbl.isHidden = false
                            
                            
                        }
                        
                    }
                    self.importBackroundView.isHidden = true
                    self.importListMainView.isHidden = true

                    var fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                    
                    if fetchCheckListId.count == 0{
                        self.view.makeToast(NSLocalizedString("No animals added to the order.", comment: ""), duration: 2, position: .top)
                    }
                    
                }
                
                
            } else {
                
                
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        
                       
                        var fetchCountGirlando = fetchAllDataAnimalNzImport(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        
                        if fetchCountGirlando.count == 0 {
                            
                          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true", ordrId: self.autoD, customerID: self.custmerId)
                            if data12333.count > 0{
                                
                                if self.dateComp >= 35{
                                    
                                    if self.tissueBttnOutlet.titleLabel!.text! == "Allflex (TSU)" || tissueBttnOutlet.titleLabel!.text! == "Allflex (TST)" || tissueBttnOutlet.titleLabel!.text! == "Caisley (TSU)" {//}|| tissuId == 16 || tissuId == 18 {
                                        
                                        //  if self.dateVale == "" {
                                        //   self.dateComp = 0
                                        //  }
                                        
                                        
                                        
                                        saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "" , barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "", update: "true" ?? "", permanentId: dataGet.offPermanentId ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD, orderSataus: dataGet.orderstatus ?? "", breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), age: Int(dataGet.diffAge), productId: Int(dataGet.productId), samconflict: dataGet.sampTypeConf ?? "", ageConf: dataGet.ageConf ?? "", bothConf: dataGet.bothConf ?? "", custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "")
                                        
                                        UserDefaults.standard.set(dataGet.tissuName, forKey: "NZBeeftsu")
                                        tissueBttnOutlet.setTitle(dataGet.tissuName, for: .normal)

                                        
                                    }
                                    else {
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                        
                                        // Create the actions
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.byDefaultSetting()
                                            
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            NSLog("Cancel Pressed")
                                            UserDefaults.standard.set("", forKey: "NZBeeftsu")
                                            
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                            self.notificationLblCount.text = String(animalCount.count)
                                            self.byDefaultSetting()
                                            return
                                        }
                                        
                                        // Add the actions
                                        alertController.addAction(okAction)
                                        alertController.addAction(cancelAction)
                                        
                                        // Present the controller
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else{
                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the age of animal is less than 35 days. Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                    // Create the actions
                                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.byDefaultSetting()
                                        
                                    }
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        NSLog("Cancel Pressed")
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                        self.notificationLblCount.text = String(animalCount.count)
                                        self.byDefaultSetting()
                                        return
                                    }
                                    
                                    // Add the actions
                                    alertController.addAction(okAction)
                                    alertController.addAction(cancelAction)
                                    
                                    // Present the controller
                                    self.present(alertController, animated: true, completion: nil)
                                    return
                                }
                            }
                            else {
                                
                                //       if self.dateVale == "" {
                                //          self.dateComp = 0
                                //     }
                                
                                saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "" , barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "", update: "true" ?? "", permanentId: dataGet.offPermanentId ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD, orderSataus: dataGet.orderstatus ?? "", breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), age: Int(dataGet.diffAge), productId: Int(dataGet.productId), samconflict: dataGet.sampTypeConf ?? "", ageConf: dataGet.ageConf ?? "", bothConf: dataGet.bothConf ?? "", custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "")
                              
                                self.tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "NZBeeftsu")

                            }
                            
                            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:self.orderId,userId:self.userId)
                            let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                           // let product = fetchproviderProductDataBreedId(entityName: Entities.getProductBeefTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                            for k in 0 ..< animalData.count{
                                
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                
                                for i in 0 ..< product.count {
                                    
                                    let data = product[i] as! GetProductTblBeef
                                    
                                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    
                                    for j in 0 ..< addonArr.count {
                                        
                                        let addonDat = addonArr[j] as! GetAdonTbl
                                        if data12333.count > 0 {
                                            
                                            if addonDat.adonName == "BVDV"{ //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                        else {
                                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        }
                                        
                                        let message = NSLocalizedString("Animal added successfully.", comment: "")
                                        self.statusOrder = false
                                        UserDefaults.standard.removeObject(forKey: "review")
                                        self.animalSucInOrder = ""

                                    }
                                }
                            }
                            if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                
                                saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                
                                }
                                
                                var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
                                if fetchObj.count != 0 {

                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    mergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    mergeListBtnOulet.isHidden = false
                                }
                                }
                        }
                        self.crossBtnOutlet.isHidden = false
                       // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                        //self.importFromListOutlet.setAttributedTitle(attributeString, for: .normal)
                        UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                        UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                        importFromListOutlet.isEnabled = true
                        self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                        
                     


                    }
                    
                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                    self.notificationLblCount.text = String(animalCount.count)
                    if animalCount.count == 0{
                        self.notificationLblCount.isHidden = true
                        self.countLbl.isHidden = true
                    } else {
                        
                        self.notificationLblCount.isHidden = false
                        self.countLbl.isHidden = false
                        
                    }
                }
                self.importBackroundView.isHidden = true
                self.importListMainView.isHidden = true

                var fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                
                if fetchCheckListId.count == 0{
                    self.view.makeToast(NSLocalizedString("No animals added to the order.", comment: ""), duration: 2, position: .top)
                }
            }
        }
        
        
    }
    
    @IBAction func cancelBtnClickImportView(_ sender: Any) {
        importBackroundView.isHidden = true
        importListMainView.isHidden = true
        
        
    }
    
    
    
    
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
        
        guard scanBarcodeTextfield.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter barcode before selecting 'Incremental barcode'.", comment: "") )
            return
        }
        
        guard isBarCodeEndsWithNumber_GetIncrementedBarCode(scanBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
            if checkBarcode == false{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
                
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            sender.isSelected = false
            incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
            
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
            
        }
    }
    
    
    
    
    func defaultIncrementalBarCodeSetting() {
        UserDefaults.standard.set(nil, forKey: "barcodeIncremental")
        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
        incrementalBarcodeTitleLabel.text = NSLocalizedString("Incremental Barcode", comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeObserver()
        self.defaultIncrementalBarCodeSetting()
    }
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    
    var heartBeatViewModel:HeartBeatViewModel?
    
    func navigateToAnotherVc(){
    }
    @IBAction func addAction(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 0 {
            view1.isHidden = false
            view2.isHidden = true
            closeImage1.addGestureRecognizer(tapRec)
        } else {
            view1.isHidden = true
            view2.isHidden = false
            closeImage2.addGestureRecognizer(tapRec)
        }
    }
    
   
    
    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
        view1.isHidden = true
        view2.isHidden = true
    }
    
    
    
//    @objc
//    func keyboardWillDisappear(notification: NSNotification?) {
//        tableViewBottomLayoutConstraint.constant = 0.0
//    }
    
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
   
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        DispatchQueue.main.async {
//            self.dismissKeyboard()
//            if self.keyBoardOptionsView.isHidden {
//                self.keyBoardOptionsView.isHidden = true
//            }
//        }
//    }
    
     @objc func keyboardWillShow(_ notification: Notification) {
         if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
             let keyboardRectangle = keyboardFrame.cgRectValue
             let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
             keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+20
            addanimalBttn.isHidden = true
            continueBttn.isHidden = true
         }
     }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        addanimalBttn.isHidden = false
        continueBttn.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        importBackroundView.isHidden = true
        importListMainView.isHidden = true
     
        
        UserDefaults.standard.setValue(nil, forKey: "submitTypeSelection")
        dateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            
            dateTextField.isHidden = false
            
            
        } else {
            dateTextField.isHidden = true
        }
        UserDefaults.standard.set("NZ", forKey: keyValue.beefProduct.rawValue)
        UserDefaults.standard.set("NZ", forKey: "screenBeef")
        // Do any additional setup after loading the view.
        byDefaultSetting()
        self.defaultIncrementalBarCodeSetting()
        
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: "GetBreedSocieties", productId: 25)
        if breedRegArr.count == 1 || breedRegArr.count == 0{
            angusDropDownIcon.isHidden = true
            breedRegAssociationBttn.isUserInteractionEnabled = false
            
        } else {
            angusDropDownIcon.isHidden = false
            breedRegAssociationBttn.isUserInteractionEnabled = true
            
        }
        
        breedArr = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        if breedArr.count == 1 || breedArr.count == 0{
            breedDropDownIcon.isHidden = true
            breedBtnOutlet.isUserInteractionEnabled = false
            
        } else {
            breedDropDownIcon.isHidden = false
            breedBtnOutlet.isUserInteractionEnabled = true
            
        }
        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
        clearFormOutlet.setAttributedTitle(attributeString, for: .normal)
        
    }
    var value = 0
    @objc func methodOfReceivedNotification(notification: Notification)
       {
          
           if value == 0
                      {
                      UserDefaults.standard.set("false", forKey: "FirstLogin")
                      let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                      let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
                      self.navigationController?.pushViewController(newViewController, animated: true)
                      self.hideIndicator()
                         value = value + 1
                     }
         
       }
    override func viewWillAppear(_ animated: Bool) {
        
               NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
               

        
        initialNetworkCheck()
        landIdApplangaugeConversion(langid: Int(langId!))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        self.navigationController?.navigationBar.isHidden = true
        earTagView.layer.cornerRadius = (earTagView.frame.size.height / 2)
        earTagView.layer.borderWidth = 0.5
        earTagView.layer.borderColor = UIColor.gray.cgColor
        earTagView.clipsToBounds = true
        
        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
        barcodeView.layer.borderWidth = 0.5
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.clipsToBounds = true
        
        dateBttnOutlet.layer.cornerRadius = (dateBttnOutlet.frame.size.height / 2)
        dateBttnOutlet.layer.borderWidth = 0.5
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.clipsToBounds = true
        
        scanAnimalTagTextField.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        damRegTextfield.addPadding(.left(20))
        sireRegTextfield.addPadding(.left(20))
        breedRegTextfield.addPadding(.left(20))
        animalNameTextfield.addPadding(.left(20))
        breedRegAssociationBttn.layer.cornerRadius = (breedRegAssociationBttn.frame.size.height / 2)
        breedRegAssociationBttn.layer.borderWidth = 0.5
        breedRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
        breedRegAssociationBttn.clipsToBounds = true
        let auto = UserDefaults.standard.bool(forKey: "autoIdBeef")
        if auto == false {
            autoIncrementidtable()
            autoD = fetchFromAutoIncrement()
            timeStampString = timeStamp()
            UserDefaults.standard.set(timeStampString, forKey: "timeStamp")
            UserDefaults.standard.set(true, forKey: "autoIdBeef")
            
            let animaltbl = fetchRemaningSubmitOrder(entityName: Entities.beefAnimalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            for i in 0..<animaltbl.count{
                let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
                updateOrderStatusServerRemain(entity: "BeefAnimalMaster", aniamltag: data.animalTag!, userId: userId)
            }
            deleteRemaningSubmitOrder(entityName: Entities.beefAnimalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimlBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.subProductBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            UserDefaults.standard.set(1, forKey: keyValue.orderIdBeef.rawValue)
        }
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as? String ?? ""
        orderId  = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        
        
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        if UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart") > 0 {
            var temp = UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart")
            animalIdBool = true
            
            UserDefaults.standard.set(0, forKey: "BeefAnimalIdSelectionCart")
            dataPopulateInScreen(animalId: temp)
            isautoPopulated = true
            barAutoPopu = true
            messageCheck = true
            textFieldBackroungWhite()
        }
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear") == false {
            self.isBarcodeAutoIncrementedEnabled = false
            
        }
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
           // deleteRecordFromDatabase(entityName: "MergeDataEntryList")
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))

        }

        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import From List", comment: ""), attributes: self.attrs)
        importFromListOutlet.setAttributedTitle(attributeString, for: .normal)

        let dataFetc = fetchDataEnteryWithListId(entityName: Entities.beefAnimalAddTblEntity,customerId:self.custmerId ?? 0 ,listId:0,providerId:pvid,orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue))
        
        if dataFetc.count == 0 {
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import From List", comment: ""), attributes: self.attrs)
            importFromListOutlet.setAttributedTitle(attributeString, for: .normal)
            importFromListOutlet.isEnabled = true
            crossBtnOutlet.isHidden = true
       
        } else {

            let get = dataFetc.object(at: 0) as? BeefAnimaladdTbl
            let getListid = get?.listId ?? 0
            UserDefaults.standard.set(Int64(getListid), forKey: "dataEnteryListId")

            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,listId:getListid,providerId:pvid )
            
            if fetchName.count != 0{
                
                let getName = fetchName.object(at: 0) as? DataEntryList
                let getListName = getName?.listName ?? ""
                crossBtnOutlet.isHidden = false
                importFromListOutlet.isEnabled = true
            }
        }
        
        ///
        
        if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count == 0 {
            mergeListBtnOulet.isHidden = true
        } else {
            mergeListBtnOulet.isHidden = false
        }
        
        let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
        
        if fetchObj.count != 0 {
        
        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
        let obj = objectFetch?.listName
        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
        
        if fetchAllMergeDta == 0 {
            let fetchNameDisplay = String(obj ?? "")
            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

        } else {
            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

        }
        }
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView!) {
        
        var strDeviceType = ""
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                scrolView.contentSize.height = 620
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                scrolView.contentSize.height = 620
                
            case 2436:
                strDeviceType = "iPhone X"
                scrolView.contentSize.height = 620
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
                scrolView.contentSize.height = 620
            case 1792:
                scrolView.contentSize.height = 620
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
    }
    func landIdApplangaugeConversion(langid:Int){
        
        if langId == 2 {
            scanAnimalTagTextField.placeholder = "Inserir Etiqueta / Tatuagem Animal"
        }
            scanBarcodeTextfield.placeholder = NSLocalizedString("Scan/Enter Sample Barcode", comment: "")
            breedRegTextfield.placeholder = NSLocalizedString("Enter Breed Registration Number", comment: "")
            animalNameTextfield.placeholder = NSLocalizedString("Enter Animal Name", comment: "")
            sireRegTextfield.placeholder = NSLocalizedString("Enter Sire Registration Number", comment: "")
            damRegTextfield.placeholder = NSLocalizedString("Enter Dam registration number", comment: "")
            dobTitleLbl.text = NSLocalizedString("Date of Birth", comment: "")
            orderingAddAnimaltitleLbl.text = NSLocalizedString("Ordering Add Animal(s)", comment: "")
            addanimalBttn.setTitle(NSLocalizedString("Add Another Animal", comment: ""), for: .normal)
            continueBttn.setTitle(NSLocalizedString("Continue to Product Selection", comment: ""), for: .normal)
            appstatusLbl.text = NSLocalizedString("App Status:", comment: "")
            selectListTitleLbl.text = NSLocalizedString("Select List", comment: "")

        
    }
    
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var samplename = String()
        var animalFetch = NSArray()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
        if animalIdBool == true {
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
            var data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
            animalId1 = Int(data.animalId)
            /////////end
            self.isBarcodeAutoIncrementedEnabled = false
            UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            earTagView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            damRegTextfield.layer.borderColor = UIColor.gray.cgColor
            breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
            sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
            //
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            var formatter = DateFormatter()
            if data.date != ""{
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1{
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        dateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = "MM/dd/yyyy"
                }
                else {
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1{
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        dateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                    
                }
                else{
                    //   self.selectedDate = Date()
                }
                //self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                let dates =  formatter.string(from: selectedDate)
            }
            dateComp = Int(data.diffAge)
            scanAnimalTagTextField.text = data.animalTag
            scanBarcodeTextfield.text = data.animalbarCodeTag
            breedRegTextfield.text = data.offPermanentId
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            animalNameTextfield.text  = data.eT
            //                animalNameTextfield.text  = data.anima
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: "NZBeeftsu")
            
            breedId = data.breedId!
            samplename = data.tissuName!
            let pvidAA = data.providerId
            UserDefaults.standard.set(data.breedName, forKey: "NZBeefbreed")
            
          if data.gender == "Male".localized || data.gender == "M" {
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                
            } else {
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
              genderString = "Female".localized
               
            }
            
            
            
            tissuId = Int(data.tissuId)
            
            dateBttnOutlet.setTitleColor(.black, for: .normal)
            let fetch = fetchAllData(entityName: "BeefAnimalMaster")
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            
            animalIdBool = false
            
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                // statusOrder = true
            }
            
        } else {
            animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
            if animalFetch.count > 0 {
                var  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                
                
                
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
                animalId1 = Int(data.animalId)
                /////////end
                
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                damRegTextfield.layer.borderColor = UIColor.gray.cgColor
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
                sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                //
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                if data.date != ""{
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = "MM/dd/yyyy"
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                    let dates =  formatter.string(from: selectedDate)
                }
                animalNameTextfield.text  = data.eT
                scanAnimalTagTextField.text = data.animalTag
                scanBarcodeTextfield.text = data.animalbarCodeTag
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                //                animalNameTextfield.text  = data.anima
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: "NZBeeftsu")
                
                breedId = data.breedId!
                samplename = data.tissuName!
                let pvidAA = data.providerId
                UserDefaults.standard.set(breedId, forKey: "NZBeefbreed")
                
              if data.gender == "Male".localized || data.gender == "M" {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    
                } else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                  genderString = "Female".localized
                    
                }
                
                
                tissuId = Int(data.tissuId)
                
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                let fetch = fetchAllData(entityName: "BeefAnimalMaster")
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                animalIdBool = false
                
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    statusOrder = true
                }
            }
        }
        
        
    }
    func timeStamp()-> String{
        
        let time1 = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyyHH:mm:ss"
        var timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let string = lblTimeStamp as String
        let charset = CharacterSet(charactersIn: "i")
        if string.rangeOfCharacter(from: charset) != nil {
           
        }
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        InheritSelectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func byDefaultSetting() {
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        if dateStr == "MM" {
            dateformt.dateFormat = "MM/dd/yyyy"
            dateTextField.placeholder = "MM/DD/YYYY"
        } else {
            dateformt.dateFormat = "dd/MM/yyyy"
            dateTextField.placeholder = "DD/MM/YYYY"
            
        }
        dobTitleLbl.textColor = UIColor.gray
        
        dateBttnOutlet.setTitle("", for: .normal)
        dateBttnOutlet.setTitle(nil, for: .normal)
        dateTextField.text = ""
        animalId1 = 0
        idAnimal = 0
        dateComp = 0
        isUpdate = false
        msgUpatedd = false
        barAutoPopu = false
        self.msgcheckk = false
        self.isautoPopulated = false
        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedRegAssociationBttn.setTitleColor(UIColor.gray, for: .normal)
        // isautoPopulated = false
        let dte = Date()
        
        //  dateBttnOutlet.setTitle( dateformt.string(from: dte ), for: .normal)
        breedRegAssociationBttn.layer.borderWidth = 0.5
        tissueBttnOutlet.layer.borderWidth = 0.5
        breedBtnOutlet.layer.borderWidth = 0.5
        earTagView.layer.borderColor = UIColor.gray.cgColor
        damRegTextfield.layer.borderColor = UIColor.gray.cgColor
        sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
        breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
        animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        breedBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        breedRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        scanAnimalTagTextField.text?.removeAll()
        scanBarcodeTextfield.text?.removeAll()
        damRegTextfield.text?.removeAll()
        sireRegTextfield.text?.removeAll()
        breedRegTextfield.text?.removeAll()
        animalNameTextfield.text?.removeAll()
        
        breedBtnOutlet.setTitle("ANG - Angus", for: .normal)
        tissueBttnOutlet.setTitle("Allflex (TSU)", for: .normal)
        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        genderToggleFlag = 0
      genderString = "Female".localized
        
        UserDefaults.standard.set("Allflex (TSU)", forKey: "tissueIdSaveLast")
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedRegAssociationBttn.setTitleColor(.gray, for: .normal)
        //  self.selectedDate = Date()
        textFieldBackroungGrey()
        self.scrolView.contentOffset.y = 0.0
        if UserDefaults.standard.string(forKey: "NZBeeftsu") == nil || UserDefaults.standard.string(forKey: "NZBeeftsu") == "" {
            
            tissueBttnOutlet.setTitle("Allflex (TSU)", for: .normal)
            tissuId = 1
        }
        else{
            tissueBttnOutlet.setTitle(UserDefaults.standard.string(forKey: "NZBeeftsu"), for: .normal)
        }
        if UserDefaults.standard.string(forKey: "NZBeefbreed") == nil{
            breedBtnOutlet.setTitle("ANG", for: .normal)
            breedId  = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
        }
        else{
            breedBtnOutlet.setTitle(UserDefaults.standard.string(forKey: "NZBeefbreed"), for: .normal)
        }
        
        
        if breedId  == "" {
            let inheritBreed = fetchAllDataProductBeefIdNz(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text) ?? "", pvid: 7)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
            }
        }
        
        
        incrementalBarcodeTitleLabel.textColor = UIColor.gray
        incrementalBarcodeButton.isEnabled = false
        incrementalBarcodeCheckBox.alpha = 0.6
        incrementalBarcodeTitleLabel.alpha = 0.6
        self.scanAnimalTagTextField.becomeFirstResponder()
        
    }
    
    func textFieldBackroungGrey(){
        dobTitleLbl.textColor = UIColor.gray
        
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        breedRegAssociationBttn.setTitleColor(.gray, for: .normal)
        male_femaleBttnOutlet.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttnOutlet.isEnabled = false
        breedRegAssociationBttn.isEnabled = false
        scanBarcodeTextfield.isEnabled = false
        damRegTextfield.isEnabled = false
        sireRegTextfield.isEnabled = false
        breedRegTextfield.isEnabled = false
        animalNameTextfield.isEnabled = false
        breedBtnOutlet.isEnabled = false
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        // scanBarcodeTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        barcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegAssociationBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.setTitle("", for: .normal)
        dateBttnOutlet.setTitle(nil, for: .normal)
        dateTextField.isEnabled = false
        
        incrementalBarcodeTitleLabel.textColor = UIColor.gray
        incrementalBarcodeButton.isEnabled = false
        incrementalBarcodeCheckBox.alpha = 0.6
        incrementalBarcodeTitleLabel.alpha = 0.6
        self.scanAnimalTagTextField.becomeFirstResponder()
        
    }
    func textFieldBackroungWhite(){
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
        tissueBttnOutlet.setTitleColor(UIColor.black, for: .normal)
        dobTitleLbl.textColor = UIColor.black
        
        breedRegAssociationBttn.setTitleColor(UIColor.black, for: .normal)
        male_femaleBttnOutlet.isEnabled = true
        dateBttnOutlet.isEnabled = true
        male_femaleBttnOutlet.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        breedRegAssociationBttn.isEnabled = true
        scanBarcodeTextfield.isEnabled = true
        damRegTextfield.isEnabled = true
        sireRegTextfield.isEnabled = true
        breedRegTextfield.isEnabled = true
        animalNameTextfield.isEnabled = true
        breedBtnOutlet.isEnabled = true
        breedRegAssociationBttn.backgroundColor = UIColor.white
        
        barcodeView.backgroundColor = UIColor.white
        barcodeView.backgroundColor = UIColor.white
        damRegTextfield.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        sireRegTextfield.backgroundColor = UIColor.white
        breedRegTextfield.backgroundColor = UIColor.white
        animalNameTextfield.backgroundColor = UIColor.white
        breedBtnOutlet.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        dateBttnOutlet.backgroundColor = UIColor.white
        dateTextField.isEnabled = true
        
        if isautoPopulated == false {
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            
            if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                    scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                }
            }
            
        } else {
            
            incrementalBarcodeTitleLabel.textColor = UIColor.gray
            incrementalBarcodeButton.isEnabled = false
            incrementalBarcodeCheckBox.alpha = 0.6
            incrementalBarcodeTitleLabel.alpha = 0.6
        }
        
    }
    
    @IBAction func breedRegAction(_ sender: UIButton) {
        btnTag = 80
        
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: "GetBreedSocieties", productId: 25)
        
        //   fetchAllData(entityName: "GetBreedSocieties")
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (breedRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (breedRegLbl.frame.minY + 100) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (breedRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (breedRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
        
        
    }
    func doDatePicker(){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2
                    {
                    self.datePicker?.locale = Locale(identifier: "pt")
                    }
      else if langId == 3
      {
        self.datePicker?.locale = Locale(identifier: "it")
      }
                    else
                    {
                        self.datePicker?.locale = Locale(identifier: "en")
                    }
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        if selectedDate != nil{
            self.datePicker.setDate(selectedDate, animated: true)
        }
        
        
        if #available(iOS 14, *) {
            self.datePicker?.preferredDatePickerStyle = .wheels
        }
        calenderView.backgroundColor = UIColor.white
        calenderView.addSubview(self.datePicker)
        // ToolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        self.datePicker.maximumDate = Date()
        
        // Adding Button ToolBar
      let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    @objc func doneClick() {
        let date = UserDefaults.standard.value(forKey: "date") as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = "MM/dd/yyyy"
        }
        else {
            dateFormatter3.dateFormat = "dd/MM/yyyy"
        }
        self.selectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        dateBttnOutlet.setTitle(selectedDate, for: .normal)
        // checkAge(date: datePicker.date))
        dateComp =  checkAge(date: datePicker.date)
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    func checkAge(date : Date)->Int{
        let birthday = date
        let now = Date()
        let calender = Calendar.current
        let ageComponents = calender.dateComponents([.day], from: birthday, to: now)
        let age = ageComponents.day
        return age!
    }
    @IBAction func breedAction(_ sender: UIButton) {
        btnTag = 10
        view.endEditing(true)
        self.tableViewpop()
       
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        breedArr = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        var yFrame = (breedLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (breedLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (breedLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (breedLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 150,height: 70)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    @IBAction func dateAction(_ sender: UIButton) {
        
        
        
        barcodeEnable = true
        self.view.endEditing(true)
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            
            dateTextField.isHidden = false
            
            
        } else {
            
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            doDatePicker()
            dateTextField.isHidden = true
            
        }
    }
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            
            self.scanAnimalTagTextField.becomeFirstResponder()
        })
        //
        //self.view.endEditing(true)
        
        
        
    }
    
    func autoPop(animalData:NSArray) {
        
        if animalData.count > 0 {
            isautoPopulated = true
            textFieldBackroungWhite()
            barAutoPopu = true
            barcodeflag = false
            updateOrder = true
            var data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            ////////start
            let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
            animalId1 = Int(data.animalId)
            
            /////////end
            //  self.isBarcodeAutoIncrementedEnabled = false
            dateBttnOutlet.titleLabel!.text = ""
            //  UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            earTagView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            var formatter = DateFormatter()
            if data.date != ""{
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }                    }
                    formatter.dateFormat = "MM/dd/yyyy"
                }
                else {
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        dateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                    
                }
                else{
                    self.selectedDate = Date()
                }
                //self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                let dates =  formatter.string(from: selectedDate)
                
            }
            breedRegTextfield.text = data.offPermanentId
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            animalNameTextfield.text  = data.eT
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: "NZBeeftsu")
            breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
            breedId = data.breedId!
            let samplename = data.tissuName!
            let pvidAA = data.providerId
            UserDefaults.standard.set(data.breedName, forKey: "NZBeefbreed")
            
          if data.gender == "Male".localized || data.gender == "M" {

                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                
            } else {
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
              genderString = "Female".localized
                
            }
            
            
            var dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
            if dataFetch.count == 0 {
                incrementalBarcodeTitleLabel.textColor = .black
                incrementalBarcodeTitleLabel.alpha = 1
                incrementalBarcodeCheckBox.alpha = 1
                incrementalBarcodeButton.isEnabled = true
            } else {
                if data.orderstatus == "true"{
                    checkBarcode = false
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeButton.isEnabled = true
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                } else {
                    scanBarcodeTextfield.text = data.animalbarCodeTag
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                    incrementalBarcodeButton.isEnabled = false
                    incrementalBarcodeTitleLabel.textColor = .gray
                    checkBarcode = false
                    incrementalBarcodeTitleLabel.alpha = 0.6
                    incrementalBarcodeCheckBox.alpha = 0.6
                }
            }
            
            
            tissuId = Int(data.tissuId)
            
            
            
            dateBttnOutlet.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                //statusOrder = true
                messageCheck = true
            }
        }
    }
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
        
        if barcodeEnable == true {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: self.idAnimal,customerID: self.custmerId)
                    self.autoPop(animalData: animalFetch)
                    self.barcodeEnable = false
                }
                alertController.addAction(okAction)
                
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
                statusOrder = false
                self.scrolView.contentOffset.y = 0.0
                return
            }
        }
        else {
        }
        
        let selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
        
        if selctionAuProvider == true {
            
            if scanAnimalTagTextField.text == "" || scanBarcodeTextfield.text == "" || breedRegTextfield.text == "" /*|| animalNameTextfield.text == "" || sireRegTextfield.text == "" || damRegTextfield.text == ""*/{
                
                self.validation()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                completionHandler(false)
                return
            } else {
                
                addBtnCondtion(completionHandler: { (success) -> Void in
                   
                    if success == true{
                        dateBttnOutlet.setTitle("", for: .normal)
                        dateTextField.text = ""
                        
                        dateBttnOutlet.titleLabel?.text = ""
                        completionHandler(true)
                    }
                })
            }
        } else {
            
            
            if scanAnimalTagTextField.text == "" || scanBarcodeTextfield.text == "" || breedRegTextfield.text == "" {//} || dateBttnOutlet.titleLabel?.text == "" || dateBttnOutlet.titleLabel?.text == nil /*|| animalNameTextfield.text == "" || sireRegTextfield.text == "" || damRegTextfield.text == ""*/{
                self.validation()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                completionHandler(false)
                return
            } else {
                
                addBtnCondtion(completionHandler: { (success) -> Void in
                    if success == true{
                        completionHandler(true)
                    }
                })
            }
        }
        if notificationLblCount.text != "0"{
            countLbl.isHidden = false
            notificationLblCount.isHidden = false
            
        }
    }
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
            return
        }
        
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        let formatter = DateFormatter()
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
        } else {
            dateVale = dateBttnOutlet.titleLabel?.text ?? ""
        }
        
        
        var codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: self.pvid,tissueName:(tissueBttnOutlet.titleLabel?.text!)!)
        let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
        if naabFetch1!.count == 0 {
            
        } else {
            let breedIdGet = naabFetch1![0] as? Int
            self.tissuId = breedIdGet!
        }
    
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            
            dateVale = dateTextField.text ?? ""
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBttnOutlet.titleLabel?.text ?? ""
                } else {
                    
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        } else {
            
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBttnOutlet.titleLabel?.text ?? ""
                } else {
                    
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                    
                }
            }
        }
        
        if dateTextField.text?.count == 0 {
            
            
        } else {
            
            if dateTextField.text?.count == 10 {
                var validate = isValidDate(dateString: dateTextField.text ?? "")
               
                
                if validate == "Correct Format"{ //true {
                    dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    if validate == "GreaterThenDate" {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                        
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                        
                    }
                    return
                }
            } else {
                dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                return
                
            }
        }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        if  barcodeflag == true {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
            if barCode.count > 0 {
                validation()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode is already used with an animal.", comment: ""))
                barcodeView.layer.borderColor = UIColor.red.cgColor
                return
            }
        }
        
        let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: "BeefAnimalMaster", animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
        if animaBarcOde.count > 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode is already used with an animal.", comment: ""))
            barcodeView.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanAnimalTagTextField.text!, orderId: orderId, userId: userId, animalId: animalId1)
        
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        
        if animalData.count > 0  {
            
            isUpdate = true
          updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMasterNZ(entity: Entities.beefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1, diffDate: dateComp)
            
            
            
            let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: "DataEntryBeefAnimaladdTbl",animalTag:scanAnimalTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:25)
           
            
            if fetchDataUpdate.count != 0 {
                
                updateOrderInfoBeefNZ(entity: "DataEntryBeefAnimaladdTbl",animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text!,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                
                updateOrderInfoBeefNZ(entity: "BeefAnimalMaster",animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text!,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                
            }
            
            
            updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: scanAnimalTagTextField.text!,barCodetag:  scanBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: scanAnimalTagTextField.text!,barCodetag:  scanBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:scanAnimalTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if msgUpatedd == true{
                 //   CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                  
                  self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "NZBeeftsu")
                    
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "NZBeeftsuClear")
                    
                    byDefaultSetting()
                    
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                }
            }
            
            editAid = animalId1
            animalId1 = 0
            
            //  1
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            //return
        }
        else if isUpdate == true {
            
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMasterNZ(entity: Entities.beefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,diffDate: dateComp)
            
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:scanAnimalTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                   // CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                  self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "NZBeeftsu")
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "NZBeeftsuClear")
                    byDefaultSetting()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                    
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            //return
        } else {
            isUpdate = false
            
            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
            let pid = product.object(at: 0) as! GetProductTblBeef
            let data =   fetchAnimaldataValidateBarcodeforValidationBeef(entityName: "BeefAnimalMaster", barcode: scanBarcodeTextfield.text!, userId: userId, orderId: orderId)
            
            
            var animalID = UserDefaults.standard.integer(forKey: "animalId")
            var animalID1 = UserDefaults.standard.integer(forKey: "animalId")
            
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
              updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false,tertiaryGeno: "")
                
                var fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: "DataEntryBeefAnimaladdTbl",animalTag:scanAnimalTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:25)
              
                
                if fetchDataUpdate.count != 0 {
                    
                    updateOrderInfoBeefNZ(entity: "DataEntryBeefAnimaladdTbl",animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ?? "",et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text! ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                    
                    updateOrderInfoBeefNZ(entity: "BeefAnimalMaster",animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ?? "",et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)

                }
            }
            else{
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                }
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                
                if animalDataMaster.count > 0{
                  updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU:"", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                }
                else {
                    
                  saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                }
            }
            
            
            
          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true", ordrId: autoD, customerID: custmerId)
            if data12333.count > 0{
                
                if dateComp >= 35{
                    
                    if tissueBttnOutlet.titleLabel!.text! == "Allflex (TSU)" || tissueBttnOutlet.titleLabel!.text! == "Allflex (TST)" || tissueBttnOutlet.titleLabel!.text! == "Caisley (TSU)" {//}|| tissuId == 16 || tissuId == 18 {
                        
                        
                        if dateVale == "" {
                            dateComp = 0
                        }
                        
                        
                        saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, age:dateComp,productId: Int(pid.productId), samconflict: "", ageConf: "", bothConf: "" ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "")
                        
                    }
                    else {
                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            self.byDefaultSetting()
                            
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                            UserDefaults.standard.set("", forKey: "NZBeeftsu")
                            
                            deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
                            deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
                            deleteDataWithProductwithEntity(animalID1, entity: Entities.beefAnimalAddTblEntity)
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                            self.notificationLblCount.text = String(animalCount.count)
                            self.byDefaultSetting()
                            return
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                }
                else{
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the age of animal is less than 35 days. Do you want to save animal?", comment: ""), preferredStyle: .alert)
                    // Create the actions
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.byDefaultSetting()
                        
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                        deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
                        deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
                        deleteDataWithProductwithEntity(animalID1, entity: Entities.beefAnimalAddTblEntity)
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        self.notificationLblCount.text = String(animalCount.count)
                        self.byDefaultSetting()
                        return
                    }
                    
                    // Add the actions
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    
                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            else {
                
                if dateVale == "" {
                    dateComp = 0
                }
                
                
                saveAnimaldatawithAge(entity: Entities.beefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, age:dateComp,productId :Int(pid.productId), samconflict: "", ageConf: "", bothConf: "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "")
                
            }
            
            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanAnimalTagTextField.text!,orderId:orderId,userId:userId)
            let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    
                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    
                    for j in 0 ..< addonArr.count {
                        
                        let addonDat = addonArr[j] as! GetAdonTbl
                        if data12333.count > 0 {
                            
                            if addonDat.adonName == "BVDV"{ //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                            }
                            else {
                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            }
                        }
                        else {
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                        
                        let message = NSLocalizedString("Animal added successfully.", comment: "")
                        statusOrder = false
                        UserDefaults.standard.removeObject(forKey: "review")
                        self.animalSucInOrder = ""
                        //  DispatchQueue.main.async {
                        if self.msgAnimalSucess == false {
                            if self.addContiuneBtn == 1 {
                                if self.msgcheckk == true {
                                    self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 1, position: .bottom)
                                }
                                else {
                                    
                                    if self.isautoPopulated == true {
                                        self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 1, position: .bottom)
                                    } else {
                                        self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 1, position: .bottom)
                                    }
                                }
                            } else if self.addContiuneBtn == 2{
                                //  self.isautoPopulated = false
                                if self.msgcheckk == true {
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                                }
                                else{
                                    if self.isautoPopulated == true {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                                        
                                    } else {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                                    }
                                }
                            }else {
                                if self.msgcheckk == true {
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                                }
                                else{
                                    if self.isautoPopulated == true {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                                        
                                    } else {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                                    }
                                }
                                
                            }
                            self.msgAnimalSucess = false
                        } else {
                            if self.msgcheckk == true {
                                self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 1, position: .bottom)
                            }
                            else{
                                if self.isautoPopulated == true {
                                    self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 1, position: .bottom)
                                }else {
                                    self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 1, position: .bottom)
                                    
                                }
                            }
                        }
                    }
                    
                    
                }
            }
            UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "NZBeeftsu")
            
            UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "NZBeeftsuClear")
            
            
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: "isBarCodeIncrementalClear")
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                
                UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                
            }
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            byDefaultSetting()
            textFieldBackroungGrey()
            genderToggleFlag = 0
          genderString = "Female".localized
            
            scanAnimalTagTextField.text = ""
            scanBarcodeTextfield.text = ""
            barAutoPopu = false
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = "MM/dd/yyyy"
            }
            else {
                formatter.dateFormat = "dd/MM/yyyy"
            }
            dateTextField.text = ""
            dateBttnOutlet.setTitle("", for: .normal)
            dateBttnOutlet.setTitle(nil, for: .normal)
            completionHandler(true)
        }
        dateVale = ""
        //BARCODE INCREMENTAL
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: "barcodeIncremental")
        }
        incrementalBarCode = ""
    }
    @IBAction func maleFemaleAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if(genderToggleFlag == 0) {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString("Male", comment: "")
        }
        else {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
          genderString = "Female".localized
            
        }
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
        
    }
    func tableViewpop() {
        
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        
        buttonbg2.addTarget(self, action:#selector(self.buttonPreddDroper), for: .touchUpInside)
        
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
    }
    
    func statusOrderTrue() -> Bool{
        
        let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal,customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        }else{
            return false
        }
        
    }
    @IBAction func tissueBtnnAction(_ sender: UIButton) {
        btnTag = 20
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        tissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        
        var yFrame = (tissueLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (tissueLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (tissueLbl.frame.minY + 110) - self.scrolView.contentOffset.y
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (tissueLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 150)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    func initialNetworkCheck(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected".localized {
            
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    @objc func checkForReachability(notification:Notification){
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected".localized {
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
            
        }
        else {
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            offLineBtn.isEnabled = true
            
        }
    }
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressed), for: .touchUpInside)
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
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    @IBAction func continueAction(_ sender: UIButton) {
        
        addContiuneBtn = 2
        let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        identify1 = true
        let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
        
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        
        // if  identyCheck == false || identyCheck == nil{
        if data1.count > 0 {
            if scanAnimalTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                self.pageLoading()
            } else {
                
                addAnimalBtn(completionHandler: { (success) -> Void in
                    
                    
                    if success == true{
                        
                        self.pageLoading()
                    }
                })
            }
        }
        else {
            
            if scanAnimalTagTextField.text == "" || scanBarcodeTextfield.text == ""{
                
                if scanAnimalTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please add at least one animal.", comment: ""))
                    self.validation()
                } else {
                    
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                    self.validation()
                    
                    
                }
            }
            else {
                
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success == true{
                        self.pageLoading()
                    }
                })
                
                
            }
        }
        // }
        //else{
        
        if data1.count > 0 {
            if scanAnimalTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                self.pageLoading()
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success == true{
                        self.pageLoading()
                    }
                })
            }
        }
        else{
            addAnimalBtn(completionHandler: { (success) -> Void in
                if success == true{
                    self.pageLoading()
                }
            })
        }
    }
    
    func pageLoading() {
        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
        
        if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
            
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
            
        } else {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
        }
    }
    @IBAction func scanBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        /*let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil) */
        
        
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
                vc?.delegate = self
                self.present(vc!, animated: true, completion: nil)
        
    }
    
 /*   private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        scanBarcodeTextfield.text = code
        
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }*/
    func validation() {
        
        if scanAnimalTagTextField.text == ""{
            
            earTagView.layer.borderColor = UIColor.red.cgColor
            // scannerView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            earTagView.layer.borderColor = UIColor.gray.cgColor
            // scannerView.layer.borderColor = UIColor.gray.cgColor
        }
        if scanBarcodeTextfield.text == ""{
            barcodeView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            barcodeView.layer.borderColor = UIColor.gray.cgColor
        }
        if breedRegTextfield.text == ""{
            breedRegTextfield.layer.borderColor = UIColor.red.cgColor
        }
        else {
            breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBAction func earTagOCRbtn(_ sender: UIButton) {
        setUpGallary()
    }
    
    private func startAnimating(){
        // self.activity.startAnimating()
    }
    private func stopAnimating(){
        //   self.activity.stopAnimating()
    }
    
    private func setUpGallary(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imgPhotoLib = UIImagePickerController()
            imgPhotoLib.delegate = self
            imgPhotoLib.allowsEditing = true
            imgPhotoLib.sourceType = .camera
            self.present(imgPhotoLib,animated: true,completion: nil)
        }
    }
    private func setVisionTextRecognizeImage(image: UIImage){
        var textStr = ""
        request = VNRecognizeTextRequest(completionHandler: {(request,error)in
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Received invalid observation")
            }
            for observation in observations{
                guard let topCandidate = observation.topCandidates(1).first else{
                   
                    continue
                }
                textStr += "\n\(topCandidate.string)"
                DispatchQueue.main.async {
                    self.stopAnimating()
                    
                    
                    let trimmed = (textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                    let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                    self.methReturn = self.ukTagReutn(animalId: test.uppercased())
                    if self.methReturn == "againClick" {
                        
                        
                        self.scanAnimalTagTextField.text = ""
                        var mesageShow = String()
                      mesageShow = "Unable to read Value from tag. Please try again. Scanned Result".localized(with: test)
                       
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            
//                            self.setUpGallary()
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
                            let vc = storyboard.instantiateViewController(withIdentifier: "TextScanVC") as? TextScanVC
                            vc?.delegate = self
                            self.navigationController?.pushViewController(vc!, animated: true)
                          /*let scannerViewController = VNDocumentCameraViewController()
                          scannerViewController.delegate = self
                          present(scannerViewController, animated: true)*/
                            
                            //SAVE DEMO DATA HERE
                        })
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
                            (_)in
                            //do something
                        })
                        let thirdAction = UIAlertAction(title: NSLocalizedString("Use scanned value anyways", comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            
                            self.scanAnimalTagTextField.text = test
                            self.dataPopulateInFocusChange()
                            self.textFieldBackroungWhite()
                            //do another thing
                        })
                        
                        alert.addAction(OKAction)
                        alert.addAction(cancelAction)
                        alert.addAction(thirdAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    
                    self.scanAnimalTagTextField.text = self.methReturn
                    self.dataPopulateInFocusChange()
                    self.textFieldBackroungWhite()
                    
                    
                }
            }
        })
        
        request.customWords = ["custOm"]
        request.minimumTextHeight = 0.03125
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en_US"]
        request.usesLanguageCorrection = true
        let requests = [request]
        DispatchQueue.global(qos: .userInitiated).async {
            guard let img1 = image.cgImage else{
                fatalError("Missing image to scan")
            }
            let handle = VNImageRequestHandler(cgImage: img1, options: [:])
            try?handle.perform(requests)
        }
    }
    func ukTagReutn(animalId:String)-> String{
        
        let idAnimal = animalId.uppercased()
        let stringResult = idAnimal.contains("UK")
        if stringResult == true {
            let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
            let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
            
            let dropTwelveElement = test.suffix(12).uppercased()
            let totalString =  dropTwelveElement
            return totalString
            
        } else {
            let stringResultUS = idAnimal.contains("US")
            let stringResult840 = idAnimal.contains("840")
            
            if stringResultUS == true && stringResult840 == true {
                
                let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
                let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                if test.count < 15 {
                  
                    return "againClick"
                    
                } else {
                    
                    guard let range: Range<String.Index> = test.range(of: "840") else {
                       
                        return "againClick"
                        
                    }
                    let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
                    
                    let countt = index + 14
                    if test.count < countt {
                        return "againClick"
                    }
                    else {
                        let indexGet = test.subString(from: index, to: index + 14)
                       
                        return indexGet
                    }
                }
            } else {
                return "againClick"
            }
        }
        
        return "againClick"
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        startAnimating()
        
        self.scanAnimalTagTextField.text = ""
        
        guard let image = info[.editedImage] as? UIImage else {
           
            return
        }
        
        
        // self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
        
    }
    
    
    @IBOutlet weak var clearFormOutlet: UIButton!
    
    
    
    @IBAction func clearFromAction(_ sender: Any) {
      self.view.endEditing(true)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString("Are you sure you want to reset form?", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            
            self.byDefaultSetting()
            
            var tissueName = UserDefaults.standard.string(forKey: "NZBeeftsuClear")
            
            if UserDefaults.standard.string(forKey: "NZBeeftsuClear") == nil || UserDefaults.standard.string(forKey: "NZBeeftsuClear") == "" {
                
                self.tissueBttnOutlet.setTitle("Allflex (TSU)", for: .normal)
                self.tissuId = 1
            } else {
                var codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: self.pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
                if naabFetch1!.count == 0 {
                    
                } else {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.tissueBttnOutlet.setTitle(tissueName, for: .normal)
                UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: "tsu")
                
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear")
            
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
               
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
               
                self.incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            
            self.scanAnimalTagTextField.becomeFirstResponder()
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
}
extension BeefAnimalNZ_VC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == damRegTextfield ) {
            
            damRegTextfield.returnKeyType = UIReturnKeyType.done
        } else {
            scanAnimalTagTextField.returnKeyType = UIReturnKeyType.next
            scanBarcodeTextfield.returnKeyType = UIReturnKeyType.next
            animalNameTextfield.returnKeyType = UIReturnKeyType.next
            sireRegTextfield.returnKeyType = UIReturnKeyType.next
            breedRegTextfield.returnKeyType = UIReturnKeyType.next
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if barAutoPopu == false {
            barcodeflag = true
        } else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                if textField == scanAnimalTagTextField || textField == damRegTextfield || textField == sireRegTextfield || textField == breedRegTextfield ||  textField == animalNameTextfield {
                    barcodeEnable = true
                }
            }
        }
        
        if  (string == " ") {
            return false
        }
        
        if textField == scanBarcodeTextfield {
            let currentString: NSString = scanBarcodeTextfield.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                    checkBarcode = false
                } else {
                    //  incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    //self.defaultIncrementalBarCodeSetting()
                    checkBarcode = true
                    
                }
            }
        }
        
       
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
               
                if textField == scanAnimalTagTextField{
                    if scanAnimalTagTextField.text!.count == 1 {
                        textFieldBackroungGrey()
                    } else {
                        
                        textFieldBackroungWhite()
                    }
                    isautoPopulated = false
                } else if textField == scanBarcodeTextfield {
                    barcodeflag = true
                    if scanBarcodeTextfield.text!.count == 1 {
                        
                        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        self.isBarcodeAutoIncrementedEnabled = false
                        checkBarcode = false
                    } else {
                       
                    }
                    
                }
                return true
                
            } else {
                if textField == scanAnimalTagTextField{
                    isautoPopulated = false
                    textFieldBackroungWhite()
                }
            }
            
            if editIngText == true{
                editIngText = false
                
            }
            
            else if isUpdate == true {
                animalId1 = editAid
                isUpdate = false
            }
            if statusOrder == true{
                msgAnimalSucess = true
            }
            else{
                messageCheck = true
            }
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal,customerID: custmerId)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
            // barcodeflag = true
            
            if isautoPopulated == true {
                let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
                if animalData.count == 0{
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgcheckk = true
                    }
                }
            }
        }
        
        
        if textField == dateTextField {
            
            if dateTextField.text?.count == 2 || dateTextField.text?.count == 5{
                dateTextField.text?.append("/")
            }
            if dateTextField.text?.count == 10 {
                return false
            }
        }
        
        
        if textField == scanBarcodeTextfield {
            
            let ACCEPTABLE_CHARACTERS = "+?%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
                return false
            }
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateTextField {
            if dateTextField.text!.count == 0{
                
            }  else {
              
                if dateTextField.text?.count == 10 {
                    
                    var validate = isValidDate(dateString: dateTextField.text ?? "")
                   
                    if validate == "Correct Format" {
                        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                        dateBttnOutlet.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        //  dateBttnOutlet.layer
                        dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                        if validate == "GreaterThenDate" {
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                            
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                            
                        }
                    }
                    
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    // dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                    
                }
            }
        }
        if textField == scanAnimalTagTextField {
            self.dataPopulateInFocusChange()
        }
    }
    func isValidDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        // dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        if dateStr == "MM"{
            
            dateFormatterGet.dateFormat = "MM/dd/yyyy"
            
            
        } else {
            dateFormatterGet.dateFormat = "dd/MM/yyyy"
            
        }
        if let dateGet = dateFormatterGet.date(from: dateString) {
            //date parsing succeeded, if you need to do additional logic, replace _ with some variable name i.e date
            
            var smallDate = dateGet.isSmallerThan(Date())
           
            if smallDate == false {
                
                return "GreaterThenDate"
            }
            
            
            return "Correct Format"
        } else {
            // Invalid date
            return  "invalid format"
        }
    }
    
    func dataPopulateInFocusChange(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        var samplename = String()
        let ob =  fetchAllData(entityName: "BeefAnimalMaster")
        let addAnimal = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanAnimalTagTextField.text!, farmId: "", animalbarCodeTag: scanBarcodeTextfield.text!, offPermanentId: breedRegTextfield.text!, offDamId: damRegTextfield.text!, offsireId: sireRegTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:scanAnimalTagTextField.text!, farmId: "", animalbarCodeTag: scanBarcodeTextfield.text!, offPermanentId: breedRegTextfield.text!, offDamId: damRegTextfield.text!, offsireId: sireRegTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        
        if isautoPopulated == false{
            if animalData.count > 0 {
                isautoPopulated = true
                textFieldBackroungWhite()
                barAutoPopu = true
                barcodeflag = false
                updateOrder = true
                var data =  animalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                ////////start
                let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
                animalId1 = Int(data.animalId)
                
                /////////end
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                dateBttnOutlet.titleLabel!.text = ""
                
                
                if data.date != ""{
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                dateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                        }
                        formatter.dateFormat = "MM/dd/yyyy"
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        
                    } else {
                        if dateBttnOutlet.titleLabel!.text != nil {
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                            
                        }
                        else {
                            //self.selectedDate = Date()
                        }
                        //self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                        let dates =  formatter.string(from: selectedDate)
                    }}
                
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: "NZBeeftsu")
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                breedId = data.breedId!
                samplename = data.tissuName!
                let pvidAA = data.providerId
                UserDefaults.standard.set(data.breedName, forKey: "NZBeefbreed")
                
              if data.gender == "Male".localized || data.gender == "M" {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    
                } else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                  genderString = "Female".localized
                    
                }
                
                
                
                var dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    //  scanBarcodeTextfield.text = ""
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                    incrementalBarcodeButton.isEnabled = true
                } else {
                    if data.orderstatus == "true"{
                        //  scanBarcodeTextfield.text = ""
                        checkBarcode = false
                        incrementalBarcodeTitleLabel.textColor = .black
                        incrementalBarcodeButton.isEnabled = true
                        incrementalBarcodeTitleLabel.alpha = 1
                        incrementalBarcodeCheckBox.alpha = 1
                    } else {
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeTitleLabel.textColor = .gray
                        checkBarcode = false
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        incrementalBarcodeCheckBox.alpha = 0.6
                        
                    }
                }
                
                tissuId = Int(data.tissuId)
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    //statusOrder = true
                    messageCheck = true
                }
            }
            
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        var samplename = String()
        let ob =  fetchAllData(entityName: "BeefAnimalMaster")
        let addAnimal = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanAnimalTagTextField.text!, farmId: "", animalbarCodeTag: scanBarcodeTextfield.text!, offPermanentId: breedRegTextfield.text!, offDamId: damRegTextfield.text!, offsireId: sireRegTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:scanAnimalTagTextField.text!, farmId: "", animalbarCodeTag: scanBarcodeTextfield.text!, offPermanentId: breedRegTextfield.text!, offDamId: damRegTextfield.text!, offsireId: sireRegTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        
        if isautoPopulated == false{
            if animalData.count > 0 {
                isautoPopulated = true
                textFieldBackroungWhite()
                barAutoPopu = true
                barcodeflag = false
                updateOrder = true
                var data =  animalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                ////////start
                let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
                animalId1 = Int(data.animalId)
                
                /////////end
                
                var dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                    incrementalBarcodeButton.isEnabled = true
                    // incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                } else {
                    if data.orderstatus == "true"{
                        //   scanBarcodeTextfield.text = ""
                        checkBarcode = false
                        incrementalBarcodeTitleLabel.textColor = .black
                        incrementalBarcodeButton.isEnabled = true
                        incrementalBarcodeTitleLabel.alpha = 1
                        incrementalBarcodeCheckBox.alpha = 1
                    } else {
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeTitleLabel.textColor = .gray
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        incrementalBarcodeCheckBox.alpha = 0.6
                        
                        checkBarcode = false
                    }
                }
                
                
                dateBttnOutlet.titleLabel!.text = ""
                
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                if data.date != ""{
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                dateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                        }
                        formatter.dateFormat = "MM/dd/yyyy"
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        
                    } else {
                        if dateBttnOutlet.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                            
                        }
                        else{
                            //   self.selectedDate = Date()
                        }
                        //self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                        let dates =  formatter.string(from: selectedDate)
                    }
                }
                
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: "NZBeeftsu")
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                breedId = data.breedId!
                samplename = data.tissuName!
                let pvidAA = data.providerId
                UserDefaults.standard.set(data.breedName, forKey: "NZBeefbreed")
                
              if data.gender == "Male".localized || data.gender == "M" {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    
                } else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                  genderString = "Female".localized
                    
                }
                
                tissuId = Int(data.tissuId)
                textField.resignFirstResponder()
                
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    //statusOrder = true
                    messageCheck = true
                }
            }
            
        }
        else{
            
            if scanAnimalTagTextField.text!.count > 0 {
                textFieldBackroungWhite()
            }
            else{
                textFieldBackroungGrey()
            }
        }
        if textField == scanAnimalTagTextField {
            
            if scanAnimalTagTextField.text == ""{
                
                earTagView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                earTagView.layer.borderColor = UIColor.gray.cgColor
            }
            scanBarcodeTextfield.becomeFirstResponder()
        }
        if textField == scanBarcodeTextfield {
            if scanBarcodeTextfield.text == ""{
                barcodeView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                barcodeView.layer.borderColor = UIColor.gray.cgColor
            }
            breedRegTextfield.becomeFirstResponder()
        }
        if textField == breedRegTextfield {
            if breedRegTextfield.text == ""{
                breedRegTextfield.layer.borderColor = UIColor.red.cgColor
            }
            else {
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            animalNameTextfield.becomeFirstResponder()
        }
        if textField == animalNameTextfield {
            sireRegTextfield.becomeFirstResponder()
        }
        if textField == sireRegTextfield {
            damRegTextfield.becomeFirstResponder()
        }
        if textField == damRegTextfield {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
extension BeefAnimalNZ_VC : objectPickCartScreen,SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
    
    func objectGetOnSelection(temp: Int) {
        
    }
    func anOptionalMethod(check :Bool){
        
        if check == true{
            isUpdate = false
            editIngText = false
            statusOrder = false
            //       msgAnimalSucess = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            textFieldBackroungGrey()
            msgUpatedd = false
        }}
}

extension BeefAnimalNZ_VC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == importTblView {
            
            return importListArray.count
        }
        if btnTag == 20 {
            return tissueArr.count
        }
        else if btnTag == 80{
            return breedRegArr.count
        }
        else{
            return breedArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        if tableView == importTblView {
            
            let cell :ImportListCell = importTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImportListCell
            
            cell.listNameLabel.text = importListArray[indexPath.row].listName
            cell.listNameDescLbl.text = importListArray[indexPath.row].listDesc
            return cell
        }
        
        if btnTag == 20{
            
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
          
          cell.textLabel?.text = tissue.sampleName?.localized
          
            return cell
        }
        
        if btnTag == 10{
            let breed = breedArr[indexPath.row] as! GetBreedsTbl
            
            cell.textLabel?.text = breed.threeCharCode
            return cell
        }
        if btnTag == 80{
            let tissue = self.breedRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        barcodeEnable = true
        if tableView == importTblView {
            
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName
            
            var customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
            listNameString = listName ?? ""
            listId = Int(listId1)
            
            
            return
        }
        if btnTag == 20  {
            
            let tissue = self.tissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
           
         
          tissueBttnOutlet.setTitle(tissue.sampleName?.localized, for: .normal)
             
           
            //    UserDefaults.standard.set(tissue.sampleName, forKey: "NZBeeftsu")
            buttonbg2.removeFromSuperview()
            
        }
        if btnTag == 10  {
            
            let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitle(breed.threeCharCode, for: .normal)
            UserDefaults.standard.set(breed.threeCharCode, forKey: "NZBeefbreed")
            buttonbg2.removeFromSuperview()
            
        }
        if btnTag == 80  {
            
            let breedReg = breedRegArr[indexPath.row] as! GetBreedSocieties
            let damRegID = Int(breedReg.associationId!)
            if damRegID == 80 {
                breedRegAssociationBttn.setTitleColor(.black, for: .normal)
                breedRegAssociationBttn.setTitle(breedReg.association, for: .normal)
                UserDefaults.standard.set(breedReg.association, forKey: "NZBeefBreedReg")
            }
            else{
                CommonClass.showAlertMessage(self, titleStr:NSLocalizedString(AlertMessagesStrings.alertString, comment: "") , messageStr: NSLocalizedString("Only 'NZ Angus Association' is allowed for this product", comment: ""))
            }
            buttonbg2.removeFromSuperview()
            
        }
        
    }
}

extension BeefAnimalNZ_VC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}
extension BeefAnimalNZ_VC : AnimalMergeProtocol{
    func refreshUI() {
        
        
        let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
        self.notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0 {
            self.notificationLblCount.isHidden = true
            self.countLbl.isHidden = true
            self.crossBtnOutlet.isHidden = true
            self.mergeListBtnOulet.isHidden = true

        } else {
            self.notificationLblCount.isHidden = false
            self.countLbl.isHidden = false
            self.crossBtnOutlet.isHidden = false

            self.mergeListBtnOulet.isHidden = false
        }
        
        
        
        
        let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid)
        if fetchObj.count != 0 {
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
            
            if fetchAllMergeDta == 0 {
                let fetchNameDisplay = String(obj ?? "")
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            } else {
                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            }
        } else {
            mergeListBtnOulet.isHidden = true
            crossBtnOutlet.isHidden = true

        }
    }
}

extension BeefAnimalNZ_VC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        print("scanned QR value -> \(qrValue)")
        scanBarcodeTextfield.text = qrValue
    }
}

extension BeefAnimalNZ_VC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        scanAnimalTagTextField.text = scannedResult
        scanAnimalTagTextField.text = scannedResult
    }
}
