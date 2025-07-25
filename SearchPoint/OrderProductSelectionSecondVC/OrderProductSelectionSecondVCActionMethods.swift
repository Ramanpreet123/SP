//
//  OrderProductSelectionSecondVCActionMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 04/03/24.
//

import Foundation
import UIKit

//MARK: IB ACTIONS
extension OrderProductSelectionSecondVC {
  @IBAction func offlineBtnAction(_ sender: UIButton) {
    let screenSize = UIScreen.main.bounds
    buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
    buttonbg.addTarget(self, action: #selector(OrderProductSelectionSecondVC.buttonbgPressed), for: .touchUpInside)
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
  
  @IBAction func editBtnAction(_ sender: Any) {
    UserDefaults.standard.set(1, forKey: keyValue.orderSlideTag.rawValue)
    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC)), animated: true)
  }
  
  @IBAction func crossBtnAction(_ sender: UIButton) {
    parentView.isHidden = true
    crossBtnOutlet.isHidden = true
    transparentView.isHidden = true
    self.bvdvTransparentView.isHidden = true
  }
  
  @IBAction func viewAnimalClick(_ sender: Any) {
    let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
    vc!.screenBackSave = false
    vc!.productBackSave = true
    self.navigationController?.pushViewController(vc!, animated: true)
  }
  
  @IBAction func farmIdDropDown(_ sender: UIButton) {
    dropUpDownBtn.setImage(UIImage(named: ImageNames.imageImg), for: .normal)
    dropDown.anchorView = farmIdHideLbl
    dropDown.direction = .bottom
    dropDown.backgroundColor = UIColor.white
    dropDown.separatorColor = UIColor.clear
    dropDown.cornerRadius = 10
    dropDown.textFont = UIFont.systemFont(ofSize: 13)
    dropDown.cellHeight = 30
    
    dropDown.dataSource = [ NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""),NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
    let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
    
    if pviduser == 4  {
      dropDown.dataSource = [ NSLocalizedString(ButtonTitles.earTagText, comment: ""),NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
    }
    
    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
      self.clickOnDropDown = item
      self.farmIdDisplyOutlet.setTitle(item, for: .normal)
      self.farmIdDisplyOutlet.layer.borderColor = UIColor.gray.cgColor
      
      if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
        UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        if self.farmId == 0{
          if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
          }
          else {
            self.fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
          }
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
          self.farmId = 1
        }
        else{
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
          if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:false,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
          }
          else {
            self.fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:false,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
          }
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
          self.farmId = 0
        }
        
      }
      else if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
        UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        if self.earTagID == 0{
          self.earTagID = 1
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
          
          self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        }
        else{
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
          self.earTagID = 0
          self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        }
      }
      else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
        UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        if self.animaId == 0{
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
          
          if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            
            self.fethData = fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
            
          }else {
            
            self.fethData =  fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
          }
          
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
          self.animaId = 1
        }
        else{
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
          if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            self.fethData =  fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
          }
          else {
            self.fethData =  fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
          }
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
          self.animaId = 0
        }
      }
      else{
        UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        if self.barCodeId == 0{
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
          if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            self.fethData = fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
          }
          else {
            self.fethData = fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
          }
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
          self.barCodeId = 1
        }
        else{
          self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
          if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            self.fethData =  fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
          }
          else {
            self.fethData =  fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
          }
          self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
          self.barCodeId = 0
        }
      }
    }
    dropDown.show()
  }
  
  @IBAction func billingClick(_ sender: UIButton) {
    if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell {
      if cell.billingBtnOutlet.titleLabel?.text == "N/A"{
        transparentView.isHidden = true
        billingView.isHidden = true
        isBillingContact = true
      }else {
        transparentView.isHidden = false
        billingView.isHidden = false
        isBillingContact = false
        billingViewHeightConst.constant = billingTableView.contentSize.height + 100
        billingTableView.reloadData()
      }
    }
  }
  
  @IBAction func backBtnClk(_ sender: UIButton) {
    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
  }
  
  @IBAction func crossClick(_ sender: UIButton) {
    transparentView.isHidden = true
    billingView.isHidden = true
  }
  
  @IBAction func menuBtnClk(_ sender: UIButton) {
    self.view.makeCorner(withRadius: 40)
    self.sideMenuViewController?.presentRightMenuViewController()
  }
  
  @IBAction func dropAction(_ sender: UIButton) {
    if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
      if self.farmId == 0{
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
          
          self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:orderId,userId:userId, farmId: serchTextField.text!)
          
        } else {
          self.fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:orderId,userId:userId, farmId: serchTextField.text!)
        }
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
        self.farmId = 1
      }
      else{
        dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
          
          self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:false,orderId:orderId,userId:userId, farmId: serchTextField.text!)
          
        } else {
          self.fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:false,orderId:orderId,userId:userId, farmId: serchTextField.text!)
        }
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        self.farmId = 0
      }
      
    }
    else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
      if self.animaId == 0{
        dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
        
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
          
          self.fethData =  fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:orderId,userId:userId, animalTag: serchTextField.text!)
          
        } else {
          self.fethData =  fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:orderId,userId:userId, animalTag: serchTextField.text!)
        }
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        self.animaId = 1
      }
      else{
        dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
          self.fethData = fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:orderId,userId:userId, animalTag: serchTextField.text!)
        }else {
          self.fethData = fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:orderId,userId:userId, animalTag: serchTextField.text!)
        }
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        self.animaId = 0
      }
    }
    else if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
      
      if self.earTagID == 0{
        self.earTagID = 1
        self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
        self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
      }
      else{
        self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
        self.earTagID = 0
        self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
      }
    }
    else{
      if self.barCodeId == 0{
        dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
        
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
          self.fethData =  fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:orderId,userId:userId, barcode: serchTextField.text!)
        }
        else {
          self.fethData =  fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:orderId,userId:userId, barcode: serchTextField.text!)
          
        }
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        self.barCodeId = 1
      }
      else{
        dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
          self.fethData =  fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:orderId,userId:userId, barcode: serchTextField.text!)
        }
        else {
          self.fethData =  fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: false,orderId:orderId,userId:userId, barcode: serchTextField.text!)
        }
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        self.barCodeId = 0
      }
    }
  }
  
  @IBAction func clarifideOkBtnAction(_ sender: Any) {
    clarifideTransparentView.isHidden = true
    clariifdeView.isHidden = true
  }
  
  @IBAction func reviewOrder(_ sender: UIButton) {
    if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pvid).count == 0{
      UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
      UserDefaults.standard.set(true, forKey: keyValue.placeOrderCheck.rawValue)
    }
    else{
      UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
      UserDefaults.standard.set(false, forKey: keyValue.placeOrderCheck.rawValue)
    }
    var atgArr = NSMutableArray()
    DispatchQueue.main.async {
      if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell {
        if cell.billingBtnOutlet.titleLabel?.text == "N/A" {
          self.transparentView.isHidden = false
          self.billingView.isHidden = false
          self.isBillingContact = false
        }
        
        else{
          UserDefaults.standard.set(true, forKey: keyValue.review.rawValue)
          let fethData =  fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId)
          let Data = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity, ordestatus: "false",orderId:self.orderId,userId:self.userId)
          
          
          if fethData.count > 0{
            if fethData.count == Data.count {
              let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
              let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.reviewOrderVC) as! ReviewOrderVC
              self.navigationController?.pushViewController(newViewController, animated: false)
              self.isBillingContact = true
            }
            else{
              let count = Data.count - fethData.count
              if UserDefaults.standard.integer(forKey: keyValue.lngId.rawValue) == 2{
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Você não atribuiu produtos a \(count) animal (es). Você quer continuar?", comment: ""), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                  UIAlertAction in
                  let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                  let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.reviewOrderVC) as! ReviewOrderVC
                  self.navigationController?.pushViewController(newViewController, animated: false)
                  self.isBillingContact = true
                }
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                  UIAlertAction in
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
              }
              else{
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: AlertMessagesStrings.noAssignedProdToCountAnimals.localized(with: count), preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                  UIAlertAction in
                  self.deleteAnimal(productArray: fethData as! [ProductAdonAnimalTbl], cartAnimalArray: Data as! [AnimaladdTbl])
                  let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                  let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.reviewOrderVC) as! ReviewOrderVC
                  self.navigationController?.pushViewController(newViewController, animated: false)
                  self.isBillingContact = true
                }
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                  UIAlertAction in
                }
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
              }
            }
          } else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.selectProductLocalStr, comment: ""))
          }
        }
      }
    }
  }
  func validateBreed(completionHandler: CompletionHandler) {
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
    let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
    var bredidd123 = String ()
    
    if data1.count > 0 {
      let breeid1 = data1.object(at: 0) as! AnimaladdTbl
      bredidd123 = breeid1.breedName ?? ""
    }
    
    if data1.count == 1 {
      UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
      UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
      
    }
    else {
      for i in 0 ..< data1.count{
        let breeid1 = data1.object(at: i) as! AnimaladdTbl
        if bredidd123 == breeid1.breedName {
          UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
          UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
        }
        else{
          UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
          return completionHandler(true)
        }
        bredidd123 = breeid1.breedName ?? ""
      }
    }
    return completionHandler(true)
  }
  
  @IBAction func toggleBtnAction(_ sender: UIButton){
    
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        if identyCheck == true {
          let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.diffBreedForAnimals, comment: ""), preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
            
          }))
          
          alert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""),
                                        style: UIAlertAction.Style.default,
                                        handler: {(_: UIAlertAction!) in
            self.createListNameAndCheckifExist()
            let cartAnimal = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity, ordestatus: "false",orderId:self.orderId,userId:self.userId)
            deleteDataProduct(entityName:Entities.animalAddTblEntity,status:"false")
            deleteDataProduct(entityName:Entities.productAdonAnimalTblEntity,status:"false")
            deleteDataProduct(entityName:Entities.subProductTblEntity, status: "false")
            UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.tsuKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.breed.rawValue)
            updateProductTablStatus(entity: Entities.getProductTblEntity)
            updateProductTablStatus(entity: Entities.getAdonTblEntity)
            UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.bvdvValidation.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.isAgreeForSubmit.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.bvdvSelected.rawValue)
            self.view.makeToast(LocalizedStrings.animalsRemovedForProductSelection, duration: 8, position: .bottom)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
              self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            }
          }))
          
          self.present(alert, animated: true, completion: nil)
        } else {
          
          
          let daata123 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity, ordestatus: "false",orderId:self.orderId,userId:self.userId)
          if daata123.count == 1{
            let datava = daata123.object(at:  0) as! AnimaladdTbl
            let fethData1 =  fetchAllDataFarmIdStatusCheckdataDairy(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag:Int(datava.animalId), pId: pid)
            let fethData123 =  fetchAllDataFarmIdStatusCheckdataDairy(entityName: Entities.subProductTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: Int(datava.animalId), pId: pid)
            if fethData1.count > 0 {
              updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
              updateProductTablSecononvc(entity: Entities.getProductTblEntity, productId: pid, status: "true")
              updateProductTablDataaid(entity: Entities.getAdonTblEntity, status: "false")
              if fethData123.count == 0 {
                updateProductTablDataaid(entity: Entities.getAdonTblEntity, status: "false")
              }
              else {
                for i in 0 ..< fethData123.count{
                  let adon = fethData123.object(at: i) as! SubProductTbl
                  updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(adon.adonId), status: "true",productId: pid)
                }
              }
              self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingProductSelectionVC)), animated: true)
              return
            }
          }
          
          let data = UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String
          if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
            let alertController = UIAlertController(title: NSLocalizedString("Warning", comment: ""), message: NSLocalizedString(LocalizedStrings.clearAllProdSelections, comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
            }
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
              let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
              let arr  = fetchproviderProductData(entityName: Entities.getProductTblEntity, provId: pvid)
              for i in 0 ..< arr.count{
                let data  = arr[i] as! GetProductTbl
                updateProductTabl(entity: Entities.getProductTblEntity, productId: Int(data.productId), status: "false", completionHandler: { (success) -> Void in
                })
                updateProducDataSingle(entity: Entities.productAdonAnimalTblEntity, productID:Int(data.productId), status: "false")
                let product  = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                for j in 0 ..< product.count{
                  let data  = product[j] as! GetAdonTbl
                  updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(data.adonId), status: "false",productId: Int(data.productId))
                  updateAdonDataSingle(entity: Entities.subProductTblEntity, adonId: Int(data.adonId) , status: "false")
                }
              }
              
              updateStatusAnimal(entityName: Entities.animalAddTblEntity,ordestatus: "false",status: "",orderId:self.orderId,userId:self.userId)
              UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
              UserDefaults.standard.removeObject(forKey: keyValue.bvdvSelected.rawValue)
              UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
              UserDefaults.standard.set("", forKey: keyValue.productName.rawValue)
              self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingProductSelectionVC)), animated: true)
            }
            
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
          }
          else {
            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingProductSelectionVC)), animated: true)
          }
        }
  }
}
