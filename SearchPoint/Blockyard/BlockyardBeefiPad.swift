//
//  BlockyardBeefiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 22/01/25.
//

import Foundation
import Toast_Swift
import Vision
import VisionKit
import CoreBluetooth

class BlockyardBeefiPad : UIViewController,offlineCustomView1,/*BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate,*/UIImagePickerControllerDelegate & UINavigationControllerDelegate,VNDocumentCameraViewControllerDelegate {
  func crossBtn() {
    buttonbg.removeFromSuperview()
    customPopView1.removeFromSuperview()
}
    @IBOutlet weak var cartView: UIView!

    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritGenderView: UIView!
    @IBOutlet weak var inheritTissueView: UIView!
    @IBOutlet weak var inheritEIDView: UIView!
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var inheritScrollViewHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var testViewHeightConstrains: NSLayoutConstraint!
    let tapRec = UITapGestureRecognizer()
   
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var importListMainView: UIView!
    @IBOutlet weak var importBackroundView: UIView!
    @IBOutlet weak var importTblView: UITableView!
    @IBOutlet weak var selectListLbl: UILabel!
    var listNameString = String()
    var value = 0
    @IBAction func cancelBtnAction(_ sender: Any) {
        
        importListMainView.isHidden = true
        importBackroundView.isHidden = true
        
    }
    var listId = Int()
    var conflictArr = [DataEntryBeefAnimaladdTbl]()
    var isAnimalComingFromCart = Bool()
    var genderArray = ["Female","Male"]
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
  // MARK: - NavigateToBeefOrderingScreen
  func NavigateToBeefOrderingScreen() {
    let viewAnimalArray =  beefFetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid) as! [BeefAnimaladdTbl]
    let dataListAnimals : [BeefAnimaladdTbl] = viewAnimalArray as! [BeefAnimaladdTbl]
    let animals = dataListAnimals.filter({ $0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil })
    let cartAnimal = viewAnimalArray.filter(({ $0.animalTag?.count ?? 0 < 15 ||  $0.animalTag?.count ?? 0 > 16 }))
    if cartAnimal.count > 0 {
      let alert = UIAlertController(title: NSLocalizedString("Alert",comment: ""), message: "Animal(s) in the cart do not have the valid Unique ID. Please review the cart to update the animal record(s).".localized(with: cartAnimal.count), preferredStyle: .alert)
      let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
        
          let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
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
    else if animals.count > 0 {
      
      let alert = UIAlertController(title: NSLocalizedString("Alert",comment: ""), message: "Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
      
      let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
        
        let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
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
        let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
    
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
      
    }
  }
  
  // MARK: - ShowAlertforwithoutBarcodeAnimal
  func showAlertforwithoutBarcodeAnimal(importListAnimal: [DataEntryBeefAnimaladdTbl]) {
   
     let animals = importListAnimal.filter({$0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil})
    
      if animals.count > 0 {
        
        let alert = UIAlertController(title: NSLocalizedString("Alert",comment: ""), message:"Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
       
        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
          
         // self.viewAnimalClick(<#UIButton#>)
//          barcodeScreen = false
//          selectedDate = Date()
//          // InheritSelectedDate = Date()
          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
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
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select list to import.", comment: "") )
            return
        }
        
        var allDataAnimalTbl1 = fetchAllDataAnimalAnimalIgnoreCase(entityName: "DataEntryBeefAnimaladdTbl",custmerId :UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),userID :self.userId,listId:Int64(self.listId))
        
        if allDataAnimalTbl1.count == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        //BeefProduct Inherit
            
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: "BeefAnimaladdTbl", orderId: autoD, userId: userId,providerId:self.pvid)
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let earTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ?? 0),providerId:pvid,earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                   
                    if dataEntryVALE.count > 0 {
                        
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                        
                    }
                }
                
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
                    
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                        
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true
                        
                    })
                    
                    alert.addAction(cancel)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                        
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                        if fetchData11.count != 0 {
                            
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                              
                              let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: "BeefAnimaladdTbl",animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    
                                  let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
                                    if data12333.count > 0{
                                        if inheritTissueBttn.titleLabel!.text! == "Allflex (TSU)" ||  inheritTissueBttn.titleLabel!.text! == "Caisley (TSU)" {//|| tissuId == 16 || tissuId == 18 {
                                          inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ?? 0), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ?? 0), listId: dataGet.listId ?? 0, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "DataEntryBeefInheritTsu")
                                            UserDefaults.standard.set(dataGet.breedName ?? "", forKey: "DataEntryInheritBeefbreed")
                                            
                                          self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                            self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                            
                                          createDataList()
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                            
                                            // Create the actions
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                // self.byDefaultSetting()
                                                self.inheritByDefaultSetting()
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                NSLog("Cancel Pressed")
                                                
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: "ProductAdonAnimlTbLBeef")
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: "SubProductTblBeef")
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: "BeefAnimaladdTbl")
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                                self.notificationLblCount.text = String(animalCount.count)
                                                self.inheritByDefaultSetting()
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
                                      inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ?? 0), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ?? 0), listId: dataGet.listId ?? 0, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "DataEntryBeefInheritTsu")
                                        UserDefaults.standard.set(dataGet.breedName ?? "", forKey: "DataEntryInheritBeefbreed")
                                        
                                      self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                        self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                      createDataList()
                                    }
                                    
                                    let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                    let productCount = UserDefaults.standard.integer(forKey: "productCount")
                                    let product  = fetchAllData(entityName: "GetProductTblBeef")
                                    
                                    
                                    for k in 0 ..< animalData.count{
                                        
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        
                                        for i in 0 ..< product.count {
                                            
                                            let data = product[i] as! GetProductTblBeef
                                            
                                            saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                                            
                                            let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                                            
                                            for j in 0 ..< addonArr.count {
                                                
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == "BVDV" { //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                                        saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: "GetAdonTbl", productId: Int(addonDat.adonId), status: "true")
                                                    }
                                                    else{
                                                        saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                                
                                                
                                                let message = NSLocalizedString("Animal added successfully.", comment: "")
                                                statusOrder = false
                                                UserDefaults.standard.removeObject(forKey: "review")
                                                self.animalSucInOrder = ""
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                    notificationLblCount.text = String(animalCount.count)
                                    if animalCount.count == 0{
                                        self.notificationLblCount.isHidden = true
                                        self.countLbl.isHidden = true
                                        self.cartView.isHidden = true
                                    } else {
                                        self.notificationLblCount.isHidden = false
                                        self.countLbl.isHidden = false
                                        self.cartView.isHidden = false
                                    }
                                    self.inheritCrossBtnOutlet.isHidden = false
                                    // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                                    // self.inheritImportFromOutlet.setAttributedTitle(attributeString, for: .normal)
                                    UserDefaults.standard.setValue(self.listNameString, forKey: "dataEnteryListName")
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                                    inheritImportFromOutlet.isEnabled = true
                                    self.importBackroundView.isHidden = true
                                    self.importListMainView.isHidden = true
                                    self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                                    
                                  showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                    
                                    if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: "DataEntryList",listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        
                                        saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        }
                                        
                                        let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
                                        if fetchObj.count != 0 {

                                            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                            let obj = objectFetch?.listName
                                            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            InheritmergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            InheritmergeListBtnOulet.isHidden = false
                                        }
                                    }
                                    
                                }
                                let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                
                                if fetchCheckListId.count == 0{
                                    self.view.makeToast(NSLocalizedString("No animals added to the order.", comment: ""), duration: 2, position: .top)
                                    self.importBackroundView.isHidden = true
                                    self.importListMainView.isHidden = true
                                }
                            }
                            
                            
                        }
                        
                        
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
                            
                           
                            
                            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: "BeefAnimaladdTbl",animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
                                if data12333.count > 0{
                                    if inheritTissueBttn.titleLabel!.text! == "Allflex (TSU)" || inheritTissueBttn.titleLabel!.text! == "Allflex (TST)" || inheritTissueBttn.titleLabel!.text! == "Caisley (TSU)" {//|| tissuId == 16 || tissuId == 18 {
                                      inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ?? 0),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ?? 0),productId:Int(dataGet.productId ?? 0), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ?? 0), listId: dataGet.listId ?? 0, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "DataEntryBeefInheritTsu")
                                        UserDefaults.standard.set(dataGet.breedName ?? "", forKey: "DataEntryInheritBeefbreed")
                                        
                                      self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                        self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                      createDataList()
                                        
                                    }
                                    else{
                                        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                        
                                        // Create the actions
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            // self.byDefaultSetting()
                                            self.inheritByDefaultSetting()
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            NSLog("Cancel Pressed")
                                            
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: "ProductAdonAnimlTbLBeef")
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: "SubProductTblBeef")
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: "BeefAnimaladdTbl")
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                            self.notificationLblCount.text = String(animalCount.count)
                                            self.inheritByDefaultSetting()
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
                                    
                                  inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ?? 0),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ?? 0),productId:Int(dataGet.productId ?? 0), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId), listId: dataGet.listId ?? 0, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "DataEntryBeefInheritTsu")
                                    UserDefaults.standard.set(dataGet.breedName ?? "", forKey: "DataEntryInheritBeefbreed")
                                    
                                  self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                    self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                  createDataList()
                                }
                                
                                let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                let productCount = UserDefaults.standard.integer(forKey: "productCount")
                                let product  = fetchAllData(entityName: "GetProductTblBeef")
                                
                                
                                for k in 0 ..< animalData.count{
                                    
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    
                                    for i in 0 ..< product.count {
                                        
                                        let data = product[i] as! GetProductTblBeef
                                        
                                        saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                                        
                                        let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                                        
                                        for j in 0 ..< addonArr.count {
                                            
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data12333.count > 0 {
                                                if addonDat.adonName == "BVDV" { //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                                    saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    updateProductTablevaleeSingleeInBef(entity: "GetAdonTbl", productId: Int(addonDat.adonId), status: "true")
                                                }
                                                else{
                                                    saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                            
                                            
                                            let message = NSLocalizedString("Animal added successfully.", comment: "")
                                            statusOrder = false
                                            UserDefaults.standard.removeObject(forKey: "review")
                                            self.animalSucInOrder = ""
                                        }
                                        
                                        
                                    }
                                }
                                let animalCount = fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0{
                                    self.notificationLblCount.isHidden = true
                                    self.countLbl.isHidden = true
                                    self.cartView.isHidden = true
                                } else {
                                    self.notificationLblCount.isHidden = false
                                    self.countLbl.isHidden = false
                                    self.cartView.isHidden = false
                                }
                                self.inheritCrossBtnOutlet.isHidden = false
                                UserDefaults.standard.setValue(self.listNameString, forKey: "dataEnteryListName")
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                                inheritImportFromOutlet.isEnabled = true
                                self.importBackroundView.isHidden = true
                                self.importListMainView.isHidden = true
                                self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                                
                              showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                
                                if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                    
                                    let fetchList = fetchMergeDataListId(entityName: "DataEntryList",listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
                                    if fetchObj.count != 0 {

                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        InheritmergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        InheritmergeListBtnOulet.isHidden = false
                                    }
                                }
                                
                            }}}}
                
            }else {
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        
                       
                        
                        var fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: "BeefAnimaladdTbl",animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        if fetchCountGirlando.count == 0 {
                            
                          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
                            if data12333.count > 0{
                                if inheritTissueBttn.titleLabel!.text! == "Allflex (TSU)" || inheritTissueBttn.titleLabel!.text! == "Allflex (TST)" || inheritTissueBttn.titleLabel!.text! == "Caisley (TSU)" {//|| tissuId == 16 || tissuId == 18 {
                                  inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ?? 0),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ?? 0),productId:Int(dataGet.productId ?? 0), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ?? 0), listId: dataGet.listId ?? 0, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "DataEntryBeefInheritTsu")
                                    UserDefaults.standard.set(dataGet.breedName ?? "", forKey: "DataEntryInheritBeefbreed")
                                    
                                  self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                    self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                  createDataList()
                                }
                                else{
                                    let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                                    
                                    // Create the actions
                                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        // self.byDefaultSetting()
                                        self.inheritByDefaultSetting()
                                    }
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        NSLog("Cancel Pressed")
                                        
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: "ProductAdonAnimlTbLBeef")
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: "SubProductTblBeef")
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: "BeefAnimaladdTbl")
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                        self.notificationLblCount.text = String(animalCount.count)
                                        self.inheritByDefaultSetting()
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
                              inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ?? 0) ,tissuId: Int(dataGet.tissuId ?? 0),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ?? 0),productId:Int(dataGet.productId ?? 0), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ?? 0), listId: dataGet.listId ?? 0, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                
                                
                                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "DataEntryBeefInheritTsu")
                                UserDefaults.standard.set(dataGet.breedName ?? "", forKey: "DataEntryInheritBeefbreed")
                                
                              self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                              createDataList()
                                
                            }
                            
                            let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                            let productCount = UserDefaults.standard.integer(forKey: "productCount")
                            let product  = fetchAllData(entityName: "GetProductTblBeef")
                            
                            
                            for k in 0 ..< animalData.count{
                                
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                
                                for i in 0 ..< product.count {
                                    
                                    let data = product[i] as! GetProductTblBeef
                                    
                                    saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                                    
                                    let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                                    
                                    for j in 0 ..< addonArr.count {
                                        
                                        let addonDat = addonArr[j] as! GetAdonTbl
                                        if data12333.count > 0 {
                                            if addonDat.adonName == "BVDV" { //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                                saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                updateProductTablevaleeSingleeInBef(entity: "GetAdonTbl", productId: Int(addonDat.adonId), status: "true")
                                            }
                                            else{
                                                saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                        else {
                                            saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        }
                                        
                                        
                                        let message = NSLocalizedString("Animal added successfully.", comment: "")
                                        statusOrder = false
                                        UserDefaults.standard.removeObject(forKey: "review")
                                        self.animalSucInOrder = ""
                                      
                                    }
                                }
                            }
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                            notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                                self.cartView.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                                self.cartView.isHidden = false
                            }
                            self.inheritCrossBtnOutlet.isHidden = false
                            //   let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                            //   self.inheritImportFromOutlet.setAttributedTitle(attributeString, for: .normal)
                            UserDefaults.standard.setValue(self.listNameString, forKey: "dataEnteryListName")
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                            inheritImportFromOutlet.isEnabled = true
                            self.importBackroundView.isHidden = true
                            self.importListMainView.isHidden = true
                            self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                            
                          showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                            
                            if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: "DataEntryList",listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                
                                saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
                                if fetchObj.count != 0 {

                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    InheritmergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    InheritmergeListBtnOulet.isHidden = false
                                }
                            }
                            
                        }}}}
        
    }
    var request = VNRecognizeTextRequest(completionHandler: nil)
    
    @IBOutlet weak var inheritDateTextField: UITextField!
    var validateDateFlag = true
    
    @IBOutlet weak var globalDateTextField: UITextField!
    @IBOutlet weak var ocrBtnOutlet: UIButton!
    @IBOutlet weak var globalOcrBtnOutlet: UIButton!
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.init(red: 29/225, green: 131/225, blue: 174/225, alpha: 1.0),.underlineStyle: NSUnderlineStyle.single.rawValue]
    var checkBarcode = Bool()
    
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var orderingTitleLbl: UILabel!
    var barAutoPopu =  false
    
    @IBOutlet weak var inheritbarcodeBttn: UIButton!
    
    @IBOutlet weak var barcodeBtn: UIButton!
    @IBOutlet weak var inheritDobLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var scanEarTagTextField: UITextField!
    @IBOutlet weak var continueBttn: UIButton!
    @IBOutlet weak var inheritAddBttn: UIButton!
    
    @IBOutlet weak var inheritContinueBttn: UIButton!
    @IBOutlet weak var addbttn: UIButton!
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var inheritTissueHideLbl: UILabel!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderbkg: UIView!
    @IBOutlet weak var damRegLbl: UILabel!
    @IBOutlet weak var sireRegLbl: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var earTagView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var breedRegTextfield: UITextField!
    @IBOutlet weak var dateBttnOutlet: UIButton!
    @IBOutlet weak var breedBtnOutlet: customButton!
    @IBOutlet weak var male_femaleBttnOutlet: UIButton!
    @IBOutlet weak var tissueBttnOutlet: customButton!
    @IBOutlet weak var tissueLbl: UILabel!
    @IBOutlet weak var inheritScrollView: UIScrollView!
    @IBOutlet weak var inheritRegistrationLbl: UILabel!
    @IBOutlet weak var breedRegLbl: UILabel!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    var timeStampString = String()
    var lblTimeStamp = String()
    
    @IBOutlet weak var breedRegBttn: UIButton!
    
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
  var pid : GetProductTblBeef?
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
    var yearPublic = Calendar.current.component(.year, from: Date())
    
    var barcodeflag = Bool()
    @IBOutlet weak var inheritBreedLbl: UILabel!
    
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var animalNameTextfield: UITextField!
    
    @IBOutlet weak var sireRegDropdownOutlet: customButton!
    @IBOutlet weak var damRegDropdownOutlet: customButton!
    
    @IBOutlet weak var sireRegTextfield: UITextField!
    
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var damRegTextfield: UITextField!
    
    @IBOutlet weak var inheritEarTagView: UIView!
    @IBOutlet weak var inheritBarcodeView: UIView!
    @IBOutlet weak var inheritBarcodeTextfield: UITextField!
    @IBOutlet weak var inheritEarTagTextfield: UITextField!
    @IBOutlet weak var inheritTissueBttn: UIButton!
    @IBOutlet weak var inheritEIDTextfield: UITextField!
    @IBOutlet weak var inheritSecondaryIdTextfield: UITextField!
    @IBOutlet weak var inheritBreedBttn: customButton!
    @IBOutlet weak var inheritDobBttn: UIButton!
    @IBOutlet weak var inheritMaleFemaleBttn: UIButton!
    @IBOutlet weak var inheritBreedRegTextfield: UITextField!
    @IBOutlet weak var inheritRegAssociationBttn: customButton!
    @IBOutlet weak var inheritDamYobBttn: UITextField!
    @IBOutlet weak var inheritDamIdTextfield: UITextField!
    @IBOutlet weak var inheritSireRegTextfield: UITextField!
    @IBOutlet weak var inheritSireYobBttn: UITextField!
    
    var defaltscreen = String()
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
    
    @IBOutlet weak var inheritAddBttnView: UIView!
    var sireRegArr = NSArray()
    var damRegArr = NSArray()
    var inheritBreedArr = NSArray()
    var inheritTissueArr = NSArray()
    var inheritRegArr = NSArray()
    var addContiuneBtn = Int()
    var userId = Int()// UserDefaults.standard.integer(forKey: "userId")
    var orderId = Int()
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
    var custmerId = UserDefaults.standard.integer(forKey: "currentActiveCustomerId")
    var pvid = Int()
   let orderingDataListViewModel = OrderingDataListViewModel()
    @IBOutlet weak var inheritDObView: UIView!
    
    @IBOutlet weak var incrementalBarcodeCheckBoxInherit: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabelInherit: UILabel!
    @IBOutlet weak var incrementalBarcodeButtonInherit: UIButton!
    
    @IBOutlet weak var incrementalBarcodeCheckBoxGlobal: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabelGlobal: UILabel!
    @IBOutlet weak var incrementalBarcodeButtonGlobal: UIButton!
  
    @IBOutlet weak var testView: UIView!
  
  @IBOutlet weak var pairedTableView: UITableView!
  @IBOutlet weak var pairedDeviceView: UIView!
  @IBOutlet weak var pairedBackroundView: UIView!
  @IBOutlet weak var pairedDeviceTitle: UILabel!
  
    var importListArray = [DataEntryList]()
  var tempimportListArray = [DataEntryList]()
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
  var autoPopulateAnimalData: BeefAnimaladdTbl?
    
   let langCode : String = UserDefaults.standard.object(forKey: "lngCode") as! String
  var arrNearbyDevice : [CBPeripheral] = [] {
    didSet{
      
      pairedTableView?.reloadData()
    }
  }
  @IBAction func crossPairedAction(_ sender: Any) {
      pairedBackroundView.isHidden = true
      
      pairedDeviceView.isHidden = true
      
  }
  @IBAction func rfidTippopClick(_ sender: UIButton) {
      
      let screenSize = UIScreen.main.bounds
      buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
      buttonbg1.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressedTip), for: .touchUpInside)
      buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
      self.view .addSubview(buttonbg1)
      customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
      customPopView1.elipseImage2.isHidden = true
      customPopView1.elipseImage1.isHidden = true
      customPopView1.textLbl2.isHidden = true
      
      if defaltscreen == "farmid" {
          customPopView1.frame = CGRect(x: 33,y: innerView.layer.frame.minY + 11 ,width: screenSize.width - 90, height: 70)
          customPopView1.textLabel1.text = NSLocalizedString("On-Farm ID can be the Herd Management #.", comment: "")
      } else {
          customPopView1.frame = CGRect(x: 33,y: innerView.layer.frame.minY + 11 ,width: screenSize.width - 90, height:90)
          customPopView1.textLabel1.text = NSLocalizedString("Official ID can be an Official RFID Tag, Unique Metal Ear Tag, Breed Registration#.", comment: "")
      }
      customPopView1.arrow_Top.isHidden = true
      
      customPopView1.delegate = self
      customPopView1.layer.borderColor = UIColor.blue.cgColor
      customPopView1.layer.borderWidth = 1
      customPopView1.layer.cornerRadius = 8
      customPopView1.layer.borderWidth = 3
      customPopView1.layer.borderColor =  UIColor.clear.cgColor
      self.buttonbg1.addSubview(customPopView1)
  }
  
    @IBAction func inheritImportFromAction(_ sender: Any) {
        
        view.endEditing(true)
        
        var userId = UserDefaults.standard.integer(forKey: "userId")
        let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
        listId = 0
      tempimportListArray = fetchDataEntryListGetWithProduct(entityName: "DataEntryList",customerId:Int64(currentCustomerId),userId:userId,providerId:pvid,productType:"INHERIT") as! [DataEntryList]
      if tempimportListArray.count>0 {
        importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempimportListArray)
      }
        
        if importListArray.count == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No lists available for this customer.", comment: ""))
            
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        conflictArr.removeAll()
        //
        let data1 = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId)
        if data1.count > 0{
            
            var animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: "BeefAnimaladdTbl",orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                
                
                if self.importListArray.count != 0 {
                    self.importListMainView.isHidden = false
                    self.importBackroundView.isHidden = false
                    self.importTblView.reloadData()
                    
                }
                
            } else {
                
                
                
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblView.reloadData()
                    
                }
            }
        } else {
            
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                importTblView.reloadData()
                
            }
            
        }
        
    }
    
    @IBOutlet weak var InheritmergeListBtnOulet: UIButton!
    
    @IBAction func InheritmergeListBtnClick(_ sender: Any) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AnimalMergePopUpVC") as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
        
    }
    
    @IBOutlet weak var globalMergeListBtnOulet: UIButton!
    
    @IBAction func globalMergeListBtnClick(_ sender: Any) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AnimalMergePopUpVC") as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
        
    }
    
    
    @IBOutlet weak var inheritImportFromOutlet: UIButton!
    
    
    @IBAction func inheritCrossBtnAction(_ sender: Any) {
        
        
        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Removing list will remove its animals from the order as well. Do you want to continue?", comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            
        })
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            
            var titleLbl = self.globalImportFromOutlet.titleLabel?.text
           
            
            
            let listArray = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0))
            
            for i in 0 ..< listArray.count{
                
                let listObj = listArray[i] as! MergeDataEntryList
                var listId = listObj.listId
                let custId = listObj.customerId
                
                let animalData =  fetchDataEnteryAnimalTbl(entityName: "BeefAnimaladdTbl", customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                
                if animalData.count > 0 {
                    
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! BeefAnimaladdTbl
                        deleteDataWithProductBeefDelete(Int(ad.animalId))
                        deleteDataWithSubProductAnimalId(Int(ad.animalId))
                        
                    }
                    deleteDataWithListIdDatEntry(entityString: "BeefAnimaladdTbl", listId: Int(listObj.listId), customerId: Int(listObj.customerId),userId: self.userId)
                }
            }
            
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))

            
            
            // let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import From List", comment: ""), attributes: self.attrs)
            // self.inheritImportFromOutlet.setAttributedTitle(attributeString, for: .normal)
            
            UserDefaults.standard.removeObject(forKey: "dataEnteryListName")
            self.inheritImportFromOutlet.isEnabled = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.cartView.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.cartView.isHidden = false
            }
            self.inheritCrossBtnOutlet.isHidden = true
            
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count == 0 {
                
                self.InheritmergeListBtnOulet.isHidden = true
            } else {
                self.InheritmergeListBtnOulet.isHidden = false
            }
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBOutlet weak var inheritCrossBtnOutlet: UIButton!
    
    //// global
    
    @IBAction func globalImportFromAction(_ sender: Any) {
        
        view.endEditing(true)
        

        
        var userId = UserDefaults.standard.integer(forKey: "userId")
        var currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
        listId = 0
      tempimportListArray = fetchDataEntryListGetWithProduct(entityName: "DataEntryList",customerId:Int64(currentCustomerId),userId:userId,providerId:pvid,productType:"Global HD50K") as! [DataEntryList]
      if tempimportListArray.count>0 {
        importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempimportListArray)
      }
        conflictArr.removeAll()
        if importListArray.count == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No lists available for this customer.", comment: ""))
            
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        let data1 = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId)
        if data1.count > 0{
            
            let animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: "BeefAnimaladdTbl",orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                
   
                if self.importListArray.count != 0 {
                    self.importListMainView.isHidden = false
                    self.importBackroundView.isHidden = false
                    self.importTblView.reloadData()
                    
                }
                
            } else {
                
                
                
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblView.reloadData()
                    
                }
            }
        } else {
            
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                importTblView.reloadData()
                
            }
        }
    }
    
    @IBOutlet weak var globalImportFromOutlet: UIButton!
    
    
    
    @IBAction func globalCrossBtnAction(_ sender: Any) {
        
        
        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Removing list will remove its animals from the order as well. Do you want to continue?", comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            
        })
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            
            var titleLbl = self.globalImportFromOutlet.titleLabel?.text
            
            
            
            let listArray = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0))
            
            for i in 0 ..< listArray.count{
                
                let listObj = listArray[i] as! MergeDataEntryList
                var listId = listObj.listId
                let custId = listObj.customerId

                let animalData =  fetchDataEnteryAnimalTbl(entityName: "BeefAnimaladdTbl", customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                
                if animalData.count > 0 {
                    
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! BeefAnimaladdTbl
                        deleteDataWithProductBeefDelete(Int(ad.animalId))
                        deleteDataWithSubProductAnimalId(Int(ad.animalId))
                        
                    }
                    deleteDataWithListIdDatEntry(entityString: "BeefAnimaladdTbl", listId: Int(listObj.listId), customerId:  Int(listObj.customerId),userId:self.userId)
                }
            }
            
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))

            
            UserDefaults.standard.removeObject(forKey: "dataEnteryListName")
            self.globalImportFromOutlet.isEnabled = true
            let animalCount = fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.cartView.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.cartView.isHidden = false
            }
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count == 0 {
                self.globalMergeListBtnOulet.isHidden = true
            } else {
                self.globalMergeListBtnOulet.isHidden = false
            }
            self.globalCrossBtnOutlet.isHidden = true
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBOutlet weak var globalCrossBtnOutlet: UIButton!
    
    ///////////
    
    @IBAction func incrementalBarcodeButtonActionInherit(_ sender: UIButton) {
      guard inheritEarTagTextfield.text?.isEmpty == false else {
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please enter Unique id before selecting 'Matched Unique ID/Barcode'.", comment: "") )
          return
      }

      
//      if sender.isSelected == false {
//          sender.isSelected = true
//          incrementalBarcodeCheckBoxInherit.image = UIImage(named: "check")
//          inheritBarcodeTextfield.text = inheritEarTagTextfield.text
//
//      } else {
//        sender.isSelected = false
//        incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
//        inheritBarcodeTextfield.text = ""
//      }
      
        if UserDefaults.standard.bool(forKey: "isBarCodeMachted") == true {
            sender.isSelected = false
            incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: "isBarCodeMachted")
            inheritBarcodeTextfield.text = ""
            
        } else {
            sender.isSelected = true
            
            incrementalBarcodeCheckBoxInherit.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: "isBarCodeMachted")
           inheritBarcodeTextfield.text = inheritEarTagTextfield.text
            
        }
    }
    
    @IBAction func incrementalBarcodeButtonActionGlobal(_ sender: UIButton) {
        
        guard scanBarcodeTextfield.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please enter barcode before selecting 'Incremental barcode'.", comment: "") )
            return
        }
        
        guard isBarCodeEndsWithNumber_GetIncrementedBarCode(scanBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
            if checkBarcode == false{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
                
            } else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            sender.isSelected = false
            incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
    }
    
    func defaultIncrementalBarCodeSetting_Inherit() {
        UserDefaults.standard.set(nil, forKey: "barcodeIncremental")
        incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
     //   incrementalBarcodeTitleLabelInherit.text = NSLocalizedString("Matched Unique ID/Barcode", comment: "")
    }
    
    func defaultIncrementalBarCodeSetting_Global() {
        UserDefaults.standard.set(nil, forKey: "barcodeIncremental")
       // incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
       // incrementalBarcodeTitleLabelGlobal.text = NSLocalizedString("Incremental Barcode", comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.defaultIncrementalBarCodeSetting_Inherit()
        self.defaultIncrementalBarCodeSetting_Global()
    }
    
    @IBOutlet weak var inheritResetIconImage: UIImageView!
    
    
    var heartBeatViewModel:HeartBeatViewModel?
    
    func navigateToAnotherVc(){
        //   hideIndicator()
        //   self.view.isUserInteractionEnabled = true
    }
    override func viewDidLoad() {
        self.setSideMenu()
        self.inheritEarTagTextfield.setLeftPaddingPoints(20.0)
        self.inheritEIDTextfield.setLeftPaddingPoints(20.0)
        self.inheritBarcodeTextfield.setLeftPaddingPoints(20.0)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 24)
        
        var resetButtonConfiguration = UIButton.Configuration.plain()
        resetButtonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 30, bottom: 24, trailing: 24)

        inheritTissueBttn.configuration = configuration
        inheritMaleFemaleBttn.configuration = configuration
      //  inheritClearFormOutlet.configuration = resetButtonConfiguration
        
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        super.viewDidLoad()
        UserDefaults.standard.set(1, forKey: "orderIdBeef")
        UserDefaults.standard.set(1, forKey: "userId")
        self.userId = UserDefaults.standard.integer(forKey: "userId")
        self.orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        UserDefaults.standard.setValue(nil, forKey: "submitTypeSelection")
      //  importListMainView.isHidden = true
      //  importBackroundView.isHidden = true
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
      //  globalDateTextField.keyboardType = .phonePad
        inheritDateTextField.keyboardType = .phonePad
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
      //  importTblView.delegate = self
     //   importTblView.dataSource = self
     //   globalDateTextField.borderStyle = .none
     //   globalDateTextField.delegate = self
        
        inheritDateTextField.borderStyle = .none
        inheritDateTextField.delegate = self
        
        tissuId = 1
        let animalCount = fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            self.cartView.isHidden = true
            UserDefaults.standard.removeObject(forKey: "dataEnteryListName")
            
        }
       
            
            inheritScrollView.isHidden = false
            //inheritAddBttnView.isHidden = false
            inheritByDefaultSetting()
           // globalClearFormOutlet.isHidden = true
            inheritClearFormOutlet.isHidden = false
          //  inheritResetIconImage.isHidden = true
            self.defaultIncrementalBarCodeSetting_Inherit()
          inheritBreedArr = fetchproviderProductDataGlobal(entityName: "GetBreedsTbl", provId: pvid, productId: 52)
         
            if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                inheritDateTextField.isHidden = false
            } else {
                inheritDateTextField.isHidden = true
            }
            
            let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
         //   inheritImportFromOutlet.setAttributedTitle(attributeString, for: .normal)

            let dataFetc = fetchDataEnteryWithListId(entityName: "BeefAnimaladdTbl",customerId:self.custmerId ?? 0 ,listId:0,providerId:pvid,orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: "orderIdBeef"))
            
            if dataFetc.count == 0 {
                UserDefaults.standard.removeObject(forKey: "dataEnteryListName")
                let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
          //      inheritImportFromOutlet.setAttributedTitle(attributeString, for: .normal)
             //   inheritImportFromOutlet.isEnabled = true
          //      inheritCrossBtnOutlet.isHidden = true
             //   InheritmergeListBtnOulet.isHidden = true

            } else {
                
                let get = dataFetc.object(at: 0) as? BeefAnimaladdTbl
                let getListid = get?.listId ?? 0
                UserDefaults.standard.set(Int64(getListid), forKey: "dataEnteryListId")
                
                let fetchName = fetchListNameAccordingToListId(entityName: "DataEntryList",customerId:custmerId ?? 0,listId:getListid,providerId:pvid )
                
                if fetchName.count != 0{
                    
                    let getName = fetchName.object(at: 0) as? DataEntryList
                    let getListName = getName?.listName ?? ""
                    
                //    inheritCrossBtnOutlet.isHidden = true
                //    inheritImportFromOutlet.isEnabled = true
                }
            }
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count == 0 {
          //      InheritmergeListBtnOulet.isHidden = true
            } else {
            //    InheritmergeListBtnOulet.isHidden = false
                if dataFetc.count == 0 {
               //     InheritmergeListBtnOulet.isHidden = true
                }
            }
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid )
            
            if fetchObj.count != 0 {
            
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
            
            if fetchAllMergeDta == 0 {
                let fetchNameDisplay = String(obj ?? "")
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
           //     InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            } else {
                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
            //    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            }
          }
   //   inheritCrossBtnOutlet.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeObserver()
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
              //  self.keyBoardOptionsView.isHidden = false
            }
      //       keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+20
       //     addbttn.isHidden = true
       //     continueBttn.isHidden = true
