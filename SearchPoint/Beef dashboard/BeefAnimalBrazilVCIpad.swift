//
//  BeefAnimalBrazilVCIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 09/03/25.
//

import Foundation
import UIKit


class BeefAnimalBrazilVCIpad: UIViewController,UIScrollViewDelegate{
    
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    var viewsArray = [UIView]()
    var importListArray = [DataEntryList]()
   var tempImportListArray = [DataEntryList]()
    var listNameString = String()
    var listId = Int()
    var conflictArr = [DataEntryBeefAnimaladdTbl]()
    
    @IBOutlet weak var tertiaryBreedingView: UIView!
    @IBOutlet weak var secondaryBreedingView: UIView!
    @IBOutlet weak var primaryBreedingView: UIView!
    @IBOutlet weak var breedTypeHeaderView: UIView!
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var nonGenoSeriesView: UIView!
    @IBOutlet weak var nonGenoBarcodeView: UIView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var nonGenoRGNView: UIView!
    @IBOutlet weak var nonGenoRGDView: UIView!
    @IBOutlet weak var nonGenoAnimalNameView: UIView!
    @IBOutlet weak var nonGenoSampleTypeView: UIView!
    @IBOutlet weak var nonGenoGenderView: UIView!
    @IBOutlet weak var nonGenoBreedTypeView: UIView!
    
    @IBOutlet weak var GenoSeriesView: UIView!
    @IBOutlet weak var GenoRGNView: UIView!
    @IBOutlet weak var GenoRGDView: UIView!
    @IBOutlet weak var GenoAnimalNameView: UIView!
    @IBOutlet weak var GenoSampleTypeView: UIView!
    @IBOutlet weak var GenoGenderView: UIView!
    @IBOutlet weak var GenoBreedTypeView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    var changeColorToRed = false
    var genderArray = ["Female","Male"]
    let tapRec = UITapGestureRecognizer()
    @IBOutlet weak var appStatusLabel: UILabel!
    /// Genotype
    @IBOutlet weak var Breedgenstarblack: UIButton!
    var userId = Int()// UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    var orderId = Int()
    var pid : GetProductTblBeef?
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    @IBOutlet weak var genotypeMergeListBtnOulet: UIButton!
   let langCode : String = UserDefaults.standard.object(forKey: "lngCode") as! String
    
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    var gestureEnabled: Bool = true
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true

    
    @IBAction func genotypeMergeListBtnClick(_ sender: Any) {
        
//        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AnimalMergePopUpVC") as! AnimalMergePopUpVC
//        vc.delegate = self
//        vc.providerId = pvid ?? 6
//        self.navigationController?.present(vc, animated: false, completion: nil)
        
        let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImportListViewVC") as! ImportListViewVC
        vc.delegate = self
        vc.providerId = pvid ?? 6
       // self.navigationController?.present(vc, animated: false, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var nongenotypeMergeListBtnOulet: UIButton!

    @IBAction func nongenotypeMergeListBtnClick(_ sender: Any) {
        
//        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AnimalMergePopUpVC") as! AnimalMergePopUpVC
//        vc.delegate = self
//        vc.providerId = pvid ?? 6
//        self.navigationController?.present(vc, animated: false, completion: nil)
        
        let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImportListViewVC") as! ImportListViewVC
        vc.delegate = self
        vc.providerId = pvid ?? 6
       // self.navigationController?.present(vc, animated: false, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBOutlet weak var genotypeImportFromBtnBtnOutlet: UIButton!
    
    @IBOutlet weak var addAnotherBtnTtile: UILabel!
    @IBAction func genotypeImportFromBtnAction(_ sender: Any) {
        
        view.endEditing(true)
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        
        if isGenostarblackOnlyAdded == true && isGenotypeOnlyAdded == true
        {
            tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.genoTypeStarBlack.rawValue) as! [DataEntryList]
          if tempImportListArray.count>0 {
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
          }
            
        }
        else{
          tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.genoTypeOnly.rawValue) as! [DataEntryList]
          if tempImportListArray.count>0 {
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
          }
        }
        

        conflictArr.removeAll()
//        if importListArray.count == 0 {
//            
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No lists available for this customer.", comment: ""))
//
////            importListMainView.isHidden = true
////            importBackroundView.isHidden = true
//            return
//        }
        let data1 = fetchAllDataWithOrderID(entityName: Entities.beefAnimalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            
            var animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
        
            if animalStatusChck.count != 0 {
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:NSLocalizedString("Product selection will be cleared if you want to import list. Do you want to continue?", comment: "") , preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    
//                    self.importListMainView.isHidden = true
//                    self.importBackroundView.isHidden = true
                    return
                })
                alert.addAction(cancel)
                
                     let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                        
                        for j in 0 ..< data1.count {
                            let animal = data1.object(at: j) as! BeefAnimaladdTbl
                            

                     }
                    //    if self.importListArray.count != 0 {
//                            self.importListMainView.isHidden = false
//                            self.importBackroundView.isHidden = false
                 //           self.importTblvIEW.reloadData()
                            let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddExistingAnimaliPad") as? AddExistingAnimaliPad
                            vc!.bckRetain = true
                            vc?.importDelegate = self
                            self.navigationController?.pushViewController(vc!, animated: false)

                     //   }
                     })
                     alert.addAction(ok)
                     
                     DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                })
                
            } else {
                
    
                
          //      if importListArray.count != 0 {
//                    importListMainView.isHidden = false
//                    importBackroundView.isHidden = false
                //    importTblvIEW.reloadData()
               //   genotypeCrossBtnOutlet.isHidden = false
                    let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddExistingAnimaliPad") as? AddExistingAnimaliPad
                    vc!.bckRetain = true
                    vc?.importDelegate = self
                    self.navigationController?.pushViewController(vc!, animated: false)

              //  }
            }
        } else {
            
            //    if importListArray.count != 0 {
//                importListMainView.isHidden = false
//                importBackroundView.isHidden = false
             //     genotypeCrossBtnOutlet.isHidden = false
                //    importTblvIEW.reloadData()
                    let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddExistingAnimaliPad") as? AddExistingAnimaliPad
                    vc!.bckRetain = true
                    vc?.importDelegate = self
                    self.navigationController?.pushViewController(vc!, animated: false)

           // }
        
        }
        
    }
    
    @IBOutlet weak var genotypeCrossBtnOutlet: UIButton!
    @IBAction func genotypeCrossBtnAction(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Removing list will remove its animals from the order as well. Do you want to continue?", comment: ""), preferredStyle: .alert)
            
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                        
        })
        
        alert.addAction(cancel)
        
             let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                
              
                
                let listArray = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid ?? 6),customerId:Int64(self.custmerId ?? 0))
                
                for i in 0 ..< listArray.count{
                    
                    let listObj = listArray[i] as! MergeDataEntryList
                    var listId = listObj.listId
                    let custId = listObj.customerId
                    
                    let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                    
                    if animalData.count > 0 {
                        
                        for i in 0 ..< animalData.count {
                               let ad = animalData[i] as! BeefAnimaladdTbl
                            deleteDataWithProductBeefDelete(Int(ad.animalId))
                            deleteDataWithSubProductAnimalId(Int(ad.animalId))
                           
                       }
                        deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listObj.listId), customerId:  Int(listObj.customerId),userId:self.userId)
                    }
                    
                }
                
                deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))


                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
               // self.genotypeImportFromBtnBtnOutlet.isEnabled = true
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
            //    self.genotypeCrossBtnOutlet.isHidden = true
                
                if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid ?? 6),customerId:Int64(self.custmerId ?? 0)).count == 0 {
                    
                    self.genotypeMergeListBtnOulet.isHidden = true
                    self.genoMergeView.isHidden = true
                    self.nonGenoMergeView.isHidden = true
                } else {
                    self.genotypeMergeListBtnOulet.isHidden = false
                    self.genoMergeView.isHidden = false
                }
             })
             alert.addAction(ok)
        
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
        
        
    }
    
    @IBOutlet weak var nongenotypeImportFromBtnBtnOutlet: UIButton!
    @IBAction func nongenotypeImportFromBtnAction(_ sender: Any) {
        
        view.endEditing(true)
        


        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        if isGenostarblackOnlyAdded == true
        {
            tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.genStarBlack.rawValue) as! [DataEntryList]
          if tempImportListArray.count>0 {
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
          }
        }
        else
        {
          tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.nonGenoType.rawValue) as! [DataEntryList]
          if tempImportListArray.count>0 {
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
          }
        }
       

        conflictArr.removeAll()
//        if importListArray.count == 0 {
//            
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No lists available for this customer.", comment: ""))
////            importListMainView.isHidden = true
////            importBackroundView.isHidden = true
//            return
//        }
        let data1 = fetchAllDataWithOrderID(entityName: Entities.beefAnimalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            
            var animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
        
            if animalStatusChck.count != 0 {
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Product selection will be cleared if you want to import list. Do you want to continue?", comment: ""), preferredStyle: .alert)
                let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    
//                    self.importListMainView.isHidden = true
//                    self.importBackroundView.isHidden = true
                    return
                })
                alert.addAction(cancel)
                
                     let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                        
                      //  updateProductTablDataaid(entity: Entities.getProductBeefTblEntity, status: "false")
                      //  updateProductTablDataaid(entity: Entities.getAdonTblEntity, status: "false")
                        for j in 0 ..< data1.count {
                            let animal = data1.object(at: j) as! BeefAnimaladdTbl
                            
                         //   updateAnimalTblDataDairystatus(entity: Entities.productAdonAnimlBeefTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                          //  updateAnimalTblDataDairystatus(entity: Entities.beefAnimalAddTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                        //    updateProductTablDataaid(entity: Entities.subProductBeefTblEntity, status: "false")

                     }
                     //   if self.importListArray.count != 0 {
//                            self.importListMainView.isHidden = false
//                            self.importBackroundView.isHidden = false
//                            self.importTblvIEW.reloadData()
//                          self.nongenotypeCrossBtnOutlet.isHidden = false
                            let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddExistingAnimaliPad") as? AddExistingAnimaliPad
                            vc!.bckRetain = true
                            vc?.importDelegate = self
                            self.navigationController?.pushViewController(vc!, animated: false)

                       // }
                     })
                     alert.addAction(ok)
                     
                     DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                })
                
            } else {
                
              //  if importListArray.count != 0 {
//                    importListMainView.isHidden = false
//                    importBackroundView.isHidden = false
//                    importTblvIEW.reloadData()
//                  nongenotypeCrossBtnOutlet.isHidden = false
                    let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddExistingAnimaliPad") as? AddExistingAnimaliPad
                    vc!.bckRetain = true
                    vc?.importDelegate = self
                    self.navigationController?.pushViewController(vc!, animated: false)
               // }
            }
        } else {
              //  if importListArray.count != 0 {
//                importListMainView.isHidden = false
//                importBackroundView.isHidden = false
//                importTblvIEW.reloadData()
//                  nongenotypeCrossBtnOutlet.isHidden = false
                    let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddExistingAnimaliPad") as? AddExistingAnimaliPad
                    vc!.bckRetain = true
                    vc?.importDelegate = self
                    self.navigationController?.pushViewController(vc!, animated: false)

           // }
        }
    }
    
    @IBOutlet weak var nongenotypeCrossBtnOutlet: UIButton!
    @IBAction func nongenotypeCrossBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Removing list will remove its animals from the order as well. Do you want to continue?", comment: ""), preferredStyle: .alert)
            
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                        
        })
        
        alert.addAction(cancel)
        
             let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                
                let listArray = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid ?? 6),customerId:Int64(self.custmerId ?? 0))
                
                for i in 0 ..< listArray.count{
                    
                    let listObj = listArray[i] as! MergeDataEntryList
                    var listId = listObj.listId
                    let custId = listObj.customerId
                    
                    
                    
                    let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                    
                    if animalData.count > 0 {
                        
                        for i in 0 ..< animalData.count {
                               let ad = animalData[i] as! BeefAnimaladdTbl
                            deleteDataWithProductBeefDelete(Int(ad.animalId))
                            deleteDataWithSubProductAnimalId(Int(ad.animalId))
                           
                       }
                        deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listObj.listId), customerId: Int(listObj.customerId),userId:self.userId)
                    }
                }
                deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))


                let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
            //    self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)

                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
          //      self.nongenotypeImportFromBtnBtnOutlet.isEnabled = true
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                self.nongenotypeCrossBtnOutlet.isHidden = true
                
                
                if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid ?? 6),customerId:Int64(self.custmerId ?? 0)).count == 0 {
                    self.nongenotypeMergeListBtnOulet.isHidden = true
                    self.nonGenoMergeView.isHidden = true
                    self.genoMergeView.isHidden = true
                } else {
                    self.nongenotypeMergeListBtnOulet.isHidden = false
                    self.nonGenoMergeView.isHidden = false
                }
             })
             alert.addAction(ok)
        
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
        
    }
    
    @IBAction func cancelBtnClickImportView(_ sender: Any) {
        
//        importListMainView.isHidden = true
//        importBackroundView.isHidden = true
    }
    
    //MARK: SIDE MENU UI METHODS
    func setSideMenu(){
        if UIDevice.current.orientation.isLandscape {
            self.sideMenuRevealWidth = 300
        }
        else {
            self.sideMenuRevealWidth = 260
            
        }
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
//        tapGestureRecognizer.numberOfTapsRequired = 1
//        tapGestureRecognizer.delegate = self
        
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
    @IBAction func menuBtnClk(_ sender: UIButton) {
//        self.view.makeCorner(withRadius: 40)
//        self.sideMenuViewController?.presentRightMenuViewController()
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()

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
    
    func sideMenuRevealSettingsViewController() -> BeefAnimalBrazilVCIpad? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is BeefAnimalBrazilVCIpad {
            return viewController! as? BeefAnimalBrazilVCIpad
        }
        while (!(viewController is BeefAnimalBrazilVCIpad) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is BeefAnimalBrazilVCIpad {
            return viewController as? BeefAnimalBrazilVCIpad
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
    
  // MARK: - NavigateToBeefOrderingScreen
    func changeViewColorToBlack(view : [UIView], color : CGColor) {
        for value in view {
            value.layer.borderColor = color
        }
        if changeColorToRed == true {
            if scanBarcodeTextfield.text == "" {
                barcodeView.layer.borderColor = UIColor.red.cgColor
            }
            
            if rGDTextfield.text == "" {
                nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
            }
            
            if genotypeSerieTextfield.text == "" {
                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
            }
            if genotypeRgnTextfield.text == "" {
                GenoRGNView.layer.borderColor = UIColor.red.cgColor
            }
            
            if genotypeScanBarcodeTextField.text == "" {
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
            }
           
            
        }
    }
    func NavigateToBeefOrderingScreen(screenType : Int = 1) {
    
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
     let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    
    let animalArray =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid)
    
   
    let dataListAnimals : [BeefAnimaladdTbl] = animalArray as! [BeefAnimaladdTbl]
    let animals = dataListAnimals.filter({ $0.animalTag == "" || $0.animalTag == nil })
   
     if animals.count > 0 {
       
       let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: "Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
      
       let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
   
           let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
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
     
         if screenType == 1{
             self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSiPadVC")), animated: true)
         }
         else {
             self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
         }
       
       
     }
  }
  
  // MARK: - ShowAlertforwithoutBarcodeAnimal
  func showAlertforwithoutBarcodeAnimal() {
   
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
     let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    
    let animalArray =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid)
    
    let dataListAnimals : [BeefAnimaladdTbl] = animalArray as! [BeefAnimaladdTbl]
    let animals = dataListAnimals.filter({ $0.animalTag == "" || $0.animalTag == nil })
      if animals.count > 0 {
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message:"Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
       
        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
          
         // self.viewAnimalClick(<#UIButton#>)
//          barcodeScreen = false
//          selectedDate = Date()
//          // InheritSelectedDate = Date()
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
  
  }
    
  @IBAction func okBtnClickImportView(_ sender: Any) {
    
    if listId == 0 {
      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please select list to import.", comment: "") )
      return
    }
    
    
    
    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue{
      
      let animalCountCheck = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId ?? 0,listId:Int64(self.listId ),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
      
      if animalCountCheck.count == 0 {
        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
//        importListMainView.isHidden = true
//        importBackroundView.isHidden = true
        return
      }
      
      let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
      if aData.count > 0 {
        for k in 0 ..< aData.count{
          let data1 = aData[k] as! BeefAnimaladdTbl
          let earTag = data1.animalTag
          
          let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ?? 0),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
          
          
          if dataEntryVALE.count > 0 {
            
            self.conflictArr.append(contentsOf: dataEntryVALE)
            
          }
        }
        if conflictArr.count > 0 {
          let count1 = conflictArr.count
          let alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
          
          let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
          let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
            
//            self.importBackroundView.isHidden = true
//            self.importListMainView.isHidden = true
            
          })
          alert.addAction(cancel)
          
          let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
            
            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            if fetchData11.count != 0 {
              
              for i in 0...fetchData11.count - 1 {
                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                
                
                
                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                if fetchCountGirlando.count == 0 {
                  
                  saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                  
                  createDataList()
                  
                  self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                  UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                  
                  let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                  let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                  let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                  
                  for k in 0 ..< animalData.count{
                    
                    let animalId = animalData[k] as! BeefAnimaladdTbl
                    
                    for i in 0 ..< product.count {
                      
                      let data = product[i] as! GetProductTblBeef
                      beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                      
                      let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                      if addonArr.count > 0 {
                        for j in 0 ..< addonArr.count {
                          
                          let addonDat = addonArr[j] as! GetAdonTbl
                          
                          saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                          
                          //  msgShow()
                        }
                      }
                      else {
                        // msgShow()
                      }
                    }
                  }
                  let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                  self.genotypeCrossBtnOutlet.isHidden = false
                  //    let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                  //      self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                  UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                  UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
            //      genotypeImportFromBtnBtnOutlet.isEnabled = true
//                  self.importBackroundView.isHidden = true
//                  self.importListMainView.isHidden = true
                  self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                  
                  
                  if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                    
                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                    let listObject = fetchList.object(at: 0) as? DataEntryList
                    let listDescr = listObject?.listDesc
                    
                    saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                    
                  }
                  
                  var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 0)
                  if fetchObj.count != 0 {
                    
                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                    let obj = objectFetch?.listName
                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                    
                    if fetchAllMergeDta == 0 {
                      let fetchNameDisplay = String(obj ?? "")
                      let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                      genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                      genotypeMergeListBtnOulet.isHidden = false
                        self.genoMergeView.isHidden = false
                    } else {
                      let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                      let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                      genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                      genotypeMergeListBtnOulet.isHidden = false
                        self.genoMergeView.isHidden = false
                    }
                  }
                  
                }
              }
            }
          })
          alert.addAction(ok)
//          importListMainView.isHidden = true
//          importBackroundView.isHidden = true
          
          DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
          })
          
        } else {
          
          let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
          if fetchData11.count != 0 {
            
            for i in 0...fetchData11.count - 1 {
              let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
              
              
              
              var fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
              if fetchCountGirlando.count == 0 {
                
                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                createDataList()
                
                self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                
                
                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                
                for k in 0 ..< animalData.count{
                  
                  let animalId = animalData[k] as! BeefAnimaladdTbl
                  
                  for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                    
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    if addonArr.count > 0 {
                      for j in 0 ..< addonArr.count {
                        
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        
                        // msgShow()
                      }
                    }
                    else {
                      //msgShow()
                    }
                  }
                }
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                self.genotypeCrossBtnOutlet.isHidden = false
                //  let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                //  self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
             //   genotypeImportFromBtnBtnOutlet.isEnabled = true
                self.importBackroundView.isHidden = true
                self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                
                //self.importListMainView.isHidden = true
                
                if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                  
                  let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                  let listObject = fetchList.object(at: 0) as? DataEntryList
                  let listDescr = listObject?.listDesc
                  
                  saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                  
                }
                
                var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6)
                if fetchObj.count != 0 {
                  
                  let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                  let obj = objectFetch?.listName
                  let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                  
                  if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    genotypeMergeListBtnOulet.isHidden = false
                      self.genoMergeView.isHidden = false
                  } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    genotypeMergeListBtnOulet.isHidden = false
                      self.genoMergeView.isHidden = false
                  }
                }
              
              }
              
            }
            
          }
        }
      } else {
        
        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        if fetchData11.count != 0 {
          
          for i in 0...fetchData11.count - 1 {
            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
            
            
            
            var fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
            if fetchCountGirlando.count == 0 {
              
              saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
              
              createDataList()
              
              self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
              UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
              
              
              
              let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
              let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
              let product = fetchAllData(entityName: Entities.getProductBeefTblEntity)
              
              for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                  
                  let data = product[i] as! GetProductTblBeef
                  beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                  
                  
                  let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                  if addonArr.count > 0 {
                    for j in 0 ..< addonArr.count {
                      
                      let addonDat = addonArr[j] as! GetAdonTbl
                      
                      saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                      
                      //  msgShow()
                    }
                  }
                  else {
                    // msgShow()
                  }
                  
                }
              }
              let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
              self.genotypeCrossBtnOutlet.isHidden = false
              // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
              //  self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
              UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
              UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
            //  genotypeImportFromBtnBtnOutlet.isEnabled = true
//              self.importBackroundView.isHidden = true
//              self.importListMainView.isHidden = true
              self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
             
              if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                
                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                let listObject = fetchList.object(at: 0) as? DataEntryList
                let listDescr = listObject?.listDesc
                
                saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                
              }
              
              var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 0)
              if fetchObj.count != 0 {
                
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                
                if fetchAllMergeDta == 0 {
                  let fetchNameDisplay = String(obj ?? "")
                  let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                  genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                  genotypeMergeListBtnOulet.isHidden = false
                    self.genoMergeView.isHidden = false
                } else {
                  let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                  let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                  genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                  genotypeMergeListBtnOulet.isHidden = false
                    self.genoMergeView.isHidden = false
                }
              }
              
            }
          }
        }
      }
    } else {
      // Nongenotype
      let animalCountCheck = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId ?? 0,listId:Int64(self.listId ?? 0),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
      
      if animalCountCheck.count == 0 {
        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
//        importListMainView.isHidden = true
//        importBackroundView.isHidden = true
        return
      }
      
      let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
      if aData.count > 0 {
        for k in 0 ..< aData.count{
          let data1 = aData[k] as! BeefAnimaladdTbl
          let earTag = data1.animalTag
          
          let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ?? 0),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
          
          
          if dataEntryVALE.count > 0 {
            
            self.conflictArr.append(contentsOf: dataEntryVALE)
            
          }
        }
        if conflictArr.count > 0 {
          var count1 = conflictArr.count
          var alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
          
          let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
          let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
            
//            self.importBackroundView.isHidden = true
//            self.importListMainView.isHidden = true
            
          })
          alert.addAction(cancel)
          
          let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
            
            
            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            if fetchData11.count != 0 {
              
              for i in 0...fetchData11.count - 1 {
                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                
                
                
                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                if fetchCountGirlando.count == 0 {
                  
                  saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                  
                  createDataList()
                  
                  self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                  UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                  
                  
                  
                  
                  let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                  let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                  let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                  
                  
                  for k in 0 ..< animalData.count{
                    
                    let animalId = animalData[k] as! BeefAnimaladdTbl
                    
                    for i in 0 ..< product.count {
                      
                      let data = product[i] as! GetProductTblBeef
                      
                      beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                      
                      let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                      if addonArr.count > 0 {
                        
                        for j in 0 ..< addonArr.count {
                          
                          let addonDat = addonArr[j] as! GetAdonTbl
                          
                          saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                          
                          //    msgShow()
                        }
                      }
                      else {
                        // msgShow()
                      }
                    }
                  }
                  let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                  self.nongenotypeCrossBtnOutlet.isHidden = false
                  //  let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                  // self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                  UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                  UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
               //   nongenotypeImportFromBtnBtnOutlet.isEnabled = true
//                  self.importBackroundView.isHidden = true
//                  self.importListMainView.isHidden = true
                  self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                  if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                    
                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                    let listObject = fetchList.object(at: 0) as? DataEntryList
                    let listDescr = listObject?.listDesc
                    
                    saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                    
                  }
                  
                  var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6 )
                  if fetchObj.count != 0 {
                    
                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                    let obj = objectFetch?.listName
                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                    
                    if fetchAllMergeDta == 0 {
                      let fetchNameDisplay = String(obj ?? "")
                      let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                      nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                      nongenotypeMergeListBtnOulet.isHidden = false
                        self.nonGenoMergeView.isHidden = false
                    } else {
                      let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                      let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                      nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                      nongenotypeMergeListBtnOulet.isHidden = false
                        self.nonGenoMergeView.isHidden = false
                    }
                  }
                }
              }
            }
          })
          alert.addAction(ok)