//             inheritAddBttn.isHidden = true
//             inheritContinueBttn.isHidden = true
             if(UserDefaults.standard.value(forKey: "scrollIsEnable") as? Bool ?? true){
                 inheritScrollView.isScrollEnabled = true
             }
            else {
                inheritScrollView.isScrollEnabled = false
             }
//
//             inheritScrollView.isScrollEnabled = false
         }
     }
    
    @objc func keyboardWillHide(_ notification: Notification) {
   //     keyBoardOptionsView.isHidden = true
   //     addbttn.isHidden = false
   //     continueBttn.isHidden = false
        inheritAddBttn.isHidden = false
        inheritContinueBttn.isHidden = false
        inheritScrollView.isScrollEnabled = true
    }
    @objc func methodOfReceivedNotification(notification: Notification)
        {
           
            if value == 0
                       {
                       UserDefaults.standard.set("false", forKey: "FirstLogin")
                       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                       self.navigationController?.pushViewController(newViewController, animated: true)
                       self.hideIndicator()
                          value = value + 1
                      }
          
        }
    override func viewWillAppear(_ animated: Bool) {
      UserDefaults.standard.set(1, forKey: "orderIdBeef")
               NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
               
        self.userId = UserDefaults.standard.integer(forKey: "userId")
        self.orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        
        
        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
   //     globalClearFormOutlet .setAttributedTitle(attributeString, for: .normal)
     //   inheritClearFormOutlet.setAttributedTitle(attributeString, for: .normal)
        initialNetworkCheck()
//        inheritDamYobBttn.delegate = self
//        inheritSireYobBttn.delegate = self
        landIdApplangaugeConversion()
    //    scrolView.flashScrollIndicators()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            self.cartView.isHidden = true
            UserDefaults.standard.removeObject(forKey: "dataEnteryListName")
         //   globalMergeListBtnOulet.isHidden = true
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))

        }
        
        self.navigationController?.navigationBar.isHidden = true
//        earTagView.layer.cornerRadius = (earTagView.frame.size.height / 2)
//        earTagView.layer.borderWidth = 0.5
//        earTagView.layer.borderColor = UIColor.gray.cgColor
//        earTagView.clipsToBounds = true
//        
//        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
//        barcodeView.layer.borderWidth = 0.5
//        barcodeView.layer.borderColor = UIColor.gray.cgColor
//        barcodeView.clipsToBounds = true
//        
//        dateBttnOutlet.layer.cornerRadius = (dateBttnOutlet.frame.size.height / 2)
//        dateBttnOutlet.layer.borderWidth = 0.5
//        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
//        dateBttnOutlet.clipsToBounds = true
        
//        scanEarTagTextField.addPadding(.left(20))
//        scanBarcodeTextfield.addPadding(.left(20))
//        damRegTextfield.addPadding(.left(20))
//        sireRegTextfield.addPadding(.left(20))
//        breedRegTextfield.addPadding(.left(20))
//        animalNameTextfield.addPadding(.left(20))
//        inheritSireYobBttn.addPadding(.left(20))
//        inheritDamYobBttn.addPadding(.left(20))
        
        //INHERIT PART
//        inheritEarTagView.layer.cornerRadius = (earTagView.frame.size.height / 2)
//        inheritEarTagView.layer.borderWidth = 0.5
//        inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
//        inheritEarTagView.clipsToBounds = true
//        
//        inheritBarcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
//        inheritBarcodeView.layer.borderWidth = 0.5
//        inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
//        inheritBarcodeView.clipsToBounds = true
//        
//        inheritDobBttn.layer.cornerRadius = (dateBttnOutlet.frame.size.height / 2)
//        inheritDobBttn.layer.borderWidth = 0.5
//        inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritDobBttn.clipsToBounds = true
//        
//        inheritRegAssociationBttn.layer.cornerRadius = (inheritRegAssociationBttn.frame.size.height / 2)
//        inheritRegAssociationBttn.layer.borderWidth = 0.5
//        inheritRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritRegAssociationBttn.clipsToBounds = true
//        
//        inheritSireYobBttn.layer.cornerRadius = (inheritSireYobBttn.frame.size.height / 2)
//        inheritSireYobBttn.layer.borderWidth = 0.5
//        inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritSireYobBttn.clipsToBounds = true
//        
//        inheritEIDTextfield.layer.cornerRadius = (inheritEIDTextfield.frame.size.height / 2)
//        inheritEIDTextfield.layer.borderWidth = 0.5
//        inheritEIDTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritEIDTextfield.clipsToBounds = true
//        
//        inheritSecondaryIdTextfield.layer.cornerRadius = (inheritSecondaryIdTextfield.frame.size.height / 2)
//        inheritSecondaryIdTextfield.layer.borderWidth = 0.5
//        inheritSecondaryIdTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritSecondaryIdTextfield.clipsToBounds = true
//        
//        inheritDamYobBttn.layer.cornerRadius = (inheritSireYobBttn.frame.size.height / 2)
//        inheritDamYobBttn.layer.borderWidth = 0.5
//        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritDamYobBttn.clipsToBounds = true
//        
//        inheritEarTagTextfield.addPadding(.left(20))
//        inheritDamIdTextfield.addPadding(.left(20))
//        inheritBarcodeTextfield.addPadding(.left(20))
//        inheritBreedRegTextfield.addPadding(.left(20))
//        inheritSireRegTextfield.addPadding(.left(20))
//        inheritEIDTextfield.addPadding(.left(20))
//        inheritSecondaryIdTextfield.addPadding(.left(20))
//        
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        
        
        let auto = UserDefaults.standard.bool(forKey: "autoIdBeef")
        if auto == false {
            autoIncrementidtable()
            autoD = fetchFromAutoIncrement()
            timeStampString = timeStamp()
            UserDefaults.standard.set(timeStampString, forKey: "timeStamp")
            UserDefaults.standard.set(true, forKey: "autoIdBeef")
            
            let animaltbl = fetchRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            for i in 0..<animaltbl.count{
                let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
                updateOrderStatusServerRemain(entity: "BeefAnimalMaster", aniamltag: data.animalTag!, userId: userId)
            }
            deleteRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: "ProductAdonAnimlTbLBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: "SubProductTblBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            UserDefaults.standard.set(1, forKey: "orderIdBeef")
        }
        autoD = UserDefaults.standard.integer(forKey: "orderIdBeef")
        orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as? String ?? ""
        BluetoothCentre.shared.navController = self
      BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
      self.navigationController?.navigationBar.isHidden = true
      appDelegate.deleg = self
      BluetoothCentre.shared.delegateRFID  = self
      BluetoothCentre.shared.nearByDeviceDelegate  = self
        
        
        
        var selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
        
        
        if UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart") > 0 {
          var cartAnimalID = UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart")
          let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimaladdTbl", animalId:cartAnimalID,orderststus:"false", customerId: self.custmerId) as! [BeefAnimaladdTbl]
          if existAnimalData.count > 0{
            autoPopulateAnimalData = existAnimalData[0]
            isAnimalComingFromCart = true
          }
            animalIdBool = true
            isautoPopulated = true
            barAutoPopu = true
            textFieldBackroungWhite()
            UserDefaults.standard.set(0, forKey: "BeefAnimalIdSelectionCart")
            dataPopulateInScreen(animalId: cartAnimalID)
            messageCheck = true
        }
        if UserDefaults.standard.bool(forKey: "isBarCodeMachted"){
          incrementalBarcodeCheckBoxInherit.image = UIImage(named: "incrementalCheckIpad")
            
        } else {
          incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
        }
        
      let animalCount1 =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
      if animalCount1.count == 0{
        checkUserDataListName()
      }
      self.updateCartCount()
      let marketId = UserDefaults.standard.object(forKey: "currentActiveMarketId") as? String ?? ""
      if  UserDefaults.standard.integer(forKey:"BeefPvid") == 13  {
        if UserDefaults.standard.value(forKey: "beefScannerSelection") as? String == "ocr"{
        //  ocrBtnOutlet.setImage(UIImage(named: "OCR_inative"), for: .normal)
         // globalOcrBtnOutlet.setImage(UIImage(named: "OCR_inative"), for: .normal)
        } else {
          if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
//            ocrBtnOutlet.setImage(UIImage(named: "forma1Copy2"), for: .normal)
//            globalOcrBtnOutlet.setImage(UIImage(named: "forma1Copy2"), for: .normal)
              
          } else {
//            ocrBtnOutlet.setImage(UIImage(named: "scan_icon_active"), for: .normal)
//            globalOcrBtnOutlet.setImage(UIImage(named: "scan_icon_active"), for: .normal)
          }
        }
      }
   //   inheritCrossBtnOutlet.isHidden = true
      
      
    }
  func updateCartCount(){
    let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
    
    if animalCount.count == 0{
      notificationLblCount.isHidden = true
      countLbl.isHidden = true
        self.cartView.isHidden = true
    } else {
      notificationLblCount.text = String(animalCount.count)
      notificationLblCount.isHidden = false
      countLbl.isHidden = false
        self.cartView.isHidden = false
    }
    
  }
    override func viewDidLayoutSubviews() {
        
//        let lastView : UIView! = inheritScrollView.subviews[0].subviews.last!
//        let height = lastView.frame.size.height
//        let pos = lastView.frame.origin.y
//        let sizeOfContent = height + pos + 20
      if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136, 1334:
          inheritScrollView.contentSize.height = 700
        case 2436, 2556,2688,2796:
            // "iPhone X"
          inheritScrollView.contentSize.height = 600
        
        default:
          inheritScrollView.contentSize.height = 700
        }
        
      }
     
    }
    func initialNetworkCheck(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected".localized {
            
            networkStatusImg.image = UIImage(named: "status_online_sign")
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: "status_offline")
            
        }
    }
    @objc func checkForReachability(notification:Notification){
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected".localized {
            networkStatusImg.image = UIImage(named: "status_online_sign")
            offLineBtn.isEnabled = false
            
        }
        else {
            networkStatusImg.image = UIImage(named: "status_offline")
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
        customPopView = OfflinePopUp.loadFromNibNamed("OfflinePopUp") as? OfflinePopUp
        customPopView.delegate = self
        customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
        
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
     
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
    }
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var samplename = String()
        var animalFetch = NSArray()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
            inherittextFieldBackroungWhite()
            if animalIdBool == true {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl", animalId: animalId, customerID: custmerId)
                let data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: "userId")
                let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                animalId1 = Int(data.animalId)
                /////////end
                
                
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
              //  inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
            //    inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                //animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
             //   inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                //
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                var years = ""
                if data.date != "" {
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            years = year
                            dateVale = month + "/" + date + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                            inheritDateTextField.text = dateVale
                        } else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
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
                            years = year
                            dateVale = date + "/" + month + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                            inheritDateTextField.text = dateVale
                        } else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    
                    if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                        
                    } else {
                        if inheritDobBttn.titleLabel!.text == nil {
                            self.InheritSelectedDate = Date()
                        }
                        else{
                            self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!) ?? Date()
                        }
                        let dates =  formatter.string(from: InheritSelectedDate)
                    }
                }
                inheritEIDTextfield.text = data.sireIDAU
                    //    inheritSecondaryIdTextfield.text = data.nationHerdAU
                inheritEarTagTextfield.text = data.animalTag
                inheritBarcodeTextfield.text = data.animalbarCodeTag
            //    inheritBreedRegTextfield.text = data.offPermanentId
               // inheritSireRegTextfield.text = data.offsireId
             //   inheritDamIdTextfield.text = data.offDamId
             //   inheritSireYobBttn.text = data.sireYOB
            //    inheritDamYobBttn.text = data.damYOB
              //  inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                //                animalNameTextfield.text  = data.anima
                inheritBreedBttn.setTitle(data.breedName, for: .normal)
                inheritTissueBttn.setTitleColor(.black, for: .normal)
                
                //inheritSireYobBttn.setTitleColor(.black, for: .normal)
                // inheritDamYobBttn.setTitleColor(.black, for: .normal)
              inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: "BeefInheritSampleType")
                
                
                var dataFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl",orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    inheritBarcodeTextfield.text = ""
                    incrementalBarcodeTitleLabelInherit.textColor = .black
                    incrementalBarcodeTitleLabelInherit.alpha = 1
                    incrementalBarcodeCheckBoxInherit.alpha = 1
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeButtonInherit.isEnabled = true
                    incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
                } else {
                    if data.orderstatus == "true"{
                        //                                       inheritBarcodeTextfield.text = ""
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeButtonInherit.isEnabled = true
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                    }else {
                        inheritBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
                        incrementalBarcodeButtonInherit.isEnabled = false
                        incrementalBarcodeTitleLabelInherit.textColor = .gray
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.alpha = 0.6
                        incrementalBarcodeCheckBoxInherit.alpha = 0.6
                        
                    }}
                
                
                
                
              //  inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
                breedId = data.breedId!
                samplename = data.tissuName!
                let pvidAA = data.providerId
                UserDefaults.standard.set(data.breedName, forKey: "InheritBeefbreed")
                
              if data.gender == "Male".localized || data.gender == "M"{
                  //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    inheritGenderToggleFlag = 1
                    inheritGenderString = NSLocalizedString("Male", comment: "")
                  self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
                  self.inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                  self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
                } else {
                  //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    
                    inheritGenderToggleFlag = 0
                  inheritGenderString = "Female".localized
                    self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
                    self.inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                    self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
                }
                
                
                
                tissuId = Int(data.tissuId)
                
                inheritDobBttn.setTitleColor(.black, for: .normal)
                let fetch = fetchAllData(entityName: "BeefAnimalMaster")
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    // statusOrder = true
                }
                if data.eT == "" || data.eT == nil {
               //     inheritRegAssociationBttn.setTitle(NSLocalizedString("Select Breed Association", comment: ""), for: .normal)
                }
                if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                //    inheriSireRedOutlet.setTitle(NSLocalizedString("Select Sire Registration Association", comment: ""), for: .normal)
                }
            } else {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
                if animalFetch.count > 0 {
                    var  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    
                    
                    
                    let userId = UserDefaults.standard.integer(forKey: "userId")
                    let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                    animalId1 = Int(data.animalId)
                    /////////end
                    
                    
                    inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                    inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
//                    inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
//                    inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                    //animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
                //    inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                    //
                    let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                    var formatter = DateFormatter()
                    var years = ""
                    if data.date != "" {
                        
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                years = year
                                dateVale = month + "/" + date + "/" + year
                                yearPublic = Int(year)!
                            }
                            if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
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
                                years = year
                                dateVale = date + "/" + month + "/" + year
                                yearPublic = Int(year)!
                                
                            }
                            if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = "dd/MM/yyyy"
                        }
                        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                            
                        }else {
                            if inheritDobBttn.titleLabel!.text == nil {
                                self.InheritSelectedDate = Date()
                            }
                            else{
                                self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                            }
                            let dates =  formatter.string(from: InheritSelectedDate)
                        }
                    }
                    inheritEIDTextfield.text = data.sireIDAU
                  //  inheritSecondaryIdTextfield.text = data.nationHerdAU
                    inheritEarTagTextfield.text = data.animalTag
                    inheritBarcodeTextfield.text = data.animalbarCodeTag
//                    inheritBreedRegTextfield.text = data.offPermanentId
//                    inheritSireRegTextfield.text = data.offsireId
//                    inheritDamIdTextfield.text = data.offDamId
//                    inheritSireYobBttn.text = data.sireYOB
//                    inheritDamYobBttn.text = data.damYOB
//                    inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                    
                    //                animalNameTextfield.text  = data.anima
                    inheritBreedBttn.setTitle(data.breedName, for: .normal)
                    //                    inheritSireYobBttn.setTitleColor(.black, for: .normal)
                    //                    inheritDamYobBttn.setTitleColor(.black, for: .normal)
                    inheritTissueBttn.setTitleColor(.black, for: .normal)
                //    inheritBreedBttn.setTitleColor(.black, for: .normal)
                  inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: "BeefInheritSampleType")
                    //inheritSireYobBttn.setTitle(years, for: .normal)
                    //inheritDamYobBttn.setTitle(years, for: .normal)
                    breedId = data.breedId!
                    samplename = data.tissuName!
                    let pvidAA = data.providerId
                    UserDefaults.standard.set(data.breedName, forKey: "InheritBeefbreed")
                //    inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
                  if data.gender == "Male".localized || data.gender == "M"{
                      //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        inheritGenderToggleFlag = 1
                        inheritGenderString = NSLocalizedString("Male", comment: "")
                      self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
                      self.inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                      self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
                    } else {
                      //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        inheritGenderToggleFlag = 0
                      inheritGenderString = "Female".localized
                        self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
                        self.inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                        self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
                    }
                    if data.eT == "" || data.eT == nil {
                        inheritRegAssociationBttn.setTitle(NSLocalizedString("Select Breed Association", comment: ""), for: .normal)
                    }
                    if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                        inheriSireRedOutlet.setTitle(NSLocalizedString("Select Sire Registration Association", comment: ""), for: .normal)
                    }
                    tissuId = Int(data.tissuId)
                    
                    inheritDobBttn.setTitleColor(.black, for: .normal)
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
    
    @IBAction func dateAction(_ sender: UIButton) {
        
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        self.view.endEditing(true)
        
        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
            
            globalDateTextField.isHidden = false
        }else {
            
            globalDateTextField.isHidden = true
           
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            doDatePicker()
        }
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
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
      let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        InheritSelectedDate = Date()
        let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        
        self.navigationController?.pushViewController(vc!, animated: true)
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
        
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    func inheritDoDatePicker(){
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
        if InheritSelectedDate != nil{
            self.datePicker.setDate(InheritSelectedDate, animated: true)
            
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
      let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.InheritDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritCancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    @objc func InheritDoneClick() {
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
        self.InheritSelectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        inheritDobBttn.setTitle(selectedDate, for: .normal)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: datePicker.date)
        let year = components.year
        yearPublic = components.year!
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func inheritCancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    @IBOutlet weak var inheriSireRedOutlet: customButton!
    @IBOutlet weak var inheritRegHideLbl: UILabel!
    
    @IBAction func inheritSireRedNumberAction(_ sender: UIButton) {
        
        if inheritEarTagTextfield.text?.count == 0 {
            return
        }
        
        btnTag = 90
        view.endEditing(true)
        
        inheritRegArr = fetchAllDataProductBeefBreedSociety(entityName: "GetBreedSocieties", productId: 20)
        
        self.tableViewpop()
        
        var yFrame = (inheritRegHideLbl.frame.minY + 135) - self.inheritScrollView.contentOffset.y
        
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (self.inheritRegHideLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (self.inheritRegHideLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (self.inheritRegHideLbl.frame.minY + 143) - self.inheritScrollView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: inheritRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    @IBAction func breedRegAction(_ sender: UIButton) {
        btnTag = 80
        
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: "GetBreedSocieties", productId: 19)
        
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
                yFrame = (breedRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
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
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegBttn.frame.width,height: 200)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    func inheritByDefaultSetting(){
//        dobLbl.textColor = UIColor.gray
//        inheritDobLbl.textColor = UIColor.gray
        
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        if dateStr == "MM" {
            dateformt.dateFormat = "MM/dd/yyyy"
            inheritDateTextField.placeholder = "MM/DD/YYYY"
        } else {
            dateformt.dateFormat = "dd/MM/yyyy"
            inheritDateTextField.placeholder = "DD/MM/YYYY"
            
        }
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        barAutoPopu == false
        self.isautoPopulated = false
        self.isAnimalComingFromCart = false
        inheritDobBttn.setTitleColor(UIColor.gray, for: .normal)
  //      inheritBreedBttn.setTitleColor(UIColor.gray, for: .normal)
        isautoPopulated = false
        let dte = Date()
        //  inheritDobBttn.setTitle( dateformt.string(from: dte ), for: .normal)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: dte)
        let year = components.year
        inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
        
//        inheritDamYobBttn.placeholder = NSLocalizedString("Dam Year of Birth", comment: "")
//        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
//        inheritSireYobBttn.placeholder = NSLocalizedString("Sire Year of Birth", comment: "")
//        inheriSireRedOutlet.layer.borderWidth = 0.5
        
//        inheritSireRegTextfield.layer.borderWidth = 0.5
//        inheritDamYobBttn.layer.borderWidth = 0.5
//        inheritTissueBttn.layer.borderWidth = 0.5
//        inheritBreedBttn.layer.borderWidth = 0.5
//        inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritBreedBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
//        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritSecondaryIdTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritEIDTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritSireYobBttn.text?.removeAll()
//        inheritDamYobBttn.text?.removeAll()
//        inheritDamIdTextfield.text?.removeAll()
//        inheritSireRegTextfield.text?.removeAll()
//        inheritBreedRegTextfield.text?.removeAll()
        inheritBarcodeTextfield.text?.removeAll()
//        breedRegTextfield.text?.removeAll()
        inheritEarTagTextfield.text?.removeAll()
        inheritEIDTextfield.text?.removeAll()
//        inheritSecondaryIdTextfield.text?.removeAll()
//        inheriSireRedOutlet.setTitle(NSLocalizedString("Select Sire Registration Association", comment: ""), for: .normal)
//        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
        self.inheritMaleFemaleBttn.setTitle("Female", for: .normal)
        self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
//        inheritGenderToggleFlag = 0
//      inheritGenderString = "Female".localized
//        inheriSireRedOutlet.isEnabled = false
        
        //        if UserDefaults.standard.string(forKey: "tsu") == nil{
        //            tissueBtnOutlet.setTitle("Allflex (TSU)", for: .normal)
        //        }
        //        else{
        //            tissueBtnOutlet.setTitle(UserDefaults.standard.string(forKey: "tsu"), for: .normal)
        //        }
//        inheriSireRedOutlet.setTitleColor(.gray, for: .normal)
//        inheritBreedBttn.setTitleColor(.gray, for: .normal)
//        inheritTissueBttn.setTitleColor(.gray, for: .normal)
//        self.InheritSelectedDate = Date()
        inheritTextFieldBackroungGrey()
        self.inheritScrollView.contentOffset.y = 0.0
        
        if UserDefaults.standard.string(forKey: "BeefInheritSampleType") == nil || UserDefaults.standard.string(forKey: "BeefInheritSampleType") == ""{
            inheritTissueBttn.setTitle("Allflex (TSU)", for: .normal)
            tissuId = 1
        }
        else{
          inheritTissueBttn.setTitle(UserDefaults.standard.string(forKey: "BeefInheritSampleType")?.localized, for: .normal)
        }
        if UserDefaults.standard.string(forKey: "InheritBeefbreed") == "" || UserDefaults.standard.string(forKey: "InheritBeefbreed") == nil{
            inheritBreedBttn.setTitle("XX", for: .normal)
            breedId = "87c30632-8da0-4f86-8d94-46da17c520dd"
        }
        else{
            // inheritBreedBttn.setTitle(UserDefaults.standard.string(forKey: "InheritBeefbreed"), for: .normal)
            let savedBreed = UserDefaults.standard.string(forKey: "InheritBeefbreed")
            inheritBreedBttn.setTitle(savedBreed, for: .normal)
            
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            let breeds = fetchproviderProductData(entityName: "GetBreedsTbl", provId: pvid)
            
            for breed in breeds as? [GetBreedsTbl] ?? [] {
                if breed.breedName == savedBreed {
                    self.breedId = breed.breedId ?? ""
                   
                    break
                }
            }
        }
        if breedId  == "" {
            
            let inheritBreed = fetchAllDataProductBeefId(entityName: "GetBreedsTbl", breedName: (inheritBreedBttn.titleLabel?.text!)!, productId: 20)
            
            if inheritBreed.count != 0 {
                
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
                
            }
        }
        
        
     //   inheritRegAssociationBttn.setTitle(NSLocalizedString("Select Breed Association", comment: ""), for: .normal)
        inheritDobBttn.titleLabel?.text = ""
        
     //   incrementalBarcodeTitleLabelInherit.textColor = .gray
        incrementalBarcodeButtonInherit.isEnabled = false
        incrementalBarcodeCheckBoxInherit.alpha = 0.6
        incrementalBarcodeTitleLabelInherit.alpha = 0.6
        self.inheritEarTagTextfield.becomeFirstResponder()
      autoPopulateAnimalData = nil
      isAnimalComingFromCart = false
    }
    
    @IBAction func inheritTissueBttnAction(_ sender: UIButton) {
        btnTag = 50
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        inheritTissueArr =  fetchproviderData(entityName: "GetSampleTbl", provId: pvid)
        self.inheritTissueView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
        var yFrame = (inheritTissueView.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
                
            case 768:
                yFrame = (inheritTissueView.frame.minY + 475) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 482,height: 130)
                
            case 810:
                yFrame = (inheritTissueView.frame.minY + 475) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 130)
                
            case 820:
                yFrame = (inheritTissueView.frame.minY + 475) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 130)

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (inheritTissueView.frame.minY + 475) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 130)
                } else {
                    yFrame = (inheritTissueView.frame.minY + 475) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 130)
                }

            case 1024:
                yFrame = (inheritTissueView.frame.minY + 475) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 652,height: 130)

            case 1032:
                yFrame = (inheritTissueView.frame.minY + 475) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 700,y: yFrame,width: 652,height: 130)
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    @IBAction func scanBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        /*let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil) */
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
                vc?.delegate = self
                self.present(vc!, animated: true, completion: nil)
        
        
    }
   /* private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        if UserDefaults.standard.string(forKey: "beefProduct") == "Global HD50K" {
            scanBarcodeTextfield.text = code
        }else{
            inheritBarcodeTextfield.text = code
        }
        
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    */
    @IBAction func tissueBtnnAction(_ sender: UIButton) {
        btnTag = 20
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        tissueArr =  fetchproviderData(entityName: "GetSampleTbl", provId: pvid)
        
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
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func inheritBreedAction(_ sender: UIButton) {
        btnTag = 60
        view.endEditing(true)
        self.tableViewpop()
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        inheritBreedArr = fetchproviderProductDataGlobal(entityName: "GetBreedsTbl", provId: pvid, productId: 52)
        
        var yFrame = (inheritBreedLbl.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (inheritBreedLbl.frame.minY + 105) - self.inheritScrollView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (inheritBreedLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (inheritBreedLbl.frame.minY + 143) - self.inheritScrollView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 300)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func breedAction(_ sender: UIButton) {
        btnTag = 10
        view.endEditing(true)
        self.tableViewpop()
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        breedArr = fetchproviderProductDataGlobal(entityName: "GetBreedsTbl", provId: pvid, productId: 19)
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
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 300)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func sireRegAction(_ sender: UIButton) {
        btnTag = 30
        view.endEditing(true)
        
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        sireRegArr = fetchAllDataProductBeefBreedSociety(entityName: "GetBreedSocieties", productId: 19)
        
        
        self.tableViewpop()
        var yFrame = (sireRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (sireRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (sireRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (sireRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: sireRegDropdownOutlet.frame.width,height: 200)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    
    @IBAction func damRegAction(_ sender: UIButton) {
        
        btnTag = 40
        
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        damRegArr = fetchAllDataProductBeefBreedSociety(entityName: "GetBreedSocieties", productId: 19)
        // fetchAllData(entityName: "GetBreedSocieties")
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (damRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (damRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (damRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (damRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: sireRegDropdownOutlet.frame.width,height: 200)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    func landIdApplangaugeConversion(){
      
           // selectListLbl.text =  NSLocalizedString("Select List", comment: "")
//            inheritEarTagTextfield.placeholder = NSLocalizedString("Enter Unique ID", comment: "")
//            scanBarcodeTextfield.placeholder = NSLocalizedString("Scan/Enter Sample Barcode", comment: "")
//            inheritEIDTextfield.placeholder = NSLocalizedString("Enter Visual ID", comment: "")
//             scanBarcodeTextfield.addPadding(.right(35))
//             inheritEIDTextfield.addPadding(.right(20))
//            inheritSecondaryIdTextfield.placeholder = NSLocalizedString("Enter Secondary ID", comment: "")
//            dobLbl.text = NSLocalizedString("Date of Birth", comment: "")
//            inheritDobLbl.text = NSLocalizedString("Date of Birth", comment: "")
//            inheritRegAssociationBttn.setTitle("Select Breed Association".localized, for: .normal)
//            inheritBreedRegTextfield.placeholder = NSLocalizedString("Enter Breed Registration Number", comment: "")
//            inheritDamIdTextfield.placeholder = NSLocalizedString("Enter dam ID", comment: "")
//            inheritSireRegTextfield.placeholder = NSLocalizedString("Enter Sire Registration Number", comment: "")
//            inheritBarcodeTextfield.placeholder = NSLocalizedString("Scan/Enter Sample Barcode", comment: "")
//            inheritRegAssociationBttn.setTitle("Select Breed Association", for: .normal)
//            inheritSireYobBttn.placeholder = NSLocalizedString("Sire Year of Birth", comment: "")
//            inheritDamYobBttn.placeholder = NSLocalizedString("Dam Year of Birth", comment: "")
//            inheritAddBttn.setTitle(NSLocalizedString("Add Another Animal", comment: ""),for: .normal)
//            addbttn.setTitle(NSLocalizedString("Add Another Animal", comment: ""),for: .normal)
//            continueBttn.setTitle(NSLocalizedString("Continue to Product Selection", comment: ""),for: .normal)
//            inheritContinueBttn.setTitle(NSLocalizedString("Continue to Product Selection", comment: ""),for: .normal)
//            scanEarTagTextField.placeholder = NSLocalizedString("Ear Tag", comment: "")
//          breedRegTextfield.placeholder = NSLocalizedString("Enter Breed Registration Number", comment: "")
//          breedRegBttn.setTitle(NSLocalizedString("Select Breed Association", comment: ""), for: .normal)
//          animalNameTextfield.placeholder = NSLocalizedString("Enter Animal Name", comment: "")
//          sireRegTextfield.placeholder = NSLocalizedString("Enter Sire Registration Number", comment: "")
//          damRegTextfield.placeholder =  NSLocalizedString("Enter Dam registration number", comment: "")
//          sireRegDropdownOutlet.setTitle(NSLocalizedString("Select Sire Registration Association", comment: ""),for: .normal)
//          damRegDropdownOutlet.setTitle(NSLocalizedString("Select Dam Registration Association", comment: ""),for: .normal)
//          appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
//          orderingTitleLbl.text = NSLocalizedString("Ordering Add Animal(s)", comment: "")
          
        
    }
    @IBAction func maleFemaleAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
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
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
        
    }
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        
        addContiuneBtn = 1
        
        addAnimalBtn(completionHandler: { (success) -> Void in
           
            DispatchQueue.main.async{
                
                self.scanEarTagTextField.becomeFirstResponder()
            }
        })
        self.view.endEditing(true)
        
        
        
    }
    var barcodeEnable = Bool()
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
      
        if inheritEarTagTextfield.text?.count ?? 0 > 14 && inheritEarTagTextfield.text?.count ?? 0 < 17 {
          
        } else {
          //inheritEarTagTextfield.becomeFirstResponder()
          self.inheritEarTagView.layer.borderColor = UIColor.red.cgColor
          CommonClass.showAlertMessage(self, titleStr: "Alert".localized, messageStr: "Unique ID length should be 15 or 16 characters.".localized)
          return
        }
      
        
        
        let selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
        
        if selctionAuProvider == true {
           
                if inheritEarTagTextfield.text == "" || inheritBarcodeTextfield.text == "" /*|| inheritBreedRegTextfield.text == "" ||  inheritSireRegTextfield.text == "" || inheritDamIdTextfield.text == ""*/{
                    
                    self.inheritValidation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                    completionHandler(false)
                    return
                } else {
                    
                    if inheritSireRegTextfield.text == ""{
                        // inheritSireRegTextfield.layer.borderColor = UIColor.red.cgColor
                    }
                    else {
                        
                        if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString("Select Sire Registration Association", comment: "") {
                            inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
                        } else {
                            inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                            
                            return
                        }
                        
                    }
                    
                    if inheritSireYobBttn.text?.count ?? 0 > 0 {
                        var inheritSireYob = Int(inheritSireYobBttn.text ?? "") ?? 0
                        
                        if inheritSireYobBttn.text!.count < 4 {
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid year. Length of year must be 4.", comment: ""))
                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        if inheritSireYob > yearPublic {
                            //self.inheritValidation()
                            ///Invalid year. Length of year must be 4.
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Sire year of birth cannot be greater than year of birth.", comment: ""))
                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                            
                            return
                        }else {
                            inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
                            
                            
                        }
                    }
                    if inheritDamYobBttn.text?.count ?? 0 > 0 {
                        
                        var inheritDamYob:Int = Int(inheritDamYobBttn.text ?? "") ?? 0
                        
                        if inheritDamYobBttn.text!.count < 4 {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid year. Length of year must be 4.", comment: ""))
                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        if inheritDamYob > yearPublic {
                            //  self.inheritValidation()
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Dam year of birth cannot be greater than year of birth.", comment: ""))
                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                            
                            return
                        }else {
                            inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
                            
                        }
                    }
                    
                    
                    inheritAddBtnCondtion(completionHandler: { (success) -> Void in
                        
                        completionHandler(true)
                    })
                    
                }
                
            
            
        } else {
                        
                if inheritEarTagTextfield.text == "" || inheritBarcodeTextfield.text == "" {//|| inheritDobBttn.titleLabel?.text == nil || inheritDobBttn.titleLabel?.text == ""/*|| inheritBreedRegTextfield.text == "" ||  inheritSireRegTextfield.text == "" || inheritDamIdTextfield.text == ""*/{
                    
                    self.inheritValidation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                    completionHandler(false)
                    return
                } else {
                    
//                    if inheritSireRegTextfield.text == ""{
//                        // inheritSireRegTextfield.layer.borderColor = UIColor.red.cgColor
//                    }
//                    else {
//                        
//                        if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString("Select Sire Registration Association", comment: "") {
//                            inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
//                        } else {
//                            inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
//                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
//                            
//                            return
//                        }
//                        
//                    }
                    
//                    if inheritSireYobBttn.text?.count ?? 0 > 0 {
//                        var inheritSireYob = Int(inheritSireYobBttn.text ?? "") ?? 0
//                        
//                        if inheritSireYobBttn.text!.count < 4 {
//                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid year. Length of year must be 4.", comment: ""))
//                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
//                            return
//                        }
//                        if inheritSireYob > yearPublic {
//                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Sire year of birth cannot be greater than year of birth.", comment: ""))
//                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
//                            
//                            return
//                        }else {
//                            inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
//                            
//                            
//                        }
//                    }
//                    if inheritDamYobBttn.text?.count ?? 0 > 0 {
//                        
//                        var inheritDamYob:Int = Int(inheritDamYobBttn.text ?? "") ?? 0
//                        
//                        if inheritDamYobBttn.text!.count < 4 {
//                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid year. Length of year must be 4.", comment: ""))
//                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
//                            return
//                        }
//                        if inheritDamYob > yearPublic {
//                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Dam year of birth cannot be greater than year of birth.", comment: ""))
//                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
//                            
//                            return
//                        } else {
//                            
//                            inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
//                            
//                        }
//                    }
                    
                    inheritAddBtnCondtion(completionHandler: { (success) -> Void in
                        if success == true{
                            inheritDobBttn.setTitle("", for: .normal)
                            inheritDobBttn.titleLabel?.text = ""
                           // inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
                           // inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
                            
                            completionHandler(true)
                        }
                    })
                    
                }
                
            
        }
        if notificationLblCount.text != "0"{
            countLbl.isHidden = false
            notificationLblCount.isHidden = false
            self.cartView.isHidden = false
        }
        //        inheritDobBttn.setTitle("", for: .normal)
        //
        //        inheritDobBttn.setTitle(nil, for: .normal)
        
    }
    func autoPop(animalData:NSArray) {
        
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            textFieldBackroungWhite()
            updateOrder = true
            var data =  animalData.lastObject as! BeefAnimaladdTbl
            let userId = UserDefaults.standard.integer(forKey: "userId")
            ////////start
            let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
            animalId1 = Int(data.animalId)
            
            /////////end
            
            //      UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            //  self.isBarcodeAutoIncrementedEnabled = false
            earTagView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            var formatter = DateFormatter()
            dateBttnOutlet.titleLabel?.text = ""
            
            if data.date != "" {
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        yearPublic = Int(year)!
                        
                    }
                    if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                        globalDateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                        yearPublic = Int(year)!
                        
                    }
                    if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                        globalDateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                    
                }else {
                    if dateBttnOutlet.titleLabel!.text == nil {
                        //  self.selectedDate = Date()
                    }
                    else{
                        self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                    }
                    let dates =  formatter.string(from: selectedDate)
                    
                }}
            
            //            if data.orderstatus == "false"{
            //                scanBarcodeTextfield.text = data.animalbarCodeTag
            //            }
            scanEarTagTextField.text = data.animalTag
            barcodeflag = false
            breedRegTextfield.text = data.offPermanentId
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            animalNameTextfield.text  = data.eT
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: "Beeftsu")
            
            if data.farmId != ""{
                breedRegBttn.setTitle(data.farmId, for: .normal)
                breedRegBttn.setTitleColor(.black, for: .normal)
            }
            if data.sireIDAU != ""{
                sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            }else {
                sireRegDropdownOutlet.setTitle(NSLocalizedString("Select Sire Registration Association", comment: ""), for: .normal)
            }
            if data.nationHerdAU != ""{
                damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            }else {
                damRegDropdownOutlet.setTitle(NSLocalizedString("Select Dam Registration Association", comment: ""), for: .normal)
                
            }
            breedRegBttn.backgroundColor = .white
            sireRegDropdownOutlet.backgroundColor = .white
            damRegDropdownOutlet.backgroundColor = .white
            breedId = data.breedId!
          let samplename = data.tissuName?.localized
            let pvidAA = data.providerId
            
            UserDefaults.standard.set(data.breedName, forKey: "Beefbreed")
            
          if data.gender == "Male".localized || data.gender == "M"{
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                
            } else {
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
              genderString = "Female".localized
                
            }
            
            var dataFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl",orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
            if dataFetch.count == 0 {
                // scanBarcodeTextfield.text = ""
                incrementalBarcodeTitleLabelGlobal.textColor = .black
                incrementalBarcodeTitleLabelGlobal.alpha = 1
                incrementalBarcodeCheckBoxGlobal.alpha = 1
                // self.isBarcodeAutoIncrementedEnabled = false
                incrementalBarcodeButtonGlobal.isEnabled = true
                // incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
            } else {
                if data.orderstatus == "true"{
                    //  scanBarcodeTextfield.text = ""
                    checkBarcode = false
                    incrementalBarcodeTitleLabelGlobal.textColor = .black
                    incrementalBarcodeButtonGlobal.isEnabled = true
                    incrementalBarcodeTitleLabelGlobal.alpha = 1
                    incrementalBarcodeCheckBoxGlobal.alpha = 1
                } else {
                    scanBarcodeTextfield.text = data.animalbarCodeTag
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
                    incrementalBarcodeButtonGlobal.isEnabled = false
                    incrementalBarcodeTitleLabelGlobal.textColor = .gray
                    checkBarcode = false
                }}
            
            
            tissuId = Int(data.tissuId)
            //textField.resignFirstResponder()
            
            
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
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            inherittextFieldBackroungWhite()
            updateOrder = true
            var data =  animalData.lastObject as! BeefAnimaladdTbl
            let userId = UserDefaults.standard.integer(forKey: "userId")
            ////////start
            let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
            animalId1 = Int(data.animalId)
            //  UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            //  self.isBarcodeAutoIncrementedEnabled = false
            /////////end
            barcodeflag = false
            
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
            inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            var formatter = DateFormatter()
            var years = ""
            inheritDobBttn.titleLabel?.text = ""
            
            if data.date != "" {
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1{
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        years = year
                        dateVale = month + "/" + date + "/" + year
                        yearPublic = Int(year)!
                    }
                    if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                        inheritDateTextField.text = dateVale
                    } else {
                        inheritDobBttn.setTitle(dateVale, for: .normal)
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
                        years = year
                        dateVale = date + "/" + month + "/" + year
                        yearPublic = Int(year)!
                        
                    }
                    if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                        inheritDateTextField.text = dateVale
                    } else {
                        inheritDobBttn.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = "dd/MM/yyyy"
                }}
            if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                
            }else {
                if inheritDobBttn.titleLabel!.text == nil {
                    self.InheritSelectedDate = Date()
                }
                else{
                    self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                }
                let dates =  formatter.string(from: InheritSelectedDate)
                
            }
            if data.orderstatus == "false"{
                inheritBarcodeTextfield.text = data.animalbarCodeTag
            }
            inheritEarTagTextfield.text = data.animalTag
            inheritBreedRegTextfield.text = data.offPermanentId
            inheritSireRegTextfield.text = data.offsireId
            inheritDamIdTextfield.text = data.offDamId
            inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
            
            inheritBreedBttn.setTitle(data.breedName, for: .normal)
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritBreedBttn.setTitleColor(.black, for: .normal)
          inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
          UserDefaults.standard.set(data.tissuName?.localized, forKey: "BeefInheritSampleType")
            inheritSireYobBttn.text = data.sireYOB
            inheritDamYobBttn.text = data.damYOB
            breedId = data.breedId!
          let samplename = data.tissuName?.localized
            let pvidAA = data.providerId
            UserDefaults.standard.set(data.breedName, forKey: "InheritBeefbreed")
            inheritEIDTextfield.text = data.sireIDAU
            inheritSecondaryIdTextfield.text = data.nationHerdAU
            inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
          if data.gender == "Male".localized || data.gender == "M"{
              //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                inheritGenderToggleFlag = 1
                inheritGenderString = NSLocalizedString("Male", comment: "")
              self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
              self.inheritMaleFemaleBttn.setTitle("Male", for: .normal)
              self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
            } else {
              //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                inheritGenderToggleFlag = 0
              inheritGenderString = "Female".localized
                self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
                self.inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
            }
            
            tissuId = Int(data.tissuId)
            
            inheritDobBttn.setTitleColor(.black, for: .normal)
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
    func inheritAddBtnCondtion(completionHandler: CompletionHandler){
      if checkBarcode == true {
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
          return
      }
      
      let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
      
      if  barcodeflag == true {
          let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: "BeefAnimaladdTbl", animalbarCodeTag: inheritBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId") )
//            let earTag =  fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: "BeefAnimaladdTbl", animalbarCodeTag: inheritEarTagTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId)
//            if earTag.count > 0 {
//                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal data cannot be loaded as animal has been saved for different product.", comment: ""))
//                return
//            }
          if barCode.count > 0 {
              
              inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
              
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
              return
          }
      }
      // }
      let codeId = fetchBreedDataTissueCode(entityName: "GetSampleTbl", provId: pvid, tissueName:(inheritTissueBttn.titleLabel?.text)!)
      
      let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
      if naabFetch1!.count == 0 {
          
      } else {
          let breedIdGet = naabFetch1![0] as? Int
          self.tissuId = breedIdGet!
      }
      
      //(self.inheritBreedBttn.titleLabel?.text!)!
      var inheritBreed = fetchAllDataProductBeefId(entityName: "GetBreedsTbl", breedName: (self.inheritBreedBttn.titleLabel?.text!)!, productId: 52)
      if inheritBreed.count == 0 {
          
          
      } else {
          
          let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
          self.breedId = medbreedRegArr1!.breedId ?? ""
          
      }
      
      
      let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: "BeefAnimaladdTbl", animalbarCodeTag: inheritBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),IsDataEmail: false)
      if animaBarcOde.count > 0 {
          
          inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order", comment: ""))
          return
      }
      
      var dateVale = ""
      let dateStr = UserDefaults.standard.value(forKey: "date") as? String
      let formatter = DateFormatter()
      if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
          
          dateVale = inheritDateTextField.text ?? ""
          if dateVale != ""{
              if dateStr == "DD"{
                  dateVale = inheritDateTextField.text ?? ""
              }
              else {
                  
                  let values = dateVale.components(separatedBy: "/")
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = month + "/" + date + "/" + year
                  
              }
          }
      } else {
          dateVale = inheritDobBttn.titleLabel?.text ?? ""
          if dateVale != ""{
              if dateStr == "DD"{
                  dateVale = inheritDobBttn.titleLabel?.text ?? ""
              }
              else {
                  
                  let values = dateVale.components(separatedBy: "/")
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = month + "/" + date + "/" + year
                  
              }
          }
      }
      
      if inheritDateTextField.text?.count == 0 {
          
          
      } else {
          
          if inheritDateTextField.text?.count == 10 {
              var validate = isValidDate(dateString: inheritDateTextField.text ?? "")
             
              
              if validate == "Correct Format" {
                  inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
                  inheritDobBttn.layer.borderWidth = 0.5
                  validateDateFlag = true
              } else {
                  inheritDobBttn.layer.borderColor = UIColor.red.cgColor
                  //  dateBtnOutlet.layer.borderWidth = 1
                  validateDateFlag = false
                  if validate == "GreaterThenDate" {
                      
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                      return
                  } else {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                      return
                  }
                  return
              }
          } else {
              inheritDobBttn.layer.borderColor = UIColor.red.cgColor
              validateDateFlag = false
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
              return
              
          }
      }
      
      
      
      let userId = UserDefaults.standard.integer(forKey: "userId")
      let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
      
     
      
      incrementalBarCode = inheritBarcodeTextfield.text ?? ""
      
      
      let animalData = fetchAllDataWithEarTagstatus(entityName: "BeefAnimaladdTbl", animalTag:autoPopulateAnimalData?.animalTag ?? "",orderststus:"true", customerId: self.custmerId,pvid: pvid)
     
      if animalData.count > 0 {
        let existAnimalData = animalData.lastObject as! BeefAnimaladdTbl
        
        if existAnimalData.orderstatus == "true" {
          if existAnimalData.date != dateVale || existAnimalData.breedId != breedId || existAnimalData.gender?.localized != inheritGenderString || existAnimalData.animalTag != inheritEarTagTextfield.text {
            
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
              let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl", animalId: Int(existAnimalData.animalId), customerID: self.custmerId)
              self.autoPop(animalData: animalFetch)
              self.barcodeEnable = false
            }
            alertController.addAction(okAction)
            
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            statusOrder = false
            self.inheritScrollView.contentOffset.y = 0.0
            return
          }
        }
      }
      
      
      let beefAnimalEartagData = fetchAllDataWithEarTagstatus(entityName: "BeefAnimaladdTbl", animalTag:inheritEarTagTextfield.text ?? "",orderststus:"false", customerId: self.custmerId, pvid: pvid)
      
      let animalidData = fetchAnimaldataValidateAnimalTag(entityName: "BeefAnimaladdTbl", animalTag:inheritEarTagTextfield.text!, orderId: orderId, userId: userId, animalId: animalId1) as! [BeefAnimaladdTbl]
      var animalOrderStaus = ""
      if animalidData.count > 0 {
        animalOrderStaus = (animalidData[0]).orderstatus ?? ""
      }
      
      
      if beefAnimalEartagData.count > 0  || animalOrderStaus == "false" || isAnimalComingFromCart {
        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
        if data12333.count > 0 {
            
            if (inheritTissueBttn.titleLabel!.text! == "Allflex (TSU)" || inheritTissueBttn.titleLabel!.text! == "Caisley (TSU)") {
          
          isUpdate = true
          inheritUpdateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: "", sireId: "" , gender: inheritGenderString,update: "false", permanentId:"", tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: "", damYOB: "",sireRegAssocation: "")
          
                inheritUpdateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: "", sireId: "" , gender: inheritGenderString,update: "true", permanentId:"", tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1, sirYOB:"", damYOB: "",sireRegAssocation: "")
          
              var fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: "DataEntryBeefAnimaladdTbl",animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:52)
        
          
          if fetchDataUpdate.count != 0 {
              
            updateOrderInfoBeefInherit(entity: "DataEntryBeefAnimaladdTbl",animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: "",sireId: "",gender: inheritGenderString,permanentId: "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU: "",userId:userId,udid: timeStampString,sirYOB: "",damYOB: "",sireRegAssocation: "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
              
            updateOrderInfoBeefInherit(entity: "BeefAnimalMaster",animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "", date: dateVale,damId: "",sireId: "",gender: inheritGenderString,permanentId: "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU: "",userId:userId,udid: timeStampString,sirYOB : "",damYOB: "",sireRegAssocation: "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
              
          }
          
          updateOrderStatusISyncProduct(entity: "ProductAdonAnimlTbLBeef",animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
          updateOrderStatusISyncSubProduct(entity: "SubProductTblBeef",animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
          
          
          let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
          let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
          
          if adata.count > 0{
              
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
              inheritByDefaultSetting()
              
          }
          
          else if animalDataMaster.count > 0 {
              if  msgUpatedd == true{
                  //CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                self.NavigateToBeefOrderingScreen()
                  
                  UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreedClear")
                  UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritTsuClear")
                  UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreed")
                  UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritSampleType")
                  
                  inheritByDefaultSetting()
                  
              }
              else{
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                  inheritByDefaultSetting()
                  
              }
              
              
          }
          
          editAid = animalId1
          animalId1 = 0
          
          //  1
          if identify1 == true {
              let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
              if data1.count > 0 {
                  completionHandler(true)
                  return
              }
          }
          
          
          completionHandler(true)
        //  scrolView.contentOffset.y = 0.0
        } else {
          //  show alert
          let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal cannot be updated in order as BVDV product is selected and the animal sample type is other than Allflex (TSU) Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
          
          // Create the actions
          let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
            self.inheritByDefaultSetting()
              
          }
          let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
              NSLog("Cancel Pressed")
              
              
//                deleteDataWithProductwithEntity(animalID1,entity: "ProductAdonAnimlTbLBeef")
//                deleteDataWithProductwithEntity(animalID1, entity: "SubProductTblBeef")
//                deleteDataWithProductwithEntity(animalID1, entity: "BeefAnimaladdTbl")
//                let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
//                self.notificationLblCount.text = String(animalCount.count)
            self.inheritByDefaultSetting()
              return
              
          }
          
          // Add the actions
          alertController.addAction(okAction)
          alertController.addAction(cancelAction)
          
          // Present the controller
          self.present(alertController, animated: true, completion: nil)
        }
          //return
        } else {
          
          isUpdate = true
          inheritUpdateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: "", sireId:"" , gender: inheritGenderString,update: "false", permanentId:"", tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: "" ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: "", damYOB: "",sireRegAssocation: "")
          
          inheritUpdateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: "", sireId: "" , gender: inheritGenderString,update: "true", permanentId:"", tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: "", damYOB: "",sireRegAssocation: "")
          
        var fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: "DataEntryBeefAnimaladdTbl",animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:52)
        
          
          if fetchDataUpdate.count != 0 {
              
            updateOrderInfoBeefInherit(entity: "DataEntryBeefAnimaladdTbl",animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: "",sireId: "",gender: inheritGenderString,permanentId: "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName:  inheritBreedBttn.titleLabel!.text!,et: "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU: "",userId:userId,udid: timeStampString,sirYOB : "",damYOB: "",sireRegAssocation: "",productId:20,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
              
            updateOrderInfoBeefInherit(entity: "BeefAnimalMaster",animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "", date: dateVale,damId: "",sireId: "",gender: inheritGenderString,permanentId: "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text!,et: "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU: "",userId:userId,udid: timeStampString,sirYOB : "",damYOB: "",sireRegAssocation: "",productId:20,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
              
          }
          
          updateOrderStatusISyncProduct(entity: "ProductAdonAnimlTbLBeef",animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
          updateOrderStatusISyncSubProduct(entity: "SubProductTblBeef",animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
          
          
          let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
          let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
          
          if adata.count > 0{
              
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
              inheritByDefaultSetting()
              
          }
          
          else if animalDataMaster.count > 0 {
              if  msgUpatedd == true{
                  //CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                self.NavigateToBeefOrderingScreen()
                  
                  UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreedClear")
                  UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritTsuClear")
                  UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreed")
                  UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritSampleType")
                  
                  
                  
                  
                  inheritByDefaultSetting()
                  
              }
              else{
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                  inheritByDefaultSetting()
                  
              }
              
              
          }
          
          editAid = animalId1
          animalId1 = 0
          
          //  1
          if identify1 == true {
              let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
              if data1.count > 0 {
                  completionHandler(true)
                  return
              }
          }
          
          
          completionHandler(true)
        //  scrolView.contentOffset.y = 0.0
        }
      }
      else if isUpdate == true {
          
          animalId1 = editAid
          inheritUpdateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
          
          inheritUpdateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
          
          if identify1 == true {
              let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
              if data1.count > 0 {
                  completionHandler(true)
                  return
              }
          }
          isautoPopulated = false
          let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
          let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
          
          if adata.count > 0{
              
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
              inheritByDefaultSetting()
              
              
          }
          
          else if animalDataMaster.count > 0 {
              if  msgUpatedd == true{
                 // CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                
                self.NavigateToBeefOrderingScreen()
                  
                  UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreedClear")
                  UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritTsuClear")
                  UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreed")
                  UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritSampleType")
                  
                  inheritByDefaultSetting()
                  
              }
              else{
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                  inheritByDefaultSetting()
                  
              }
              
              
          }
          completionHandler(true)
          scrolView.contentOffset.y = 0.0
          // return
      }
      else {
          let data =   fetchAnimaldataValidateBarcodeforValidationBeef(entityName: "BeefAnimalMaster", barcode: inheritBarcodeTextfield.text!, userId: userId, orderId: orderId)
          
          //            if data.count > 0 {
          //
          //                inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
          //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Barcode is already used with an animal.", comment: ""))
          //                return
          //            }
          let product  = fetchAllData(entityName: "GetProductTblBeef")
        if product.count > 0 {
           pid = product[0] as? GetProductTblBeef
        }
          
          isUpdate = false
          
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
              
              
              InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
              
              
              
            var fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: "DataEntryBeefAnimaladdTbl",animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:52)
            
              
              if fetchDataUpdate.count != 0 {
                  
                updateOrderInfoBeefInherit(entity: "DataEntryBeefAnimaladdTbl",animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                  
                updateOrderInfoBeefInherit(entity: "BeefAnimalMaster",animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "", date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                  
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
                  InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU:inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
              }
              else {
                  //inheritDamIdTextfield.text! inheritSireRegTextfield.text ?? inheritBreedRegTextfield.text! (inheritBreedBttn.titleLabel?.text!)! inheritRegAssociationBttn.titleLabel?.text! ?? inheritSecondaryIdTextfield.text! inheritSireYobBttn.text ?? inheritDamYobBttn.text ?? inheriSireRedOutlet.titleLabel?.text ??
                inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: "" , sireId:  "" , gender: inheritGenderString,update: "false", permanentId: "", tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et:  "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid?.productId ?? 0), sirYOB: "", damYOB:  "", sireRegAssocation:  "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                createDataList()
              }
          }
          
          
         
          
        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
          if data12333.count > 0{
              if inheritTissueBttn.titleLabel!.text! == "Allflex (TSU)" || inheritTissueBttn.titleLabel!.text! == "Allflex (TST)" || inheritTissueBttn.titleLabel!.text! == "Caisley (TSU)" {//|| tissuId == 16 || tissuId == 18 {
                inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: "", sireId: "" , gender: inheritGenderString,update: "true", permanentId:"", tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid?.productId ?? 0), sirYOB:  "", damYOB: "", sireRegAssocation: "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                  
                createDataList()
              }
              else{
                  //   CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("BVDV product selection cannot be applied as animals in order have sample type other than Allflex (TSU) or Caisely (TSU).", comment: ""))
                  let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                  
                  // Create the actions
                  let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                      UIAlertAction in
                      // self.byDefaultSetting()
                      self.inheritByDefaultSetting()
                  }
                  let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                      UIAlertAction in
                      NSLog("Cancel Pressed")
                      
                      deleteDataWithProductwithEntity(animalID1,entity: "ProductAdonAnimlTbLBeef")
                      deleteDataWithProductwithEntity(animalID1, entity: "SubProductTblBeef")
                      deleteDataWithProductwithEntity(animalID1, entity: "BeefAnimaladdTbl")
                      let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                      self.notificationLblCount.text = String(animalCount.count)
                      self.inheritByDefaultSetting()
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
              //inheritDamIdTextfield.text! inheritSireRegTextfield.text ?? inheritBreedRegTextfield.text!, inheritBreedRegTextfield.text! inheritRegAssociationBttn.titleLabel?.text! ?? inheritDamYobBttn.text ?? inheritRegAssociationBttn.titleLabel?.text! ?? inheritSireYobBttn.text ?? inheriSireRedOutlet.titleLabel?.text ??
            inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: "", sireId: "" , gender: inheritGenderString,update: "true", permanentId:"", tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid?.productId ?? 0), sirYOB: "", damYOB:  "", sireRegAssocation:  "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), listId: 0, serverAnimalId: "", tertiaryGeno: "")
            createDataList()
          }
          
          
          let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:inheritEarTagTextfield.text!,orderId:orderId,userId:userId) as! [BeefAnimaladdTbl]
        let filterAnimalData = animalData.filter({ $0.orderstatus == "false"})
          let productCount = UserDefaults.standard.integer(forKey: "productCount")
          
          
          
          for k in 0 ..< filterAnimalData.count{
              
              let animalId = filterAnimalData[k] as! BeefAnimaladdTbl
              
              for i in 0 ..< product.count {
                  
                  let data = product[i] as! GetProductTblBeef
                  
                  saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                  
                  let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                  
                  for j in 0 ..< addonArr.count {
                      
                      let addonDat = addonArr[j] as! GetAdonTbl
                      if data12333.count > 0 {
                          if addonDat.adonName == "BVDV" { //76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                              saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                              updateProductTablevaleeSingleeInBef(entity: "GetAdonTbl", productId: Int(addonDat.adonId), status: "true")
                          }
                          else{
                              saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                          }
                      }
                      else {
                          saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                      }
                      
                      
                      let message = NSLocalizedString("Animal added successfully.", comment: "")
                      statusOrder = false
                      UserDefaults.standard.removeObject(forKey: "review")
                      self.animalSucInOrder = ""
                      //  DispatchQueue.main.async {
                      if self.msgAnimalSucess == false {
                          if self.addContiuneBtn == 1 {
                              if self.msgcheckk == true {
                                  self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 2, position: .bottom)
                              }
                              else {
                                  
                                  if self.isautoPopulated == true {
                                      self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 2, position: .bottom)
                                  } else {
                                      self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 2, position: .bottom)
                                  }
                              }
                          } else if self.addContiuneBtn == 2{
                              //  self.isautoPopulated = false
                              if self.msgcheckk == true {
                                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                              }
                              else{
                                  if self.isautoPopulated == true {
                                      
                                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                                      
                                  } else {
                                      
                                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                                  }
                              }
                          }else {
                              if self.msgcheckk == true {
                                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                              }
                              else{
                                  if self.isautoPopulated == true {
                                      
                                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                                      
                                  } else {
                                      
                                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                                  }
                              }
                              
                              
                              
                          }
                          self.msgAnimalSucess = false
                      } else {
                          if self.msgcheckk == true {
                              self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 2, position: .bottom)
                          }
                          else{
                              if self.isautoPopulated == true {
                                  self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 2, position: .bottom)
                              }else {
                                  self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 2, position: .bottom)
                                  
                              }
                          }
                      }
                  }
                  
                  
              }
          }
          
          UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreedClear")
          UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritTsuClear")
          UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreed")
          UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: "BeefInheritSampleType")
          
          if isBarcodeAutoIncrementedEnabled == true {
              UserDefaults.standard.set(true, forKey: "isBarCodeIncrementalClear")
              UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
          } else {
              UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
              UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
          }

      //    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
          inheritByDefaultSetting()
          inheritTextFieldBackroungGrey()
          inheritGenderToggleFlag = 0
        inheritGenderString = "Female".localized
          barAutoPopu = false
          
          inheritEarTagTextfield.text = ""
          // inheritBarcodeTextfield.text = ""
          self.inheritScrollView.contentOffset.y = 0.0

          let userId = UserDefaults.standard.integer(forKey: "userId")
          let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
          
          let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
          notificationLblCount.text = String(animalCount.count)
          
          let dateStr = UserDefaults.standard.value(forKey: "date") as? String
          let formatter = DateFormatter()
          
          if dateStr == "MM"{
              formatter.dateFormat = "MM/dd/yyyy"
          }
          else {
              formatter.dateFormat = "dd/MM/yyyy"
          }
          inheritDobBttn.setTitle("", for: .normal)
          dateVale = ""
          inheritDobBttn.setTitle(nil, for: .normal)
          
          completionHandler(true)
          // }
      }
      ////BARCODE INCREMENTAL INHERIT
      if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
          UserDefaults.standard.set(incrementalBarCode, forKey: "barcodeIncremental")
      }
      incrementalBarCode = ""
      view.endEditing(true)
      
  }
    
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        
        
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
            return
        }
        
        
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        // if  msgUpatedd == false {
        if  barcodeflag == true {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: "BeefAnimaladdTbl", animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId") )
            let earTag =  fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: "BeefAnimaladdTbl", animalbarCodeTag: scanEarTagTextField.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId)