//          importListMainView.isHidden = true
//          importBackroundView.isHidden = true
          
          DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
          })
          
        } else {
          
          
          let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
          if fetchData11.count != 0 {
            
            for i in 0...fetchData11.count - 1 {
              let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
              
              
              
              let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
              if fetchCountGirlando.count == 0 {
                
                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                
                createDataList()
                
                self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                
                
                
                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                let product = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                
                for k in 0 ..< animalData.count{
                  
                  let animalId = animalData[k] as! BeefAnimaladdTbl
                  
                  for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    
                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    if addonArr.count > 0 {
                      
                      for j in 0 ..< addonArr.count {
                        
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        
                        //   msgShow()
                        
                      }
                    }
                    else {
                      //msgShow()
                    }
                  }
                }
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                self.nongenotypeCrossBtnOutlet.isHidden = false
                // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                //  self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
             //   nongenotypeImportFromBtnBtnOutlet.isEnabled = true
//                self.importBackroundView.isHidden = true
//                self.importListMainView.isHidden = true
                self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                  
                  let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                  let listObject = fetchList.object(at: 0) as? DataEntryList
                  let listDescr = listObject?.listDesc
                  
                  saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                  
                }
                
                var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6 )
                if fetchObj.count != 0 {
                  
                  let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                  let obj = objectFetch?.listName
                  let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                  
                  if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    nongenotypeMergeListBtnOulet.isHidden = false
                      self.nonGenoMergeView.isHidden = false
                  } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    nongenotypeMergeListBtnOulet.isHidden = false
                      self.nonGenoMergeView.isHidden = false
                  }
                }
              }
            }
          }
        }
        
      }
      else {
        
        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        if fetchData11.count != 0 {
          
          for i in 0...fetchData11.count - 1 {
            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
            
            
            
            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
            if fetchCountGirlando.count == 0 {
              
              saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
              
              createDataList()
              
              
              self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
              UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
              
              
              let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
              let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
              let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
              
              
              for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                  
                  let data = product[i] as! GetProductTblBeef
                  
                  beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                  
                  let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                  if addonArr.count > 0 {
                    
                    for j in 0 ..< addonArr.count {
                      
                      let addonDat = addonArr[j] as! GetAdonTbl
                      
                      saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                      
                      // msgShow()
                      
                    }
                  }
                  else {
                    // msgShow()
                  }
                }
              }
              let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
              self.nongenotypeCrossBtnOutlet.isHidden = false
              // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
              // self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
              UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
              UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
         //     nongenotypeImportFromBtnBtnOutlet.isEnabled = true
//              self.importBackroundView.isHidden = true
//              self.importListMainView.isHidden = true
              self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
             
              if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                
                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                let listObject = fetchList.object(at: 0) as? DataEntryList
                let listDescr = listObject?.listDesc
                
                saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                
              }
              
              let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6 )
              if fetchObj.count != 0 {
                
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                
                if fetchAllMergeDta == 0 {
                  let fetchNameDisplay = String(obj ?? "")
                  let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                  nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                  nongenotypeMergeListBtnOulet.isHidden = false
                    self.nonGenoMergeView.isHidden = false
                } else {
                  let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                  let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                  nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                  nongenotypeMergeListBtnOulet.isHidden = false
                    self.nonGenoMergeView.isHidden = false
                }
              }
            }
          }
        }
      }
    }
    self.showAlertforwithoutBarcodeAnimal()
  }
    
    @IBOutlet weak var selectTitleLbl: UILabel!
    @IBOutlet weak var importBackroundView: UIView!
    @IBOutlet weak var importListMainView: UIView!
    @IBOutlet weak var importTblvIEW: UITableView!
    
    
    
    
    //  MARK: - OtherView
    var checkBarcode = Bool()
    
    
    var validateDateFlag = true
    
    var validateRGD = false
    var genovalidateRGD = false
    @IBOutlet weak var genotypeDateTextField: UITextField!

    @IBOutlet weak var dateTextField: UITextField!

    
    
    @IBOutlet weak var dateOfLbl: UILabel!
    
    @IBOutlet weak var genotypeBarcodeBttn: UIButton!
    @IBOutlet weak var barcodeBttn: UIButton!
    @IBOutlet weak var genotypeView: UIView!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    var barAutoPopu = false
    
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var innerView: UIView!
    var lblTimeStamp = String()
    @IBOutlet weak var genotypeScrollView: UIScrollView!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    @IBOutlet weak var serieTextfield: UITextField!
    @IBOutlet weak var rGNTextfield: UITextField!
    @IBOutlet weak var rGDTextfield: UITextField!
    @IBOutlet weak var tissueHideLbl: UILabel!
    @IBOutlet weak var tissueBttn: UIButton!
    @IBOutlet weak var maleFemaleBttn: UIButton!
    @IBOutlet weak var dateBttnOutlet: UIButton!
    @IBOutlet weak var animalTextfield: UITextField!
    var requiredflag = 0
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderbkg: UIView!
    
    var  barcodeflag = Bool()
    @IBOutlet weak var dobView: UIView!
    
    //GENOTYPE
    @IBOutlet weak var nonGenoMergeView: UIView!
    @IBOutlet weak var genoMergeView: UIView!
    @IBOutlet weak var genotypeScanBarcodeView: UIView!
    @IBOutlet weak var genotypeScanBarcodeTextField: UITextField!
    @IBOutlet weak var genotypeSerieTextfield: UITextField!
    
    @IBOutlet weak var genotypeRgnTextfield: UITextField!
    
    @IBOutlet weak var genotypeTissueBttn: UIButton!
    
    @IBOutlet weak var genotypeDOBBttn: UIButton!
    
    @IBOutlet weak var genotypeAnimalNameTextfield: UITextField!
    
    @IBOutlet weak var genotypeMaleFemaleBttn: UIButton!
    
    
    @IBOutlet weak var selectBreedBtn: UIButton!
    @IBOutlet weak var genstarblackBreedBtn: UIButton!
    @IBOutlet weak var genotypeTissueHideLbl: UILabel!
    
    @IBOutlet weak var breedlablehide: UILabel!
    @IBOutlet weak var breedblackstarlablehide: UILabel!
    @IBOutlet weak var genotypeRgdTextfield: UITextField!
    @IBOutlet weak var calenderViewOutlet: UIView!
    @IBOutlet weak var priorityBreeingBtnOutlet: UIButton!
    @IBOutlet weak var secondaryBreddingOutlet: UIButton!
    @IBOutlet weak var territoryBreddingOutlet: UIButton!
    @IBOutlet weak var secondaryHidenLbl: UILabel!
    @IBOutlet weak var priorityBreddingLbl: UILabel!
    @IBOutlet weak var territoryHidenLbl: UILabel!
    var genderString = String()
    
    var othersGenderString = String()
    
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 19), .foregroundColor: UIColor.init(red: 246/225, green: 96/225, blue: 6/225, alpha: 1.0)]
    
    var selectedDate = Date()
    var btnTag = Int()
    var barcodeEnable = Bool()
    var priorityBreeding = NSArray()
    
    var secondaryBreeding = NSArray()
    var tertiaryBreeding = NSArray()
    
    var tissueArr = NSArray()
    
    let buttonbg2 = UIButton ()
    
    var droperTableView  = UITableView ()
    var datePicker : UIDatePicker!
    var genderToggleFlag : Int = 0
    var timeStampString = String()
    var othersGenderToggleFlag : Int = 0
    var addContiuneBtn = Int()
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
    var isGenotypeOnlyAdded = false
    var isGenostarblackOnlyAdded = false
    var GenotypeOnlyAddedbreed = false
    var GenoblackstarOnlyAddedbreed = false
    var animalIdBool = Bool()
    // var droperTableView  = UITableView ()
    var breedArr = NSArray()
    var breedArrblack = NSArray()
    var commomNamebreed = NSArray()
    var commomNamethreecode = NSArray()
    var commomNamebreedID = NSArray()
    var tempbreedblackname = [String]()
    var tempbreedblackname1 = [String]()
    var tempbreedblackname2 = [String]()
    var tempbreedarraynames = [String]()
    var tempbreedarraynames1 = [String]()
    var tempbreedarraynames2 = [String]()
    var breedRegArr = NSArray()
    var breedId = String()
    var tissuId = Int()
    var animalId1 = Int()
    let toolBar = UIToolbar()
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
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var breeddroupdown: UIImageView!
    @IBOutlet weak var breedblackstardroupdown: UIImageView!
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    
    @IBOutlet weak var incrementalBarcodeCheckBoxGenoType: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabelGenoType: UILabel!
    @IBOutlet weak var incrementalBarcodeButtonGenoType: UIButton!
    
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
  let orderingDataListViewModel = OrderingDataListViewModel()
  
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
        
        guard isautoPopulated == false else {
            return
        }
        
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
    
    @IBAction func incrementalBarcodeButtonActionGenotype(_ sender: UIButton) {
        
        guard isautoPopulated == false else {
            return
        }
        
        guard genotypeScanBarcodeTextField.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter barcode before selecting 'Incremental barcode'.", comment: "") )
            return
        }
        
        guard isBarCodeEndsWithNumber_GetIncrementedBarCode(genotypeScanBarcodeTextField.text ?? "").isBarCodeEndsWithNumber else {
            if checkBarcode == false{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
                
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            sender.isSelected = false
            incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
        
    }
    // UserDefaults.standard.set(nil, forKey: "barcodeIncremental")
    
    func defaultIncrementalBarCodeSetting() {
        // UserDefaults.standard.set(nil, forKey: "barcodeIncremental")
        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
        incrementalBarcodeTitleLabel.text = NSLocalizedString("Incremental Barcode", comment: "")
    }
    func defaultIncrementalBarCodeSetting_GenoType() {
        //    UserDefaults.standard.set(nil, forKey: "barcodeIncremental")
        incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
        incrementalBarcodeTitleLabelGenoType.text = NSLocalizedString("Incremental Barcode", comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.defaultIncrementalBarCodeSetting()
        self.defaultIncrementalBarCodeSetting_GenoType()
        removeObserver()
    }
    var pvid :Int = UserDefaults.standard.integer(forKey: "BeefPvid")
    var heartBeatViewModel:HeartBeatViewModel?

    func navigateToAnotherVc(){
       //  hideIndicator()
       //  self.view.isUserInteractionEnabled = true
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
             keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+140
             
             if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                 scrolView.isScrollEnabled = true
                 genotypeScrollView.isScrollEnabled = true
             }
            else {
                 scrolView.isScrollEnabled = false
                genotypeScrollView.isScrollEnabled = false
             }
            
         }
     }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        genotypeScrollView.isScrollEnabled = true
        scrolView.isScrollEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanBarcodeTextfield.layer.cornerRadius = 15
        scanBarcodeTextfield.clipsToBounds = true
        genotypeScanBarcodeTextField.layer.cornerRadius = 15
        genotypeScanBarcodeTextField.clipsToBounds = true
        serieTextfield.layer.cornerRadius = 15
        serieTextfield.clipsToBounds = true
        rGNTextfield.layer.cornerRadius = 15
        rGNTextfield.clipsToBounds = true
        rGDTextfield.layer.cornerRadius = 15
        rGDTextfield.clipsToBounds = true
        animalTextfield.layer.cornerRadius = 15
        animalTextfield.clipsToBounds = true
        tissueBttn.layer.cornerRadius = 15
        tissueBttn.clipsToBounds = true
        maleFemaleBttn.layer.cornerRadius = 15
        maleFemaleBttn.clipsToBounds = true
        Breedgenstarblack.layer.cornerRadius = 15
        Breedgenstarblack.clipsToBounds = true
        genstarblackBreedBtn.layer.cornerRadius = 15
        genstarblackBreedBtn.clipsToBounds = true
        genotypeSerieTextfield.layer.cornerRadius = 15
        genotypeSerieTextfield.clipsToBounds = true
        genotypeRgnTextfield.layer.cornerRadius = 15
        genotypeRgnTextfield.clipsToBounds = true
        genotypeRgdTextfield.layer.cornerRadius = 15
        genotypeRgdTextfield.clipsToBounds = true
        genotypeAnimalNameTextfield.layer.cornerRadius = 15
        genotypeAnimalNameTextfield.clipsToBounds = true
        genotypeTissueBttn.layer.cornerRadius = 15
        genotypeTissueBttn.clipsToBounds = true
        genotypeMaleFemaleBttn.layer.cornerRadius = 15
        genotypeMaleFemaleBttn.clipsToBounds = true
        selectBreedBtn.layer.cornerRadius = 15
        selectBreedBtn.clipsToBounds = true
        priorityBreeingBtnOutlet.layer.cornerRadius = 15
        priorityBreeingBtnOutlet.clipsToBounds = true
        secondaryBreddingOutlet.layer.cornerRadius = 15
        secondaryBreddingOutlet.clipsToBounds = true
        territoryBreddingOutlet.layer.cornerRadius = 15
        territoryBreddingOutlet.clipsToBounds = true
        self.setSideMenu()
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        UserDefaults.standard.setValue(nil, forKey: "submitTypeSelection")
       // importBackroundView.isHidden = true
      //  importListMainView.isHidden = true
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        dateTextField.setLeftPaddingPoints(20.0)
        genotypeDateTextField.setLeftPaddingPoints(20.0)
        dateTextField.keyboardType = .phonePad
        genotypeDateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        genotypeDateTextField.borderStyle = .none
        genotypeDateTextField.delegate = self

        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set("BR", forKey: keyValue.capsBrazil.rawValue)
        self.GenotypetextfieldLeftPadding()
        self.byDefaultSetting()
        self.GenotypebyDefaultScreen()
        
        self.defaultIncrementalBarCodeSetting()
        self.defaultIncrementalBarCodeSetting_GenoType()
        self.pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
       
    }
    var value = 0
    @objc func methodOfReceivedNotification(notification: Notification)
       {
          
           if  value == 0
           {
               UserDefaults.standard.set("false", forKey: "FirstLogin")
               let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
               self.navigationController?.pushViewController(newViewController, animated: true)
               self.hideIndicator()
               value = value + 1
           }
          
       }
    override func viewWillAppear(_ animated: Bool) {
       
                NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
                

        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
     //   clearFormOutlet.setAttributedTitle(attributeString, for: .normal)
     //   nonGenotypeclearFormOutlet.setAttributedTitle(attributeString, for: .normal)
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        landIdApplangaugeConversion()
        
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
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
                
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            self.cartView.isHidden = true
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId ?? 0))

           // nongenotypeMergeListBtnOulet.isHidden = true
            self.nonGenoMergeView.isHidden = true
            self.genoMergeView.isHidden = true
          //  genotypeMergeListBtnOulet.isHidden = true

        }
        self.navigationController?.navigationBar.isHidden = true
        
        let selectedProduct = fetchAllData(entityName: Entities.getProductBeefTblEntity)
       
        let name = "GeneSTAR\u{00ae} Black"
        for product in selectedProduct as? [GetProductTblBeef] ?? [] {
            if product.productName?.uppercased() == keyValue.genoTypeOnly.rawValue.uppercased() {
                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                isGenotypeOnlyAdded = true
            }
            else if product.productName == name
            {
                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                self.isGenostarblackOnlyAdded = true
            }
            else
            {
                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                
            }
        }
        
        if (selectedProduct.count == 1 && isGenotypeOnlyAdded) || (selectedProduct.count == 3 && isGenotypeOnlyAdded) || (selectedProduct.count == 2 && isGenotypeOnlyAdded)
        {
            GenotypeOnlyAddedbreed = true
            GenoblackstarOnlyAddedbreed = false
            genotypeScrollView.isHidden = false
            self.genotypeImportFromBtnBtnOutlet.isHidden = false
            self.nongenotypeImportFromBtnBtnOutlet.isHidden = true
            scrolView.isHidden = true
           // genotypeView.isHidden = false
            selectBreedBtn.isHidden = false
         //   breeddroupdown.isHidden = false
            
        }
        else if (selectedProduct.count == 1 && isGenostarblackOnlyAdded) || (selectedProduct.count == 3 && isGenostarblackOnlyAdded) || (selectedProduct.count == 2 && isGenostarblackOnlyAdded)
        {
            GenotypeOnlyAddedbreed = false
            GenoblackstarOnlyAddedbreed = true
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            self.nongenotypeImportFromBtnBtnOutlet.isHidden = false
            self.genotypeImportFromBtnBtnOutlet.isHidden = true
           // genotypeView.isHidden = true
            genstarblackBreedBtn.isHidden = false
            nonGenoBreedTypeView.isHidden = false
            breedTypeHeaderView.isHidden = false
         //   breedblackstardroupdown.isHidden = false
            
        }
        else if selectedProduct.count == 2 && (isGenostarblackOnlyAdded == true && isGenotypeOnlyAdded == true)
        {
            GenotypeOnlyAddedbreed = true
            GenoblackstarOnlyAddedbreed = true
            genotypeScrollView.isHidden = false
            self.genotypeImportFromBtnBtnOutlet.isHidden = false
            self.nongenotypeImportFromBtnBtnOutlet.isHidden = true
            scrolView.isHidden = true
           // genotypeView.isHidden = false
            selectBreedBtn.isHidden = false
        //    breeddroupdown.isHidden = false
            
           // UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
        }
        else if selectedProduct.count == 4
        {
            GenotypeOnlyAddedbreed = true
            GenoblackstarOnlyAddedbreed = true
            genotypeScrollView.isHidden = false
            self.nongenotypeImportFromBtnBtnOutlet.isHidden = true
            self.genotypeImportFromBtnBtnOutlet.isHidden = false
            scrolView.isHidden = true
           // genotypeView.isHidden = false
            selectBreedBtn.isHidden = false
      //      breeddroupdown.isHidden = false
        }
        else
        {
            GenotypeOnlyAddedbreed = false
            GenoblackstarOnlyAddedbreed = false
            genstarblackBreedBtn.isHidden = true
            nonGenoBreedTypeView.isHidden = true
            breedTypeHeaderView.isHidden = true
         //   breedblackstardroupdown.isHidden = true
            genotypeScrollView.isHidden = true
            self.nongenotypeImportFromBtnBtnOutlet.isHidden = false
            self.genotypeImportFromBtnBtnOutlet.isHidden = true
            scrolView.isHidden = false
            //genotypeView.isHidden = true
        }
        
        if isGenotypeOnlyAdded {
            
//            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
//                
//                genotypeDateTextField.isHidden = false
//            } else {
//                genotypeDateTextField.isHidden = true
//            }
//            
         
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            self.nongenotypeImportFromBtnBtnOutlet.isHidden = true
            self.genotypeImportFromBtnBtnOutlet.isHidden = false
          //  genotypeView.isHidden = false
            if isGenostarblackOnlyAdded == true && isGenotypeOnlyAdded == true
            {
                UserDefaults.standard.set(keyValue.genoTypeStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            else{
            UserDefaults.standard.set(keyValue.genoTypeOnly.rawValue, forKey: keyValue.beefProduct.rawValue)
            }

            let dataFetc = fetchDataEnteryWithListId(entityName: Entities.beefAnimalAddTblEntity,customerId:self.custmerId ?? 0 ,listId:0,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue))
            
            if dataFetc.count == 0 {
                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
            //    self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            //    genotypeImportFromBtnBtnOutlet.isEnabled = true
           //     genotypeCrossBtnOutlet.isHidden = true
            } else {
                

                let get = dataFetc.object(at: 0) as? BeefAnimaladdTbl
                let getListid = get?.listId ?? 0
                UserDefaults.standard.set(Int64(getListid), forKey: "dataEnteryListId")

                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,listId:getListid,providerId:UserDefaults.standard.integer(forKey: "BeefPvid") )
                
                if fetchName.count != 0{
                    
                    let getName = fetchName.object(at: 0) as? DataEntryList
                    let getListName = getName?.listName ?? ""
                    
                  //  genotypeCrossBtnOutlet.isHidden = false

                  //  self.genotypeImportFromBtnBtnOutlet.isEnabled = true
                  //  let attributeString = NSMutableAttributedString(string: getListName, attributes: self.attrs)
                   // self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
                   // self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)

                }
            }
            
            
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count == 0 {
            //    genotypeMergeListBtnOulet.isHidden = true
                self.genoMergeView.isHidden = true
                self.nonGenoMergeView.isHidden = true
            } else {
             //   genotypeMergeListBtnOulet.isHidden = false
                self.genoMergeView.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6)
            
            if fetchObj.count != 0 {
            
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
            
            if fetchAllMergeDta == 0 {
                let fetchNameDisplay = String(obj ?? "")
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            } else {
                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            }
            }
        } else {
            
//            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
//                
//                dateTextField.isHidden = false
//            } else {
//                dateTextField.isHidden = true
//            }
            if isGenostarblackOnlyAdded == true
            {
                UserDefaults.standard.set(keyValue.genStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            else
            {
                UserDefaults.standard.set(keyValue.nonGenoType.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            //UserDefaults.standard.set(keyValue.nonGenoType.rawValue, forKey: keyValue.beefProduct.rawValue)
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            self.nongenotypeImportFromBtnBtnOutlet.isHidden = false
            self.genotypeImportFromBtnBtnOutlet.isHidden = true
           // genotypeView.isHidden = true
           
            

            let dataFetc = fetchDataEnteryWithListId(entityName: Entities.beefAnimalAddTblEntity,customerId:self.custmerId ?? 0 ,listId:0,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue))
            
            if dataFetc.count == 0 {
                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
              //  self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            //    nongenotypeImportFromBtnBtnOutlet.isEnabled = true
             //   nongenotypeCrossBtnOutlet.isHidden = true
            } else {
                

                let get = dataFetc.object(at: 0) as? BeefAnimaladdTbl
                let getListid = get?.listId ?? 0
                
                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,listId:getListid,providerId:UserDefaults.standard.integer(forKey: "BeefPvid") )
                UserDefaults.standard.set(Int64(getListid), forKey: "dataEnteryListId")

                if fetchName.count != 0{
                    
                    let getName = fetchName.object(at: 0) as? DataEntryList
                    var getListName = getName?.listName ?? ""
                    
                //    nongenotypeCrossBtnOutlet.isHidden = false

               //     self.nongenotypeImportFromBtnBtnOutlet.isEnabled = true
                    let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
              //      self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)

               //     let attributeString = NSMutableAttributedString(string: getListName, attributes: self.attrs)
                //    self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                }
            }
            
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count == 0 {
             //   nongenotypeMergeListBtnOulet.isHidden = true
                self.nonGenoMergeView.isHidden = true
                self.genoMergeView.isHidden = true
            } else {
             //   nongenotypeMergeListBtnOulet.isHidden = false
                self.nonGenoMergeView.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6)
            
            if fetchObj.count != 0 {
            
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
            
            if fetchAllMergeDta == 0 {
                let fetchNameDisplay = String(obj ?? "")
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            } else {
                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

            }
            }
        }
   //     otherBorderColor()
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)

     //   genotypeSetBorder()
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        timeStampString = timeStamp()
        UserDefaults.standard.set(timeStampString, forKey: "timeStamp")
        timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as? String ?? ""
        if UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear") == false {
            self.isBarcodeAutoIncrementedEnabled = false
            byDefaultSetting()
            GenotypebyDefaultScreen()
        }
       
        if UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart") > 0 {
            let temp = UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart")
            animalIdBool = true
            othersByDefaultBackroundWhite()
            UserDefaults.standard.set(0, forKey: "BeefAnimalIdSelectionCart")
            dataPopulateInScreen(animalId: temp)
            isautoPopulated = true
            barAutoPopu = true
            messageCheck = true
            
        }
        
        if isGenotypeOnlyAdded {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        } else {
            self.scanBarcodeTextfield.becomeFirstResponder()
            self.scanBarcodeTextfield.backgroundColor = .white
        }
      let animalCount1 =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
      if animalCount1.count == 0{
        checkUserDataListName()
      }
  //    self.updateCartCount()
        
       
            
       // selectBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
    }
  func updateCartCount(){
    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
      
    //  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
    
    
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
//    genotypeCrossBtnOutlet.isHidden = true
//    nongenotypeCrossBtnOutlet.isHidden = true
    
  }
    override func viewDidAppear(_ animated: Bool) {
        if isGenotypeOnlyAdded {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        } else {
            self.scanBarcodeTextfield.becomeFirstResponder()
            self.scanBarcodeTextfield.backgroundColor = .white
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
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var samplename = String()
        var animalFetch = NSArray()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        if !isGenotypeOnlyAdded {
            if animalIdBool == true {
                
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
                var data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
                animalId1 = Int(data.animalId)
                /////////end
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                animalTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                //
                dateBttnOutlet.titleLabel?.text = ""
                
                
               UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
               UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
               self.isBarcodeAutoIncrementedEnabled = false
               incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
               incrementalBarcodeButton.isEnabled = false
               incrementalBarcodeTitleLabel.textColor = .gray
               self.isBarcodeAutoIncrementedEnabled = false
               checkBarcode = false
                incrementalBarcodeTitleLabelGenoType.textColor = .gray
                
                
                
                
                
                
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                if data.date != ""{
                    dobLbl.text = ""
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
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
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
//
                        } else {
                            //dateBttnOutlet.setTitle(dateVale, for: .normal)

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
                            self.selectedDate = Date()
                        }
                        let dates =  formatter.string(from: selectedDate)
                    }
                }
                scanBarcodeTextfield.text = data.animalTag
                rGNTextfield.text = data.offPermanentId
                serieTextfield.text = data.offsireId
                rGDTextfield.text = data.offDamId
                
                tissueBttn.setTitleColor(.black, for: .normal)
                animalTextfield.text = data.animalbarCodeTag
              tissueBttn.setTitle(data.tissuName?.localized, for: .normal)
              UserDefaults.standard.set(data.tissuName?.localized, forKey: "tissueBttn")
                
                breedId = data.breedId!
                if isGenostarblackOnlyAdded
                {
                    genstarblackBreedBtn.setTitle(data.breedName, for: .normal)
                }
               
               
                samplename = data.tissuName!
                let pvidAA = data.providerId
                
                
              if data.gender == NSLocalizedString("Male", comment: "") || data.gender == "M" || data.gender == "Male".localized {
                  //  self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                  self.maleFemaleBttn.setTitle("Male", for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                  UserDefaults.standard.set("M", forKey: "NonGenoGender")
                } else {
                  //  self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    self.maleFemaleBttn.setTitle("Female", for: .normal)
                    genderToggleFlag = 0
                    genderString = NSLocalizedString("Female", comment: "")
                    UserDefaults.standard.set("F", forKey: "NonGenoGender")
                }
                
                
                
                tissuId = Int(data.tissuId)
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                let fetch = fetchAllData(entityName: "BeefAnimalMaster")
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
                
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                }
            } else {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
                if animalFetch.count > 0 {
                    var  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
                    animalId1 = Int(data.animalId)
                    /////////end
                    
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                    
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    animalTextfield.layer.borderColor = UIColor.gray.cgColor
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    //
                    dateBttnOutlet.titleLabel?.text = ""
                    let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                    var formatter = DateFormatter()
                    if data.date != ""{
                        dobLbl.text = ""
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1 {
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                            }
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                            formatter.dateFormat = "dd/MM/yyyy"
                        }
                        if dateBttnOutlet.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                            
                            
                        }
                        else{
                            self.selectedDate = Date()
                        }
                        let dates =  formatter.string(from: selectedDate)
                    }
                    scanBarcodeTextfield.text = data.animalTag
                    rGNTextfield.text = data.offPermanentId
                    serieTextfield.text = data.offsireId
                    rGDTextfield.text = data.offDamId
                    
                    
                    tissueBttn.setTitleColor(.black, for: .normal)
                    animalTextfield.text = data.animalbarCodeTag
                  tissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                  UserDefaults.standard.set(data.tissuName?.localized, forKey: "tissueBttn")
                    
                    breedId = data.breedId!
                    if isGenostarblackOnlyAdded
                    {
                        genstarblackBreedBtn.setTitle(data.breedName, for: .normal)
                    }
                    samplename = data.tissuName!
                    let pvidAA = data.providerId
                    //UserDefaults.standard.set(breedId, forKey: "Beefbreed")
                    
                  if data.gender == "Male".localized || data.gender == "M"{
                       // self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                      self.maleFemaleBttn.setTitle("Male", for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString("Male", comment: "")
                      UserDefaults.standard.set("M", forKey: "NonGenoGender")
                        
                    } else {
                        genderToggleFlag = 0
                      genderString = "Female".localized
                    //    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        self.maleFemaleBttn.setTitle("Female", for: .normal)
                        UserDefaults.standard.set("F", forKey: "NonGenoGender")
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
        else{
            GenotypebyDefaultbackroundWhite()
            if animalIdBool == true {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
                var data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
                animalId1 = Int(data.animalId)
                /////////end
                genotypeDOBBttn.titleLabel?.text = ""
                
                genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                //
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                if data.date != "" {
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {

                            genotypeDateTextField.text = dateVale
                        } else {
                            
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)

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

                            genotypeDateTextField.text = dateVale
                        } else {
                            
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)

                        }
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {

                    } else {
                        if genotypeDOBBttn.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel!.text!)!
                        }
                        else{
                            self.selectedDate = Date()
                        }
                        let dates = formatter.string(from: selectedDate)
                    }
                }
                genotypeScanBarcodeTextField.text = data.animalTag
                genotypeRgnTextfield.text = data.offPermanentId
                genotypeSerieTextfield.text = data.offsireId
                genotypeRgdTextfield.text = data.offDamId
                genotypeAnimalNameTextfield.text = data.animalbarCodeTag
                //                animalNameTextfield.text  = data.anima
                if data.sireIDAU == "" {
                  if let primary = UserDefaults.standard.object(forKey: keyValue.primaryGenoType.rawValue)
                  {
                    priorityBreeingBtnOutlet.setTitle(primary as! String ,for: .normal)
                  } else{
                    priorityBreeingBtnOutlet.setTitle(NSLocalizedString("Select Primary Breed Genotype", comment: "") ,for: .normal)
                  }
                } else {
                    priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
                }
                genotypeTissueBttn.setTitleColor(.black, for: .normal)
                priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
              genotypeTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                territoryBreddingOutlet.setTitleColor(.black, for: .normal)
                if data.nationHerdAU == ""{
                  if let secondary = UserDefaults.standard.object(forKey: keyValue.secondaryGenoType.rawValue)
                  {
                    secondaryBreddingOutlet.setTitle(secondary as! String ,for: .normal)
                  } else{
                    secondaryBreddingOutlet.setTitle(NSLocalizedString("Select Secondary Breed Genotype", comment: ""), for: .normal)
                  }
                    
                } else {
                    secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                }
              if data.tertiaryGeno == "" {
                
                if let  territory = UserDefaults.standard.object(forKey: keyValue.tertirayGenoType.rawValue)
                {
                  territoryBreddingOutlet.setTitle(territory as! String ,for: .normal)
                } else{
                  territoryBreddingOutlet.setTitle(NSLocalizedString("Select Tertiary Breed Genotype", comment: "") ,for: .normal)
                }
                
              } else {
                territoryBreddingOutlet.setTitle(data.tertiaryGeno ,for: .normal)
              }
              
                UserDefaults.standard.set(data.tissuName, forKey: "genotypeTissueBttn")
              
              if data.breedName == "" {
                  if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
                   {
                    if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
                                    breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                                    selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
                    } else {
                    breedId = tempbreedarraynames2[0]
                    selectBreedBtn.setTitle(tempbreedarraynames2[0], for: .normal)
                    }
                
                    }
                     else
                     {
                       if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
                                       breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                                       selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
                       } else {
                       breedId = breedArr[0] as! String
                       selectBreedBtn.setTitle(breedArr[0] as! String, for: .normal)
                       }
                  
                     }
                  }
                  else
                  {
                    breedId = data.breedId!
                  selectBreedBtn.setTitle(data.breedName, for: .normal)
                  }
              
              