//            if earTag.count > 0 {
//                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal data cannot be loaded as animal has been saved for different product.", comment: ""))
//                return
//            }
            
            if barCode.count > 0 {
                barcodeView.layer.borderColor = UIColor.red.cgColor
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
            }
        }
        
        /////////
        
        var inheritBreed = fetchAllDataProductBeefId(entityName: "GetBreedsTbl", breedName: (self.breedBtnOutlet.titleLabel?.text!)!, productId: 19)
        if inheritBreed.count != 0 {
            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
            self.breedId = medbreedRegArr1!.breedId ?? ""
        }
       
        let codeId = fetchBreedDataTissueCode(entityName: "GetSampleTbl", provId: pvid, tissueName: (tissueBttnOutlet.titleLabel?.text)!)
        
        let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
        if naabFetch1!.count == 0 {
            
        } else {
            let tissuId = naabFetch1![0] as? Int
            self.tissuId = tissuId!
        }
      
        let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: "BeefAnimalMaster", animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),IsDataEmail: false)
        if animaBarcOde.count > 0 {
            barcodeView.layer.borderColor = UIColor.red.cgColor
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
            return
        }
        
        var breedReg = ""
        if breedRegBttn.titleLabel?.text == nil {
            breedReg = ""
        }
        else{
            breedReg = breedRegBttn.titleLabel!.text!
        }
        var sireReg = ""
        if sireRegDropdownOutlet.titleLabel?.text == nil {
            sireReg = ""
        }
        else{
            sireReg = sireRegDropdownOutlet.titleLabel!.text!
        }
        var damReg = ""
        if damRegDropdownOutlet.titleLabel?.text == nil {
            damReg = ""
        }
        else{
            damReg = damRegDropdownOutlet.titleLabel!.text!
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        let formatter = DateFormatter()
        
        
        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
            dateVale = globalDateTextField.text ?? ""
            if dateStr == "DD"{
                dateVale = globalDateTextField.text ?? ""
            }
            else {
                if dateVale != ""{
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        } else {
            
            dateVale = dateBttnOutlet.titleLabel?.text ?? ""
            if dateStr == "DD"{
                dateVale = dateBttnOutlet.titleLabel?.text ?? ""
            }
            else {
                if dateVale != ""{
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        }
     
        if globalDateTextField.text?.count == 0 {
            
            
        } else {
            
            if globalDateTextField.text?.count == 10 {
                var validate = isValidDate(dateString: globalDateTextField.text ?? "")
          
                if validate == "Correct Format" {
                    dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    //  dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                    if validate == "GreaterThenDate" {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                        return
                    }
                    return
                }
            } else {
                dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                return
                
            }
        }
        
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        
        
        
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: "BeefAnimaladdTbl", animalTag:scanEarTagTextField.text!, orderId: orderId, userId: userId, animalId: animalId1)
        
        if animalData.count > 0 {
          let existAnimalData = animalData.lastObject as! BeefAnimaladdTbl
          if existAnimalData.orderstatus == "true" {
            if existAnimalData.date != dateVale || existAnimalData.breedId != breedId || existAnimalData.gender?.localized != genderString {
              
              let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
              
              // Create the actions
              let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl", animalId: self.idAnimal, customerID: self.custmerId)
                self.autoPop(animalData: animalFetch)
                self.barcodeEnable = false
              }
              alertController.addAction(okAction)
              
              
              // Present the controller
              self.present(alertController, animated: true, completion: nil)
              statusOrder = false
              self.inheritScrollView.contentOffset.y = 0.0
              return
            }
          }
        }
        
        if animalData.count > 0  {
          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
          if data12333.count > 0 && tissueBttnOutlet.titleLabel!.text! != "Allflex (TSU)" || tissueBttnOutlet.titleLabel!.text! != "Allflex (TST)" || tissueBttnOutlet.titleLabel!.text! != "Caisley (TSU)" {
            //  show alert
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.byDefaultSetting()
                
            }
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                
                
//                deleteDataWithProductwithEntity(animalID1,entity: "ProductAdonAnimlTbLBeef")
//                deleteDataWithProductwithEntity(animalID1, entity: "SubProductTblBeef")
//                deleteDataWithProductwithEntity(animalID1, entity: "BeefAnimaladdTbl")
//                let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
//                self.notificationLblCount.text = String(animalCount.count)
                self.byDefaultSetting()
                return
                
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
          }
        else {
            
            isUpdate = true
          updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text ?? "", date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
          updateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl", animalTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text ?? "", date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            
            
            updateOrderStatusISyncProduct(entity: "ProductAdonAnimlTbLBeef",animalTag: scanEarTagTextField.text!,barCodetag:  scanBarcodeTextfield.text ?? "",farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: "SubProductTblBeef",animalTag: scanEarTagTextField.text!,barCodetag:  scanBarcodeTextfield.text ?? "",farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            
            var fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: "DataEntryBeefAnimaladdTbl",animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:52)
          
            
            if fetchDataUpdate.count != 0 {
                
                updateOrderInfoBeefGlobal(entity: "DataEntryBeefAnimaladdTbl",animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ?? 0),editFlagSave: true)
            }
            
            
            
            
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:scanEarTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                   // CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                  self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: "BeefbreedClear")
                    UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: "BeeftsuClear")
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "Beeftsu")
                    UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: "Beefbreed")
                    
                    byDefaultSetting()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                    
                }
                
                
            }
            
            editAid = animalId1
            animalId1 = 0
            
            //  1
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            //  return
        }
        }
         
        else if isUpdate == true {
            
            animalId1 = editAid
          updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl", animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:scanEarTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    //CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                  
                  self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: "BeefbreedClear")
                    UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: "BeeftsuClear")
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "Beeftsu")
                    UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: "Beefbreed")
                    
                    byDefaultSetting()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                    
                }
                
                
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            // return
        }
        else {
            isUpdate = false
            let data =   fetchAnimaldataValidateBarcodeforValidationBeef(entityName: "BeefAnimalMaster", barcode: scanBarcodeTextfield.text!, userId: userId, orderId: orderId)
            //    let data =  fetchAnimaldataValidateAnimalIdforValidationBeef(entityName: "BeefAnimalMaster", animalId:scanEarTagTextField.text!,userId: userId,orderId:orderId)
            
            //            if data.count > 0 {
            //                barcodeView.layer.borderColor = UIColor.red.cgColor
            //
            //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Duplicate Entry", comment: ""))
            //                return
            //            }
            
            let product  = fetchAllData(entityName: "GetProductTblBeef")
            let pid = product[0] as! GetProductTblBeef
            
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
                
                
              updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                
                var fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: "DataEntryBeefAnimaladdTbl",animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:52)
               
                
                if fetchDataUpdate.count != 0 {
                    
                    
                    updateOrderInfoBeefGlobal(entity: "DataEntryBeefAnimaladdTbl",animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
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
                  updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                }
                else {
                    
                  saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                  createDataList()
                }
            }
            
            
           
          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
            if data12333.count > 0{
                if tissueBttnOutlet.titleLabel!.text! == "Allflex (TSU)" || tissueBttnOutlet.titleLabel!.text! == "Allflex (TST)" || tissueBttnOutlet.titleLabel!.text! == "Caisley (TSU)" {//|| tissuId == 1 || tissuId == 18 {
                  saveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                  createDataList()
                }
                else{
                    //   CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("BVDV product selection cannot be applied as animals in order have sample type other than Allflex (TSU) or Caisely (TSU).", comment: ""))
                    let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal cannot be added in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                    
                    // Create the actions
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.byDefaultSetting()
                        
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                        
                        
                        deleteDataWithProductwithEntity(animalID1,entity: "ProductAdonAnimlTbLBeef")
                        deleteDataWithProductwithEntity(animalID1, entity: "SubProductTblBeef")
                        deleteDataWithProductwithEntity(animalID1, entity: "BeefAnimaladdTbl")
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
              saveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), listId: 0, serverAnimalId: "", tertiaryGeno: "")
              createDataList()
            }
            
            
            
            let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:scanEarTagTextField.text!,orderId:orderId,userId:userId)
            
            
            
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    
                    saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                    
                    let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                    
                    for j in 0 ..< addonArr.count {
                        
                        let addonDat = addonArr[j] as! GetAdonTbl
                        if data12333.count > 0 {
                            if addonDat.adonName == "BVDV" {//76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                                saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                updateProductTablevaleeSingleeInBef(entity: "GetAdonTbl", productId: Int(addonDat.adonId), status: "true")
                            }
                            else {
                                saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            }
                        }
                        else {
                            saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                        
                        let message = NSLocalizedString("Animal added successfully.", comment: "")
                        statusOrder = false
                        UserDefaults.standard.removeObject(forKey: "review")
                        self.animalSucInOrder = ""
                        //  DispatchQueue.main.async {
                        if self.msgAnimalSucess == false {
                            if self.addContiuneBtn == 1 {
                                if self.msgcheckk == true {
                                    self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 2, position: .bottom)
                                }
                                else {
                                    
                                    if self.isautoPopulated == true {
                                        self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 2, position: .bottom)
                                    } else {
                                        self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 2, position: .bottom)
                                    }
                                }
                            } else if self.addContiuneBtn == 2{
                                //  self.isautoPopulated = false
                                if self.msgcheckk == true {
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                                }
                                else{
                                    if self.isautoPopulated == true {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                                        
                                    } else {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                                    }
                                }
                            }else {
                                if self.msgcheckk == true {
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                                }
                                else{
                                    if self.isautoPopulated == true {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                                        
                                    } else {
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                                    }
                                }
                                
                                
                                
                            }
                            self.msgAnimalSucess = false
                        } else {
                            if self.msgcheckk == true {
                                self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 2, position: .bottom)
                            }
                            else{
                                if self.isautoPopulated == true {
                                    self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 2, position: .bottom)
                                }else {
                                    self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 2, position: .bottom)
                                    
                                }
                            }
                        }
                    }
                    
                    
                }
            }
            UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: "BeefbreedClear")
            UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: "BeeftsuClear")
            UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: "Beeftsu")
            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: "Beefbreed")
            
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
            barAutoPopu = false
            dateVale = ""
            scanEarTagTextField.text = ""
            scanBarcodeTextfield.text = ""
            
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
            
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = "MM/dd/yyyy"
            }
            else {
                formatter.dateFormat = "dd/MM/yyyy"
            }
            
            inheritDobBttn.setTitle(nil, for: .normal)
            dateBttnOutlet.setTitle(nil, for: .normal)
            dateVale = ""
            dateBttnOutlet.titleLabel?.text = ""
            
            completionHandler(true)
            // }
        }
        
        ////BARCODE INCREMENTAL GLOBAL
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: "barcodeIncremental")
        }
        incrementalBarCode = ""
        
    }
    
    func inheritValidation(){
        if inheritEarTagTextfield.text == ""{
            
            inheritEarTagView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
        }
        if inheritBarcodeTextfield.text == ""{
            inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
        }
        
        
        
//        if inheritSireRegTextfield.text == ""{
//        }
//        else {
//            
//            if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString("Select Sire Registration Association", comment: "") {
//                inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
//            } else {
//                inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
//            }
//            
//            inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        }
        
    }
    func validation() {
        if scanEarTagTextField.text == ""{
            
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
            breedRegBttn.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            if breedRegBttn.titleLabel?.text != NSLocalizedString("Select Breed Association", comment:  "") {
                breedRegBttn.layer.borderColor = UIColor.gray.cgColor
            }else{
                breedRegBttn.layer.borderColor = UIColor.red.cgColor
            }
        }
        if sireRegTextfield.text == ""{
            sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            if sireRegDropdownOutlet.titleLabel?.text != NSLocalizedString("Select Sire Registration Association", comment: "") {
                sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
            }else{
                sireRegDropdownOutlet.layer.borderColor = UIColor.red.cgColor
            }
            
        }
        if damRegTextfield.text == ""{
            damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            if damRegDropdownOutlet.titleLabel?.text != NSLocalizedString("Select Dam Registration Association", comment: "") {
                damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
            }else{
                damRegDropdownOutlet.layer.borderColor = UIColor.red.cgColor
            }
        }
        
    }
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
//        self.sideMenuViewController?.presentRightMenuViewController()
//        self.view.makeCorner(withRadius: 40)
        
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
    }
    
    func statusOrderTrue() -> Bool{
        
        let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        }else{
            return false
        }
        
    }
    @IBAction func backClick(_ sender: UIButton) {
     
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        
    }
    @IBAction func continueAction(_ sender: UIButton) {
        
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
            
            addContiuneBtn = 2
            
            let  userId = UserDefaults.standard.integer(forKey: "userId")
            let  orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
            identify1 = true
            let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
            
            let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
            
            if  identyCheck == false || identyCheck == nil{
                if data1.count > 0 {
                  
                    if inheritEarTagTextfield.text == "" && inheritBarcodeTextfield.text == ""{
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
                    
                    if inheritEarTagTextfield.text == "" || inheritBarcodeTextfield.text == ""{
                        
                        if inheritEarTagTextfield.text == "" && inheritBarcodeTextfield.text == ""{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please add at least one animal.", comment: ""))
                            self.inheritValidation()
                            
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                            self.inheritValidation()
                            
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
            }
            else{
                
                if data1.count > 0 {
                  if inheritEarTagTextfield.text == "" && isAnimalComingFromCart {
                    inheritEarTagView.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: "Alert".localized, messageStr: "Unique ID length should be 15 or 16 characters.".localized)
                    return
                  }
                   else if inheritEarTagTextfield.text == "" && inheritBarcodeTextfield.text == ""{
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
            
        
        //self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
    }
    
    @IBAction func inheritAddAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            self.inheritEarTagTextfield.becomeFirstResponder()
        })
        // inheritValidation()
        
    }
    
    @IBAction func inheritSireYobAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        inheritSireYOBDoDatePicker()
        
        
    }
  func inheritSireYOBDoDatePicker(){
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
    if InheritSireSelectedDate != nil{
      self.datePicker.setDate(InheritSireSelectedDate, animated: true)
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
    let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.InheritSireYOBDoneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritSireCancelClick))
    cancelButton.tintColor = UIColor.black
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
    toolBar.isUserInteractionEnabled = true
    toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
    self.calenderView.addSubview(toolBar)
    self.toolBar.isHidden = false
    
  }
    @objc func InheritSireYOBDoneClick() {
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
        self.InheritSireSelectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        // inheritSireYobBttn.setTitle(selectedDate, for: .normal)
        
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func inheritSireCancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @IBAction func inheritDamYObAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        inheritDamYOBDoDatePicker()
    }
    func inheritDamYOBDoDatePicker(){
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
        if InheritDamSelectedDate != nil{
            self.datePicker.setDate(InheritDamSelectedDate, animated: true)
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
      let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.InheritDamYOBDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritDamCancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    @objc func InheritDamYOBDoneClick() {
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
        self.InheritDamSelectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        //  inheritDamYobBttn.setTitle(selectedDate, for: .normal)
        
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func inheritDamCancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    @IBAction func inheritRegAssociationAction(_ sender: UIButton){
        btnTag = 70
        view.endEditing(true)
        inheritRegArr = fetchAllDataProductBeefBreedSociety(entityName: "GetBreedSocieties", productId: 20)
        
        
        self.tableViewpop()
      
        var yFrame = (inheritRegistrationLbl.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (self.inheritRegistrationLbl.frame.minY + 105) - self.inheritScrollView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (self.inheritRegistrationLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
            case 1792:
                yFrame = (self.inheritRegistrationLbl.frame.minY + 143) - self.inheritScrollView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: inheritRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
        
    }
    func byDefaultSetting(){
        //dobLbl.textColor = UIColor.gray
       // inheritDobLbl.textColor = UIColor.gray
        
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        if dateStr == "MM" {
            dateformt.dateFormat = "MM/dd/yyyy"
          //  globalDateTextField.placeholder = "MM/DD/YYYY"
        } else {
            dateformt.dateFormat = "dd/MM/yyyy"
          //  globalDateTextField.placeholder = "DD/MM/YYYY"
            
        }
       // inheriSireRedOutlet.isEnabled = false
        
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        barAutoPopu = false
        self.isautoPopulated = false
//        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
//        breedBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        // isautoPopulated = false
        let dte = Date()
      //  dateBttnOutlet.setTitle( "", for: .normal)
//        sireRegDropdownOutlet.layer.borderWidth = 0.5
//        damRegDropdownOutlet.layer.borderWidth = 0.5
//        tissueBttnOutlet.layer.borderWidth = 0.5
//        breedBtnOutlet.layer.borderWidth = 0.5
//        breedRegBttn.layer.borderWidth = 0.5
//        breedRegBttn.layer.borderColor = UIColor.gray.cgColor
//        damRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
//        breedBtnOutlet.layer.borderColor = UIColor.gray.cgColor
//        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
//        damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
//        sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
//        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
//        barcodeView.layer.borderColor = UIColor.gray.cgColor
//        earTagView.layer.borderColor = UIColor.gray.cgColor
//        scanEarTagTextField.text?.removeAll()
//        scanBarcodeTextfield.text?.removeAll()
//        damRegTextfield.text?.removeAll()
//        sireRegTextfield.text?.removeAll()
//        breedRegTextfield.text?.removeAll()
//        animalNameTextfield.text?.removeAll()
//        self.selectedDate = Date()
//        breedBtnOutlet.setTitle("ANG", for: .normal)
//        breedRegBttn.setTitle(NSLocalizedString("Select Breed Association", comment:  "") , for: .normal)
//        sireRegDropdownOutlet.setTitle(NSLocalizedString("Select Sire Registration Association", comment: ""), for: .normal)
//        damRegDropdownOutlet.setTitle(NSLocalizedString("Select Dam Registration Association", comment: ""), for: .normal)
//        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        genderToggleFlag = 0
      genderString = "Female".localized
        
//        breedBtnOutlet.setTitleColor(.gray, for: .normal)
//        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        //  self.selectedDate = Date()
      //  textFieldBackroungGrey()
      // self.scrolView.contentOffset.y = 0.0
    //  self.inheritScrollView.contentOffset.y = 0.0
//        if UserDefaults.standard.string(forKey: "Beeftsu") == nil{
//            self.tissueArr = fetchproviderData(entityName: "GetSampleTbl", provId: UserDefaults.standard.integer(forKey: "BeefPvid"))
//            for items in self.tissueArr
//            {
//                let tissue = items  as? GetSampleTbl
//                let checkdefault  = tissue?.isDefault
//                
//                if checkdefault == true
//                {
//                    self.tissueBttnOutlet.setTitle(tissue?.sampleName, for: .normal)
//                    self.tissuId =  Int(tissue?.sampleId ?? 1)
//                }
//                
//                
//            }
//            //tissueBttnOutlet.setTitle("Allflex (TSU)", for: .normal)
//           // tissuId = 1
//        }
//        else {
//            tissueBttnOutlet.setTitle(UserDefaults.standard.string(forKey: "Beeftsu"), for: .normal)
//        }
//        if UserDefaults.standard.string(forKey: "Beefbreed") == nil{
//            breedBtnOutlet.setTitle("ANG", for: .normal)
//            // breedId  = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
//            var inheritBreed = fetchAllDataProductBeefId(entityName: "GetBreedsTbl", breedName: (breedBtnOutlet.titleLabel?.text!)!, productId: 19)
//            if inheritBreed.count != 0 {
//                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
//                breedId = medbreedRegArr1!.breedId ?? ""
//                
//            }
//            
//        }
//        else{
//            breedBtnOutlet.setTitle(UserDefaults.standard.string(forKey: "Beefbreed"), for: .normal)
//        }
        inheritDobBttn.setTitle("", for: .normal)
        inheritDobBttn.setTitle(nil, for: .normal)
//        incrementalBarcodeTitleLabelGlobal.textColor = .gray
//        incrementalBarcodeButtonGlobal.isEnabled = false
//        incrementalBarcodeCheckBoxGlobal.alpha = 0.6
//        incrementalBarcodeTitleLabelGlobal.alpha = 0.6
        
//        if breedId  == "" {
//            
//            var inheritBreed = fetchAllDataProductBeefId(entityName: "GetBreedsTbl", breedName: (breedBtnOutlet.titleLabel?.text!)!, productId: 19)
//            if inheritBreed.count != 0 {
//                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
//                breedId = medbreedRegArr1!.breedId ?? ""
//                
//            }
//        }
        
    //    dateBttnOutlet.setTitle("", for: .normal)
        
        
   //     self.scanEarTagTextField.becomeFirstResponder()
//
        
        
    }
    func textFieldBackroungGrey(){
        dobLbl.textColor = UIColor.gray
        inheritDobLbl.textColor = UIColor.gray
        
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        breedRegBttn.setTitleColor(.gray, for: .normal)
        sireRegDropdownOutlet.setTitleColor(UIColor.gray, for: .normal)
        damRegDropdownOutlet.setTitleColor(UIColor.gray, for: .normal)
        male_femaleBttnOutlet.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttnOutlet.isEnabled = false
        
        breedBtnOutlet.isEnabled = false
        breedRegBttn.isEnabled = false
        scanBarcodeTextfield.isEnabled = false
        damRegTextfield.isEnabled = false
        sireRegTextfield.isEnabled = false
        breedRegTextfield.isEnabled = false
        sireRegDropdownOutlet.isEnabled = false
        animalNameTextfield.isEnabled = false
        damRegDropdownOutlet.isEnabled = false
        
        barcodeBtn.isEnabled = false
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        scanBarcodeTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        barcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.setTitle("", for: .normal)
        globalDateTextField.text = ""
        dateBttnOutlet.setTitle(nil, for: .normal)
        self.scanEarTagTextField.becomeFirstResponder()
        globalDateTextField.isEnabled = false
        
    }
    func inheritTextFieldBackroungGrey(){
//        dobLbl.textColor = UIColor.gray
//        inheritDobLbl.textColor = UIColor.gray
        
        inheritDobBttn.setTitleColor(.gray, for: .normal)
        inheritTissueBttn.setTitleColor(.gray, for: .normal)
        //inheriSireRedOutlet.setTitleColor(.gray, for: .normal)
        inheritDobBttn.setTitle("", for: .normal)
        inheritDobBttn.setTitle(nil, for: .normal)
//        inheritBreedBttn.setTitleColor(.gray, for: .normal)
//        inheritRegAssociationBttn.setTitleColor(UIColor.gray, for: .normal)
//        inheritDamYobBttn.textColor = .gray
//        inheritSireYobBttn.textColor = .gray
        inheritMaleFemaleBttn.isEnabled = false
        inheritDobBttn.isEnabled = false
        //inheriSireRedOutlet.isEnabled = false
        inheritDobBttn.isEnabled = false
//        inheritSireYobBttn.isEnabled = false
//        inheritDamYobBttn.isEnabled = false
        inheritbarcodeBttn.isEnabled = false
        inheritBarcodeTextfield.isEnabled = false
//        inheritDamIdTextfield.isEnabled = false
//        inheritSireRegTextfield.isEnabled = false
//        inheritBreedRegTextfield.isEnabled = false
//        inheritRegAssociationBttn.isEnabled = false
        inheritEIDTextfield.isEnabled = false
      //  inheritSecondaryIdTextfield.isEnabled = false
        inheritDateTextField.isEnabled = false
        
        inheritTissueBttn.isEnabled = false
//        inheritBreedBttn.isEnabled = false
//        inheritRegAssociationBttn.isEnabled = false
//        inheriSireRedOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        inheritDobBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritBarcodeTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritDamIdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritSireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritBarcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        sireRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        damRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritBreedBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritTissueBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritRegAssociationBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritBreedRegTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritDamYobBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritSireYobBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritEIDTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritMaleFemaleBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritSecondaryIdTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritDobBttn.setTitle(nil, for: .normal)
        
        inheritDobBttn.setTitle("", for: .normal)
        inheritDateTextField.text = ""
       
        
    }
    @IBAction func inheritDateAction(_ sender: UIButton) {
        
        let orderStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orderStatus.count > 0 {
            barcodeEnable = true
        }
        
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
            
            inheritDateTextField.isHidden = false
            
        } else {
            inheritDateTextField.isHidden = true
            
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            inheritDoDatePicker()
            
        }
        
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    func inherittextFieldBackroungWhite(){
       // dobLbl.textColor = UIColor.black
      //  inheritDobLbl.textColor = UIColor.black
        
       // inheriSireRedOutlet.setTitleColor(.black, for: .normal)
        inheritDobBttn.setTitleColor(.black, for: .normal)
        inheritTissueBttn.setTitleColor(.black, for: .normal)
     //   inheritBreedBttn.setTitleColor(.black, for: .normal)
     //   inheritRegAssociationBttn.setTitleColor(UIColor.black, for: .normal)
     //   inheritDamYobBttn.textColor = .black
    //    inheritSireYobBttn.textColor = .black
        inheritMaleFemaleBttn.isEnabled = true
        inheritDobBttn.isEnabled = true
        inheritbarcodeBttn.isEnabled = true
        inheritBarcodeTextfield.isEnabled = true
   //     inheritDamIdTextfield.isEnabled = true
     //   inheritSireRegTextfield.isEnabled = true
   //     inheritBreedRegTextfield.isEnabled = true
        //  inheriSireRedOutlet.isEnabled = true
        inheritTissueBttn.isEnabled = true
     //   inheritBreedBttn.isEnabled = true
     //   inheritRegAssociationBttn.isEnabled = true
        inheritEIDTextfield.isEnabled = true
    //    inheritSecondaryIdTextfield.isEnabled = true
     //   inheriSireRedOutlet.isEnabled = true
        
        inheritDobBttn.isEnabled = true
   //     inheritSireYobBttn.isEnabled = true
   //     inheritDamYobBttn.isEnabled = true
        // inheriSireRedOutlet.backgroundColor = .white
    //    inheriSireRedOutlet.backgroundColor = UIColor.white
        inheritDobBttn.backgroundColor = UIColor.white
        inheritBarcodeTextfield.backgroundColor = UIColor.white
   //     inheritDamIdTextfield.backgroundColor = UIColor.white
   //     inheritSireRegTextfield.backgroundColor = UIColor.white
        inheritBarcodeView.backgroundColor = UIColor.white
   //     breedRegTextfield.backgroundColor = UIColor.white
   //     animalNameTextfield.backgroundColor = UIColor.white
      //  inheritBreedBttn.backgroundColor = UIColor.white
        inheritTissueBttn.backgroundColor = UIColor.white
   //     inheritRegAssociationBttn.backgroundColor = UIColor.white
    //    inheritBreedRegTextfield.backgroundColor = UIColor.white
   //     inheritDamYobBttn.backgroundColor = .white
   //     inheritSireYobBttn.backgroundColor = .white
        inheritEIDTextfield.backgroundColor =  .white
        inheritMaleFemaleBttn.backgroundColor = .white

     //   inheritSecondaryIdTextfield.backgroundColor = .white
        inheritDateTextField.text = ""
        inheritDateTextField.isEnabled = true
        
        if isautoPopulated == false {
            incrementalBarcodeTitleLabelInherit.textColor = .black
            incrementalBarcodeButtonInherit.isEnabled = true
            incrementalBarcodeCheckBoxInherit.alpha = 1
            incrementalBarcodeTitleLabelInherit.alpha = 1
            if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                    inheritBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                }
            }
        } else {
            incrementalBarcodeTitleLabelInherit.textColor = UIColor.gray
            incrementalBarcodeButtonInherit.isEnabled = false
            incrementalBarcodeCheckBoxInherit.alpha = 0.6
            incrementalBarcodeTitleLabelInherit.alpha = 0.6
            // self.defaultIncrementalBarCodeSetting_Inherit()
        }
        
    }
    
    func textFieldBackroungWhite(){
        
     //   dobLbl.textColor = UIColor.black
       // inheritDobLbl.textColor = UIColor.black
        
//        dateBttnOutlet.setTitleColor(.black, for: .normal)
//        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
//        tissueBttnOutlet.setTitleColor(UIColor.black, for: .normal)
//        sireRegDropdownOutlet.setTitleColor(UIColor.black, for: .normal)
//        damRegDropdownOutlet.setTitleColor(UIColor.black, for: .normal)
//        breedRegBttn.setTitleColor(UIColor.black, for: .normal)
//        dateBttnOutlet.isEnabled = true
//        damRegDropdownOutlet.isEnabled = true
//        male_femaleBttnOutlet.isEnabled = true
//        tissueBttnOutlet.isEnabled = true
//        breedBtnOutlet.isEnabled = true
//        barcodeBtn.isEnabled = true
//        scanBarcodeTextfield.isEnabled = true
//        damRegTextfield.isEnabled = true
//        sireRegTextfield.isEnabled = true
//        breedRegTextfield.isEnabled = true
//        animalNameTextfield.isEnabled = true
//        breedRegBttn.isEnabled = true
//        tissueBttnOutlet.isEnabled = true
//        sireRegDropdownOutlet.isEnabled = true
//        breedRegBttn.backgroundColor = .white
//        sireRegDropdownOutlet.backgroundColor = .white
//        damRegDropdownOutlet.backgroundColor = .white
//        barcodeView.backgroundColor = UIColor.white
//        scanBarcodeTextfield.backgroundColor = UIColor.white
//        damRegTextfield.backgroundColor = UIColor.white
//        tissueBttnOutlet.backgroundColor = UIColor.white
//        sireRegTextfield.backgroundColor = UIColor.white
//        breedRegTextfield.backgroundColor = UIColor.white
//        animalNameTextfield.backgroundColor = UIColor.white
//        breedBtnOutlet.backgroundColor = UIColor.white
//        tissueBttnOutlet.backgroundColor = UIColor.white
//        dateBttnOutlet.backgroundColor = UIColor.white
//        globalDateTextField.isEnabled = true
//        if isautoPopulated == false {
//            incrementalBarcodeTitleLabelGlobal.textColor = .black
//            incrementalBarcodeButtonGlobal.isEnabled = true
//            incrementalBarcodeCheckBoxGlobal.alpha = 1
//            incrementalBarcodeTitleLabelGlobal.alpha = 1
//            if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
//                if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
//                    scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
//                }
//            }
//        } else {
//            incrementalBarcodeTitleLabelGlobal.textColor = .gray
//            incrementalBarcodeButtonGlobal.isEnabled = true
//            incrementalBarcodeCheckBoxGlobal.alpha = 0.6
//            incrementalBarcodeTitleLabelGlobal.alpha = 0.6
//            // self.defaultIncrementalBarCodeSetting_Global()
//        }
        
    }
    
    func tableViewpop() {
        
        buttonbg2.frame = CGRect(x:0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        buttonbg2.addTarget(self, action:#selector(BlockyardBeefiPad.buttonPreddDroper), for: .touchUpInside)
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
        self.inheritGenderView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.inheritTissueView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor

    }
    
    
    @IBAction func inheritMaleFemaleBttnAction(_ sender: UIButton) {
        btnTag = 110
        self.view.endEditing(true)
        self.tableViewpop()
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
       
        self.inheritGenderView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

////        if(inheritGenderToggleFlag == 0) {
//          //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
//            inheritGenderToggleFlag = 1
//            inheritGenderString = NSLocalizedString("Male", comment: "")
//            self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
//            self.inheritMaleFemaleBttn.setTitle("Male", for: .normal)
//            self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
//        }
//        else {
//         //   self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//            inheritGenderToggleFlag = 0
//          inheritGenderString = "Female".localized
//            self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
//            self.inheritMaleFemaleBttn.setTitle("Female", for: .normal)
//            self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
//        }
    var yFrame = (inheritMaleFemaleBttn.frame.minY + 130) - self.inheritScrollView.contentOffset.y
    
    if UIDevice().userInterfaceIdiom == .pad {
        switch UIScreen.main.bounds.height {
        case 768:
            yFrame = (inheritMaleFemaleBttn.frame.minY + 575) - self.inheritScrollView.contentOffset.y
            droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 95)
            
        case 810:
            yFrame = (inheritMaleFemaleBttn.frame.minY + 575) - self.inheritScrollView.contentOffset.y
            droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
            
        case 820:
            yFrame = (inheritMaleFemaleBttn.frame.minY + 575) - self.inheritScrollView.contentOffset.y
            droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)

        case 834:
            if UIScreen.main.nativeBounds.height == 2224.0 {
                yFrame = (inheritMaleFemaleBttn.frame.minY + 575) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 95)
            } else {
                yFrame = (inheritMaleFemaleBttn.frame.minY + 575) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 95)
            }

        case 1024:
            yFrame = (inheritMaleFemaleBttn.frame.minY + 575) - self.inheritScrollView.contentOffset.y
            droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 95)

        case 1032:
            yFrame = (inheritMaleFemaleBttn.frame.minY + 575) - self.inheritScrollView.contentOffset.y
            droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 95)

        default:
            break
        }
    }
        droperTableView.reloadData()
    
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    @IBAction func inheritBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        /*let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil) */
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
                vc?.delegate = self
                self.present(vc!, animated: true, completion: nil)
        
    }
    @IBAction func scanButtonAction(_ sender: UIButton) {
      barcodeScreen = true
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
      vc?.delegate = self
      self.present(vc!, animated: true, completion: nil)
        
        //        scannerView.isHidden = false
        //        scannerView.startScanning()
        //        let viewController = makeBarcodeScannerViewController()
        //        viewController.title = "Barcode Scanner"
        //        present(viewController, animated: true, completion: nil)
        
    }
//    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
//        if UserDefaults.standard.string(forKey: "beefProduct") == "Global HD50K" {
//            scanBarcodeTextfield.text = code
//        }else{
//            inheritBarcodeTextfield.text = code
//        }
//
//
//        controller.dismiss(animated: true, completion: nil)
//    }
//
//    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
//
//    }
//
//    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
    
    //////// Ocr Reader
    
    var methReturn = String()
    
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
                            
                            self.inheritEarTagTextfield.text = ""
                            
                            var mesageShow = String()
                          mesageShow = "Unable to read Value from tag. Please try again. Scanned Result".localized(with: test)
                           
                            let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: mesageShow, preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                                (_)in
                                
//                                self.setUpGallary()
                                let storyboard = UIStoryboard(name: "Main", bundle: nil) //
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
                                
                                self.inheritEarTagTextfield.text = test
                                self.inherittextFieldBackroungWhite()
                                self.dataPopulateInFocusChange()
                                //do another thing
                            })
                            
                            alert.addAction(OKAction)
                            alert.addAction(cancelAction)
                            alert.addAction(thirdAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            return
                        }
                        self.inheritEarTagTextfield.text = self.methReturn
                        self.inherittextFieldBackroungWhite()
                        self.dataPopulateInFocusChange()
                    
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
        
            self.inheritEarTagTextfield.text = ""
       
        //           if self.scanAnimalTagText.tag == 0 {
        //
        //           self.scanAnimalTagText.text = ""
        //
        //           } else  {
        //
        //               self.farmIdTextField.text = ""
        //           }
        
        guard let image = info[.editedImage] as? UIImage else {
           
            return
        }
        
        
        // self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
       
    }
    
    @IBAction func inheritOCRbtn(_ sender: UIButton) {
//        setUpGallary()
      let marketId = UserDefaults.standard.object(forKey: "currentActiveMarketId") as? String ?? ""
      if marketId == "15009e40-7e3d-4653-b7bc-2be1f05915df"{
        if UserDefaults.standard.value(forKey: "beefScannerSelection") as? String == "ocr"{
          let storyboard = UIStoryboard(name: "Main", bundle: nil) //
          let vc = storyboard.instantiateViewController(withIdentifier: "TextScanVC") as? TextScanVC
          vc?.delegate = self
          self.navigationController?.pushViewController(vc!, animated: true)
        }
        else {
          
          if BluetoothCentre.shared.manager.state == .poweredOff{
            let alertController = UIAlertController (title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Bluetooth on this device is currently OFF.", comment: ""), preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { (_) -> Void in
              guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
              }
              
              if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                  UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                  
                } else {
                  UIApplication.shared.openURL(settingsUrl)
                  
                }
              }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
          }
          else {
            if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.disconnected || BluetoothCentre.shared.smartBowPeripheral == nil{
              
              pairedDeviceView.isHidden = false
              pairedBackroundView.isHidden = false
              pairedTableView.reloadData()
            }
            if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
              BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
              
              
              for i in 0 ..< arrNearbyDevice.count{
                var state = arrNearbyDevice[i].state
                if state == .connecting {
                  
                  //    arrNearbyDevice.remove(at: i)
                }
              }
              pairedDeviceView.isHidden = false
              pairedBackroundView.isHidden = false
              pairedTableView.reloadData()
              
            }
          }
        }
      } else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) //
        let vc = storyboard.instantiateViewController(withIdentifier: "TextScanVC") as? TextScanVC
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
      }
     
        
    }
    
    @IBAction func globalOcrBtnAction(_ sender: Any) {
      //        setUpGallary()
            let marketId = UserDefaults.standard.object(forKey: "currentActiveMarketId") as? String ?? ""
            if marketId == "15009e40-7e3d-4653-b7bc-2be1f05915df"{
              if UserDefaults.standard.value(forKey: "beefScannerSelection") as? String == "ocr"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil) //
                let vc = storyboard.instantiateViewController(withIdentifier: "TextScanVC") as? TextScanVC
                vc?.delegate = self
                self.navigationController?.pushViewController(vc!, animated: true)
              }
              else {
                
                if BluetoothCentre.shared.manager.state == .poweredOff{
                  let alertController = UIAlertController (title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Bluetooth on this device is currently OFF.", comment: ""), preferredStyle: .alert)
                  
                  let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                      return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                      if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                        
                      } else {
                        UIApplication.shared.openURL(settingsUrl)
                        
                      }
                    }
                  }
                  alertController.addAction(settingsAction)
                  let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                  alertController.addAction(cancelAction)
                  self.present(alertController, animated: true, completion: nil)
                }
                else {
                  if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.disconnected || BluetoothCentre.shared.smartBowPeripheral == nil{
                    
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                  }
                  if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
                    BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
                    
                    
                    for i in 0 ..< arrNearbyDevice.count{
                      var state = arrNearbyDevice[i].state
                      if state == .connecting {
                        
                        //    arrNearbyDevice.remove(at: i)
                      }
                    }
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                    
                  }
                }
              }
            } else {
              let storyboard = UIStoryboard(name: "Main", bundle: nil) //
              let vc = storyboard.instantiateViewController(withIdentifier: "TextScanVC") as? TextScanVC
              vc?.delegate = self
              self.navigationController?.pushViewController(vc!, animated: true)
            }
           
              
          }
  
    @IBOutlet weak var globalClearFormOutlet: UIButton!
    @IBAction func globalclearFromAction(_ sender: Any) {
       self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let alert = UIAlertController(title: NSLocalizedString("Alert",comment: ""), message: NSLocalizedString("Are you sure you want to reset form?", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            
            self.byDefaultSetting()
            
            
            // tissue perference save
            let ab =  UserDefaults.standard.string(forKey: "BeeftsuClear")
            if ab == nil || ab == "" {
                
                self.tissueArr = fetchproviderData(entityName: "GetSampleTbl", provId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true
                    {
                        self.tissueBttnOutlet.setTitle(tissue?.sampleName, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 1)
                    }
                    
                    
                }
              //  self.tissueBttnOutlet.setTitle("Allflex (TSU)", for: .normal)
              //  self.tissuId = 1
                
                
            } else {
                
                
                self.tissueBttnOutlet.setTitle(ab, for: .normal)
                UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: "Beeftsu")
                let codeId = fetchBreedDataTissueCode(entityName: "GetSampleTbl", provId: pvid, tissueName: ab!)
                
                let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
                if naabFetch1!.count == 0 {
                    
                } else {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
            }
            //// Breedd
            
            var breed = UserDefaults.standard.string(forKey: "BeefbreedClear")
            
            if breed == nil || breed == "" {
                breed = "ANG"
                self.breedBtnOutlet.setTitle(breed, for: .normal)
                
            } else {
                
                self.breedBtnOutlet.setTitle(breed, for: .normal)
                UserDefaults.standard.set(self.breedBtnOutlet.titleLabel?.text, forKey: "Beefbreed")
                
                var inheritBreed = fetchAllDataProductBeefId(entityName: "GetBreedsTbl", breedName: (self.breedBtnOutlet.titleLabel?.text!)!, productId: 19)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    self.breedId = medbreedRegArr1!.breedId ?? ""
                }
            }
            
            /// Incremental
            
            
            let inrementCheck = UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear")
            
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                
                self.incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "incrementalCheckIpad")
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
               
                self.incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            
            
            self.scanEarTagTextField.becomeFirstResponder()
            
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    @IBOutlet weak var inheritClearFormOutlet: UIButton!
    @IBAction func inheritClearFromAction(_ sender: Any) {
      self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let alert = UIAlertController(title: NSLocalizedString("Alert",comment: ""), message: NSLocalizedString("Are you sure you want to reset form?", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            
          self.inheritByDefaultSetting()
          
            
            // tissue perference save
            let ab =  UserDefaults.standard.string(forKey: "BeefInheritTsuClear")
            if ab == nil || ab == "" {
                
                self.inheritTissueBttn.setTitle("Allflex (TSU)", for: .normal)
                self.tissuId = 1
                
                
            } else {
                
                
                self.inheritTissueBttn.setTitle(ab, for: .normal)
                UserDefaults.standard.set(self.inheritTissueBttn.titleLabel!.text, forKey: "BeefInheritSampleType")
                let codeId = fetchBreedDataTissueCode(entityName: "GetSampleTbl", provId: pvid, tissueName: ab!)
                
                let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
                if naabFetch1!.count == 0 {
                    
                } else {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
            }
            //// Breedd
            
            var breed = UserDefaults.standard.string(forKey: "InheritBeefbreedClear")
            
            if breed == nil || breed == "" {
                //  breed = "ANG"
                // self.inheritBreedBttn.setTitle(breed, for: .normal)
                
            } else {
                
                self.inheritBreedBttn.setTitle(breed, for: .normal)
                UserDefaults.standard.set(self.inheritBreedBttn.titleLabel?.text, forKey: "InheritBeefbreed")
                
                var inheritBreed = fetchAllDataProductBeefId(entityName: "GetBreedsTbl", breedName: (self.inheritBreedBttn.titleLabel?.text!)!, productId: 20)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    self.breedId = medbreedRegArr1!.breedId ?? ""
                }
            }
            
            
            
            ///
            /// Incremental
            
            
            let inrementCheck = UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear")
            
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
               
                self.incrementalBarcodeCheckBoxInherit.image = UIImage(named: "incrementalCheckIpad")
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
               
                self.incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            self.inheritEarTagTextfield.becomeFirstResponder()
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
  
  @IBAction func helpAction(_ sender: UIButton) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppHelpImagesVC") as? AppHelpImagesVC
    vc?.module = "Place an Order: Ordering Add Animal(s) Beef".localized
    vc?.modalPresentationStyle = .overFullScreen
    self.present(vc!, animated: false, completion: nil)
  }
    
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
        
        // Side Menu AutoLayout
        
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
            // When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    // Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
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
            // Animate Shadow (Fade In)
            //  UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            self.menuIconLeadingConstraint.constant = 30
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
                
            }
            // Animate Shadow (Fade Out)
            //  UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
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
    
    func sideMenuRevealSettingsViewController() -> BlockyardBeefiPad? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is BlockyardBeefiPad {
            return viewController! as? BlockyardBeefiPad
        }
        while (!(viewController is BlockyardBeefiPad) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is BlockyardBeefiPad {
            return viewController as? BlockyardBeefiPad
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
  
}
extension BlockyardBeefiPad:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }}
extension BlockyardBeefiPad : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == importTblView {
            
            
            
            return importListArray.count
        }
      if tableView == pairedTableView {
        return arrNearbyDevice.count
      }
        
        if btnTag == 20 {
            return tissueArr.count
        }
        else if btnTag == 10{
            return  breedArr.count
        }
        else if btnTag == 40{
            return damRegArr.count
        }
        else if btnTag == 50{
            return inheritTissueArr.count
        }
        else if btnTag == 60{
            return inheritBreedArr.count
        }
        else if btnTag == 70{
            return inheritRegArr.count
        }
        else if btnTag == 80{
            return breedRegArr.count
        } else if btnTag == 90{
            return inheritRegArr.count
        }
        else if btnTag == 110 {
            return genderArray.count
        }
        else{
            return sireRegArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        
        
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
            
            
            // cell.textLabel?.text = tissueArr[indexPath.row]
        }
        
        else if btnTag == 110{
            
        let gender = self.genderArray[indexPath.row]
          cell.textLabel?.text = gender
          return cell
            
            
            // cell.textLabel?.text = tissueArr[indexPath.row]
        }
        
        if btnTag == 10{
            let breed = breedArr[indexPath.row] as! GetBreedsTbl
            
            cell.textLabel?.text = breed.threeCharCode
            return cell
        }
        if btnTag == 30 {
            let tissue = self.sireRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
            return cell
        }
        if btnTag == 40{
            let tissue = self.damRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        if btnTag == 80{
            let tissue = self.breedRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        if btnTag == 50{
            
            let tissue = self.inheritTissueArr[indexPath.row]  as! GetSampleTbl
           
              
          cell.textLabel?.text = tissue.sampleName?.localized
           
           
            return cell
            
            
            
        }
        if btnTag == 60{
            
            
            let breed = inheritBreedArr[indexPath.row] as! GetBreedsTbl
            
            cell.textLabel?.text = breed.threeCharCode
            return cell
            
        }
        if btnTag == 70{
            let tissue = self.inheritRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text =  tissue.association
        }
        if btnTag == 90{
            let tissue = self.inheritRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text =  tissue.association
        }
        return cell
      if tableView == pairedTableView {
        
        let cell = pairedTableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! PairedDeviceCell
        
        var deviceName = arrNearbyDevice[indexPath.row].name
        if deviceName == nil {
          deviceName = String(describing: arrNearbyDevice[indexPath.row].identifier)
        }
        
        cell.deviceLbl?.text = deviceName
        let state = arrNearbyDevice[indexPath.row].state
        if state == .connected{
          cell.accessoryType = .checkmark
        }
        else {
          cell.accessoryType = .none
          
        }
        return cell
        
      }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        if tableView == importTblView {
            
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName
            
            var customerId = UserDefaults.standard.integer(forKey: "currentActiveCustomerId")
            listNameString = listName ?? ""
            listId = Int(listId1)
            
            
            
            return
        }
        
        if btnTag == 20  {
            
            let tissue = self.tissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
      
               
          tissueBttnOutlet.setTitle(tissue.sampleName?.localized, for: .normal)
              
           
            
            // UserDefaults.standard.set(tissue.sampleName, forKey: "Beeftsu")
            buttonbg2.removeFromSuperview()
            
        }
        
        if btnTag == 50 {
            let tissue = self.inheritTissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritTissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
            self.inheritTissueView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if btnTag == 110 {
            let gender = self.genderArray[indexPath.row]
            inheritGenderString = gender
            inheritMaleFemaleBttn.titleLabel?.font = inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
            inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
            inheritMaleFemaleBttn.setTitle(gender, for: .normal)
            buttonbg2.removeFromSuperview()
            self.inheritGenderView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if btnTag == 10  {
            
            let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitle(breed.threeCharCode, for: .normal)
            //
            //            UserDefaults.standard.set(breed.threeCharCode, forKey: "Beefbreed")
            buttonbg2.removeFromSuperview()
            
        }
        if btnTag == 30{
            
            let sireReg = sireRegArr[indexPath.row] as! GetBreedSocieties
            let sireRegID = sireReg.associationId ?? ""
            sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            sireRegDropdownOutlet.setTitle(sireReg.association, for: .normal)
            UserDefaults.standard.set(sireReg.association, forKey: "BeefSireReg")
            buttonbg2.removeFromSuperview()
        }
        if btnTag == 40{
            let damReg = damRegArr[indexPath.row] as! GetBreedSocieties
            let damRegID = damReg.associationId ?? ""
            damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            damRegDropdownOutlet.setTitle(damReg.association, for: .normal)
            UserDefaults.standard.set(damReg.association, forKey: "BeefDamReg")
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 80{
            let breedReg = breedRegArr[indexPath.row] as! GetBreedSocieties
            let damRegID = breedReg.associationId ?? ""
            breedRegBttn.setTitleColor(.black, for: .normal)
            breedRegBttn.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: "BeefBreedReg")
            buttonbg2.removeFromSuperview()
        }
        if btnTag == 50{
            
            let tissue = self.inheritTissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            //inheritTissueBttn.setTitle(tissue.sampleName, for: .normal)
         
          inheritTissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
         
            //UserDefaults.standard.set(tissue.sampleName, forKey: "BeefInheritSampleType")
            buttonbg2.removeFromSuperview()
            
            
            
        }
        if btnTag == 60{
            
            let breed = self.inheritBreedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            inheritBreedBttn.setTitleColor(.black, for: .normal)
            inheritBreedBttn.setTitle(breed.threeCharCode, for: .normal)
            //     UserDefaults.standard.set(breed.threeCharCode, forKey: "InheritBeefbreed")
            buttonbg2.removeFromSuperview()
            
            
            
        }
        if btnTag == 70{
            let breedReg = inheritRegArr[indexPath.row] as! GetBreedSocieties
            let damRegID = breedReg.associationId ?? ""
            inheritRegAssociationBttn.setTitleColor(.black, for: .normal)
            inheritRegAssociationBttn.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: "BeefRegAssociation")
            buttonbg2.removeFromSuperview()
            
        }
        if btnTag == 90{
            let breedReg = inheritRegArr[indexPath.row] as! GetBreedSocieties
            let damRegID = Int(breedReg.associationId!)
            inheriSireRedOutlet.setTitleColor(.black, for: .normal)
            inheriSireRedOutlet.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: "BeefRegAssociation")
            buttonbg2.removeFromSuperview()
            
        }
      if tableView == pairedTableView {
        
          if BluetoothCentre.shared.smartBowPeripheral != nil {
              BluetoothCentre.shared.manager.cancelPeripheralConnection(BluetoothCentre.shared.smartBowPeripheral!)
          }
          BluetoothCentre.shared.ConnectArgument(peripheral: arrNearbyDevice[indexPath.row])
         
          pairedBackroundView.isHidden = true
          pairedDeviceView.isHidden = true
          pairedTableView.reloadData()
          return
      }
    }
    
    
}
extension BlockyardBeefiPad : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if scanEarTagTextField == textField || inheritEarTagTextfield == textField {
         //   scanEarTagTextField.returnKeyType = .next
            inheritEarTagTextfield.returnKeyType = .next
          //  self.inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
            self.inheritEarTagView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        } else if textField == inheritBarcodeTextfield {
            self.inheritEarTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            self.inheritEIDView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor

            self.inheritBarcodeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
        }
        else if textField == inheritEIDTextfield {
            self.inheritEarTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            self.inheritBarcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor

            self.inheritEIDView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if barAutoPopu == false {
            barcodeflag = true
        } else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                if textField == scanEarTagTextField || textField == inheritEarTagTextfield || textField == breedRegTextfield || textField == inheritBreedRegTextfield ||  textField == animalNameTextfield || textField == sireRegTextfield || textField == damRegTextfield || textField == inheritSireRegTextfield    || textField == inheritDamIdTextfield || textField == inheritEIDTextfield || textField == inheritSecondaryIdTextfield || textField == inheritDamYobBttn || textField == inheritSireYobBttn   {
                    barcodeEnable = true
                }
            }
        }
        
        
        //  barcodeflag = true
        
        if (string == " ") {
            return false
        }
      if textField ==  inheritEarTagTextfield {
          self.inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
      }
        
        if textField == scanBarcodeTextfield {
            let currentString: NSString = scanBarcodeTextfield.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                    checkBarcode = false
                } else {
                    //  incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    //self.defaultIncrementalBarCodeSetting()
                    checkBarcode = true
                    
                }
            }
            
        }
        
        if textField == inheritBarcodeTextfield {
            let currentString: NSString = inheritBarcodeTextfield.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxInherit.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                    checkBarcode = false
                    
                } else {
                    // incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    //self.defaultIncrementalBarCodeSetting()
                    checkBarcode = true
                    
                }
            }
            
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
              
                if textField == scanEarTagTextField{
                    if scanEarTagTextField.text!.count == 1 {
                 //       textFieldBackroungGrey()
                        
                    } else {
                        
                        textFieldBackroungWhite()
                    }
                    isautoPopulated = false
                }
                if textField == inheritEarTagTextfield{
                    if inheritEarTagTextfield.text!.count == 1 {
                        inheritTextFieldBackroungGrey()
                    } else {
                        
                        inherittextFieldBackroungWhite()
                    }
                    isautoPopulated = false
                    
                }
                if textField == breedRegTextfield{
                    if breedRegTextfield.text!.count == 1 {
                    }
                }
                if textField == damRegTextfield{
                    if damRegTextfield.text!.count == 1 {
                    }
                }
                if textField == inheritSireRegTextfield{
                    if inheritSireRegTextfield.text!.count == 1 {
                        // inheriSireRedOutlet.isEnabled = false
                        inheriSireRedOutlet.setTitleColor(.black, for: .normal)
                    }
                }
                
                if textField == scanBarcodeTextfield {
                    barcodeflag = true
                    if scanBarcodeTextfield.text!.count == 1 {
                        
                        incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        self.isBarcodeAutoIncrementedEnabled = false
                        checkBarcode = false
                    } else {
                       
                    }
                    
                }
                if textField == inheritBarcodeTextfield {
                    barcodeflag = true
                    if inheritBarcodeTextfield.text!.count == 1 {
                        
                        incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        self.isBarcodeAutoIncrementedEnabled = false
                        checkBarcode = false
                    } else {
                       
                    }
                }
                
            } else {
                if textField == inheritDamYobBttn || textField == inheritSireYobBttn {
                    let textstring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    let length = textstring.count
                    let ACCEPTABLE_CHARACTERS = "0123456789"
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    if check == false {
                        return false
                    }
                    if length > 4 {
                        return false
                    }
                }
                if textField == inheritBarcodeTextfield || textField == scanBarcodeTextfield || textField == inheritEarTagTextfield || textField == scanEarTagTextField {
                    
                    let ACCEPTABLE_CHARACTERS = "+?%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    if check == false {
                        return false
                    }
                }
                
                if textField == inheritDateTextField {
                    
                    if inheritDateTextField.text?.count == 2 || inheritDateTextField.text?.count == 5{
                        inheritDateTextField.text?.append("/")
                    }
                    if inheritDateTextField.text?.count == 10 {
                        return false
                    }
                    
                }
                if textField == globalDateTextField {
                    
                    if globalDateTextField.text?.count == 2 || globalDateTextField.text?.count == 5{
                        globalDateTextField.text?.append("/")
                    }
                    if globalDateTextField.text?.count == 10 {
                        return false
                    }
                    
                }
                if textField == scanEarTagTextField{
                    isautoPopulated = false
                    textFieldBackroungWhite()
                }
              if textField == inheritEarTagTextfield{
                  let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    isautoPopulated = false
                    inherittextFieldBackroungWhite()
                  let maxLength = 16
                  let currentString = (textField.text ?? "") as NSString
                  let newS55tring = currentString.replacingCharacters(in: range, with: string)
                  
                  return newString.count <= maxLength
                }
                if textField == breedRegTextfield{
                    
                    breedRegBttn.isEnabled = true
                }
                if textField ==  sireRegTextfield {
                    
                    sireRegDropdownOutlet.isEnabled = true
                }
                if textField == inheritSireRegTextfield {
                    
                    inheriSireRedOutlet.backgroundColor = UIColor.white
                    inheriSireRedOutlet.setTitleColor(.black, for: .normal)
                }
                if textField == damRegTextfield{
                    
                    damRegDropdownOutlet.isEnabled = true
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
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
            //  barcodeflag = true
            if isautoPopulated == true {
                let animalData = fetchAnimaldataValidateAnimalTag(entityName: "BeefAnimaladdTbl", animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
                if animalData.count == 0{
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgcheckk = false
                    }
                }
            }
        }
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      if  textField == inheritEarTagTextfield {
        if inheritEarTagTextfield.text?.count ?? 0 != 0 {
          if inheritEarTagTextfield.text?.count ?? 0 > 14 && inheritEarTagTextfield.text?.count ?? 0 < 17 {
            dataPopulateInFocusChange()
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
           
            
          } else {
            //inheritEarTagTextfield.becomeFirstResponder()
            inheritEarTagView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: "Alert".localized, messageStr: "Unique ID length should be 15 or 16 characters.".localized)
            return
          }
        }
      }

            else if textField == inheritDateTextField {
            if inheritDateTextField.text!.count == 0{
                
            }  else {
                
                if inheritDateTextField.text?.count == 10 {
                    
                    var validate = isValidDate(dateString: inheritDateTextField.text ?? "")
                  
                    if validate == "Correct Format" {
                        inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
                        inheritDobBttn.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        //  dateBttnOutlet.layer
                        inheritDobBttn.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                        
                    }
                    
                } else {
                    inheritDobBttn.layer.borderColor = UIColor.red.cgColor
                    // dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                }
            }
        }
        
        
        if textField == globalDateTextField {
            if globalDateTextField.text!.count == 0{
                
            }  else {
                
                if globalDateTextField.text?.count == 10 {
                    
                    var validate = isValidDate(dateString: globalDateTextField.text ?? "")
                   
                    if validate == "Correct Format" {
                        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                        dateBttnOutlet.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        //  dateBttnOutlet.layer
                        dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                        
                    }
                    
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    // dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                }
            }
        }
        if textField == scanEarTagTextField {
            if scanEarTagTextField.text != "" {
                dataPopulateInFocusChange()

            }
        }
        
    }
    
    func dataPopulateInFocusChange(){
      let userId = UserDefaults.standard.integer(forKey: "userId")
      let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
      let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
      var samplename = String()
      let ob =  fetchAllData(entityName: "BeefAnimalMaster")
      
      
      let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:"", farmId: "", animalbarCodeTag: "", offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
      let inheritAddAnimal = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimaladdTbl", animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
      
      if isautoPopulated == false{
        if animalData.count > 0 {
          isautoPopulated = true
          barAutoPopu = true
          textFieldBackroungWhite()
          updateOrder = true
          var data =  animalData.lastObject as! BeefAnimalMaster
          let userId = UserDefaults.standard.integer(forKey: "userId")
          ////////start
          let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
          animalId1 = Int(data.animalId)
          dateBttnOutlet.titleLabel?.text = ""
          
          
          var dataFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl",orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
          if dataFetch.count == 0 {
            // scanBarcodeTextfield.text = ""
            incrementalBarcodeTitleLabelGlobal.textColor = .black
            incrementalBarcodeTitleLabelGlobal.alpha = 1
            incrementalBarcodeCheckBoxGlobal.alpha = 1
            // self.isBarcodeAutoIncrementedEnabled = false
            incrementalBarcodeButtonGlobal.isEnabled = true
            // incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
          } else {
            if data.orderstatus == "true"{
              //  scanBarcodeTextfield.text = ""
              checkBarcode = false
              incrementalBarcodeTitleLabelGlobal.textColor = .black
              incrementalBarcodeButtonGlobal.isEnabled = true
              incrementalBarcodeTitleLabelGlobal.alpha = 1
              incrementalBarcodeCheckBoxGlobal.alpha = 1
            } else {
              scanBarcodeTextfield.text = data.animalbarCodeTag
              UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
              UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
              self.isBarcodeAutoIncrementedEnabled = false
              incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
              incrementalBarcodeButtonGlobal.isEnabled = false
              incrementalBarcodeTitleLabelGlobal.textColor = .gray
              checkBarcode = false
              incrementalBarcodeTitleLabelGlobal.alpha = 0.6
              incrementalBarcodeCheckBoxGlobal.alpha = 0.6
              
            }}
          
          earTagView.layer.borderColor = UIColor.gray.cgColor
          barcodeView.layer.borderColor = UIColor.gray.cgColor
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
                yearPublic = Int(year)!
                
              }
              
              if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                globalDateTextField.text = dateVale
              } else {
                dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                yearPublic = Int(year)!
                
              }
              if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                globalDateTextField.text = dateVale
              } else {
                dateBttnOutlet.setTitle(dateVale, for: .normal)
              }
              formatter.dateFormat = "dd/MM/yyyy"
            }
            if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
              
            }else {
              if dateBttnOutlet.titleLabel!.text == nil {
                //self.selectedDate = Date()
              }
              else{
                self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
              }
            }
          }
          // let dates =  formatter.string(from: selectedDate)
          
          
          barcodeflag = false
          breedRegTextfield.text = data.offPermanentId
          sireRegTextfield.text = data.offsireId
          damRegTextfield.text = data.offDamId
          animalNameTextfield.text  = data.eT
          if data.breedName == "X-Breed"{
            breedBtnOutlet.setTitle("XX", for: .normal)
          } else {
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
          }
         
          tissueBttnOutlet.setTitleColor(.black, for: .normal)
          breedBtnOutlet.setTitleColor(.black, for: .normal)
          tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
          UserDefaults.standard.set(data.tissuName, forKey: "Beeftsu")
          
          if data.farmId != ""{
            breedRegBttn.setTitle(data.farmId, for: .normal)
            breedRegBttn.setTitleColor(.black, for: .normal)
          }
          if data.sireIDAU != ""{
            sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
            sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
          }
          if data.nationHerdAU != ""{
            damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
            damRegDropdownOutlet.setTitleColor(.black, for: .normal)
          }
          breedRegBttn.backgroundColor = .white
          sireRegDropdownOutlet.backgroundColor = .white
          damRegDropdownOutlet.backgroundColor = .white
          breedId = data.breedId!
          samplename = data.tissuName!
          let pvidAA = data.providerId
          
          UserDefaults.standard.set(data.breedName, forKey: "Beefbreed")
          
          if data.gender == "Male".localized || data.gender == "M"{
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
        
        
        
        /// Inherit code
        if inheritAddAnimal.count > 0 {
          isautoPopulated = true
          barAutoPopu = true
          inherittextFieldBackroungWhite()
          updateOrder = true
          let data =  inheritAddAnimal.lastObject as! BeefAnimaladdTbl
          autoPopulateAnimalData = data
          let userId = UserDefaults.standard.integer(forKey: "userId")
          ////////start
          animalId1 = Int(data.animalId)
          
          /////////end
          barcodeflag = false
          
          inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
          inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
          let dateStr = UserDefaults.standard.value(forKey: "date") as? String
          var formatter = DateFormatter()
          var years = ""
          inheritDobBttn.titleLabel?.text = ""
          
          if data.date != ""{
            if dateStr == "MM"{
              var dateVale = ""
              let values = data.date!.components(separatedBy: "/")
              if values.count > 1{
                let date = values[0]
                let month = values[1]
                let year = values[2]
                years = year
                dateVale = month + "/" + date + "/" + year
                yearPublic = Int(year)!
              }
              if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                inheritDateTextField.text = dateVale
              } else {
                inheritDobBttn.setTitle(dateVale, for: .normal)
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
                years = year
                dateVale = date + "/" + month + "/" + year
                yearPublic = Int(year)!
                
              }
              if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                inheritDateTextField.text = dateVale
              } else {
                inheritDobBttn.setTitle(dateVale, for: .normal)
              }
              formatter.dateFormat = "dd/MM/yyyy"
            }
            
            if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
              
            } else {
              if inheritDobBttn.titleLabel!.text == nil {
                self.InheritSelectedDate = Date()
              }
              else{
                self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!) ?? Date()
              }
              let dates =  formatter.string(from: InheritSelectedDate)
              
            }}
          