//              if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
//                breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
//                selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
//
//              } else {
//                breedId = data.breedId!
//                selectBreedBtn.setTitle(data.breedName, for: .normal)
//              }
                samplename = data.tissuName!
                let pvidAA = data.providerId
                // UserDefaults.standard.set(breedId, forKey: "InheritBeefbreed")
              //  UserDefaults.standard.set(data.sireIDAU, forKey: "priorityBreedName")
                if data.gender == "Male".localized || data.gender == "M"{
                    //   self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    UserDefaults.standard.set("M", forKey: "GenoGender")
                 //   UserDefaults.standard.set("M", forKey: "NonGenoGender")
                    
                }
                else {
                    genderToggleFlag = 0
                    genderString = "Female".localized
                    //    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    self.maleFemaleBttn.setTitle("Female", for: .normal)
                    UserDefaults.standard.set("F", forKey: "NonGenoGender")
                }
                  incrementalBarcodeTitleLabelGenoType.textColor = .gray
                
                
                tissuId = Int(data.tissuId)
                genotypeDOBBttn.setTitleColor(.black, for: .normal)
                
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
                    genotypeDOBBttn.titleLabel?.text = ""
                    genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    //
                    let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                    var formatter = DateFormatter()
                    if data.date != "" {
                        
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1 {
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                            }
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
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
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
                            formatter.dateFormat = "dd/MM/yyyy"
                        }
                        if genotypeDOBBttn.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel!.text!)!
                            
                        }
                        else{
                            self.selectedDate = Date()
                        }
                        let dates =  formatter.string(from: selectedDate)
                    }
                    genotypeScanBarcodeTextField.text = data.animalTag
                    genotypeRgnTextfield.text = data.offPermanentId
                    genotypeSerieTextfield.text = data.offsireId
                    genotypeRgdTextfield.text = data.offDamId
                    genotypeAnimalNameTextfield.text = data.animalbarCodeTag
                    //                animalNameTextfield.text  = data.anima
                    priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
                    genotypeTissueBttn.setTitleColor(.black, for: .normal)
                    priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
                  genotypeTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                    secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                  
                  territoryBreddingOutlet.setTitleColor(.black, for: .normal)
                  territoryBreddingOutlet.setTitle(data.tertiaryGeno, for: .normal)
                    
                    UserDefaults.standard.set(data.tissuName, forKey: "genotypeTissueBttn")
                    
                  if UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) != nil {
                    breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                    selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
                    
                  } else {
                    breedId = data.breedId!
                    selectBreedBtn.setTitle(data.breedName, for: .normal)
                  }
                    samplename = data.tissuName!
                    let pvidAA = data.providerId
                    // UserDefaults.standard.set(breedId, forKey: "InheritBeefbreed")
                  //  UserDefaults.standard.set(data.sireIDAU, forKey: "priorityBreedName")
                  if data.gender == "Male".localized || data.gender == "M"{
                       // self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                      self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString("Male", comment: "")
                      UserDefaults.standard.set("M", forKey: "GenoGender")
                        
                        
                    } else {
                        genderToggleFlag = 0
                      genderString = "Female".localized
                    //    self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
                        UserDefaults.standard.set("F", forKey: "GenoGender")
                    }
                    
                    tissuId = Int(data.tissuId)
                    
                    genotypeDOBBttn.setTitleColor(.black, for: .normal)
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
    }
    
    
    
    
    
    func statusOrderTrue() -> Bool{
        
        let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        } else {
            return false
        }
        
    }
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    func GenotypetextfieldLeftPadding(){
        
        genotypeScanBarcodeTextField.addPadding(.left(20))
        genotypeSerieTextfield.addPadding(.left(20))
        genotypeRgnTextfield.addPadding(.left(20))
        genotypeAnimalNameTextfield.addPadding(.left(20))
        genotypeRgdTextfield.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        serieTextfield.addPadding(.left(20))
        rGNTextfield.addPadding(.left(20))
        rGDTextfield.addPadding(.left(20))
        animalTextfield.addPadding(.left(20))
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
        self.genotypeScanBarcodeTextField.backgroundColor = .white
    }
    //  MARK: - OtherType
    func otherBorderColor(){
//        serieTextfield.layer.cornerRadius = (serieTextfield.frame.size.height / 2)
//        serieTextfield.layer.borderWidth = 0.5
//        serieTextfield.layer.borderColor = UIColor.gray.cgColor
//        serieTextfield.layer.masksToBounds = true
//        rGNTextfield.layer.cornerRadius = (rGNTextfield.frame.size.height / 2)
//        rGNTextfield.layer.borderWidth = 0.5
//        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
//        rGNTextfield.layer.masksToBounds = true
//        rGDTextfield.layer.cornerRadius = (rGDTextfield.frame.size.height / 2)
//        rGDTextfield.layer.borderWidth = 0.5
//        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
//        rGDTextfield.layer.masksToBounds = true
//        animalTextfield.layer.cornerRadius = (animalTextfield.frame.size.height / 2)
//        animalTextfield.layer.borderWidth = 0.5
//        animalTextfield.layer.borderColor = UIColor.gray.cgColor
//        animalTextfield.layer.masksToBounds = true
//        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
//        barcodeView.layer.borderWidth = 0.5
//        barcodeView.layer.borderColor = UIColor.gray.cgColor
//        barcodeView.layer.masksToBounds = true
//        dobView.layer.cornerRadius = (dobView.frame.size.height / 2)
//        dobView.layer.borderWidth = 0.5
//        dobView.layer.borderColor = UIColor.gray.cgColor
//        dobView.layer.masksToBounds = true
//        tissueBttn.layer.borderWidth = 0.5
//        tissueBttn.layer.borderColor = UIColor.gray.cgColor
//        genstarblackBreedBtn.layer.borderWidth = 0.5
//        genstarblackBreedBtn.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    func othersByDefaultBackroundWhite(isBeginEditing: Bool = false){
      //  dateOfLbl.textColor = UIColor.black
      //  dobLbl.textColor = UIColor.black
        scanBarcodeTextfield.layer.backgroundColor = UIColor.white.cgColor
        maleFemaleBttn.backgroundColor = UIColor.white
        serieTextfield.layer.backgroundColor = UIColor.white.cgColor
        rGNTextfield.layer.backgroundColor = UIColor.white.cgColor
        rGDTextfield.layer.backgroundColor = UIColor.white.cgColor
        animalTextfield.layer.backgroundColor = UIColor.white.cgColor
        dateBttnOutlet.layer.backgroundColor = UIColor.white.cgColor
        tissueBttn.layer.backgroundColor = UIColor.white.cgColor
        genstarblackBreedBtn.layer.backgroundColor = UIColor.white.cgColor
        serieTextfield.isEnabled = true
        rGNTextfield.isEnabled = true
        rGDTextfield.isEnabled = true
        animalTextfield.isEnabled = true
        dateBttnOutlet.isEnabled = true
        tissueBttn.isEnabled = true
        genstarblackBreedBtn.isEnabled = true
        maleFemaleBttn.isEnabled = true
        dateBttnOutlet.isEnabled = true
        tissueBttn.setTitleColor(.black, for: .normal)
        genstarblackBreedBtn.setTitleColor(.black, for: .normal)
        maleFemaleBttn.setTitleColor(.black, for: .normal)
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        incrementalBarcodeTitleLabel.textColor = UIColor.black
        incrementalBarcodeButton.isEnabled = true
        dateTextField.isEnabled = true
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true && isBeginEditing == false {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
            }
        }
    }
    
    func byDefaultSetting(){
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        
        if dateStr == "MM" {
            dateformt.dateFormat = "MM/dd/yyyy"
            dateTextField.placeholder = "MM/DD/YYYY"
            genotypeDateTextField.placeholder = "MM/DD/YYYY"
        } else {
            dateformt.dateFormat = "dd/MM/yyyy"
            dateTextField.placeholder = "DD/MM/YYYY"
            genotypeDateTextField.placeholder = "DD/MM/YYYY"

        }
      //  dateOfLbl.isHidden = false
        if isGenotypeOnlyAdded {
            
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
                genotypeDateTextField.isHidden = false
                dateOfLbl.isHidden = true
            } else {
                genotypeDateTextField.isHidden = true
                dateOfLbl.isHidden = false
            }
        } else {
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                dateTextField.isHidden = false
                dobLbl.isHidden = true
            } else {
                dateTextField.isHidden = true
                dobLbl.isHidden = false
            }
        }
        //dobLbl.isHidden = false

        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        self.isautoPopulated = false
        barAutoPopu = false
      
       selectBreedBtn.setTitleColor(UIColor.gray, for: .normal)
        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
        let dte = Date()
        dateBttnOutlet.setTitle("", for: .normal)
//        serieTextfield.layer.borderColor = UIColor.gray.cgColor
//        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
//        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
//        animalTextfield.layer.borderColor = UIColor.gray.cgColor
//        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
//        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        scanBarcodeTextfield.text?.removeAll()
        serieTextfield.text?.removeAll()
        rGNTextfield.text?.removeAll()
        rGDTextfield.text?.removeAll()
        animalTextfield.text?.removeAll()
        //  tissueBttn.setTitle("Allflex (TSU)", for: .normal)
        dateTextField.text?.removeAll()
        dateBttnOutlet.titleLabel?.text = ""
       // self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        if UserDefaults.standard.value(forKey: "NonGenoGender") as? String == "F" ||
            UserDefaults.standard.value(forKey: "NonGenoGender") as? String == nil {
            self.maleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "NonGenoGender")
        } else {
            self.maleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "NonGenoGender")
        }
     
        
        if UserDefaults.standard.string(forKey: "tissueBttn") == nil || UserDefaults.standard.string(forKey: "tissueBttn") == ""{
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            for items in self.tissueArr
            {
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if checkdefault == true
                {
                  self.tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                    self.tissuId =  Int(tissue?.sampleId ?? 4)
                }
                
                
            }
            //tissueBttn.setTitle("Hair", for: .normal)
           // tissuId = 4
        } else {
          tissueBttn.setTitle(UserDefaults.standard.string(forKey: "tissueBttn"), for: .normal)
        }
        
        OtherbyTextfieldGray()
        self.scrolView.contentOffset.y = 0.0
        
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        
        if isGenotypeOnlyAdded {
            if !changeColorToRed {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
                self.genotypeScanBarcodeTextField.backgroundColor = .white
            }
            
        } else {
            if !changeColorToRed {
                self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
            
        }
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
       
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        for items in tissueArr
        {
            let tissue = items  as? GetSampleTbl
            let checkdefault  = tissue?.isDefault
            
            if checkdefault == true
            {
              genotypeTissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
              tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                tissuId =  Int(tissue?.sampleId ?? 4)
            }
            
            
        }
            
    
          if isGenostarblackOnlyAdded {
         let breed = self.breedArrblack[0] as! GetBreedsTbl
         if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
           genstarblackBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
           breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
           
         } else  {
           genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
            breedId = breed.breedId ?? ""
         }
            
             }
     
    }
    
    func OtherbyTextfieldGray(){
      //  dobLbl.textColor = UIColor.gray
      //  dateOfLbl.textColor = UIColor.gray
//        barcodeView.layer.borderColor = UIColor.gray.cgColor
//        serieTextfield.layer.borderColor = UIColor.gray.cgColor
//        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
//        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
       // genstarblackBreedBtn.layer.borderColor = UIColor.gray.cgColor
        serieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        rGNTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        rGDTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dobView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genstarblackBreedBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        maleFemaleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        serieTextfield.isEnabled = false
        rGNTextfield.isEnabled = false
        rGDTextfield.isEnabled = false
        animalTextfield.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttn.isEnabled = false
        maleFemaleBttn.isEnabled = false
        maleFemaleBttn.setTitleColor(.gray, for: .normal)
        dateBttnOutlet.isEnabled = false
        genstarblackBreedBtn.isEnabled = false
        tissueBttn.setTitleColor(.gray, for: .normal)
        genstarblackBreedBtn.setTitleColor(.gray, for: .normal)
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        dateTextField.isEnabled = false
        dateTextField.text = ""
      
    }
    
    func validation(){
        
        if scanBarcodeTextfield.text == ""{
            barcodeView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            
        }
        
        if rGDTextfield.text == ""{
            requiredflag = 0
            //serieTextfield.layer.borderColor = UIColor.red.cgColor
           // rGNTextfield.layer.borderColor = UIColor.red.cgColor
            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
        }
        if requiredflag == 1{
            serieTextfield.layer.borderColor = UIColor.gray.cgColor
            rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        }
        else{
           // serieTextfield.layer.borderColor = UIColor.red.cgColor
           // rGNTextfield.layer.borderColor = UIColor.red.cgColor
            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    //  MARK: - Genotype
    
    func GenotypebyDefaultbackroundWhite(isBeginEditing: Bool = true){
        
        genotypeMaleFemaleBttn.isEnabled = true
        genotypeScanBarcodeView.layer.backgroundColor = UIColor.white.cgColor
        genotypeSerieTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeRgnTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeMaleFemaleBttn.backgroundColor = UIColor.white
        genotypeAnimalNameTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeRgdTextfield.layer.backgroundColor = UIColor.white.cgColor
        calenderViewOutlet.layer.backgroundColor = UIColor.white.cgColor
        genotypeTissueBttn.layer.backgroundColor = UIColor.white.cgColor
       
        selectBreedBtn.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeDOBBttn.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeSerieTextfield.isEnabled = true
        genotypeRgnTextfield.isEnabled = true
        genotypeAnimalNameTextfield.isEnabled = true
        genotypeRgdTextfield.isEnabled = true
        //genotypeBarcodeBttn.isEnabled = true
        calenderViewOutlet.isUserInteractionEnabled = true
      //  dateOfLbl.textColor = UIColor.black
     //   dobLbl.textColor = UIColor.black

        genotypeDOBBttn.isEnabled = true
        
        genotypeTissueBttn.isEnabled = true
       
        selectBreedBtn.isEnabled = true
       
        priorityBreeingBtnOutlet.isEnabled = true
        territoryBreddingOutlet.isEnabled = true
        secondaryBreddingOutlet.isEnabled = true
        priorityBreeingBtnOutlet.backgroundColor = UIColor.white
        genotypeMaleFemaleBttn.backgroundColor = UIColor.white
        secondaryBreddingOutlet.backgroundColor = UIColor.white
      territoryBreddingOutlet.backgroundColor = UIColor.white
        secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
      territoryBreddingOutlet.setTitleColor(.black, for: .normal)
        genotypeTissueBttn.setTitleColor(.black, for: .normal)
        genotypeMaleFemaleBttn.setTitleColor(.black, for: .normal)
        selectBreedBtn.setTitleColor(.black, for: .normal)
        
        incrementalBarcodeTitleLabelGenoType.textColor = .black
        incrementalBarcodeButtonGenoType.isEnabled = true
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true && isBeginEditing == false {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
            }
        }
    }
    
    func GenotypebyDefaultbackroundGray(){
   //     dateOfLbl.textColor = UIColor.gray
   //     dobLbl.textColor = UIColor.gray

        
        genotypeDOBBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
//        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        
        calenderViewOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeSerieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgnTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeAnimalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.gray, for: .normal)
       territoryBreddingOutlet.setTitleColor(.gray, for: .normal)
        genotypeTissueBttn.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        secondaryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)

      territoryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)

        genotypeTissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        selectBreedBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeMaleFemaleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeSerieTextfield.isEnabled = false
        genotypeRgnTextfield.isEnabled = false
        genotypeAnimalNameTextfield.isEnabled = false
        genotypeRgdTextfield.isEnabled = false
        calenderViewOutlet.isUserInteractionEnabled = false
        genotypeDOBBttn.isEnabled = false
        
        genotypeTissueBttn.isEnabled = false
        
        selectBreedBtn.isEnabled = false
        
        priorityBreeingBtnOutlet.isEnabled = false
        secondaryBreddingOutlet.isEnabled = false
       territoryBreddingOutlet.isEnabled = false
        genotypeMaleFemaleBttn.isEnabled = false
        genotypeMaleFemaleBttn.setTitleColor(.gray, for: .normal)
        maleFemaleBttn.isEnabled = false
        tissueBttn.isEnabled = false
        priorityBreeingBtnOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)

       territoryBreddingOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)

        incrementalBarcodeTitleLabelGenoType.textColor = .gray
        incrementalBarcodeButtonGenoType.isEnabled = false
        
        if !changeColorToRed {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        }
        
        genotypeDateTextField.text = ""
    }
    
    func genotypeSetBorder(){
//        genotypeTissueBttn.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
//        genotypeTissueBttn.layer.borderWidth = 0.5
//        genotypeTissueBttn.layer.borderColor = UIColor.gray.cgColor
//        genotypeTissueBttn.layer.masksToBounds = true
//        genotypeScanBarcodeView.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
//        
//        genotypeScanBarcodeView.layer.borderWidth = 0.5
//        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
//        genotypeScanBarcodeView.layer.masksToBounds = true
//        genotypeDOBBttn.layer.cornerRadius = (genotypeDOBBttn.frame.size.height / 2)
//        genotypeDOBBttn.layer.borderWidth = 0.5
//        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
//        genotypeDOBBttn.layer.masksToBounds = true
//       
//        selectBreedBtn.layer.cornerRadius = (genotypeDOBBttn.frame.size.height / 2)
//        selectBreedBtn.layer.borderWidth = 0.5
//        selectBreedBtn.layer.borderColor = UIColor.gray.cgColor
//        selectBreedBtn.layer.masksToBounds = true
//        
//        
//        
//        genotypeSerieTextfield.layer.cornerRadius = (genotypeSerieTextfield.frame.size.height / 2)
//        genotypeSerieTextfield.layer.borderWidth = 0.5
//        
//        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
//        
//        genotypeSerieTextfield.layer.masksToBounds = true
//        genotypeRgnTextfield.layer.cornerRadius = (genotypeRgnTextfield.frame.size.height / 2)
//        genotypeRgnTextfield.layer.borderWidth = 0.5
//        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeRgnTextfield.layer.masksToBounds = true
//        genotypeAnimalNameTextfield.layer.cornerRadius = (genotypeAnimalNameTextfield.frame.size.height / 2)
//        genotypeAnimalNameTextfield.layer.borderWidth = 0.5
//        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeAnimalNameTextfield.layer.masksToBounds = true
//        
//        genotypeRgdTextfield.layer.cornerRadius = (genotypeRgdTextfield.frame.size.height / 2)
//        genotypeRgdTextfield.layer.borderWidth = 0.5
//        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeRgdTextfield.layer.masksToBounds = true
//        priorityBreeingBtnOutlet.layer.cornerRadius = (priorityBreeingBtnOutlet.frame.size.height / 2)
//        priorityBreeingBtnOutlet.layer.borderWidth = 0.5
//        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
//        priorityBreeingBtnOutlet.layer.masksToBounds = true
//        secondaryBreddingOutlet.layer.cornerRadius = (secondaryBreddingOutlet.frame.size.height / 2)
//        secondaryBreddingOutlet.layer.borderWidth = 0.5
//        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
//        secondaryBreddingOutlet.layer.masksToBounds = true
//      
//      territoryBreddingOutlet.layer.cornerRadius = (territoryBreddingOutlet.frame.size.height / 2)
//      territoryBreddingOutlet.layer.borderWidth = 0.5
//      territoryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
//      territoryBreddingOutlet.layer.masksToBounds = true
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
        self.genotypeScanBarcodeTextField.backgroundColor = .white
    }
    
    func GenotypebyDefaultScreen(){
        
        //  MARK: - Genotype
      //  self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        if UserDefaults.standard.value(forKey: "GenoGender") as? String == "F" || UserDefaults.standard.value(forKey: "GenoGender") as? String == nil {
            self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
          genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "GenoGender")
        } else {
            self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "GenoGender")
        }
        
        if isGenotypeOnlyAdded {
            
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
                genotypeDateTextField.isHidden = false
                dateOfLbl.isHidden = true
            } else {
                genotypeDateTextField.isHidden = true
                dateOfLbl.isHidden = false
            }
        } else {
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                dateTextField.isHidden = false
                dobLbl.isHidden = true
            } else {
                dateTextField.isHidden = true
                dobLbl.isHidden = false
            }
        }
      
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        barAutoPopu = false
        msgUpatedd = false
        
        self.msgcheckk = false
        
        self.isautoPopulated = false
        
        genotypeScanBarcodeTextField.text?.removeAll()
        genotypeSerieTextfield.text?.removeAll()
        genotypeRgnTextfield.text?.removeAll()
        genotypeAnimalNameTextfield.text?.removeAll()
        genotypeRgdTextfield.text?.removeAll()
        genotypeSerieTextfield.isEnabled = false
        genotypeRgnTextfield.isEnabled = false
        genotypeAnimalNameTextfield.isEnabled = false
        genotypeRgdTextfield.isEnabled = false
        calenderViewOutlet.isUserInteractionEnabled = false
        
        genotypeDOBBttn.isEnabled = false
       genotypeDOBBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeTissueBttn.isEnabled = false
        
        priorityBreeingBtnOutlet.isEnabled = false
        
        secondaryBreddingOutlet.isEnabled = false
      territoryBreddingOutlet.isEnabled = false
        
      if let primary = UserDefaults.standard.object(forKey: keyValue.primaryGenoType.rawValue)
      {
        priorityBreeingBtnOutlet.setTitle(primary as? String ,for: .normal)
      } else{
        priorityBreeingBtnOutlet.setTitle(NSLocalizedString("Select Primary Breed Genotype", comment: "") ,for: .normal)
      }
      
      if let secondary = UserDefaults.standard.object(forKey: keyValue.secondaryGenoType.rawValue)
      {
        secondaryBreddingOutlet.setTitle(secondary as? String ,for: .normal)
      } else{
        secondaryBreddingOutlet.setTitle(NSLocalizedString("Select Secondary Breed Genotype", comment: ""), for: .normal)
      }
      
      if let tertiray = UserDefaults.standard.object(forKey: keyValue.tertirayGenoType.rawValue)
      {
        territoryBreddingOutlet.setTitle(tertiray as! String ,for: .normal)
      } else{
        territoryBreddingOutlet.setTitle(NSLocalizedString("Select Tertiary Breed Genotype", comment: ""), for: .normal)
      }
      
       // priorityBreeingBtnOutlet.setTitle(NSLocalizedString("Select Primary Breed Genotype", comment: ""), for: .normal)