//          inheritBreedRegTextfield.text = data.offPermanentId
//          inheritSireRegTextfield.text = data.offsireId
//          inheritDamIdTextfield.text = data.offDamId
//          inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
          var dataFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl",orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
          if dataFetch.count == 0 {
            //  inheritBarcodeTextfield.text = ""
            incrementalBarcodeTitleLabelInherit.textColor = .black
            incrementalBarcodeTitleLabelInherit.alpha = 1
            incrementalBarcodeCheckBoxInherit.alpha = 1
            //  self.isBarcodeAutoIncrementedEnabled = false
            incrementalBarcodeButtonInherit.isEnabled = true
            // incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
          } else {
            var orStatus = dataFetch[0] as? BeefAnimaladdTbl
            
            if orStatus?.orderstatus == "true"{
              //     inheritBarcodeTextfield.text = ""
              checkBarcode = false
              incrementalBarcodeTitleLabelInherit.textColor = .black
              incrementalBarcodeButtonInherit.isEnabled = true
              incrementalBarcodeTitleLabelInherit.alpha = 1
              incrementalBarcodeCheckBoxInherit.alpha = 1
            } else {
              inheritBarcodeTextfield.text = data.animalbarCodeTag
              UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
              UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
              self.isBarcodeAutoIncrementedEnabled = false
              incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
              incrementalBarcodeButtonInherit.isEnabled = false
              incrementalBarcodeTitleLabelInherit.textColor = .gray
              checkBarcode = false
            }}
          if data.breedName == "X-Breed"{
            inheritBreedBttn.setTitle("XX", for: .normal)
          } else {
            inheritBreedBttn.setTitle(data.breedName, for: .normal)
          }
          
         
          inheritTissueBttn.setTitleColor(.black, for: .normal)
        //  inheritBreedBttn.setTitleColor(.black, for: .normal)
          inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
          UserDefaults.standard.set(data.tissuName, forKey: "BeefInheritTsu")
       //   inheritSireYobBttn.text = data.sireYOB
//inheritDamYobBttn.text = data.damYOB
          breedId = data.breedId!
          samplename = data.tissuName!
          let pvidAA = data.providerId
          UserDefaults.standard.set(data.breedName, forKey: "InheritBeefbreed")
          inheritEIDTextfield.text = data.sireIDAU
        //  inheritSecondaryIdTextfield.text = data.nationHerdAU
        //  inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
          if data.gender == "Male".localized || data.gender == "M"{
          //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 1
            inheritGenderString = NSLocalizedString("Male", comment: "")
              self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
              self.inheritMaleFemaleBttn.setTitle("Male", for: .normal)
              self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
          } else {
         //   self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 0
            inheritGenderString = "Female".localized
              self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
              self.inheritMaleFemaleBttn.setTitle("Female", for: .normal)
              self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
          }
          
          tissuId = Int(data.tissuId)
          
          inheritDobBttn.setTitleColor(.black, for: .normal)
          statusOrder = false
          messageCheck = false
          let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
          if adata.count > 0{
            let animal  = adata.object(at: 0) as! BeefAnimalMaster
            idAnimal = Int(animal.animalId)
            //statusOrder = true
            messageCheck = true
          }
          
          if data.eT == "" || data.eT == nil {
         //   inheritRegAssociationBttn.setTitle(NSLocalizedString("Select Breed Association", comment: ""), for: .normal)
          }
          if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
         //   inheriSireRedOutlet.setTitle(NSLocalizedString("Select Sire Registration Association", comment: ""), for: .normal)
          }
        }
      }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        var samplename = String()
        let ob =  fetchAllData(entityName: "BeefAnimalMaster")
        
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:"", farmId: "", animalbarCodeTag: "", offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId)
        let inheritAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId)
        if isautoPopulated == false{
            if animalData.count > 0 {
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                var data =  animalData.lastObject as! BeefAnimalMaster
                //                damtexfield.layer.borderColor = UIColor.gray.cgColor
                let userId = UserDefaults.standard.integer(forKey: "userId")
                ////////start
                let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                animalId1 = Int(data.animalId)
                //                if data.orderstatus == "false"{
                //                   scanBarcodeTextfield.text = data.animalbarCodeTag
                //                }
                /////////end
                
                var dataFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl",orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    // scanBarcodeTextfield.text = ""
                    incrementalBarcodeTitleLabelGlobal.textColor = .black
                    incrementalBarcodeTitleLabelGlobal.alpha = 1
                    incrementalBarcodeCheckBoxGlobal.alpha = 1
                    //  self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeButtonGlobal.isEnabled = true
                    // incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
                } else {
                    if data.orderstatus == "true"{
                        // scanBarcodeTextfield.text = ""
                        checkBarcode = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .black
                        incrementalBarcodeButtonGlobal.isEnabled = true
                        incrementalBarcodeTitleLabelGlobal.alpha = 1
                        incrementalBarcodeCheckBoxGlobal.alpha = 1
                    }else {
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "Incremental_Check")
                        incrementalBarcodeButtonGlobal.isEnabled = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .gray
                        incrementalBarcodeTitleLabelGlobal.alpha = 0.6
                        incrementalBarcodeCheckBoxGlobal.alpha = 0.6
                        checkBarcode = false
                    }}
                
                
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                
                dateBttnOutlet.titleLabel?.text = ""
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
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                        
                    } else {
                        if dateBttnOutlet.titleLabel!.text == nil {
                            self.selectedDate = Date()
                        }
                        else {
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                            
                        }
                        let dates =  formatter.string(from: selectedDate)
                    }
                }
                
                
                
                barcodeflag = false
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: "Beeftsu")
                
                if data.farmId != ""{
                    breedRegBttn.setTitle(data.farmId, for: .normal)
                    breedRegBttn.setTitleColor(.black, for: .normal)
                }
                if data.sireIDAU != ""{
                    sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                    sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                if data.nationHerdAU != ""{
                    damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                    damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                breedRegBttn.backgroundColor = .white
                sireRegDropdownOutlet.backgroundColor = .white
                damRegDropdownOutlet.backgroundColor = .white
                breedId = data.breedId!
                samplename = data.tissuName!
                let pvidAA = data.providerId
                
                UserDefaults.standard.set(data.breedName, forKey: "Beefbreed")
                
              if data.gender == "Male".localized || data.gender == "M"{
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
            if inheritAnimalData.count > 0 {
                isautoPopulated = true
                barAutoPopu = true
                inherittextFieldBackroungWhite()
                updateOrder = true
                var data =  inheritAnimalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: "userId")
                ////////start
                let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                animalId1 = Int(data.animalId)
                UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                self.isBarcodeAutoIncrementedEnabled = false
                /////////end
                barcodeflag = false
                
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                inheritDobBttn.titleLabel?.text = ""
                
                var years = ""
                if data.date != "" {
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            years = year
                            dateVale = month + "/" + date + "/" + year
                            yearPublic = Int(year)!
                        }
                        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                            inheritDateTextField.text = dateVale
                        }else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
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
                            years = year
                            dateVale = date + "/" + month + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                            inheritDateTextField.text = dateVale
                        }else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry" {
                        
                    }else {
                        if inheritDobBttn.titleLabel!.text == nil {
                            self.InheritSelectedDate = Date()
                        }
                        else{
                            self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                        }
                        let dates =  formatter.string(from: InheritSelectedDate)
                    }}
                
                var dataFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl",orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    //  inheritBarcodeTextfield.text = ""
                    incrementalBarcodeTitleLabelInherit.textColor = .black
                    incrementalBarcodeTitleLabelInherit.alpha = 1
                    incrementalBarcodeCheckBoxInherit.alpha = 1
                    //  self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeButtonInherit.isEnabled = true
                    // incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
                } else {
                    
                    var orStatus = dataFetch[0] as? BeefAnimaladdTbl
                    
                    if orStatus?.orderstatus == "true"{
                        //inheritBarcodeTextfield.text = ""
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeButtonInherit.isEnabled = true
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                    } else {
                        inheritBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxInherit.image = UIImage(named: "Incremental_Check")
                        incrementalBarcodeButtonInherit.isEnabled = false
                        incrementalBarcodeTitleLabelInherit.textColor = .gray
                        checkBarcode = false
                    }
                }
                
                inheritBreedRegTextfield.text = data.offPermanentId
                inheritSireRegTextfield.text = data.offsireId
                inheritDamIdTextfield.text = data.offDamId
                inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                
                inheritBreedBttn.setTitle(data.breedName, for: .normal)
                inheritTissueBttn.setTitleColor(.black, for: .normal)
                inheritBreedBttn.setTitleColor(.black, for: .normal)
              inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
              UserDefaults.standard.set(data.tissuName?.localized, forKey: "BeefInheritSampleType")
                inheritSireYobBttn.text = data.sireYOB
                inheritDamYobBttn.text = data.damYOB
                breedId = data.breedId!
                samplename = data.tissuName!
                let pvidAA = data.providerId
                UserDefaults.standard.set(data.breedName, forKey: "InheritBeefbreed")
                inheritEIDTextfield.text = data.sireIDAU
                inheritSecondaryIdTextfield.text = data.nationHerdAU
                inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
              if data.gender == "Male".localized || data.gender == "M"{
                 //   self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    inheritGenderToggleFlag = 1
                    inheritGenderString = NSLocalizedString("Male", comment: "")
                  self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
                  self.inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                  self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
                } else {
                 //   self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    inheritGenderToggleFlag = 0
                  inheritGenderString = "Female".localized
                    self.inheritMaleFemaleBttn.titleLabel?.font = self.inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
                    self.inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                    self.inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
                }
                
                tissuId = Int(data.tissuId)
                textField.resignFirstResponder()
                
                inheritDobBttn.setTitleColor(.black, for: .normal)
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
            