//        secondaryBreddingOutlet.setTitle(NSLocalizedString("Select Secondary Breed Genotype", comment: ""), for: .normal)
//        territoryBreddingOutlet.setTitle(NSLocalizedString("Select Tertiary Breed Genotype", comment: ""), for: .normal)
        genotypeDOBBttn.titleLabel?.text = ""
        genotypeDOBBttn.setTitle("", for: .normal)
        maleFemaleBttn.isEnabled = false
        genotypeMaleFemaleBttn.isEnabled = false
        tissueBttn.isEnabled = false
//        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
//        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
//        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
//        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
//        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
//        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
//       territoryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
//        tissueBttn.layer.borderColor = UIColor.gray.cgColor
//       
//      selectBreedBtn.layer.borderColor = UIColor.gray.cgColor
       
        GenotypebyDefaultbackroundGray()
        self.genotypeScrollView.contentOffset.y = 0.0
      
        //   if UserDefaults.standard.string(forKey: "genotypeTissueBttn") == nil{
       
        
        incrementalBarcodeTitleLabelGenoType.textColor = .gray
        incrementalBarcodeButtonGenoType.isEnabled = false
        //self.genotypeScanBarcodeTextField.becomeFirstResponder()
        
        if !changeColorToRed {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        }
        
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 23, speciesName: "")
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        for items in tissueArr
        {
            let tissue = items  as? GetSampleTbl
            let checkdefault  = tissue?.isDefault
            
            if checkdefault == true
            {
              genotypeTissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
              tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                tissuId =  Int(tissue?.sampleId ?? 4)
            }
            
            
        }
            
        
      if tempbreedarraynames1.count == 0 {
        
      
        let breed = self.breedArrblack[0] as! GetBreedsTbl
        let breed1 = self.breedArr[0] as! GetBreedsTbl
       
        
       
        //blackstar
        if breedArrblack.count != 0 {
            for i in 0 ..< breedArrblack.count{
                let obj = breedArrblack[i] as! GetBreedsTbl
                tempbreedblackname.append(obj.breedName ?? "")
               
            }
        }
        //genotype
        if breedArr.count != 0 {
            for i in 0 ..< breedArr.count{
                let obj = breedArr[i] as! GetBreedsTbl
                tempbreedarraynames.append(obj.breedName ?? "")
               
            }
        }
        
        commomNamebreed = tempbreedblackname.filter{ tempbreedarraynames.contains($0) } as NSArray
        
        if commomNamebreed.count != 0 {
            for i in 0 ..< breedArr.count{
                let obj = breedArr[i] as! GetBreedsTbl
                if commomNamebreed.contains(obj.breedName)
                {
                    tempbreedarraynames1.append(obj.breedId ?? "")
                    tempbreedarraynames2.append(obj.threeCharCode ?? "")
                }
            }
        }
       
            
        
        if isGenotypeOnlyAdded && isGenostarblackOnlyAdded
        {
          if UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) != nil {
            breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
            selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
            
          } else {
            selectBreedBtn.setTitle(tempbreedarraynames2[0], for: .normal)
            breedId = tempbreedarraynames1[0]
          }
          
           
        }
         else if isGenostarblackOnlyAdded
             {
           if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
             breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
             genstarblackBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
             
           } else {
             genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
              breedId = breed.breedId ?? ""
             }
         }
        else
        {
          if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
            breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
            selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as! String, for: .normal)
            
          } else {
            selectBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
            breedId = breed1.breedId ?? ""
          }
           
        }
      }
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
       
        
    }
    @IBAction func selectBreedTypeblackstar(_ sender: Any) {
        btnTag = 117
        view.endEditing(true)
        self.tableViewpop()
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
       //breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 23)
        var yFrame = (genstarblackBreedBtn.frame.minY + 130) - self.scrolView.contentOffset.y
        self.nonGenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: nonGenoBreedTypeView, removeShadow: false)
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (genstarblackBreedBtn.frame.minY + 860) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 140)
                    
                }
            case 810:
                yFrame = (genstarblackBreedBtn.frame.minY + 860) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 140)
                    
                }
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (genstarblackBreedBtn.frame.minY + 778) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 23,y: yFrame,width: 567,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                        
                    }
                }
                else {
                    yFrame = (genstarblackBreedBtn.frame.minY + 778) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 140)
                        
                    }
                }
              
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (genstarblackBreedBtn.frame.minY + 778) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 140)
                        
                    }
                } else {
                    yFrame = (genstarblackBreedBtn.frame.minY + 778) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 140)
                        
                    }
                }
            case 1024:
                yFrame = (genstarblackBreedBtn.frame.minY + 778) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 140)
                    
                }
            case 1032:
                yFrame = (genstarblackBreedBtn.frame.minY + 778) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 140)
                    
                }
            default:
                break
            }
        }
       // droperTableView.frame = CGSize(width: genstarblackBreedBtn.frame.width, height: 300)
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
   
    @IBAction func selectBreedTypeBtnAction(_ sender: Any) {
        
        btnTag = 116
        view.endEditing(true)
        self.tableViewpop()
      
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        let breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 23, speciesName: "")
        var yFrame = (selectBreedBtn.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        self.GenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: GenoBreedTypeView, removeShadow: false)
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (selectBreedBtn.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 140)
                    
                }
            case 810:
                yFrame = (selectBreedBtn.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 140)
                    
                }
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (selectBreedBtn.frame.minY + 778) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 23,y: yFrame,width: 567,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                        
                    }
                }
                else {
                    yFrame = (selectBreedBtn.frame.minY + 778) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 140)
                        
                    }
                }
              
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (selectBreedBtn.frame.minY + 778) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 140)
                        
                    }
                } else {
                    yFrame = (selectBreedBtn.frame.minY + 778) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 140)
                        
                    }
                }
            case 1024:
                yFrame = (selectBreedBtn.frame.minY + 778) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 140)
                    
                }
            case 1032:
                yFrame = (selectBreedBtn.frame.minY + 778) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 140)
                    
                }
            default:
                break
            }
        }
        //droperTableView.frame = CGRect(x: genstarblackBreedBtn.frame.minX+20,y: yFrame,width: 145,height: 300)
      //  droperTableView.frame = CGRect(x:selectBreedBtn.frame.minX+20,y: yFrame,width: 150,height: 300)
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
    
    @IBAction func tissureBtnAction(_ sender: Any) {
        
        //  MARK: - Genotype
        btnTag = 10
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        self.GenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: GenoSampleTypeView, removeShadow: false)
        self.tableViewpop()
        var yFrame = (genotypeTissueBttn.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (genotypeTissueBttn.frame.minY + 630) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 482,height: 95)
                
            case 810:
                yFrame = (genotypeTissueBttn.frame.minY + 630) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (genotypeTissueBttn.frame.minY + 577) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 95)
                } else {
                    yFrame = (genotypeTissueBttn.frame.minY + 630) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (genotypeTissueBttn.frame.minY + 627) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 95)
                } else {
                    yFrame = (genotypeTissueBttn.frame.minY + 627) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 95)
                }

            case 1024:
                yFrame = (genotypeTissueBttn.frame.minY + 575) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 95)

            case 1032:
                yFrame = (genotypeTissueBttn.frame.minY + 575) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 700,y: yFrame,width: 655,height: 95)

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
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    func tableViewpop() {
        
        //  MARK: - Genotype
        buttonbg2.frame = CGRect(x:0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        
        buttonbg2.addTarget(self, action:#selector(BeefAnimalBrazilVCIpad.buttonPreddDroper), for: .touchUpInside)
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
        self.nonGenoGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.nonGenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.nonGenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.GenoGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.GenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.GenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: nonGenoGenderView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoSampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoBreedTypeView, removeShadow: true)
        self.setShadowForUIView(view: GenoGenderView, removeShadow: true)
        self.setShadowForUIView(view: GenoSampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: GenoBreedTypeView, removeShadow: true)
        self.setShadowForUIView(view: primaryBreedingView, removeShadow: true)
        self.setShadowForUIView(view: secondaryBreedingView, removeShadow: true)
        self.setShadowForUIView(view: tertiaryBreedingView, removeShadow: true)
    }
    
    
    
    
    
    @IBAction func prioorityBreddingAction(_ sender: Any) {
        
        //  MARK: - Genotype
        btnTag = 20
        view.endEditing(true)
        priorityBreeding = fetchAllData(entityName: "GetPriorityBreeding")
        self.tableViewpop()
        var yFrame = (priorityBreeingBtnOutlet.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        var strDeviceType = ""
        self.setShadowForUIView(view: primaryBreedingView, removeShadow: false)
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
            case 810:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 878) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                }
                else {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 878) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                }
              
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 878) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                } else {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 878) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                }
            case 1024:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 878) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
            case 1032:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 878) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
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
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func secondayBtnAction(_ sender: Any) {
        
        btnTag = 30
        view.endEditing(true)
        
        secondaryBreeding = fetchAllData(entityName: "GetSecondaryBreedingPrograms")
        self.tableViewpop()
        self.setShadowForUIView(view: secondaryBreedingView, removeShadow: false)
        var yFrame = (secondaryBreddingOutlet.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (secondaryBreddingOutlet.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 482,height: 95)
                
            case 810:
                yFrame = (secondaryBreddingOutlet.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (secondaryBreddingOutlet.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 95)
                } else {
                    yFrame = (secondaryBreddingOutlet.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (secondaryBreddingOutlet.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 95)
                } else {
                    yFrame = (genotypeTissueBttn.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 95)
                }

            case 1024:
                yFrame = (secondaryBreddingOutlet.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 652,height: 95)

            case 1032:
                yFrame = (secondaryBreddingOutlet.frame.minY + 877) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 700,y: yFrame,width: 652,height: 95)

            default:
                break
            }
        }
        
        droperTableView.reloadData()
        
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
  // MARK: - tertiary Breeding Button Action
  
  @IBAction func tertiaryButtonAction(_ sender: Any) {
      
      btnTag = 50
      view.endEditing(true)
      
    tertiaryBreeding = fetchAllData(entityName: "GetTertiaryBreedingPrograms")
      self.tableViewpop()
      self.setShadowForUIView(view: tertiaryBreedingView, removeShadow: false)
      var yFrame = (territoryBreddingOutlet.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
      var strDeviceType = ""
      
      if UIDevice().userInterfaceIdiom == .pad {
          switch UIScreen.main.bounds.height {
          case 768:
              yFrame = (territoryBreddingOutlet.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
              droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
          case 810:
              yFrame = (territoryBreddingOutlet.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
              droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
          case 820:
              if UIScreen.main.nativeBounds.height == 2360.0 {
                  yFrame = (territoryBreddingOutlet.frame.minY + 978) - self.genotypeScrollView.contentOffset.y
                  droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
              }
              else {
                  yFrame = (territoryBreddingOutlet.frame.minY + 978) - self.genotypeScrollView.contentOffset.y
                      droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                      
              }
            
          case 834:
              if UIScreen.main.nativeBounds.height == 2224.0 {
                  yFrame = (territoryBreddingOutlet.frame.minY + 978) - self.genotypeScrollView.contentOffset.y
                  droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
              } else {
                  yFrame = (territoryBreddingOutlet.frame.minY + 978) - self.genotypeScrollView.contentOffset.y
                  droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
              }
          case 1024:
              yFrame = (territoryBreddingOutlet.frame.minY + 978) - self.genotypeScrollView.contentOffset.y
              droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
          case 1032:
              yFrame = (territoryBreddingOutlet.frame.minY + 978) - self.genotypeScrollView.contentOffset.y
              droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
          default:
              break
          }
      }
      
      droperTableView.reloadData()
      
      statusOrderTrue()
      if statusOrder == true{
          msgAnimalSucess = true
      } else {
          messageCheck = true
      }
      
      let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
      if animalDataMaster.count > 0 {
          msgUpatedd = true
      }
  }
  
    
    @IBAction func genotypeAddAnimalAction(_ sender: UIButton) {
        // self.view.endEditing(true)
        
//        addContiuneBtn = 1
//        addAnimalBtn(completionHandler: { (success) -> Void in
//
//            self.3
//        })
//        44564645757dfgdfgdf
        
        self.view.endEditing(true)
        changeColorToRed = true
        addContiuneBtn = 1
        UserDefaults.standard.setValue("addAnotherAnimal", forKey: "isToUpdateAndAddAnimal")
        addAnimalBtn(completionHandler: { (success) -> Void in
            if success == true {
                self.changeColorToRed = false
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.changeColorToRed = false
                })
            }
            if self.isGenotypeOnlyAdded
            {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
                self.genotypeScanBarcodeTextField.backgroundColor = .white
            }
            else
            {
            self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
        }
        )
        
        
    }
    func genotypecontinueproduct()
    {
           
            
            let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            identify1 = true
            let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
            
            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
            
            if  identyCheck == false || identyCheck == nil{
                if data1.count > 0 {
                    if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                        if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                            requiredflag = 1
                        } else {
                            requiredflag = 0
                        }
                        
                    }
                    else{
                        requiredflag = 1
                    }
                    if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                        
                        if genotypeScanBarcodeTextField.text != ""{
                            if genotypeSerieTextfield.text != "" && genotypeRgnTextfield.text != ""  {
                            }else {
                                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                                GenoRGNView.layer.borderColor = UIColor.red.cgColor
                                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                             //   genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                return
                                
                                
                            }
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                            
                          NavigateToBeefOrderingScreen()
                            
                        } else {
                            if identyCheck == false || identyCheck == nil {
                                if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
//                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                  self.NavigateToBeefOrderingScreen()
                                }
                                else{
                                    NavigateToBeefOrderingScreen(screenType: 2)
//                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                }
                            }
                            else {
                                NavigateToBeefOrderingScreen(screenType: 2)
//                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                              
                            }
                        }
                    } else {
                        
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            
                            
                            if success == true{
                                
                                let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                if  identyCheck == true {
                                    self.NavigateToBeefOrderingScreen(screenType: 2)
//                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
//
                                    
                                }  else {
                                    if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                        
//                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                      self.NavigateToBeefOrderingScreen()
                                        
                                    } else {
                                        self.NavigateToBeefOrderingScreen(screenType: 2)
//                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                      
                                    }
                                }
                            }
                        })
                    }
                }
                else {
                    
                    if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == ""{
                            requiredflag = 0
                    }
                    else{
                        requiredflag = 1
                    }
                    if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                        
                        if genotypeScanBarcodeTextField.text?.count == 0 {
                            if genotypeScanBarcodeTextField.text == "" && requiredflag == 0 {
                                self.textFieldValidation()
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please add at least one animal.", comment: ""))
                                return
                            } else {
                                
                                self.textFieldValidation()
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                return
                                
                            }
                            
                        } else {
                            
                            
                            
                            if genotypeSerieTextfield.text != "" && genotypeRgnTextfield.text != ""  {
                                
                                genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                                    if success == true{
                                    }
                                })
                            } else {
                                
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                self.textFieldValidation()
                                
                                return
                                
                            }
                        }
                    } else {
                        
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success == true{
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
//                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                  self.NavigateToBeefOrderingScreen()
                                    
                                } else {
                                    self.NavigateToBeefOrderingScreen(screenType: 2)
//                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController:
//                                        self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                }
                            }
                        })
                        
                        
                    }
                }
            }  else {
                
                if data1.count > 0 {
                    if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                        if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                            requiredflag = 1
                        }else{
                            requiredflag = 0
                        }
                        
                    }
                    else{
                        requiredflag = 1
                    }
                    if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                        
                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                        if  identyCheck == true {
                            NavigateToBeefOrderingScreen(screenType: 2)
//                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            
                        }  else {
                            NavigateToBeefOrderingScreen(screenType: 2)
//                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                        }
                    }
                    else{
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success == true{
                                let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                if  identyCheck == true {
                                    self.NavigateToBeefOrderingScreen(screenType: 2)
                                //    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                    
                                }  else {
                                    self.NavigateToBeefOrderingScreen(screenType: 2)
                                 //   self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                }
                            }
                        })
                    }
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                              //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                            else {
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                               // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                
                            }
                        }
                    })
                }
            }
        
    }
    @IBAction func genotypeContinueProductAction(_ sender: UIButton)
    {
        addContiuneBtn = 2
        genotypecontinueproduct()
    }
    
    
    
    @IBAction func maleBtnClick(_ sender: Any) {
        btnTag = 210
        self.view.endEditing(true)
//        if genderToggleFlag == 0 {
//          //  self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
//            self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
//            genderToggleFlag = 1
//            genderString = NSLocalizedString("Male", comment: "")
//            
//        } else {
//           // self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//            self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
//            genderToggleFlag = 0
//          genderString = "Female".localized
//        }
        
        self.GenoGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: GenoGenderView, removeShadow: false)
        self.tableViewpop()
        var yFrame = (genotypeMaleFemaleBttn.frame.minY + 640) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 640) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 150)

                
            case 810:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 640) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 680) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                } else {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 680) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                }
             

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 680) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 532,height: 150)
                } else {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 680) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                }

            case 1024:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 680) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 150)

            case 1032:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 680) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 150)

            default:
                break
            }
        }
        
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        droperTableView.reloadData()
    }
    
    
    
    func textFieldValidation(){
        if genotypeScanBarcodeTextField.text == ""{
            genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
        } else {
            genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" {
            if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                requiredflag = 1
            }else{
                requiredflag = 0
            }
        }
        
        if requiredflag == 1 {
            genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
         //   genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        } else {
            GenoSeriesView.layer.borderColor = UIColor.red.cgColor
            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
            GenoRGNView.layer.borderColor = UIColor.red.cgColor
          //  genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    //  MARK: - OtherView
    func landIdApplangaugeConversion(){
            animalTextfield.placeholder = NSLocalizedString("Enter Animal Name", comment: "")
            // dateBttnOutlet.setTitle("Data de nascimento",for: .normal)
//            dobLbl.text = NSLocalizedString("Date of Birth", comment: "")
//            dateOfLbl.text = NSLocalizedString("Date of Birth", comment: "")
//            maleFemaleBttn.setTitle("",for: .normal)
//           // tissueBttn.setTitle("Allflex(TSU)",for: .normal)
//            rGDTextfield.placeholder = NSLocalizedString("RGD or Animal ID", comment: "")
//            rGNTextfield.placeholder = NSLocalizedString("RGN", comment: "")
//            serieTextfield.placeholder = NSLocalizedString("Series", comment: "")
//            scanBarcodeTextfield.placeholder = NSLocalizedString("Scan/Enter Sample Barcode", comment: "")
//            
//            //GENOTYPE
//            genotypeScanBarcodeTextField.placeholder = NSLocalizedString("Scan/Enter Sample Barcode", comment: "")
//            genotypeSerieTextfield.placeholder = NSLocalizedString("Series", comment: "")
//            genotypeRgnTextfield.placeholder = NSLocalizedString("RGN", comment: "")
//            genotypeAnimalNameTextfield.placeholder = NSLocalizedString("Enter Animal Name", comment: "")
//            genotypeRgdTextfield.placeholder = NSLocalizedString("RGD or Animal ID", comment: "")
//            priorityBreeingBtnOutlet.setTitle(NSLocalizedString("Select Primary Breed Genotype", comment: ""),for: .normal)
//            secondaryBreddingOutlet.setTitle(NSLocalizedString("Select Secondary Breed Genotype", comment: ""),for: .normal)
//           territoryBreddingOutlet.setTitle(NSLocalizedString("Select Tertiary Breed Genotype", comment: ""),for: .normal)
//            
//            addAnotherBtnTtile.text = NSLocalizedString("Ordering Add Animal(s)", comment: "")
//            addAnotherTtile.setTitle(NSLocalizedString("Add Another Animal", comment: ""), for: .normal)
//            continueToTtile.setTitle(NSLocalizedString("Continue to Product Selection", comment: ""), for: .normal)
//            genoTypeAddAnotherAnimalTtile.setTitle(NSLocalizedString("Add Another Animal", comment: ""), for: .normal)
//            continueToBtnTtile.setTitle(NSLocalizedString("Continue to Product Selection", comment: ""), for: .normal)
//            appStatusLabel.text = NSLocalizedString("App Status:", comment: "")
//            selectTitleLbl.text = NSLocalizedString("Select List", comment: "")
    }
    @IBOutlet weak var addAnotherTtile: UIButton!
    
    @IBOutlet weak var continueToTtile: UIButton!
    @IBOutlet weak var genoTypeAddAnotherAnimalTtile: UIButton!
    @IBOutlet weak var continueToBtnTtile: UIButton!
    
    @IBAction func otherMaleBtnAction(_ sender: Any) {
        
        self.view.endEditing(true)
//        if othersGenderToggleFlag == 0 {
//            self.maleFemaleBttn.setImage(UIImage(named: "LangMale\(langCode)"), for: .normal)
//            othersGenderToggleFlag = 1
//            othersGenderString = NSLocalizedString("Male", comment: "")
//            genderString = othersGenderString
//            
//        } else {
//            self.maleFemaleBttn.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
//            othersGenderToggleFlag = 0
//          othersGenderString = "Female".localized
//            genderString = othersGenderString
//        }
        
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        btnTag = 200
        
        self.nonGenoGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: nonGenoGenderView, removeShadow: false)
        self.tableViewpop()
        var yFrame = (maleFemaleBttn.frame.minY + 640) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (maleFemaleBttn.frame.minY + 640) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 150)

                
            case 810:
                yFrame = (maleFemaleBttn.frame.minY + 640) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (maleFemaleBttn.frame.minY + 680) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                } else {
                    yFrame = (maleFemaleBttn.frame.minY + 680) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                }
             

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (maleFemaleBttn.frame.minY + 680) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 532,height: 150)
                } else {
                    yFrame = (maleFemaleBttn.frame.minY + 680) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                }

            case 1024:
                yFrame = (maleFemaleBttn.frame.minY + 675) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            case 1032:
                yFrame = (maleFemaleBttn.frame.minY + 675) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            default:
                break
            }
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        droperTableView.reloadData()
    }
    
    
    @IBAction func OtherTissuebtnAction(_ sender: Any) {
        btnTag = 40
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        var strDeviceType = ""
        self.nonGenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: nonGenoSampleTypeView, removeShadow: false)
        self.tableViewpop()
        var yFrame = (tissueBttn.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (tissueBttn.frame.minY + 630) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 482,height: 95)
                
            case 810:
                yFrame = (tissueBttn.frame.minY + 630) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (tissueBttn.frame.minY + 577) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 95)
                } else {
                    yFrame = (tissueBttn.frame.minY + 630) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (tissueBttn.frame.minY + 627) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 95)
                } else {
                    yFrame = (tissueBttn.frame.minY + 627) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 95)
                }

            case 1024:
                yFrame = (tissueBttn.frame.minY + 575) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 95)

            case 1032:
                yFrame = (tissueBttn.frame.minY + 575) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 695,y: yFrame,width: 655,height: 95)

            default:
                break
            }
        }
            
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        changeColorToRed = true
        addContiuneBtn = 1
        UserDefaults.standard.setValue("addAnotherAnimal", forKey: "isToUpdateAndAddAnimal")
        addAnimalBtn(completionHandler: { (success) -> Void in
            
            if success == true {
                self.changeColorToRed = false
                self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.changeColorToRed = false
                })
                self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
            
            
           
        })
        