//            if scanEarTagTextField.text!.count > 0 {
//                textFieldBackroungWhite()
//            }
//            else{
//                textFieldBackroungGrey()
//            }
        }
        if textField == scanEarTagTextField {
            
            if scanEarTagTextField.text == ""{
                
                earTagView.layer.borderColor = UIColor.red.cgColor
                // scannerView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                earTagView.layer.borderColor = UIColor.gray.cgColor
                // scannerView.layer.borderColor = UIColor.gray.cgColor
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
        if textField == inheritEarTagTextfield {
            if inheritEarTagTextfield.text == ""{
                
                inheritEarTagView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                self.inheritEarTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.inheritBarcodeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

            }
            inheritBarcodeTextfield.becomeFirstResponder()

        }
        if textField == inheritBarcodeTextfield{
            if inheritBarcodeTextfield.text == ""{
                inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
            }
            else {
            self.inheritBarcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
              

            }
            inheritEIDView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
            inheritEIDTextfield.becomeFirstResponder()

        }
        if textField == inheritEIDTextfield {
         //   inheritSecondaryIdTextfield.becomeFirstResponder()
        }
        if textField == inheritSecondaryIdTextfield {
            inheritBreedRegTextfield.becomeFirstResponder()
        }
        if textField == inheritBreedRegTextfield{
            inheritSireRegTextfield.becomeFirstResponder()
        }
        if textField == inheritSireRegTextfield{
            inheritSireYobBttn.becomeFirstResponder()
        }
        if textField == inheritSireYobBttn{
            inheritDamIdTextfield.becomeFirstResponder()
        }
        if textField == inheritDamIdTextfield{
            inheritDamYobBttn.becomeFirstResponder()
        }
        if textField == inheritDamYobBttn{
            textField.resignFirstResponder()
        }
        return true
    }
    func pageLoading() {
        if UserDefaults.standard.value(forKey: "page")  == nil {
            
            // UserDefaults.standard.set("off", forKey: "On")
          self.NavigateToBeefOrderingScreen()
           // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
            
        } else {
            if  UserDefaults.standard.value(forKey: "On") as? String  == "off" {
                let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
             
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
            }
            else {
                // UserDefaults.standard.set("off", forKey: "On")
              self.NavigateToBeefOrderingScreen()
             //   self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
            }
        }
    }
    func timeStamp()-> String{
        
        var time1 = NSDate()
        
        var formatter = DateFormatter()
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
    
}
extension BlockyardBeefiPad : SideMenuUI,objectPickCartScreen{
    func objectGetOnSelection(temp: Int) {
      isAnimalComingFromCart = true
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
          //  textFieldBackroungGrey()
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}




extension BlockyardBeefiPad : AnimalMergeProtocol{
    func refreshUI() {
            let animalCount = fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.cartView.isHidden = true
                self.inheritCrossBtnOutlet.isHidden = true
                self.InheritmergeListBtnOulet.isHidden = true
                
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.cartView.isHidden = false
                self.inheritCrossBtnOutlet.isHidden = false
                
                self.InheritmergeListBtnOulet.isHidden = false
            }
            
           
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                InheritmergeListBtnOulet.isHidden = true
                inheritCrossBtnOutlet.isHidden = true
            }
        }
}
//MARK: CREATE Beef Datalist
private typealias DataListGlobalHD50KCartHelper = BlockyardBeefiPad
private extension DataListGlobalHD50KCartHelper {
  
  func fetchDatalistDetailbyName(listName: String) -> [DataEntryList] {
    let fetchDataEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:"Dairy") as! [DataEntryList]
    return fetchDataEntry
  }
  
    func CheckCartanimalCount() {
      //TODO:  checked if for this customer animal count is greater than zero
      let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: "AnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
      if viewAnimalArray.count > 0{
        createDataList()
      }
      
    }
  func createDataList(){
    print("pvid =", pvid)
    
    let orderingDataList = OrderingDataListViewModel()
    let listName = orderingDataList.makeListName(custmerId: custmerId , providerID: pvid)
    if listName != "" {
      
      
      var animalID1 = UserDefaults.standard.integer(forKey: "listId")
      if animalID1 == 0 {
        animalID1 = animalID1 + 1
        UserDefaults.standard.set(animalID1, forKey: "listId")
        
      } else {
        animalID1 = animalID1 + 1
        UserDefaults.standard.set(animalID1, forKey: "listId")
      }
      self.hideIndicator()
      
      if UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
        
        if self.pvid == 5 || self.pvid == 13  {
          var fetchDatEntry = [DataEntryList]()
          var productType  = ""
          fetchDatEntry =  fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(custmerId ),listName: listName ,productName:"Beef") as! [DataEntryList]
         
          
          
          if fetchDatEntry.count == 0 {
            // self.view.makeToast(NSLocalizedString("List created successfully.", comment: ""), duration: 8, position: .bottom)
            
            saveDataEnteryList(entity: "DataEntryList",customerId: Int64(custmerId ?? 0),listDesc: "",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: "userId") as? Int ?? 0, providerId: self.pvid, productType: "InheritEnrollment", productName: "Beef")
            
            SaveAnimalDatInList(listID: Int64(animalID1), animalID: animalID1)
            
          } else {
            let listIdGet = fetchDatEntry[0].listId
            // save animal in existing listName
            SaveAnimalDatInList(listID: listIdGet, animalID: animalID1)
          }
        }
        
      }
      
      
    }
    
  }
  func SaveAnimalDatInList(listID:Int64,animalID:Int){
    
      let animals = fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid) as! [BeefAnimaladdTbl]
      
      for data in animals {
        
        let animalData = checkAnimaldataValidateAnimalTagDataEntry(entityName: "DataEntryBeefAnimaladdTbl", animalTag:data.animalTag ?? "",listId: Int(listID ), custmerId: custmerId , providerID: self.pvid)
        if animalData.count == 0 {
          inheritSaveAnimalInDataBeefAnimalGlobalHD50K(listID: listID, animalDetails: data, animalID: animalID)
        }
        
      }
      
    
  }
  
  
  func saveAnimalInDataBeefAnimalGlobalHD50K(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
   
    saveAnimaldataBeefInProductId(entity: "DataEntryBeefAnimaladdTbl",
                                  animalTag: animalDetails.animalTag ?? "",
                                  barCodetag: animalDetails.animalbarCodeTag ?? "" ,
                                  date: animalDetails.date ?? ""  ,
                                  damId: animalDetails.offDamId ?? "",
                                  sireId: animalDetails.offsireId ?? "" ,
                                  gender: animalDetails.gender ?? "",
                                  update: "true",
                                  permanentId:animalDetails.offPermanentId ?? "",
                                  tissuName: animalDetails.tissuName ?? "",
                                  breedName: animalDetails.breedName ?? "",
                                  et: animalDetails.eT ?? "",
                                  farmId: animalDetails.farmId ?? "",
                                  orderId: autoD,
                                  orderSataus:"false",
                                  breedId:animalDetails.breedId ?? "",
                                  isSync:"false",
                                  providerId: Int(animalDetails.providerId),
                                  tissuId: Int(animalDetails.tissuId),
                                  sireIDAU: animalDetails.sireIDAU ?? "",
                                  nationHerdAU: animalDetails.nationHerdAU ?? "",
                                  userId: userId,
                                  udid:animalDetails.udid ?? "",
                                  animalId: Int(animalDetails.animalId),
                                  productId:Int(animalDetails.productId),
                                  custId: Int(animalDetails.custmerId),
                                  listId: listID,
                                  serverAnimalId: "",
                                  tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
  
  func inheritSaveAnimalInDataBeefAnimalGlobalHD50K(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
   
    inheritSaveAnimaldataBeefInProductId(entity: "DataEntryBeefAnimaladdTbl",
                                         animalTag: animalDetails.animalTag ?? "",
                                         barCodetag: animalDetails.animalbarCodeTag ?? "",
                                         date: animalDetails.date ?? "" ,
                                         damId: animalDetails.offDamId ?? "",
                                         sireId: animalDetails.offsireId ?? "" ,
                                         gender: animalDetails.gender ?? "",
                                         update: "true",
                                         permanentId:animalDetails.offPermanentId ?? "",
                                         tissuName: animalDetails.tissuName ?? "",
                                         breedName: animalDetails.breedName ?? "",
                                         et: animalDetails.eT ?? "",
                                         farmId:animalDetails.farmId ?? "",
                                         orderId: autoD,
                                         orderSataus:"false",
                                         breedId:animalDetails.breedId ?? "",
                                         isSync:"false",
                                         providerId: Int(animalDetails.providerId ),
                                         tissuId: Int(animalDetails.tissuId ),
                                         sireIDAU: animalDetails.sireIDAU ?? "",
                                         nationHerdAU: animalDetails.nationHerdAU ?? "",
                                         userId: userId,
                                         udid:animalDetails.udid ?? "",
                                         animalId: Int(animalDetails.animalId ),
                                         productId:Int(animalDetails.productId ),
                                         sirYOB: animalDetails.sireYOB ?? "",
                                         damYOB: animalDetails.damYOB ?? "",
                                         sireRegAssocation: animalDetails.sireRegAssocation ?? "",
                                         custId: Int(animalDetails.custmerId ),
                                         listId: listID ,
                                         serverAnimalId: "",
                                         tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
}
//MARK: Auto Import Datalist
private typealias AutoImportDataListHelper = BlockyardBeefiPad
private extension AutoImportDataListHelper {
  // MARK: AUTO IMPORT ANIMAL FROM DATALIST
  func checkUserDataListName(){
    // checked list name - rajni.raswant@mobileprogramming.com&customerID&species
    // if exist auto import that data in cart meanse save that data in "AnimaladdTbl" and "AnimalmasterTbl"
    let orderingDataList = OrderingDataListViewModel()
    let listName = orderingDataList.makeListName(custmerId: self.custmerId ?? 0, providerID: pvid)
    let fetchDatEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:"Beef") as! [DataEntryList]
    if fetchDatEntry.count > 0{
//      inheritCrossBtnOutlet.isHidden = true
//      globalCrossBtnOutlet.isHidden = true
      var screenPerference = UserDefaults.standard.value(forKey: "screen") as? String
//          if screenPerference == "officialid" {
      let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: "DataEntryBeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry.first?.listId ?? 0), custmerId: Int64(custmerId ?? 0), providerId: pvid)
        if fetchData11.count != 0 {
          
          for i in 0...fetchData11.count - 1 {
            
            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
            
              inheritSaveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: pvid ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: fetchDatEntry.first?.listId ?? 0 , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
              
              UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "DataEntryBeefInheritTsu")
              UserDefaults.standard.set(dataGet.breedName ?? "", forKey: "DataEntryInheritBeefbreed")
              
              self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
              self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
              
            
            autoSaveProductandsubProduct(dataGet: dataGet)
            //}
          }
        }
      
    }
    
  }
  //MARK: AUTOSAVE Product and subProduct
  func autoSaveProductandsubProduct(dataGet:DataEntryBeefAnimaladdTbl){
    let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
    
    let product  = fetchAllData(entityName: "GetProductTblBeef")
   
    for k in 0 ..< animalData.count{
        
        let animalId = animalData[k] as! BeefAnimaladdTbl
        
        for i in 0 ..< product.count {
            
            let data = product[i] as! GetProductTblBeef
            
            saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
            
            let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTblBeef", adonId: "BVDV", status: "true",ordrId:orderId,customerID: custmerId)
            for j in 0 ..< addonArr.count {
                
                let addonDat = addonArr[j] as! GetAdonTbl
                if data12333.count > 0 {
                    if addonDat.adonName == "BVDV" {//76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                        saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        updateProductTablevaleeSingleeInBef(entity: "GetAdonTbl", productId: Int(addonDat.adonId), status: "true")
                    }
                    else {
                        saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
                else {
                    saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                }
                
                let message = NSLocalizedString("Animal added successfully.", comment: "")
                statusOrder = false
                UserDefaults.standard.removeObject(forKey: "review")
                self.animalSucInOrder = ""
                
            }
        }
    }
  }
}


extension BlockyardBeefiPad: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        print("scanned QR value -> \(qrValue)")
        if UserDefaults.standard.string(forKey: "beefProduct") == "Global HD50K" {
            scanBarcodeTextfield.text = qrValue
        }else{
            inheritBarcodeTextfield.text = qrValue
        }
    }
}


extension BlockyardBeefiPad: scannedOCRProtocol {
  func ocrDetected(_ scannedResult: String) {
    inheritEarTagTextfield.text = scannedResult
    isautoPopulated = false
    inherittextFieldBackroungWhite()
    
  }
}


extension BlockyardBeefiPad : RFID,nearByDevice{
    
    func rfidCode(rfid: String) {
        
        if UserDefaults.standard.value(forKey: "beefScannerSelection") as? String == "ocr"  && UserDefaults.standard.string(forKey: "ProviderName") == "US Dairy Products"{
            
        } else {
          inheritEarTagTextfield.text?.removeAll()
                if inheritEarTagTextfield.isEnabled == true {
                    // arrNearbyDevice =  rfid
                  inheritEarTagTextfield.becomeFirstResponder()
                  inheritEarTagTextfield.text = rfid
                  inheritEarTagTextfield.text = inheritEarTagTextfield.text!.trimmingCharacters(in: CharacterSet.whitespaces)
                  // dataPopulateInFocusChange()
                  inherittextFieldBackroungWhite()
                }
            
        }}
    
   
    
    func deviceNear(deviceName : [CBPeripheral]){
        
        arrNearbyDevice = deviceName
    }
}