//        self.view.endEditing(true)
//
//        addContiuneBtn = 1
//        UserDefaults.standard.setValue("addAnotherAnimal", forKey: "isToUpdateAndAddAnimal")
//        addAnimalBtn(completionHandler: { (success) -> Void in
//            if self.isGenotypeOnlyAdded
//            {
//                self.genotypeScanBarcodeTextField.becomeFirstResponder()
//            }
//            else
//            {
//            self.scanBarcodeTextfield.becomeFirstResponder()
//            }
//        })
        
        
        // validation()
    }
    
    
    @IBAction func addAnimalkeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
       
        addContiuneBtn = 1
        UserDefaults.standard.setValue("addAnotherAnimal", forKey: "isToUpdateAndAddAnimal")
        addAnimalBtn(completionHandler: { (success) -> Void in
            if self.isGenotypeOnlyAdded
            {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
                self.genotypeScanBarcodeTextField.backgroundColor = .white
            }
            else
            {
            self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
        })
        
        
        // validation()
    }
   
    func autoPop(animalData:NSArray) {
        
        
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            barcodeflag = false
            updateOrder = true
            var data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            ////////start
            let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
            animalId1 = Int(data.animalId)
            dateBttnOutlet.titleLabel!.text = ""
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            var formatter = DateFormatter()
            if data.date != "" {
                dobLbl.text = ""
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1{
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                    }
                    dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                    dateBttnOutlet.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                }
                else{
                    //   self.selectedDate = Date()
                }
                let dates =  formatter.string(from: selectedDate)
            }
            if data.orderstatus == "false"{
                scanBarcodeTextfield.text =  data.animalTag
            }
            //scanBarcodeTextfield.text = data.animalTag
            rGNTextfield.text = data.offPermanentId
            serieTextfield.text = data.offsireId
            rGDTextfield.text = data.offDamId
            
            //                animalNameTextfield.text  = data.anima
            
            tissueBttn.setTitleColor(.black, for: .normal)
            animalTextfield.text = data.animalbarCodeTag
          tissueBttn.setTitle(data.tissuName?.localized, for: .normal)
          UserDefaults.standard.set(data.tissuName?.localized, forKey: "tissueBttn")
            
            breedId = String(data.breedId ?? "")
            let samplename = data.tissuName!
            let pvidAA = data.providerId
            UserDefaults.standard.set(breedId, forKey: "Beefbreed")
            
          if data.gender == "Male".localized || data.gender == "M"{
               // self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
              self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
                genderToggleFlag = 1
              UserDefaults.standard.set("M", forKey: "GenoGender")
                genderString = NSLocalizedString("Male", comment: "")
                
            } else {
             //  self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                self.maleFemaleBttn.setTitle("Female", for: .normal)
                genderToggleFlag = 0
              genderString = "Female".localized
                UserDefaults.standard.set("F", forKey: "NonGenoGender")
                
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
            
            if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                requiredflag = 0
            }
            else{
                if isautoPopulated == true{
                    requiredflag = 1
                }
                else{
                    requiredflag = 0
                }
            }
            if requiredflag == 1{
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            else{
                nonGenoSeriesView.layer.borderColor = UIColor.red.cgColor
                nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
                serieTextfield.layer.borderColor = UIColor.red.cgColor
                rGNTextfield.layer.borderColor = UIColor.red.cgColor
                rGDTextfield.layer.borderColor = UIColor.red.cgColor
            }
            UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            
        }
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            updateOrder = true
            var data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            ////////start
            let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
            animalId1 = Int(data.animalId)
            UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            
            /////////end
            
            genotypeDOBBttn.titleLabel?.text = ""
            genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
            genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            var formatter = DateFormatter()
            if data.date != "" {
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                    }
                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
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
                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                if  genotypeDOBBttn.titleLabel!.text != nil {
                    if  genotypeDOBBttn.titleLabel?.text != "" && formatter.date(from: genotypeDOBBttn.titleLabel?.text ?? "") != nil {
                        self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel?.text ?? "")!
                    }
                    
                }
                else{
                    self.selectedDate = Date()
                }
                let dates =  formatter.string(from: selectedDate)
            }
            if data.orderstatus == "false"{
                genotypeScanBarcodeTextField.text = data.animalTag
            }
            
            genotypeRgnTextfield.text = data.offPermanentId
            genotypeSerieTextfield.text = data.offsireId
            genotypeRgdTextfield.text = data.offDamId
            genotypeAnimalNameTextfield.text = data.animalbarCodeTag
            //                animalNameTextfield.text  = data.anima
            
            priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
            genotypeTissueBttn.setTitleColor(.black, for: .normal)
            priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
          genotypeTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
            secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
            territoryBreddingOutlet.setTitle(data.tertiaryGeno, for: .normal)
            territoryBreddingOutlet.setTitleColor(.black, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: "BeefInheritTsu")
            
            breedId = String(data.breedId ?? "")
            let samplename = data.tissuName!
            let pvidAA = data.providerId
            // UserDefaults.standard.set(breedId, forKey: "InheritBeefbreed")
          //  UserDefaults.standard.set(data.sireIDAU, forKey: "priorityBreedName")
          if data.gender == "Male".localized || data.gender == "M"{
               // self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
              self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
              UserDefaults.standard.set("M", forKey: "GenoGender")
                
            } else {
              //  self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
                genderToggleFlag = 0
              genderString = "Female".localized
                UserDefaults.standard.set("F", forKey: "GenoGender")
                
            }
            tissuId = Int(data.tissuId)
            
            genotypeDOBBttn.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                //statusOrder = true
                messageCheck = true
            }
            if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                    requiredflag = 1
                }else{
                    requiredflag = 0
                }
                
            }
            else{
                if isautoPopulated == true{
                    requiredflag = 1
                }
                else{
                    requiredflag = 0
                }
            }
            if requiredflag == 1{
                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            else{
                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                GenoRGNView.layer.borderColor = UIColor.red.cgColor
                GenoRGDView.layer.borderColor = UIColor.red.cgColor
                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
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
                    let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
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
            if !isGenotypeOnlyAdded {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if  scanBarcodeTextfield.text == "" || requiredflag == 0{
                    if  scanBarcodeTextfield.text == "" {
                        
                        
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                    } else if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                        completionHandler(false)
                        return
                    }
                    
                } else {
                    if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                           
                            completionHandler(true)
                        })
                    }
                    
                }
            }
            else{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    } else {
                        requiredflag = 0
                    }
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    if genotypeScanBarcodeTextField.text == "" {
                        self.textFieldValidation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                        
                    } else if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == "" {
                        
                        self.textFieldValidation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                        completionHandler(false)
                        return
                        
                    }
                } else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                      
                        completionHandler(true)
                    })
                    
                }
                
            }
            
        } else {
            
            if !isGenotypeOnlyAdded {
                if rGDTextfield.text == "" {//serieTextfield.text == "" && rGNTextfield.text == "" || rGDTextfield.text == ""{
                    requiredflag = 0
                    
                } else if serieTextfield.text != "" && rGNTextfield.text == "" || serieTextfield.text == "" && rGNTextfield.text != ""  {
                    
                    requiredflag = 0
                    
                    if serieTextfield.text == "" {
                        nonGenoSeriesView.layer.borderColor = UIColor.red.cgColor
                        nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                        serieTextfield.layer.borderColor = UIColor.red.cgColor
                        rGNTextfield.layer.borderColor = UIColor.gray.cgColor

                    } else{
                        serieTextfield.layer.borderColor = UIColor.gray.cgColor
                        nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                        rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    }
                    
                    if rGDTextfield.text != ""{
                        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                    }
                }
                else {
                    requiredflag = 1
                }
                
                if scanBarcodeTextfield.text == "" || requiredflag == 0{
                    
                    if rGDTextfield.text == "" {
                        
                        if scanBarcodeTextfield.text == ""{
                            barcodeView.layer.borderColor = UIColor.red.cgColor
                        }
                        else {
                            barcodeView.layer.borderColor = UIColor.gray.cgColor
                            
                        }
                        nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
                        rGDTextfield.layer.borderColor = UIColor.red.cgColor
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return

                        
                    }
                    
                    
                    if scanBarcodeTextfield.text == "" {
                        
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                    } else if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                        completionHandler(false)
                        return
                    }
                    
                } else {
                        if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            if success == true{
                                completionHandler(true)
                            }
                        })
                    }
                }
            }
            else{
                if genotypeSerieTextfield.text == "" || genotypeRgnTextfield.text == "" {//&& genotypeRgdTextfield.text == ""{
//                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
//                        requiredflag = 1
//                    }else{
//                        requiredflag = 0
//                    }
                    requiredflag = 0
                    
                } else {
                    
                    requiredflag = 1
                }
                
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    if genotypeScanBarcodeTextField.text?.count == 0 {
                        self.textFieldValidation()
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                    } else {
                        
                        
                        if genotypeSerieTextfield.text == "" || genotypeRgnTextfield.text == "" {
                            if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" {
                                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                                GenoRGNView.layer.borderColor = UIColor.red.cgColor
                                
                                if genotypeScanBarcodeTextField.text?.count == 0 {
                                    genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor

                                }else {
                                    genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor

                                }
                                
                                
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                completionHandler(false)
                                return                            }
                            
                            if genotypeSerieTextfield.text == "" {
                                
                                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                                GenoRGNView.layer.borderColor = UIColor.red.cgColor
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                completionHandler(false)
                                return
                            }
                            if genotypeRgnTextfield.text == ""{
                                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                                GenoRGNView.layer.borderColor = UIColor.red.cgColor
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                completionHandler(false)
                                return
                            }
                        }
                        
                        
                        if priorityBreeingBtnOutlet.titleLabel?.text! == "Cia De Melhoramento" {
                            
                            genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                                if success == true{
                                    completionHandler(true)
                                }
                            })
                        } else {
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                            self.textFieldValidation()
                            
                            completionHandler(false)
                            return
                            
                        }
                    }
                    
                } else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                        if success == true{
                            completionHandler(true)
                        }
                    })
                }
            }
        }
        if notificationLblCount.text != "0"{
            countLbl.isHidden = false
            notificationLblCount.isHidden = false
            self.cartView.isHidden = false
        }
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        // InheritSelectedDate = Date()
        let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
        // vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        
        self.navigationController?.pushViewController(vc!, animated: true)
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
    
    func addBtnCondtion(completionHandler: CompletionHandler){
//        if validateRGD == true
//        {
     //   let checkRGD = fetchAnimaldataValidateRGD(entityName: "BeefAnimalMaster", rgd: rGDTextfield.text ?? "")
//        //BeefAnimaladdTbl
//        let checkRGD1 = fetchAnimaldataValidateRGD(entityName: Entities.beefAnimalAddTblEntity, rgd: rGDTextfield.text ?? "")
//        if checkRGD.count > 0
//        {
//            rGDTextfield.layer.borderColor = UIColor.red.cgColor
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
//            return
//        }
//        if checkRGD1.count > 0
//        {
//            rGDTextfield.layer.borderColor = UIColor.red.cgColor
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
//            return
//        }
//            validateRGD == false
//        }
//
//
        
        
        if breedId == ""
        {
        let breed = self.breedArrblack[0] as! GetBreedsTbl
        breedId = breed.breedId ?? ""
        }
//        if tissuId == 0
//        {
//        let tissue = self.tissueArr[1]  as! GetSampleTbl
//        tissuId =  Int(tissue.sampleId)
//        }
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
            return
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        let formatter = DateFormatter()
        
        
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {

            
            dateVale = dateTextField.text ?? ""
            if dateStr == "DD"{
                dateVale = dateTextField.text ?? ""
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
        
        if UserDefaults.standard.value(forKey: "NonGenoGender") as? String == "F" ||
            UserDefaults.standard.value(forKey: "NonGenoGender") as? String == nil {
            self.maleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "NonGenoGender")
        } else {
            self.maleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "NonGenoGender")
        }
     
        
        if dateTextField.text?.count == 0 {
            
            
        } else {
            
            if dateTextField.text?.count == 10 {
            var validate = isValidDate(dateString: dateTextField.text ?? "")
          
                
                if validate == "Correct Format" {
//                    dobView.layer.borderColor = UIColor.gray.cgColor
//                    dobView.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dobView.layer.borderColor = UIColor.red.cgColor
                  //  dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                    if validate == "GreaterThenDate" {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                        return
                    }
                    return
                }
            } else {
                dobView.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                return
                
            }
        }
        
//        let barCode = fetchAnimaBarcodeValidateWithoutOrderId(entityName: "DataEntryBeefAnimaladdTbl",animalbarCodeTag:scanBarcodeTextfield.text ?? "",orderSatatus: "false")
//        if barCode.count > 0 {
//            barcodeView.layer.borderColor = UIColor.red.cgColor
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode is already used with an animal.", comment: ""))
//            return
//        }
//      if rGDTextfield.text != "" {
//        let barCodeRGD = fetchAnimaBarcodeValidateWithoutOrderIdRGD(entityName: "DataEntryBeefAnimaladdTbl",RGD: rGDTextfield.text ?? "",orderSatatus: "false")
//        if barCodeRGD.count > 0 {
//            rGDTextfield.layer.borderColor = UIColor.red.cgColor
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in a list.", comment: ""))
//            return
//        }
//      }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        //if  msgUpatedd == false {
        if barcodeflag == true {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId)
            if barCode.count > 0 {
                
                barcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
            }
        }
        //}
      let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalIdearTag(entityName: "BeefAnimalMaster", animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderStatus:"true",IsDataEmail: false)
        if animaBarcOde.count > 0 {
            
            barcodeView.layer.borderColor = UIColor.red.cgColor
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order", comment: ""))
            return
        }
       /// fetchAnimaldataValidateAnimalRGD
        if  validateRGD == true
        {
            //validateRGD = false
        let RGDcheck = fetchAnimaldataValidateAnimalRGD(entityName: Entities.beefAnimalAddTblEntity, RGD: rGDTextfield.text ?? "", userId: userId, animalId: animalId1, orderSatatus: "false",orderid:orderId)
        if RGDcheck.count > 0
        {
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
            return
            
        }
//            let RGDcheckmasterdata1 = fetchAnimaldataValidateAnimalRGDmaster(entityName: "BeefAnimalMaster", RGD: rGDTextfield.text ?? "",userId: userId, animalId: animalId1,orderSatatus:"false")
//                   if RGDcheckmasterdata1.count > 0 {
//                       rGDTextfield.layer.borderColor = UIColor.red.cgColor
//
//                       CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
//                       return
//                   }
        }
        //BeefAnimalMaster
        let RGDcheckmasterdata = fetchAnimaldataValidateAnimalRGDmaster(entityName: "BeefAnimalMaster", RGD: rGDTextfield.text ?? "",userId: userId, animalId: animalId1,orderSatatus:"true",IsDataEmail: false)
        if RGDcheckmasterdata.count > 0 {
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
            return
        }
        //  let newcheck2 = fetchAllDataOrdercheckfarmid(entityName: "AnimalMaster", ordestatus: "false", farmid: onfarmidtext ,userId: userId)
//        let RGDcheckmasterdata1 = fetchAnimaldataValidateAnimalRGDmaster(entityName: "BeefAnimalMaster", RGD: rGDTextfield.text ?? "",userId: userId, animalId: animalId1,orderSatatus:"false")
//        if RGDcheckmasterdata1.count > 0 {
//            rGDTextfield.layer.borderColor = UIColor.red.cgColor
//
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
//            return
//        }
        
       
        
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanBarcodeTextfield.text!, orderId: orderId, userId: userId, animalId: animalId1)
        
        if animalData.count > 0 {
          let existAnimalData = animalData.lastObject as! BeefAnimaladdTbl
          if existAnimalData.orderstatus == "true" {
            if existAnimalData.date != dateVale || existAnimalData.breedId != breedId || existAnimalData.gender?.localized != genderString {
              
              let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
              
              // Create the actions
              let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
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
        }
        
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        
        if animalData.count > 0  {
          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
          if data12333.count > 0 {
            if  tissueBttn.titleLabel!.text! != "Allflex (TSU)" || tissueBttn.titleLabel!.text! != "Allflex (TST)" || tissueBttn.titleLabel!.text! != "Caisley (TSU)" {
              //  show alert
              let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be updated in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
              
              // Create the actions
              let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.byDefaultSetting()
                
              }
              let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                
                
                //                deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
                //                deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
                //                deleteDataWithProductwithEntity(animalID1, entity: Entities.beefAnimalAddTblEntity)
                //                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                //                self.notificationLblCount.text = String(animalCount.count)
                self.byDefaultSetting()
                return
                
              }
              
              // Add the actions
              
              alertController.addAction(cancelAction)
              alertController.addAction(okAction)
              
              // Present the controller
              self.present(alertController, animated: true, completion: nil)
            }
            
          }else {
            let dataEntryBeefanimal = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, sireId: serieTextfield.text ?? "", animalBarCode: animalTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
            if dataEntryBeefanimal.count > 0 {
              updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: Int(dataEntryBeefanimal[0].animalId) ,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            }
            isUpdate = true
          updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "" )
            
          updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity,animalTag: scanBarcodeTextfield.text ?? "", barCodetag: animalTextfield.text ?? "", date: dateVale , damId: rGDTextfield.text ?? "", sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            
            
            updateOrderStatusISyncProductbr(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: scanBarcodeTextfield.text!,barCodetag: animalTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1,rgd: rGDTextfield.text ?? "",rgn:rGNTextfield.text ?? "",serie: serieTextfield.text ?? "")
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: scanBarcodeTextfield.text!,barCodetag:  animalTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
                
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                   // CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                //  self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttnClear")
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttn")
                    
                    byDefaultSetting()
                    
                }
                else{
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
            // return
          }
        }
        else if isUpdate == true {
          
          let animalData = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, sireId: serieTextfield.text ?? "", animalBarCode: animalTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
          if animalData.count > 0 {
            updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: Int(animalData[0].animalId),isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
          }
            
            animalId1 = editAid
          updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                        
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
                
            else if animalDataMaster.count > 0 {
              //  if  msgUpatedd == true{
                   // CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                  
           //       self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttnClear")
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttn")
                    
                    byDefaultSetting()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                    
                }
            //}
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            //return
        }
        else {
            isUpdate = false
            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
          if product.count > 0 {
            pid = product[0] as? GetProductTblBeef
          }
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
              updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                
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
                  updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU:"", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                  
                  
                }
                else {
                    
                  saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid?.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",tertiaryGeno: "")
                  createDataList()
                }
            }
            
            
            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid?.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",tertiaryGeno: "")
          createDataList()
            
            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanBarcodeTextfield.text!,orderId:orderId,userId:userId)
            let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    
                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    if addonArr.count > 0 {
                        
                        for j in 0 ..< addonArr.count {
                            
                            let addonDat = addonArr[j] as! GetAdonTbl
                            
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            
                            msgShow()
                            
                        }
                    }
                    else {
                        msgShow()
                    }
                    
                }
            }
            
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: "isBarCodeIncrementalClear")
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                
                UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                
            }
            
           
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttnClear")
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttn")
           // self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
         //   self.maleFemaleBttn.setTitle("Female", for: .normal)
            byDefaultSetting()
            
            OtherbyTextfieldGray()
     //       genderToggleFlag = 0
       //   genderString = "Female".localized
            scanBarcodeTextfield.text = ""
            
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = "MM/dd/yyyy"
            }
            else {
                formatter.dateFormat = "dd/MM/yyyy"
            }
            dateBttnOutlet.titleLabel?.text = ""
            barAutoPopu = false
            dateVale = ""
            completionHandler(true)
        }
        
        //BARCODE INCREMENTAL
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: "barcodeIncremental")
        }
        incrementalBarCode = ""
        
        
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                
                if scanBarcodeTextfield.text?.isEmpty == false {
                    othersByDefaultBackroundWhite()
                }
            }
        }
        self.scrolView.contentOffset.y = 0.0
    }
    func msgShow()  {
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
    
        UserDefaults.standard.set(priorityBreeingBtnOutlet.titleLabel?.text, forKey: keyValue.primaryGenoType.rawValue)
      UserDefaults.standard.set(secondaryBreddingOutlet.titleLabel?.text, forKey: keyValue.secondaryGenoType.rawValue)
      UserDefaults.standard.set(territoryBreddingOutlet.titleLabel?.text, forKey: keyValue.tertirayGenoType.rawValue)
      UserDefaults.standard.set(breedId, forKey: keyValue.beefBreedID.rawValue)
      UserDefaults.standard.set(selectBreedBtn.titleLabel?.text, forKey: keyValue.beefBreedName.rawValue)
     // UserDefaults.standard.set(genstarblackBreedBtn.titleLabel?.text, forKey: keyValue.beefBreedName.rawValue)
      
      }
      
    
    func genotypeAddBtnCondtion(completionHandler: CompletionHandler){
        if UserDefaults.standard.value(forKey: "GenoGender") as? String == "F" || UserDefaults.standard.value(forKey: "GenoGender") as? String == nil {
            self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "GenoGender")
        } else {
            self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "GenoGender")
        }
//        let checkall = fetchAllData(entityName: "BeefAnimalMaster")
//        let checkall1 = fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
//        let genocheckRGD = fetchAnimaldataValidateRGD(entityName: "BeefAnimalMaster", rgd: genotypeRgdTextfield.text ?? "")
//        //BeefAnimaladdTbl
//        let genocheckRGD1 = fetchAnimaldataValidateRGD(entityName: Entities.beefAnimalAddTblEntity, rgd: genotypeRgdTextfield.text ?? "")
//        if genocheckRGD.count > 0
//        {
//            genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
//            return
//        }
//        if genocheckRGD1.count > 0
//        {
//            genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
//            return
//        }
      var dataListDetail = [DataEntryList]()
      let listName = orderingDataListViewModel.makeListName(custmerId: custmerId ?? 0, providerID: pvid ?? 0)
      if listName != "" {
       dataListDetail =  fetchDatalistDetailbyName(listName: listName)
      }
        
        if breedId == ""
        {
        let breed = self.breedArr[0] as! GetBreedsTbl
        breedId = breed.breedId ?? ""
        }
//        if tissuId == 0
//        {
//        let tissue = self.tissueArr[1]  as! GetSampleTbl
//        tissuId =  Int(tissue.sampleId)
//        }
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
            return
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        let formatter = DateFormatter()

        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {

           dateVale = genotypeDateTextField.text ?? ""
            if dateStr == "DD"{
                dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
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
            
            dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
            if dateStr == "DD"{
                dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
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
        
        
        if genotypeDateTextField.text?.count == 0 {
            
            
        } else {
            
            if genotypeDateTextField.text?.count == 10 {
            let validate = isValidDate(dateString: genotypeDateTextField.text ?? "")
           
                
                if validate == "Correct Format" {
//                    dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
//                    dateBttnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                  //  dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                    if validate == "GreaterThenDate" {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                        return
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
        
        
        incrementalBarCode = genotypeScanBarcodeTextField.text ?? ""
//        let barCode = fetchAnimaBarcodeValidateWithoutOrderId(entityName: "DataEntryBeefAnimaladdTbl",animalbarCodeTag:genotypeScanBarcodeTextField.text ?? "",orderSatatus: "false")
//        if barCode.count > 0 {
//            genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
//            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode is already used with an animal.", comment: ""))
//            return
//        }
        //fetchAnimaBarcodeValidateWithoutOrderIdRGD
      if genotypeRgdTextfield.text?.count ?? 0 > 0{
        let genobarCodeRGD = fetchAnimaBarcodeValidateWithoutOrderIdRGD(entityName: "DataEntryBeefAnimaladdTbl",RGD:genotypeRgdTextfield.text ?? "",orderSatatus: "false") as! [DataEntryBeefAnimaladdTbl]
        if genobarCodeRGD.count > 0 && dataListDetail.count > 0 {
          if genobarCodeRGD[0].listId != dataListDetail[0].listId{
            genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
              GenoRGDView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in a list.", comment: ""))
            return
          }
        }
      }
//        let printvalue = fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
//        let printvalue1 = fetchAllData(entityName: "BeefAnimalMaster")
//        print(printvalue)
//        print(printvalue1)
        //if  msgUpatedd == false {
        if  barcodeflag == true {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: genotypeScanBarcodeTextField.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId )
            if barCode.count > 0 {
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
            }
        }
        //}
      let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalIdearTag(entityName: "BeefAnimalMaster", animalbarCodeTag: genotypeScanBarcodeTextField.text ?? "", userId: userId, animalId: animalId1,orderStatus:"true",IsDataEmail: false)
        if animaBarcOde.count > 0 {
            genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
            return
        }
        
        if genovalidateRGD == true
        {
            if genotypeRgdTextfield.text != "" {
                let RGDcheck = fetchAnimaldataValidateAnimalRGD(entityName: Entities.beefAnimalAddTblEntity, RGD: genotypeRgdTextfield.text ?? "", userId: userId, animalId: animalId1, orderSatatus: "false",orderid:orderId)
                if RGDcheck.count > 0
                {
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    GenoRGDView.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                    return
                    
                }
            }
            
//                let RGDcheckmasterdata1 = fetchAnimaldataValidateAnimalRGDmaster(entityName: "BeefAnimalMaster", RGD: genotypeRgdTextfield.text ?? "",userId: userId, animalId: animalId1,orderSatatus:"false",IsDataEmail: false)
//                       if RGDcheckmasterdata1.count > 0 {
//                           genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
//
//                           CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
//                           return
//                       }
            }
            //BeefAnimalMaster
      if genotypeRgdTextfield.text?.count ?? 0 > 0 {
            let RGDcheckmasterdata = fetchAnimaldataValidateAnimalRGDmaster(entityName: "BeefAnimalMaster", RGD: genotypeRgdTextfield.text ?? "",userId: userId, animalId: animalId1,orderSatatus:"true",IsDataEmail: false)
            if RGDcheckmasterdata.count > 0 {
                genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                GenoRGDView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
            }
      }
       
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:genotypeScanBarcodeTextField.text!, orderId: orderId, userId: userId, animalId: animalId1)
        if animalData.count > 0 {
          let existAnimalData = animalData.lastObject as! BeefAnimaladdTbl
          if existAnimalData.orderstatus == "true" {
            if existAnimalData.date != dateVale || existAnimalData.breedId != breedId || existAnimalData.gender?.localized != genderString {
              
              let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
              
              // Create the actions
              let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
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
        }
        
        if animalData.count > 0  {
          let dataEntryBeefanimal = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, sireId: genotypeSerieTextfield.text ?? "", animalBarCode:  genotypeAnimalNameTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
          if dataEntryBeefanimal.count > 0 {
            
            updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: Int(dataEntryBeefanimal[0].animalId),isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
          }
            isUpdate = true
          updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity,animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (priorityBreeingBtnOutlet.titleLabel!.text!), nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            
            
            updateOrderStatusISyncProductbr(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: genotypeScanBarcodeTextField.text ?? "",barCodetag:  genotypeAnimalNameTextfield.text ?? "",farmId: "",orderId: orderId,userId:userId,animalId:animalId1,rgd: genotypeRgdTextfield.text ?? "",rgn: genotypeRgnTextfield.text ?? "",serie: genotypeSerieTextfield.text ?? "")

            
            
           // updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: genotypeScanBarcodeTextField.text!,barCodetag:  genotypeAnimalNameTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: genotypeScanBarcodeTextField.text!,barCodetag:  genotypeAnimalNameTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                GenotypebyDefaultScreen()
                
                
            }
                
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                 // self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.GenotypebyDefaultScreen()
                    }
                }
                 
                if let isFromCart = UserDefaults.standard.bool(forKey: "isAnimalClickedFromBeefCart") as? Bool {
                    if let isUpdateAndAddMore = UserDefaults.standard.value(forKey: "isToUpdateAndAddAnimal") as? String {
                    
                    if isFromCart {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                     // self.NavigateToBeefOrderingScreen()
                        UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
                        UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.GenotypebyDefaultScreen()
                        }
                    }
                }
            }
//                if let isUpdateAndAddMore = UserDefaults.standard.value(forKey: "isToUpdateAndAddAnimal")
//
//
//
//                dfghhfghfh
                
                
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    GenotypebyDefaultScreen()
                    
                }
                
                
           // }
            
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
          let dataEntryBeefanimal = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, sireId: genotypeSerieTextfield.text ?? "", animalBarCode: genotypeAnimalNameTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
          if dataEntryBeefanimal.count > 0 {
           
            updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: Int(dataEntryBeefanimal[0].animalId),isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
          }
          
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            
            
            
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                GenotypebyDefaultScreen()
                
                
            }
                
            else if animalDataMaster.count > 0 {
              //  if  msgUpatedd == true{
                   // CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
               //   self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
                    
                    GenotypebyDefaultScreen()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    GenotypebyDefaultScreen()
                    
                }
                
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            //return
        }
        else {
            isUpdate = false
            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
            let pid = product[0] as! GetProductTblBeef
            
            //            if breedId == 0{
            //                UserDefaults.standard.set(5, forKey: keyValue.breed.rawValue)
            //                breedId = (UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? Int)!
            //            }
            //            let breedName =   breedBtnOutlet.titleLabel?.text
            //            if breedName == "HO"{
            //                UserDefaults.standard.set(5, forKey: keyValue.breed.rawValue)
            //                breedId = (UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? Int)!
            //            }
            //
            //
            //            let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            //            let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId )
            //            if product.count == 0{
            //
            //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("The product does not allow for this breed. Please change the breed or product to continue. ", comment: ""))
            //                self.scrolView.contentOffset.y = 0.0
            //
            //            }
            //
            //            else {
            
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
                
                
                
                
                
              updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                
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
                  updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU:secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                }
                else {
                    
                  saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",IsEmailData: false,tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                  
                  createDataList()
                }
            }
        
            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",IsEmailData: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
          createDataList()
            
            
            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:genotypeScanBarcodeTextField.text!,orderId:orderId,userId:userId)
            let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
            
            //                if UserDefaults.standard.bool(forKey: keyValue.identifyStore.rawValue) == false  {
            //
            //                    if productCount > 0{
            //
            //                        if product.count == UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue){
            //                            UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
            //                        }
            //                        else {
            //                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
            //                        }
            //                    }
            //                }
            
            //UserDefaults.standard.set( product.count, forKey: keyValue.productCount.rawValue)
            //let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
            
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                    
                    
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    if addonArr.count > 0 {
                        for j in 0 ..< addonArr.count {
                            
                            let addonDat = addonArr[j] as! GetAdonTbl
                            
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            
                            msgShow()
                        }
                    }
                    else {
                        msgShow()
                    }
                    
                }
            }
            UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
            UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
           // self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
          //  self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
            GenotypebyDefaultScreen()
         //   GenotypebyDefaultbackroundGray()
         //   genderToggleFlag = 0
         // genderString = "Female".localized
            
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: "isBarCodeIncrementalClear")
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                
                UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                
            }
            genotypeScanBarcodeTextField.text = ""
            
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
            //                let result = formatter.string(from: date)
            //                dateBtnOutlet.titleLabel?.text = result
            dateVale = ""
            genotypeDOBBttn.titleLabel!.text  = ""
            genotypeDOBBttn.setTitle("", for: .normal)
            completionHandler(true)
            // }
        }
        barAutoPopu = false
        //BARCODE INCREMENTAL
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: "barcodeIncremental")
        }
        incrementalBarCode = ""
        
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                if genotypeScanBarcodeTextField.text?.isEmpty == false {
                    self.GenotypebyDefaultbackroundWhite()
                }
            }
        }
       
        view.endEditing(true)
        self.genotypeScrollView.contentOffset.y = 0.0
      
          UserDefaults.standard.set(priorityBreeingBtnOutlet.titleLabel?.text, forKey: keyValue.primaryGenoType.rawValue)
        UserDefaults.standard.set(secondaryBreddingOutlet.titleLabel?.text, forKey: keyValue.secondaryGenoType.rawValue)
        UserDefaults.standard.set(territoryBreddingOutlet.titleLabel?.text, forKey: keyValue.tertirayGenoType.rawValue)
        UserDefaults.standard.set(breedId, forKey: keyValue.beefBreedID.rawValue)
        UserDefaults.standard.set(selectBreedBtn.titleLabel?.text, forKey: keyValue.beefBreedName.rawValue)
        //UserDefaults.standard.set(genstarblackBreedBtn.titleLabel?.text, forKey: keyValue.GenoBeefBreedName.rawValue)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        barcodeEnable = true
        self.view.endEditing(true)
        
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {

            dateTextField.isHidden = false
        }else {
            dateTextField.isHidden = true

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
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    @IBAction func genotypeDateAction(_ sender: UIButton) {
        barcodeEnable = true
        self.view.endEditing(true)
        
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {

            genotypeDateTextField.isHidden = false
        }else {
            genotypeDateTextField.isHidden = true

            
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        genotypeDoDatePicker()
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
    
    func genotypeDoDatePicker(){
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
      let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.genotypeDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
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
        dobLbl.isHidden = true
        dateOfLbl.isHidden = true
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        //dateTextField.isHidden = false
    }
    
    @objc func genotypeDoneClick() {
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
        genotypeDOBBttn.setTitle(selectedDate, for: .normal)
        dobLbl.isHidden = true
        dateOfLbl.isHidden = true
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        genotypeDOBBttn.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    func continueproduct()
    {
       
        
        let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        identify1 = true
        let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
        
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        
        if  identyCheck == false || identyCheck == nil{
            if data1.count > 0 {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if  scanBarcodeTextfield.text == "" || requiredflag == 0{
                    
                    
                    if scanBarcodeTextfield.text != ""{
                        if rGDTextfield.text != "" {
                            
                        } else {
                          //  serieTextfield.layer.borderColor = UIColor.red.cgColor
                         //   rGNTextfield.layer.borderColor = UIColor.red.cgColor
                            rGDTextfield.layer.borderColor = UIColor.red.cgColor
                            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))

                            
                        //    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                            return
                            
                            
                        }
                    }
                    

                    if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                        if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                            self.NavigateToBeefOrderingScreen(screenType: 2)
                          //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                          
                        }
                        else {
                          NavigateToBeefOrderingScreen()
//                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                        }
                    } else {
                        // if identyCheck == false || identyCheck == nil {
                        if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                            if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                             //   self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                            else {
                              NavigateToBeefOrderingScreen()
//                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                            }
                        }
                        else{
                            self.NavigateToBeefOrderingScreen(screenType: 2)
                           // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                        }
                    }
                } else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        
                        
                        if success == true{
                            
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                              //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                
                            }  else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    
                                    if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                                        self.NavigateToBeefOrderingScreen(screenType: 2)
                                      //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                    }
                                    else {
                                      self.NavigateToBeefOrderingScreen()
//                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                    }
                                    
                                } else {
                                    self.NavigateToBeefOrderingScreen(screenType: 2)
                                  //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                    
                                }
                            }
                        }
                    })
                }
            }
            else {
                
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == "" {
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if scanBarcodeTextfield.text == "" || requiredflag == 0 {
                    if scanBarcodeTextfield.text == "" && requiredflag == 0 {
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
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                                if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                                  //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                }
                                else {
                                  self.NavigateToBeefOrderingScreen()
//                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                }
                                
                            } else {
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                              //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController:
                                   // self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                        }
                    })
                    
                    
                }
            }
        }
        else {
            
            if data1.count > 0 {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if  scanBarcodeTextfield.text == "" || requiredflag == 0{
                    
                    let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                    if  identyCheck == true {
                        self.NavigateToBeefOrderingScreen(screenType: 2)
                     //   self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                        
                    }  else {
                        self.NavigateToBeefOrderingScreen(screenType: 2)
                      //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                    }
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                               // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                
                            }  else {
                                self.NavigateToBeefOrderingScreen(screenType: 2)
                            //    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                        }
                    })
                }
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success == true{
                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                        if  identyCheck == true {
                            self.NavigateToBeefOrderingScreen(screenType: 2)
                          //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                        }
                        else {
                            self.NavigateToBeefOrderingScreen(screenType: 2)
                          //  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            
                        }
                    }
                })
            }
        }
        }
    
    @IBAction func continueProductAction(_ sender: UIButton) {
        
        addContiuneBtn = 2
       if isGenotypeOnlyAdded
        {
           genotypecontinueproduct()
       }
        else
        {
            continueproduct()
        }
    }
    
  /*  private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
   func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
       if isGenotypeOnlyAdded == true {
           genotypeScanBarcodeTextField.text = code
           
           GenotypebyDefaultbackroundWhite()
          // self.genotypeSerieTextfield.becomeFirstResponder()
           
       }else{
           scanBarcodeTextfield.text = code
           
           othersByDefaultBackroundWhite()
          // self.serieTextfield.becomeFirstResponder()
       }
       
       controller.dismiss(animated: true, completion: nil)
   }
   
   func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
       
   }
   
   func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
       controller.dismiss(animated: true, completion: nil)
   }
   */
    @IBAction func BarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
//        let viewController = makeBarcodeScannerViewController()
//        viewController.title = "Barcode Scanner"
//        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func genotypeBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        /* let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil) */
        
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var clearFormOutlet: UIButton!
    
    
    
    @IBAction func clearFromAction(_ sender: Any) {
      self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString("Are you sure you want to reset form?", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.GenotypebyDefaultScreen()
            
           
            if let breed1 = self.breedArr[0] as? GetBreedsTbl
            {
           
            self.selectBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
            }
           
            let tissueName = UserDefaults.standard.string(forKey: "genotypeTissueBttnClear")
            if UserDefaults.standard.string(forKey: "genotypeTissueBttnClear") == nil || UserDefaults.standard.string(forKey: "genotypeTissueBttnClear") == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true
                    {
                      self.genotypeTissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                    
                    
                }
//                self.genotypeTissueBttn.setTitle("Hair", for: .normal)
//                self.tissuId = 4
                
            } else {
                
                
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
                if naabFetch1!.count == 0 {
                    
                } else {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
              self.genotypeTissueBttn.setTitle(tissueName?.localized, for: .normal)
                UserDefaults.standard.set(self.genotypeTissueBttn.titleLabel!.text, forKey: "genotypeTissueBttn")
            }
            
            
            
            let inrementCheck = UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear")
            
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
              
                self.checkBarcode = false
                
                self.incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
                if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
                    if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                        self.genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                        if self.genotypeScanBarcodeTextField.text?.isEmpty == false {
                            self.GenotypebyDefaultbackroundWhite()
                        }
                    }
                }
                
            } else {
              
                self.incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
            
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBOutlet weak var nonGenotypeclearFormOutlet: UIButton!
    
    
    
    @IBAction func nonGenotypeclearFromAction(_ sender: Any) {
      self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString("Are you sure you want to reset form?", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            
            self.byDefaultSetting()
            if let breed = self.breedArrblack[0] as? GetBreedsTbl
            {
                self.genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
            }
            let tissueName = UserDefaults.standard.string(forKey: "tissueBttnClear")
            if UserDefaults.standard.string(forKey: "tissueBttnClear") == nil || UserDefaults.standard.string(forKey: "tissueBttnClear") == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true
                    {
                      self.tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                    
                    
                }
//                self.tissueBttn.setTitle("Hair", for: .normal)
//                self.tissuId = 4
            }else {
                
                
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
                if naabFetch1!.count == 0 {
                    
                } else {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
              self.tissueBttn.setTitle(tissueName?.localized, for: .normal)
                UserDefaults.standard.set(self.tissueBttn.titleLabel!.text, forKey: "tissueBttn")
            }
            
            
            
            
            
            let inrementCheck = UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear")
            
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
              
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                self.checkBarcode = false
                if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
                    if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                        self.scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                        
                        if self.scanBarcodeTextfield.text?.isEmpty == false {
                            self.othersByDefaultBackroundWhite()
                        }
                    }
                }
            } else {
                
                self.incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            self.scanBarcodeTextfield.becomeFirstResponder()
            self.scanBarcodeTextfield.backgroundColor = .white
            
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

extension BeefAnimalBrazilVCIpad:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

extension BeefAnimalBrazilVCIpad:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == importTblvIEW  {
            
            
            return importListArray.count
        }
        //  MARK: - Genotype
        if btnTag == 10 {
            return self.tissueArr.count
        }else if btnTag == 116
        {
          if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
           {
            return self.tempbreedarraynames2.count
          }
           else
           {
          
             return self.breedArr.count
           }
            
            
        }
        
        else if btnTag == 200 {
            return self.genderArray.count
        }
        
        else if btnTag == 210 {
            return self.genderArray.count
        }
        
        else if btnTag == 117
        {
            
            return self.breedArrblack.count
        }
        else if btnTag == 20 {
            
            return self.priorityBreeding.count
            
        } else  if btnTag == 40 {
            return self.tissueArr.count
        } else  if btnTag == 50 {
          return self.tertiaryBreeding.count
      }
      else {
            return self.secondaryBreeding.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        if tableView == importTblvIEW {
            
            let cell :ImportListCell = importTblvIEW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImportListCell

            cell.listNameLabel.text = importListArray[indexPath.row].listName
            cell.listNameDescLbl.text = importListArray[indexPath.row].listDesc
            return cell
        }
        //  MARK: - Genotype
        
         if btnTag == 200 {
            let gender = self.genderArray[indexPath.row] as! String
            cell.textLabel?.text = gender
            return cell
            
        }
        
        if btnTag == 210 {
           let gender = self.genderArray[indexPath.row] as! String
           cell.textLabel?.text = gender
           return cell
           
       }
        
        if btnTag == 10 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId =  Int(tissue.sampleId)
         
          cell.textLabel?.text = tissue.sampleName?.localized
              
            
            return cell
            
        }
        else if btnTag == 116
        {
           // breedArrblack
            //breedArr
//            let breedblacarrayname = [String]()
//            for i in breedArrblack.count
//            {
//                breedblacarrayname.append(breedArrblack[i].)
//            }
            
           
           if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
               //let breednew = tempbreedarraynames2[indexPath.row] as! GetBreedsTbl
               cell.textLabel?.text = tempbreedarraynames2[indexPath.row]
               breedId = tempbreedarraynames1[indexPath.row]

               return cell
           }
            else
            {
                let breed = breedArr[indexPath.row] as! GetBreedsTbl
                cell.textLabel?.text = breed.threeCharCode
                breedId = breed.breedId!
                return cell
            }
            
          
        }
        else if btnTag == 117
        {
            
            let breed1 = breedArrblack[indexPath.row] as! GetBreedsTbl
            cell.textLabel?.text = breed1.threeCharCode
            breedId = breed1.breedId!
            return cell
          
        }
        else if btnTag == 20 {
            
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            cell.textLabel?.text = tissue.priorityBreedName
            return cell
            
        } else if btnTag == 40 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId =  Int(tissue.sampleId)
            
               
          cell.textLabel?.text = tissue.sampleName?.localized
              
            
            return cell
            
        } else if btnTag == 50 {
          let tissue = self.tertiaryBreeding[indexPath.row]  as! GetTertiaryBreedingPrograms
          cell.textLabel?.text = tissue.priorityBreedName
          return cell
      }
      else {
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetSecondaryBreedingPrograms
            cell.textLabel?.text = tissue.priorityBreedName
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        barcodeEnable = true
        
        self.nonGenoGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.nonGenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.nonGenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        
        self.GenoGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.GenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.GenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: nonGenoGenderView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoSampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoBreedTypeView, removeShadow: true)
        self.setShadowForUIView(view: GenoGenderView, removeShadow: true)
        self.setShadowForUIView(view: GenoSampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: GenoBreedTypeView, removeShadow: true)
        self.setShadowForUIView(view: primaryBreedingView, removeShadow: true)
        self.setShadowForUIView(view: secondaryBreedingView, removeShadow: true)
        self.setShadowForUIView(view: tertiaryBreedingView, removeShadow: true)
        
        if tableView == importTblvIEW {
            
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName

            var customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
            listNameString = listName ?? ""
            listId = Int(listId1)
       
           

            return
        }
        
         if btnTag == 200  {
            let gender = self.genderArray[indexPath.row]
             othersGenderString = gender
            genderString = othersGenderString
           //  maleFemaleBttn.titleLabel?.font = maleFemaleBttn.titleLabel?.font.withSize(20)
            // maleFemaleBttn.setTitleColor(.black, for: .normal)
             maleFemaleBttn.setTitle(gender, for: .normal)
            buttonbg2.removeFromSuperview()
             if gender.contains("F") {
                 UserDefaults.standard.set("F", forKey: "NonGenoGender")
             } else {
                 UserDefaults.standard.set("M", forKey: "NonGenoGender")
             }
            return
        }
        
        if btnTag == 210  {
           let gender = self.genderArray[indexPath.row]
            othersGenderString = gender
           genderString = othersGenderString
          //  maleFemaleBttn.titleLabel?.font = maleFemaleBttn.titleLabel?.font.withSize(20)
           // maleFemaleBttn.setTitleColor(.black, for: .normal)
            genotypeMaleFemaleBttn.setTitle(gender, for: .normal)
           buttonbg2.removeFromSuperview()
            if gender.contains("F") {
                UserDefaults.standard.set("F", forKey: "GenoGender")
            } else {
                UserDefaults.standard.set("M", forKey: "GenoGender")
            }
           return
       }
        
        if btnTag == 10 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            genotypeTissueBttn.setTitleColor(.black, for: .normal)
            tissuId = Int(tissue.sampleId)
            
          genotypeTissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
              
              
            
            //       UserDefaults.standard.set(tissue.sampleName, forKey: "genotypeTissueBttn")
            buttonbg2.removeFromSuperview()
            
        }
        else if btnTag == 116
        {
            
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
             {
                
                breedId = tempbreedarraynames1[indexPath.row]
                selectBreedBtn.setTitle(tempbreedarraynames2[indexPath.row], for: .normal)
             
            }
            else
            {
            let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
                       breedId = breed.breedId!
                       selectBreedBtn.setTitleColor(.black, for: .normal)
            selectBreedBtn.setTitle(breed.threeCharCode, for: .normal)
              
            }
           
                       //
                       //            UserDefaults.standard.set(breed.threeCharCode, forKey: "Beefbreed")
                       buttonbg2.removeFromSuperview()
        }
        else if btnTag == 117
        {
            let breed1 = self.breedArrblack[indexPath.row] as! GetBreedsTbl
                       breedId = breed1.breedId!
            genstarblackBreedBtn.setTitleColor(.black, for: .normal)
            genstarblackBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
                       //
                       //            UserDefaults.standard.set(breed.threeCharCode, forKey: "Beefbreed")
                       buttonbg2.removeFromSuperview()
        }
        else  if btnTag == 20 {
            
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
            priorityBreeingBtnOutlet.setTitle(tissue.priorityBreedName, for: .normal)
         
            buttonbg2.removeFromSuperview()
            
        } else if btnTag == 40 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissueBttn.setTitleColor(.black, for: .normal)
            tissuId = Int(tissue.sampleId)
           // tissueBttn.setTitle(tissue.sampleName, for: .normal)
           
              
          tissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            
              
                
            //  UserDefaults.standard.set(tissue.sampleName, forKey: "tissueBttn")
            buttonbg2.removeFromSuperview()
            
        }
      else if btnTag == 50 {
        let tissue = self.tertiaryBreeding[indexPath.row]  as! GetTertiaryBreedingPrograms
        territoryBreddingOutlet.setTitleColor(.black, for: .normal)
        territoryBreddingOutlet.setTitle(tissue.priorityBreedName, for: .normal)
       // UserDefaults.standard.set(tissue.priorityBreedName, forKey: keyValue.tertirayGenoType.rawValue)
        buttonbg2.removeFromSuperview()
      }
      else {
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetSecondaryBreedingPrograms
            secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            secondaryBreddingOutlet.setTitle(tissue.priorityBreedName, for: .normal)
      //  UserDefaults.standard.set(tissue.priorityBreedName, forKey: keyValue.secondaryGenoType.rawValue)
            buttonbg2.removeFromSuperview()
        }
    }
}



extension BeefAnimalBrazilVCIpad: UITextFieldDelegate{
    
    func setShadowForUIView(view : UIView, removeShadow : Bool) {
        if removeShadow {
            view.layer.shadowOpacity = 0
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 0
            view.layer.masksToBounds = false
        } else {
            view.layer.shadowColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).withAlphaComponent(1.0).cgColor
            view.layer.shadowOpacity = 0.7
            view.layer.shadowOffset = CGSize(width: 0, height: 1)
            view.layer.shadowRadius = 3
            view.layer.masksToBounds = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if isGenotypeOnlyAdded == false {
            
            if (textField == animalTextfield ) {
                
                animalTextfield.returnKeyType = UIReturnKeyType.done
            } else {
                serieTextfield.returnKeyType = UIReturnKeyType.next
                scanBarcodeTextfield.returnKeyType = UIReturnKeyType.next
                rGNTextfield.returnKeyType = UIReturnKeyType.next
                rGDTextfield.returnKeyType = UIReturnKeyType.next
            }
            
            
            
//            incrementalBarcodeTitleLabel.textColor = UIColor.black
//            incrementalBarcodeButton.isEnabled = true
            
            if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
                if UserDefaults.standard.value(forKey: "barcodeIncremental") as? String != scanBarcodeTextfield.text {
                   
                } else {
                    
                    
                    if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                        scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                        
                        if scanBarcodeTextfield.text?.isEmpty == false {
                            othersByDefaultBackroundWhite()
                        }
                    }}
            }
            
        } else {
            
            if (textField == genotypeAnimalNameTextfield ) {
                genotypeAnimalNameTextfield.returnKeyType = UIReturnKeyType.done
            } else {
                genotypeScanBarcodeTextField.returnKeyType = UIReturnKeyType.next
                genotypeSerieTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgnTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgdTextfield.returnKeyType = UIReturnKeyType.next
                
            }
            
            //            incrementalBarcodeTitleLabelGenoType.textColor = .black
            //            incrementalBarcodeButtonGenoType.isEnabled = true
            if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
                
                
                if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") == true {
                    if UserDefaults.standard.value(forKey: "barcodeIncremental") as? String != genotypeScanBarcodeTextField.text {
                      
                    } else {
                        
                        if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                            genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                            if genotypeScanBarcodeTextField.text?.isEmpty == false {
                                self.GenotypebyDefaultbackroundWhite()
                            }
                        }
                    }
                }}}
        
        if textField == scanBarcodeTextfield {
            viewsArray = [nonGenoSeriesView, nonGenoRGNView, nonGenoRGDView, nonGenoAnimalNameView]
            self.barcodeView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.setShadowForUIView(view: barcodeView, removeShadow: false)
            self.setShadowForUIView(view: nonGenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoAnimalNameView, removeShadow: true)
            
        }
        
        if textField == serieTextfield {
            viewsArray = [barcodeView, nonGenoRGNView, nonGenoRGDView, nonGenoAnimalNameView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.nonGenoSeriesView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: barcodeView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoSeriesView, removeShadow: false)
            self.setShadowForUIView(view: nonGenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoAnimalNameView, removeShadow: true)
        }
        
        if textField == rGNTextfield {
            viewsArray = [barcodeView, nonGenoSeriesView, nonGenoRGDView, nonGenoAnimalNameView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.nonGenoRGNView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: barcodeView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGNView, removeShadow: false)
            self.setShadowForUIView(view: nonGenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoAnimalNameView, removeShadow: true)
        }
        
        if textField == rGDTextfield {
            viewsArray = [barcodeView, nonGenoSeriesView, nonGenoRGNView, nonGenoAnimalNameView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.nonGenoRGDView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: barcodeView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGDView, removeShadow: false)
            self.setShadowForUIView(view: nonGenoAnimalNameView, removeShadow: true)
        }
        
        if textField == animalTextfield {
            viewsArray = [barcodeView, nonGenoSeriesView, nonGenoRGNView, nonGenoRGDView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.nonGenoAnimalNameView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: barcodeView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: nonGenoAnimalNameView, removeShadow: false)
        }
        
        if textField == genotypeScanBarcodeTextField {
            viewsArray = [GenoSeriesView, GenoRGNView, GenoRGDView, GenoAnimalNameView]
            self.genotypeScanBarcodeView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.setShadowForUIView(view: genotypeScanBarcodeView, removeShadow: false)
            self.setShadowForUIView(view: GenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: GenoAnimalNameView, removeShadow: true)
            
        }
        
        if textField == genotypeSerieTextfield {
            viewsArray = [genotypeScanBarcodeView, GenoRGNView, GenoRGDView, GenoAnimalNameView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.GenoSeriesView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: genotypeScanBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: GenoSeriesView, removeShadow: false)
            self.setShadowForUIView(view: GenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: GenoAnimalNameView, removeShadow: true)
        }
        
        if textField == genotypeRgnTextfield {
            viewsArray = [genotypeScanBarcodeView, GenoSeriesView, GenoRGDView, GenoAnimalNameView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.GenoRGNView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: genotypeScanBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: GenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGNView, removeShadow: false)
            self.setShadowForUIView(view: GenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: GenoAnimalNameView, removeShadow: true)
        }
        
        if textField == genotypeRgdTextfield {
            viewsArray = [genotypeScanBarcodeView, GenoSeriesView, GenoRGNView, GenoAnimalNameView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.GenoRGDView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: genotypeScanBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: GenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGDView, removeShadow: false)
            self.setShadowForUIView(view: GenoAnimalNameView, removeShadow: true)
        }
        
        if textField == genotypeAnimalNameTextfield {
            viewsArray = [genotypeScanBarcodeView, GenoSeriesView, GenoRGNView, GenoRGDView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.GenoAnimalNameView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: genotypeScanBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: GenoSeriesView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGNView, removeShadow: true)
            self.setShadowForUIView(view: GenoRGDView, removeShadow: true)
            self.setShadowForUIView(view: GenoAnimalNameView, removeShadow: false)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField == genotypeDateTextField {
            if genotypeDateTextField.text!.count == 0{
                
            }  else {
               
                if genotypeDateTextField.text?.count == 10 {
                    
                    var validate = isValidDate(dateString: genotypeDateTextField.text ?? "")
                   
                    if validate == "Correct Format" {
//                        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
//                        genotypeDOBBttn.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        genotypeDOBBttn.layer.borderColor = UIColor.red.cgColor
                      //  dateBtnOutlet.layer.borderWidth = 1
                        validateDateFlag = false
                    }
                    
                } else {
                    genotypeDOBBttn.layer.borderColor = UIColor.red.cgColor
                   // dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                }
            }
        }
        
 
                
         
        if textField == dateTextField {
            if dateTextField.text!.count == 0{
                
            }  else {
             
                if dateTextField.text?.count == 10 {
                    
                    var validate = isValidDate(dateString: dateTextField.text ?? "")
                   
                    if validate == "Correct Format" {
//                        dobView.layer.borderColor = UIColor.gray.cgColor
//                        dobView.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        dobView.layer.borderColor = UIColor.red.cgColor
                      //  dateBtnOutlet.layer.borderWidth = 1
                        validateDateFlag = false
                    }
                    
                } else {
                    dobView.layer.borderColor = UIColor.red.cgColor
                   // dateBtnOutlet.layer.borderWidth = 1
                    validateDateFlag = false
                }
            }
        }
        
        self.setShadowForUIView(view: genotypeScanBarcodeView, removeShadow: true)
        self.setShadowForUIView(view: GenoSeriesView, removeShadow: true)
        self.setShadowForUIView(view: GenoRGNView, removeShadow: true)
        self.setShadowForUIView(view: GenoRGDView, removeShadow: true)
        self.setShadowForUIView(view: GenoAnimalNameView, removeShadow: true)
        self.setShadowForUIView(view: barcodeView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoSeriesView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoRGNView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoRGDView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoAnimalNameView, removeShadow: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //  MARK: - Genotype
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        var samplename = String()
        let ob =  fetchAllData(entityName: "BeefAnimalMaster")
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:scanBarcodeTextfield.text!, farmId: "", animalbarCodeTag: "", offPermanentId: "", offDamId: rGDTextfield.text!, offsireId: serieTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        let genotypeAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:genotypeScanBarcodeTextField.text!, farmId: "", animalbarCodeTag: genotypeAnimalNameTextfield.text!, offPermanentId: rGNTextfield.text!, offDamId: genotypeRgdTextfield.text!, offsireId: genotypeSerieTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        if isautoPopulated == false{
            //            if animalData.count > 0 {
            //                isautoPopulated = true
            //                barcodeflag = false
            //                barAutoPopu = true
            //                updateOrder = true
            //                var data =  animalData.lastObject as! BeefAnimalMaster
            //                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            //                ////////start
            //                let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
            //                animalId1 = Int(data.animalId)
            //
            //                barcodeView.layer.borderColor = UIColor.gray.cgColor
            //                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            //                var formatter = DateFormatter()
            //
            //                if dateStr == "MM"{
            //                    var dateVale = ""
            //                    let values = data.date!.components(separatedBy: "/")
            //                    if values.count > 1{
            //                        let date = values[0]
            //                        let month = values[1]
            //                        let year = values[2]
            //                        dateVale = month + "/" + date + "/" + year
            //                    }
            //                    dateBttnOutlet.setTitle(dateVale, for: .normal)
            //                    formatter.dateFormat = "MM/dd/yyyy"
            //                }
            //                else {
            //                    var dateVale = ""
            //                    let values = data.date!.components(separatedBy: "/")
            //                    if values.count > 1{
            //                        let date = values[0]
            //                        let month = values[1]
            //                        let year = values[2]
            //                        dateVale = date + "/" + month + "/" + year
            //                    }
            //                    dateBttnOutlet.setTitle(dateVale, for: .normal)
            //                    formatter.dateFormat = "dd/MM/yyyy"
            //                }
            //                if dateBttnOutlet.titleLabel!.text != nil{
            //                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
            //                }
            //                else{
            //                    self.selectedDate = Date()
            //                }
            //                let dates =  formatter.string(from: selectedDate)
            //
            //                if data.orderstatus == "false"{
            //                    scanBarcodeTextfield.text =  data.animalTag
            //                }
            //                //scanBarcodeTextfield.text = data.animalTag
            //                rGNTextfield.text = data.offPermanentId
            //                serieTextfield.text = data.offsireId
            //                rGDTextfield.text = data.offDamId
            //
            //                //                animalNameTextfield.text  = data.anima
            //
            //                tissueBttn.setTitleColor(.black, for: .normal)
            //                animalTextfield.text = data.animalbarCodeTag
            //                tissueBttn.setTitle(data.tissuName, for: .normal)
            //                UserDefaults.standard.set(data.tissuName, forKey: "tissueBttn")
            //
            //                breedId = String(data.breedId ?? "")
            //                samplename = data.tissuName!
            //                let pvidAA = data.providerId
            //                UserDefaults.standard.set(breedId, forKey: "Beefbreed")
            //
            //                if data.gender == "Male" {
            //
            //                    self.maleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
            //                    genderToggleFlag = 1
            //                    genderString = "Male"
            //
            //                } else {
            //
            //                    self.maleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
            //                    genderToggleFlag = 0
            //                    genderString = "Female"
            //
            //                }
            //
            //                tissuId = Int(data.tissuId)
            //                textField.resignFirstResponder()
            //                dateBttnOutlet.setTitleColor(.black, for: .normal)
            //                statusOrder = false
            //                messageCheck = false
            //                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            //                if adata.count > 0{
            //                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
            //                    idAnimal = Int(animal.animalId)
            //                    //statusOrder = true
            //                    messageCheck = true
            //                }
            //
            //                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
            //                    requiredflag = 0
            //                }
            //                else{
            //                    if isautoPopulated == true{
            //                        requiredflag = 1
            //                    }
            //                    else{
            //                        requiredflag = 0
            //                    }
            //                }
            //                if requiredflag == 1{
            //                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
            //                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            //                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
            //                }
            //                else{
            //                    serieTextfield.layer.borderColor = UIColor.red.cgColor
            //                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
            //                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
            //                }
            //
            //            }
            //            if genotypeAnimalData.count > 0 {
            //                isautoPopulated = true
            //                barAutoPopu = true
            //                updateOrder = true
            //                var data =  genotypeAnimalData.lastObject as! BeefAnimalMaster
            //                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            //                ////////start
            //                let animalTbl =  fetchAllData(entityName: Entities.beefAnimalAddTblEntity)
            //                animalId1 = Int(data.animalId)
            //
            //                /////////end
            //
            //
            //                genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
            //                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
            //                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            //                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
            //                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            //                var formatter = DateFormatter()
            //
            //                if dateStr == "MM"{
            //                    var dateVale = ""
            //                    let values = data.date!.components(separatedBy: "/")
            //                    if values.count > 1 {
            //                        let date = values[0]
            //                        let month = values[1]
            //                        let year = values[2]
            //                        dateVale = month + "/" + date + "/" + year
            //                    }
            //                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
            //                    formatter.dateFormat = "MM/dd/yyyy"
            //                }
            //                else {
            //                    var dateVale = ""
            //                    let values = data.date!.components(separatedBy: "/")
            //                    if values.count > 1 {
            //                        let date = values[0]
            //                        let month = values[1]
            //                        let year = values[2]
            //                        dateVale = date + "/" + month + "/" + year
            //                    }
            //                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
            //                    formatter.dateFormat = "dd/MM/yyyy"
            //                }
            //                if  genotypeDOBBttn.titleLabel!.text != nil {
            //                    if  genotypeDOBBttn.titleLabel?.text != "" && formatter.date(from: genotypeDOBBttn.titleLabel?.text ?? "") != nil {
            //                        self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel?.text ?? "")!
            //                    }
            //
            //                }
            //                else{
            //                    self.selectedDate = Date()
            //                }
            //                let dates =  formatter.string(from: selectedDate)
            //                if data.orderstatus == "false"{
            //                    genotypeScanBarcodeTextField.text = data.animalTag
            //                }
            //
            //                genotypeRgnTextfield.text = data.offPermanentId
            //                genotypeSerieTextfield.text = data.offsireId
            //                genotypeRgdTextfield.text = data.offDamId
            //                genotypeAnimalNameTextfield.text = data.animalbarCodeTag
            //                //                animalNameTextfield.text  = data.anima
            //
            //                priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
            //                genotypeTissueBttn.setTitleColor(.black, for: .normal)
            //                priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
            //                genotypeTissueBttn.setTitle(data.tissuName, for: .normal)
            //                secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            //                secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
            //                UserDefaults.standard.set(data.tissuName, forKey: "BeefInheritTsu")
            //
            //                breedId = String(data.breedId ?? "")
            //                samplename = data.tissuName!
            //                let pvidAA = data.providerId
            //                // UserDefaults.standard.set(breedId, forKey: "InheritBeefbreed")
            //                UserDefaults.standard.set(data.sireIDAU, forKey: "priorityBreedName")
            //                if data.gender == "Male" {
            //
            //                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
            //                    genderToggleFlag = 1
            //                    genderString = "Male"
            //
            //
            //                } else {
            //
            //                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
            //                    genderToggleFlag = 0
            //                    genderString = "Female"
            //
            //                }
            //                tissuId = Int(data.tissuId)
            //                textField.resignFirstResponder()
            //                genotypeDOBBttn.setTitleColor(.black, for: .normal)
            //                statusOrder = false
            //                messageCheck = false
            //                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            //                if adata.count > 0{
            //                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
            //                    idAnimal = Int(animal.animalId)
            //                    //statusOrder = true
            //                    messageCheck = true
            //                }
            //                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
            //                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
            //                        requiredflag = 1
            //                    }else{
            //                        requiredflag = 0
            //                    }
            //
            //                }
            //                else{
            //                    if isautoPopulated == true{
            //                        requiredflag = 1
            //                    }
            //                    else{
            //                        requiredflag = 0
            //                    }
            //                }
            //                if requiredflag == 1{
            //                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
            //                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
            //                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            //                }
            //                else{
            //                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
            //                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
            //                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
            //                }
            //            }
        }
        else{
            
            if scanBarcodeTextfield.text!.count > 0 {
                othersByDefaultBackroundWhite()
            }
            else{
                OtherbyTextfieldGray()
            }
        }
        if genotypeScanBarcodeTextField.text!.count > 0 {
            
            GenotypebyDefaultbackroundWhite()
            
        } else {
            
            GenotypebyDefaultScreen()
            
        }
        
        
        
        if (textField == self.genotypeScanBarcodeTextField) {
            
            if genotypeScanBarcodeTextField.text == ""{
                
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
                
                self.genotypeSerieTextfield.becomeFirstResponder()
                
            }
            
            self.genotypeSerieTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeSerieTextfield) {
            requiredflag = 1
            if genotypeSerieTextfield.text == ""{
                
                //  genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    GenoRGNView.layer.borderColor = UIColor.red.cgColor
                    GenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    GenoRGNView.layer.borderColor = UIColor.red.cgColor
                    GenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
                
            }
            
            self.genotypeRgnTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeRgnTextfield) {
            requiredflag = 1
            if genotypeRgnTextfield.text == ""{
                
                // genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    GenoRGNView.layer.borderColor = UIColor.red.cgColor
                    GenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
            } else {
                
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    GenoRGNView.layer.borderColor = UIColor.red.cgColor
                    GenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
                
            }
            
            self.genotypeRgdTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeRgdTextfield) {
            requiredflag = 1
            if genotypeRgdTextfield.text == ""{
                
                // genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    GenoRGNView.layer.borderColor = UIColor.red.cgColor
                    GenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
            } else {
                
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    GenoRGNView.layer.borderColor = UIColor.red.cgColor
                    GenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
            }
            
            self.genotypeAnimalNameTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeAnimalNameTextfield) {
            
            self.genotypeAnimalNameTextfield.resignFirstResponder()
            
        }
        if scanBarcodeTextfield.text!.count > 0 {
            
            othersByDefaultBackroundWhite()
        } else {
            
            OtherbyTextfieldGray()
            
        }
        //  MARK: - Othertype
        
        if (textField == self.scanBarcodeTextfield) {
            
            if scanBarcodeTextfield.text == ""{
                
                barcodeView.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                
                self.genotypeSerieTextfield.becomeFirstResponder()
                
            }
            
            self.serieTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.serieTextfield) {
            requiredflag = 1
            if serieTextfield.text == ""{
                
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                    nonGenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                    nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                
            }
            
            self.rGNTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.rGNTextfield) {
            requiredflag = 1
            if rGNTextfield.text == ""{
                
                // rGNTextfield.layer.borderColor = UIColor.red.cgColor
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                    nonGenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                    nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            self.rGDTextfield.becomeFirstResponder()
            
        }
            
            
            
        else if (textField == self.rGDTextfield) {
            requiredflag = 1
            if rGDTextfield.text == ""{
                
                // rGDTextfield.layer.borderColor = UIColor.red.cgColor
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                    nonGenoSeriesView.layer.borderColor = UIColor.red.cgColor
                    nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                    nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            
            self.animalTextfield.becomeFirstResponder()
        }
            
            
            
        else if (textField == self.animalTextfield) {
            self.animalTextfield.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        //  MARK: - Genotype
   //     barcodeflag = true
        
        if barAutoPopu == false {
            barcodeflag = true
        }else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                if textField == genotypeSerieTextfield || textField == genotypeRgnTextfield || textField == genotypeAnimalNameTextfield || textField == genotypeRgdTextfield ||  textField == serieTextfield || textField == rGNTextfield || textField == rGDTextfield || textField == animalTextfield  {
                    barcodeEnable = true
                }
            }
        }
      if textField == animalTextfield {
        guard range.location == 0 else {
                return true
            }

            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
        
      }  else if textField  == genotypeAnimalNameTextfield {
        guard range.location == 0 else {
                return true
            }

            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
        
      } else {
        if  (string == " ") {
            return false
        }
      }
        
        
        if textField == genotypeScanBarcodeTextField {
            self.defaultIncrementalBarCodeSetting_GenoType()
            
            let currentString: NSString = genotypeScanBarcodeTextField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                    checkBarcode = false
                    
                } else {
                    //incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
                    incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
                    
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    checkBarcode = true
                    
                }
            }
            
        }
        if textField == genotypeRgdTextfield
        {
            let currentString: NSString = genotypeRgdTextfield.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            genovalidateRGD = true
        }
        if textField == rGDTextfield
        {
            let currentString: NSString = rGDTextfield.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            validateRGD = true
        }
        
        if textField == scanBarcodeTextfield {
            self.defaultIncrementalBarCodeSetting()
            
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
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                    
                    // incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    checkBarcode = true
                    
                }
            }
            
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
              
                if textField == scanBarcodeTextfield{
                    barcodeflag = true
                    if scanBarcodeTextfield.text!.count == 1 {
                        self.isBarcodeAutoIncrementedEnabled = false
                        // UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                        incrementalBarcodeTitleLabel.textColor = .gray
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                        
                        OtherbyTextfieldGray()
                    } else {
                        othersByDefaultBackroundWhite(isBeginEditing: true)
                    }
                }
                
                if textField == genotypeScanBarcodeTextField{
                    barcodeflag = true
                    if genotypeScanBarcodeTextField.text!.count == 1 {
                        
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeTitleLabelGenoType.textColor = .gray
                        incrementalBarcodeButtonGenoType.isEnabled = false
                        incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
                        
                        
                        GenotypebyDefaultbackroundGray()
                    } else {
                        GenotypebyDefaultbackroundWhite(isBeginEditing: true)
                    }
                }
                if textField == genotypeRgdTextfield
                {
                    let currentString: NSString = genotypeRgdTextfield.text! as NSString
                    let newString: NSString =
                        currentString.replacingCharacters(in: range, with: string) as NSString
                    genovalidateRGD = true
                }
                if textField == rGDTextfield
                {
                    let currentString: NSString = rGDTextfield.text! as NSString
                    let newString: NSString =
                        currentString.replacingCharacters(in: range, with: string) as NSString
                    validateRGD = true
                }
                return true
            } else {
                
                if textField == genotypeScanBarcodeTextField{
                    GenotypebyDefaultbackroundWhite(isBeginEditing: true)
                }
                
                if textField == scanBarcodeTextfield{
                    othersByDefaultBackroundWhite(isBeginEditing: true)
                }
            }
            if textField == genotypeDateTextField {
                
                if genotypeDateTextField.text?.count == 2 || genotypeDateTextField.text?.count == 5{
                    genotypeDateTextField.text?.append("/")
                }
                if genotypeDateTextField.text?.count == 10 {
                    return false
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
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
          //  barcodeflag = true
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
        if textField == scanBarcodeTextfield || textField == genotypeScanBarcodeTextField {//|| textField == rGNTextfield || textField == genotypeRgnTextfield || textField == rGDTextfield || textField == genotypeRgdTextfield || textField == serieTextfield || textField == genotypeSerieTextfield || textField == animalTextfield{
            
            let ACCEPTABLE_CHARACTERS = "+?%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
                return false
            }
        }
        return true
    }
    
}
extension BeefAnimalBrazilVCIpad : SideMenuUI,objectPickCartScreen{
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
            OtherbyTextfieldGray()
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
extension BeefAnimalBrazilVCIpad : AnimalMergeProtocol{
    func refreshUI() {
        
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) as? String == keyValue.genoTypeOnly.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue{
            
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid ?? 6)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.genotypeCrossBtnOutlet.isHidden = true
                self.genotypeMergeListBtnOulet.isHidden = true
                self.genoMergeView.isHidden = true
                self.cartView.isHidden = true
                
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.genotypeCrossBtnOutlet.isHidden = false
                self.cartView.isHidden = false
                self.genotypeMergeListBtnOulet.isHidden = false
                self.genoMergeView.isHidden = false
            }
            
           
            
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 0)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            } else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                genotypeMergeListBtnOulet.isHidden = true
                genotypeCrossBtnOutlet.isHidden = true
                self.genoMergeView.isHidden = true
            }
            
            
        } else {
            
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid ?? 6)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.nongenotypeCrossBtnOutlet.isHidden = true
                self.nongenotypeMergeListBtnOulet.isHidden = true
                self.nonGenoMergeView.isHidden = true
                self.cartView.isHidden = true

            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.nongenotypeCrossBtnOutlet.isHidden = false
                self.cartView.isHidden = false
                self.nongenotypeMergeListBtnOulet.isHidden = false
                self.nonGenoMergeView.isHidden = false
            }

          


            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1

                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)

                }
            }else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                nongenotypeMergeListBtnOulet.isHidden = true
                nongenotypeCrossBtnOutlet.isHidden = true
                self.nonGenoMergeView.isHidden = true
            }
        }}
}

//MARK: CREATE Beef Datalist
private typealias DataListCartHelper = BeefAnimalBrazilVCIpad
private extension DataListCartHelper {
  
  func fetchDatalistDetailbyName(listName: String) -> [DataEntryList] {
    let fetchDataEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(custmerId ?? 0),listName: listName ,productName:"Beef") as! [DataEntryList]
    return fetchDataEntry
  }
  
    func CheckCartanimalCount() {
      //TODO:  checked if for this customer animal count is greater than zero
      let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid ?? 0)
      if viewAnimalArray.count > 0{
        createDataList()
      }
      
    }
  func createDataList(){
    print("pvid =", pvid)
    
   
    let listName = orderingDataListViewModel.makeListName(custmerId: custmerId ?? 0, providerID: pvid ?? 0)
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
        var fetchDatEntry = [DataEntryList]()
        var productType  = ""
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
              productType = keyValue.genoTypeOnly.rawValue
             
            }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
              productType = keyValue.genoTypeStarBlack.rawValue
              
            }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue {
              productType = keyValue.genStarBlack.rawValue
              
            }
            else {
              productType = keyValue.nonGenoType.rawValue
              
            }
        fetchDatEntry =  fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(custmerId ?? 0),listName: listName ,productName:"Beef") as! [DataEntryList]
        
          if fetchDatEntry.count == 0 {
            // self.view.makeToast(NSLocalizedString("List created successfully.", comment: ""), duration: 8, position: .bottom)
            
            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(custmerId ?? 0),listDesc: "",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: pvid , productType: productType, productName: "Beef")
            
            SaveAnimalDatInList(list_ID: Int64(animalID1), animalID: animalID1)
            
          } else {
            let listIdGet = fetchDatEntry[0].listId
            // save animal in existing listName
            SaveAnimalDatInList(list_ID: listIdGet, animalID: animalID1)
          }
        
        
      }
      
      
    }
    
  }
  func SaveAnimalDatInList(list_ID:Int64,animalID:Int){
   
    
      let animals = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid")) as! [BeefAnimaladdTbl]
      
      for data in animals {
                let animalCount =  fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId ?? 0,listId:list_ID,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))

        
         
        let animalData = fetchAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: data.animalTag ?? "", sireId: data.offsireId ?? "", animalBarCode: data.animalbarCodeTag ?? "", userId: 1, orderStatus: "false", listID: Int(list_ID), providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
       
        
        if animalData.count == 0 {
          saveAnimalInDataBeefAnimalGlobal(listID: list_ID, animalDetails: data, animalID: animalID)
        }
        
      }
   
  }
  
  
  func saveAnimalInDataBeefAnimalGlobal(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
   
    
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
                                  orderId: 1,
                                  orderSataus:"false",
                                  breedId:animalDetails.breedId ?? "",
                                  isSync:"false",
                                  providerId: Int(animalDetails.providerId),
                                  tissuId: Int(animalDetails.tissuId),
                                  sireIDAU: animalDetails.sireIDAU ?? "",
                                  nationHerdAU: animalDetails.nationHerdAU ?? "",
                                  userId: userId,
                                  udid:animalDetails.udid ?? "",
                                  animalId: animalID,
                                  productId:Int(animalDetails.productId),
                                  custId: Int(animalDetails.custmerId),
                                  listId: listID,
                                  serverAnimalId: "",
                                  tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
  
  
}
//MARK: Auto Import Datalist
private typealias AutoImportDataListHelper = BeefAnimalBrazilVCIpad
private extension AutoImportDataListHelper {
  // MARK: AUTO IMPORT ANIMAL FROM DATALIST
  func checkUserDataListName(){
    // checked list name - rajni.raswant@mobileprogramming.com&customerID&species
    // if exist auto import that data in cart meanse save that data in Entities.animalAddTblEntity and "AnimalmasterTbl"
    let orderingDataList = OrderingDataListViewModel()
    let listName = orderingDataList.makeListName(custmerId: self.custmerId, providerID: pvid)
    let fetchDatEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId),listName:listName ,productName:"Beef") as! [DataEntryList]
    if fetchDatEntry.count > 0{
   //   genotypeCrossBtnOutlet.isHidden = true
     
      var screenPerference = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
//          if screenPerference == keyValue.officialId.rawValue {
      let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: "DataEntryBeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry.first?.listId ?? 0), custmerId: Int64(custmerId ), providerId: pvid )
        if fetchData11.count != 0 {
          
          for i in 0...fetchData11.count - 1 {
            
            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
           
              saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity,
                                            animalTag: dataGet.animalTag ?? "",
                                            barCodetag: dataGet.animalbarCodeTag ?? "" ,
                                            date: dataGet.date ?? ""  ,
                                            damId: dataGet.offDamId ?? "",
                                            sireId: dataGet.offsireId ?? "" ,
                                            gender: dataGet.gender ?? "",
                                            update: "true",
                                            permanentId:dataGet.offPermanentId ?? "",
                                            tissuName: dataGet.tissuName ?? "",
                                            breedName: dataGet.breedName ?? "",
                                            et: dataGet.eT ?? "",
                                            farmId: dataGet.farmId ?? "",
                                            orderId: autoD,
                                            orderSataus:"false",
                                            breedId:dataGet.breedId ?? "",
                                            isSync:"false",
                                            providerId: pvid,
                                            tissuId: Int(dataGet.tissuId),
                                            sireIDAU: dataGet.sireIDAU ?? "",
                                            nationHerdAU: dataGet.nationHerdAU ?? "",
                                            userId: userId,
                                            udid:dataGet.udid ?? "",
                                            animalId: Int(dataGet.animalId),
                                            productId:Int(dataGet.productId),
                                            custId: Int(dataGet.custmerId),
                                            listId: fetchDatEntry.first?.listId ?? 0,
                                            serverAnimalId: "",
                                            tertiaryGeno: dataGet.tertiaryGeno ?? "")
              UserDefaults.standard.setValue(dataGet.breedName, forKey: "Beefbreed")
              UserDefaults.standard.setValue(dataGet.tissuName, forKey: "Beeftsu")
              genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
              genstarblackBreedBtn.setTitle(dataGet.breedName ?? "", for: .normal)
           
            autoSaveProductandsubProduct(dataGet: dataGet)
            //}
          }
        }
      
    }
 //   genotypeCrossBtnOutlet.isHidden = true
    
  }
  //MARK: AUTOSAVE Product and subProduct
  func autoSaveProductandsubProduct(dataGet:DataEntryBeefAnimaladdTbl){
    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
    
    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
   
    for k in 0 ..< animalData.count{
        
        let animalId = animalData[k] as! BeefAnimaladdTbl
        
        for i in 0 ..< product.count {
            
            let data = product[i] as! GetProductTblBeef
            
            saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
            
            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
          let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
            for j in 0 ..< addonArr.count {
                
                let addonDat = addonArr[j] as! GetAdonTbl
                if data12333.count > 0 {
                    if addonDat.adonName == "BVDV" {//76 ||  addonDat.adonId == 92 ||  addonDat.adonId == 95 {
                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                    }
                    else {
                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
                else {
                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
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

extension BeefAnimalBrazilVCIpad: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        print("scanned QR value -> \(qrValue)")
        
        if isGenotypeOnlyAdded == true {
            genotypeScanBarcodeTextField.text = qrValue
            
            GenotypebyDefaultbackroundWhite()
           // self.genotypeSerieTextfield.becomeFirstResponder()
            
        }else{
            scanBarcodeTextfield.text = qrValue
            
            othersByDefaultBackroundWhite()
           // self.serieTextfield.becomeFirstResponder()
        }
        
        
    }
    
    
    
}

extension BeefAnimalBrazilVCIpad : ImportListProtocol {
    func importList(listNameString: String, listId: Int) {
        self.listNameString = listNameString
        self.listId = listId
          if listId == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please select list to import.", comment: "") )
            return
          }
          
          
          
          if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue{
            
            let animalCountCheck = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId ?? 0,listId:Int64(self.listId ),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            
            if animalCountCheck.count == 0 {
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
      //        importListMainView.isHidden = true
      //        importBackroundView.isHidden = true
              return
            }
            
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            if aData.count > 0 {
              for k in 0 ..< aData.count{
                let data1 = aData[k] as! BeefAnimaladdTbl
                let earTag = data1.animalTag
                
                let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ?? 0),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                
                
                if dataEntryVALE.count > 0 {
                  
                  self.conflictArr.append(contentsOf: dataEntryVALE)
                  
                }
              }
              if conflictArr.count > 0 {
                let count1 = conflictArr.count
                let alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
                
                let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                  
      //            self.importBackroundView.isHidden = true
      //            self.importListMainView.isHidden = true
                  
                })
                alert.addAction(cancel)
                
                let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                  
                  let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                  if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                      let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                      
                      
                      
                      let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                      if fetchCountGirlando.count == 0 {
                        
                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                        
                        createDataList()
                        
                        self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                        
                        let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                        let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                        
                        for k in 0 ..< animalData.count{
                          
                          let animalId = animalData[k] as! BeefAnimaladdTbl
                          
                          for i in 0 ..< product.count {
                            
                            let data = product[i] as! GetProductTblBeef
                            beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                            
                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                            if addonArr.count > 0 {
                              for j in 0 ..< addonArr.count {
                                
                                let addonDat = addonArr[j] as! GetAdonTbl
                                
                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                
                                //  msgShow()
                              }
                            }
                            else {
                              // msgShow()
                            }
                          }
                        }
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                        self.genotypeCrossBtnOutlet.isHidden = false
                        //    let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                        //      self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                        UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                        UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                  //      genotypeImportFromBtnBtnOutlet.isEnabled = true
      //                  self.importBackroundView.isHidden = true
      //                  self.importListMainView.isHidden = true
                        self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                        
                        
                        if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                          
                          let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                          let listObject = fetchList.object(at: 0) as? DataEntryList
                          let listDescr = listObject?.listDesc
                          
                          saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                          
                        }
                        
                        var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 0)
                        if fetchObj.count != 0 {
                          
                          let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                          let obj = objectFetch?.listName
                          let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                          
                          if fetchAllMergeDta == 0 {
                            let fetchNameDisplay = String(obj ?? "")
                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                            genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                            genotypeMergeListBtnOulet.isHidden = false
                              self.genoMergeView.isHidden = false
                          } else {
                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                            genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                            genotypeMergeListBtnOulet.isHidden = false
                              self.genoMergeView.isHidden = false
                          }
                        }
                        
                      }
                    }
                  }
                })
                alert.addAction(ok)
      //          importListMainView.isHidden = true
      //          importBackroundView.isHidden = true
                
                DispatchQueue.main.async(execute: {
                  self.present(alert, animated: true)
                })
                
              } else {
                
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                if fetchData11.count != 0 {
                  
                  for i in 0...fetchData11.count - 1 {
                    let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                    
                    
                    
                    var fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                    if fetchCountGirlando.count == 0 {
                      
                      saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                      createDataList()
                      
                      self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                      UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                      
                      
                      let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                      let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                      let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                      
                      for k in 0 ..< animalData.count{
                        
                        let animalId = animalData[k] as! BeefAnimaladdTbl
                        
                        for i in 0 ..< product.count {
                          
                          let data = product[i] as! GetProductTblBeef
                          beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                          
                          
                          let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                          if addonArr.count > 0 {
                            for j in 0 ..< addonArr.count {
                              
                              let addonDat = addonArr[j] as! GetAdonTbl
                              
                              saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                              
                              // msgShow()
                            }
                          }
                          else {
                            //msgShow()
                          }
                        }
                      }
                      let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                      self.genotypeCrossBtnOutlet.isHidden = false
                      //  let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                      //  self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                      UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                      UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                   //   genotypeImportFromBtnBtnOutlet.isEnabled = true
                  //    self.importBackroundView.isHidden = true
                      self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                      
                      //self.importListMainView.isHidden = true
                      
                      if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                        
                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                        let listObject = fetchList.object(at: 0) as? DataEntryList
                        let listDescr = listObject?.listDesc
                        
                        saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                        
                      }
                      
                      var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6)
                      if fetchObj.count != 0 {
                        
                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                        let obj = objectFetch?.listName
                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                        
                        if fetchAllMergeDta == 0 {
                          let fetchNameDisplay = String(obj ?? "")
                          let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                          genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                          genotypeMergeListBtnOulet.isHidden = false
                            self.genoMergeView.isHidden = false
                        } else {
                          let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                          let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                          genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                          genotypeMergeListBtnOulet.isHidden = false
                            self.genoMergeView.isHidden = false
                        }
                      }
                    
                    }
                    
                  }
                  
                }
              }
            } else {
              
              let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
              if fetchData11.count != 0 {
                
                for i in 0...fetchData11.count - 1 {
                  let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                  
                  
                  
                  var fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                  if fetchCountGirlando.count == 0 {
                    
                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                    
                    createDataList()
                    
                    self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                    
                    
                    
                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                    let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                    let product = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                    
                    for k in 0 ..< animalData.count{
                      
                      let animalId = animalData[k] as! BeefAnimaladdTbl
                      
                      for i in 0 ..< product.count {
                        
                        let data = product[i] as! GetProductTblBeef
                        beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                        
                        
                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                        if addonArr.count > 0 {
                          for j in 0 ..< addonArr.count {
                            
                            let addonDat = addonArr[j] as! GetAdonTbl
                            
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            
                            //  msgShow()
                          }
                        }
                        else {
                          // msgShow()
                        }
                        
                      }
                    }
                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                    self.genotypeCrossBtnOutlet.isHidden = false
                    // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                    //  self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                  //  genotypeImportFromBtnBtnOutlet.isEnabled = true
      //              self.importBackroundView.isHidden = true
      //              self.importListMainView.isHidden = true
                    self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                   
                    if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                      
                      let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                      let listObject = fetchList.object(at: 0) as? DataEntryList
                      let listDescr = listObject?.listDesc
                      
                      saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                      
                    }
                    
                    var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 0)
                    if fetchObj.count != 0 {
                      
                      let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                      let obj = objectFetch?.listName
                      let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                      
                      if fetchAllMergeDta == 0 {
                        let fetchNameDisplay = String(obj ?? "")
                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                        genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                        genotypeMergeListBtnOulet.isHidden = false
                          self.genoMergeView.isHidden = false
                      } else {
                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                        genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                        genotypeMergeListBtnOulet.isHidden = false
                          self.genoMergeView.isHidden = false
                      }
                    }
                    
                  }
                }
              }
            }
          } else {
            // Nongenotype
            let animalCountCheck = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId ?? 0,listId:Int64(self.listId ?? 0),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            
            if animalCountCheck.count == 0 {
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
      //        importListMainView.isHidden = true
      //        importBackroundView.isHidden = true
              return
            }
            
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            if aData.count > 0 {
              for k in 0 ..< aData.count{
                let data1 = aData[k] as! BeefAnimaladdTbl
                let earTag = data1.animalTag
                
                let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ?? 0),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                
                
                if dataEntryVALE.count > 0 {
                  
                  self.conflictArr.append(contentsOf: dataEntryVALE)
                  
                }
              }
              if conflictArr.count > 0 {
                var count1 = conflictArr.count
                var alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
                
                let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                  
      //            self.importBackroundView.isHidden = true
      //            self.importListMainView.isHidden = true
                  
                })
                alert.addAction(cancel)
                
                let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                  
                  
                  let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                  if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                      let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                      
                      
                      
                      let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                      if fetchCountGirlando.count == 0 {
                        
                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                        
                        createDataList()
                        
                        self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                        
                        
                        
                        
                        let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                        let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                        
                        
                        for k in 0 ..< animalData.count{
                          
                          let animalId = animalData[k] as! BeefAnimaladdTbl
                          
                          for i in 0 ..< product.count {
                            
                            let data = product[i] as! GetProductTblBeef
                            
                            beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                            
                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                            if addonArr.count > 0 {
                              
                              for j in 0 ..< addonArr.count {
                                
                                let addonDat = addonArr[j] as! GetAdonTbl
                                
                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                
                                //    msgShow()
                              }
                            }
                            else {
                              // msgShow()
                            }
                          }
                        }
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                        self.nongenotypeCrossBtnOutlet.isHidden = false
                        //  let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                        // self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                        UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                        UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                     //   nongenotypeImportFromBtnBtnOutlet.isEnabled = true
      //                  self.importBackroundView.isHidden = true
      //                  self.importListMainView.isHidden = true
                        self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                        if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                          
                          let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                          let listObject = fetchList.object(at: 0) as? DataEntryList
                          let listDescr = listObject?.listDesc
                          
                          saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                          
                        }
                        
                        var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6 )
                        if fetchObj.count != 0 {
                          
                          let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                          let obj = objectFetch?.listName
                          let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                          
                          if fetchAllMergeDta == 0 {
                            let fetchNameDisplay = String(obj ?? "")
                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                            nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                            nongenotypeMergeListBtnOulet.isHidden = false
                              self.nonGenoMergeView.isHidden = false
                          } else {
                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                            nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                            nongenotypeMergeListBtnOulet.isHidden = false
                              self.nonGenoMergeView.isHidden = false
                          }
                        }
                      }
                    }
                  }
                })
                alert.addAction(ok)
      //          importListMainView.isHidden = true
      //          importBackroundView.isHidden = true
                
                DispatchQueue.main.async(execute: {
                  self.present(alert, animated: true)
                })
                
              } else {
                
                
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                if fetchData11.count != 0 {
                  
                  for i in 0...fetchData11.count - 1 {
                    let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                    
                    
                    
                    let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                    if fetchCountGirlando.count == 0 {
                      
                      saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                      
                      createDataList()
                      
                      self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                      UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                      
                      
                      
                      let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                      let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                      let product = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                      
                      for k in 0 ..< animalData.count{
                        
                        let animalId = animalData[k] as! BeefAnimaladdTbl
                        
                        for i in 0 ..< product.count {
                          
                          let data = product[i] as! GetProductTblBeef
                          
                          beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                          
                          let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                          if addonArr.count > 0 {
                            
                            for j in 0 ..< addonArr.count {
                              
                              let addonDat = addonArr[j] as! GetAdonTbl
                              
                              saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                              
                              //   msgShow()
                              
                            }
                          }
                          else {
                            //msgShow()
                          }
                        }
                      }
                      let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                      self.nongenotypeCrossBtnOutlet.isHidden = false
                      // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                      //  self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                      UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                      UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                   //   nongenotypeImportFromBtnBtnOutlet.isEnabled = true
      //                self.importBackroundView.isHidden = true
      //                self.importListMainView.isHidden = true
                      self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                      if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                        
                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                        let listObject = fetchList.object(at: 0) as? DataEntryList
                        let listDescr = listObject?.listDesc
                        
                        saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                        
                      }
                      
                      var fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6 )
                      if fetchObj.count != 0 {
                        
                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                        let obj = objectFetch?.listName
                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                        
                        if fetchAllMergeDta == 0 {
                          let fetchNameDisplay = String(obj ?? "")
                          let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                          nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                          nongenotypeMergeListBtnOulet.isHidden = false
                            self.nonGenoMergeView.isHidden = false
                        } else {
                          let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                          let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                          nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                          nongenotypeMergeListBtnOulet.isHidden = false
                            self.nonGenoMergeView.isHidden = false
                        }
                      }
                    }
                  }
                }
              }
              
            }
            else {
              
              let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
              if fetchData11.count != 0 {
                
                for i in 0...fetchData11.count - 1 {
                  let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                  
                  
                  
                  let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                  if fetchCountGirlando.count == 0 {
                    
                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                    
                    createDataList()
                    
                    
                    self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                    
                    
                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                    let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                    
                    
                    for k in 0 ..< animalData.count{
                      
                      let animalId = animalData[k] as! BeefAnimaladdTbl
                      
                      for i in 0 ..< product.count {
                        
                        let data = product[i] as! GetProductTblBeef
                        
                        beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                        
                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                        if addonArr.count > 0 {
                          
                          for j in 0 ..< addonArr.count {
                            
                            let addonDat = addonArr[j] as! GetAdonTbl
                            
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            
                            // msgShow()
                            
                          }
                        }
                        else {
                          // msgShow()
                        }
                      }
                    }
                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
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
                    self.nongenotypeCrossBtnOutlet.isHidden = false
                    // let attributeString = NSMutableAttributedString(string: self.listNameString, attributes: self.attrs)
                    // self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
               //     nongenotypeImportFromBtnBtnOutlet.isEnabled = true
      //              self.importBackroundView.isHidden = true
      //              self.importListMainView.isHidden = true
                    self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                   
                    if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                      
                      let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                      let listObject = fetchList.object(at: 0) as? DataEntryList
                      let listDescr = listObject?.listDesc
                      
                      saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid ?? 6), listDesc:listDescr ?? "")
                      
                    }
                    
                    let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId ?? 0,providerId:pvid ?? 6 )
                    if fetchObj.count != 0 {
                      
                      let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                      let obj = objectFetch?.listName
                      let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid ?? 6),customerId:Int64(custmerId ?? 0)).count - 1
                      
                      if fetchAllMergeDta == 0 {
                        let fetchNameDisplay = String(obj ?? "")
                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                        nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                        nongenotypeMergeListBtnOulet.isHidden = false
                          self.nonGenoMergeView.isHidden = false
                      } else {
                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                        nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                        nongenotypeMergeListBtnOulet.isHidden = false
                          self.nonGenoMergeView.isHidden = false
                      }
                    }
                  }
                }
              }
            }
          }
          self.showAlertforwithoutBarcodeAnimal()
    }
}

