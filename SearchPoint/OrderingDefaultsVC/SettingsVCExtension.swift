//
//  SettingsVCExtension.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 11/01/25.
//

import Foundation
import UIKit
import Alamofire


extension SettingsVC :offlineCustomView, offlineCustomView1{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}
extension SettingsVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        if collectionView.tag == 1 {
            return speiecCountCheck.count
            
        }
        else {
            return getListProvider.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 140, height: 55)
        }
        if getListProvider.count == 1 {
            return CGSize(width: 217 , height: 55)
        }
       // let collectionViewSizeWidth = collectionView.frame.size.width
        return CGSize(width: 166 , height: 55)
      //  return CGSize(width: 217, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // vertical spacing between rows
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8 // horizontal spacing between items
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 1{
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "species", for: indexPath) as! SpeciesCollectionViewCell
            let data = speiecCountCheck[indexPath.row] as! GetSpeciesTbl
            let spName = UserDefaults.standard.value(forKey: "name") as? String
       
            item.speciesBttn.setTitle(NSLocalizedString("\(data.speciesName ?? "")", comment: ""), for: .normal )
            //            }
            item.speciesBttn.addTarget(self, action: #selector(SettingsVC.specisButton(_:)) , for: .touchUpInside )
            item.speciesBttn.tag = indexPath.row
            
            if data.speciesName!  == spName{
//                item.speciesBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                item.speciesBttn.isUserInteractionEnabled = true
//                item.speciesBttn.layer.borderWidth = 2
//                item.speciesBttn.isSelected = true
                self.setButtonState(button: item.speciesBttn, isOn: true)
            }
            else {
//                item.speciesBttn.layer.borderColor = UIColor.gray.cgColor
//                item.speciesBttn.layer.borderWidth = 1
//                item.speciesBttn.isSelected = false
                self.setButtonState(button: item.speciesBttn, isOn: false)
            }
            
            
            if indexPath.row == 2 {
//                item.speciesBttn.layer.borderColor = UIColor.gray.cgColor
//                item.speciesBttn.layer.borderWidth = 1
                  item.speciesBttn.alpha = 0.3
              //  item.speciesBttn.isEnabled = false
//                item.speciesBttn.isSelected = false
                self.setButtonState(button: item.speciesBttn, isOn: false)
            } else {
                item.speciesBttn.alpha = 1
                //item.speciesBttn.isSelected = true
               // item.speciesBttn.setTitleColor(.black, for: .selected)
      //          self.setButtonState(button: item.speciesBttn, isOn: true)
            }
            return item
        }
        else  {
            marketTipYopOutlet.isHidden = false
            let spName = UserDefaults.standard.value(forKey: "name") as? String
            var pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            if spName == "Dairy" {
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                
                if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products"{
                    //nominatorHeightConst.constant = 100
                    nominatorView.isHidden = false
                    
                }
                else  if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                  //  nominatorHeightConst.constant = 100
                    nominatorView.isHidden = false
                    
                }else  {
                   // nominatorHeightConst.constant = 0
                    nominatorView.isHidden = true
                    if pvid == 4 {
                        self.evaluationProvider = "CLARIFIDE GIROLANDO (BR)"
                        UserDefaults.standard.set("CLARIFIDE GIROLANDO (BR)", forKey: "providerNameUS")
                    }
                }
                if pvid ==  nil || pvid == 0{
                    UserDefaults.standard.setValue(getListProvider[0].providerId, forKey: keyValue.providerID.rawValue)
                    pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                }
//                if pvid == 3 {
//                    getListProvider.swapAt(0, 1)
//                }
                item.EcalutionProviderBttn.tag = indexPath.row
                let arrData = getListProvider[indexPath.row] as! GetProviderTbl
               
                
                item.EcalutionProviderBttn.setTitle("\(arrData.providerName!)", for: .normal )
             //   item.EcalutionProviderBttn.setTitleColor(UIColor.black, for: .normal)
                item.EcalutionProviderBttn.titleLabel?.lineBreakMode = .byWordWrapping
                self.provideCountCheck = fetchdataOfProvider(specisId: "074dc82b-2b82-4ee6-99c6-f9691937394d") as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                
                if getListProvider.count == 1 || getListProvider.count == 2 {
                    
                    //providerCollectionViewHeight.constant = 70
                } else if getListProvider.count == 0 {
                  //  providerCollectionViewHeight.constant = 0
                    
                }else {
                  //  providerCollectionViewHeight.constant = 140
                    
                }
           
                

                if pvid == arrData.providerId{
//                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    item.EcalutionProviderBttn.layer.borderWidth = 2
                    
                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                    let providerName = UserDefaults.standard.value(forKey: "ProviderName") as? String
                    UserDefaults.standard.set(arrData.providerName, forKey: "ProviderName")
                    
                    
                } else {
//                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
//                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
//                    item.EcalutionProviderBttn.layer.borderWidth = 1
                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)
                    
                }
                //  }
                
                item.EcalutionProviderBttn.addTarget(self, action: #selector(SettingsVC.providerButton(_:)) , for: .touchUpInside )
                
                return item
                
            } else {
                marketTipYopOutlet.isHidden = true
                self.provideCountCheck = fetchdataOfProvider(specisId: "151e2230-9a01-4828-a105-d87a92b5be2f") as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                item.EcalutionProviderBttn.tag = indexPath.row
                item.isUserInteractionEnabled = true
                let arrData = getListProvider[indexPath.row] as? GetProviderTbl
                item.EcalutionProviderBttn.setTitle("\(arrData!.providerName!)", for: .normal )
               // item.EcalutionProviderBttn.setTitleColor(UIColor.black, for: .normal)
                var isProviderIdfoundInMarket = false
                
                if getListProvider.count == 1 || getListProvider.count == 2 {
                    
                   // providerCollectionViewHeight.constant = 70
                } else if getListProvider.count == 0 {
                 //   providerCollectionViewHeight.constant = 0
                    
                }else {
                   // providerCollectionViewHeight.constant = 140
                    
                }
                
                var pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                if pvid ==  nil || pvid == 0{
                    UserDefaults.standard.setValue(getListProvider[0].providerId, forKey: "BeefPvid")
                    pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                }
                if pvid == arrData!.providerId {
//                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    item.EcalutionProviderBttn.layer.borderWidth = 2
                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                } else {
//                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
//                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
//                    item.EcalutionProviderBttn.layer.borderWidth = 1
                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)
                }
                if pvid == 5 {
                    marketTipYopOutlet.isHidden = true
                }
                
                item.EcalutionProviderBttn.addTarget(self, action: #selector(SettingsVC.providerButton(_:)) , for: .touchUpInside )
                
                return item
                
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 5
//    }
    
    func addBeefProducts() {
        UserDefaults.standard.set(true, forKey: "identifyStore")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        deleteDataProduct(entityName:"ProductAdonAnimlTbLBeef",status:"false")
        deleteDataProduct(entityName:"SubProductTblBeef", status: "false")
        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        
        let animalData = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:1,userId:1) as! [BeefAnimaladdTbl]
        
        updateProductTablStatus(entity: "GetProductTblBeef")
        updateProductTablStatus(entity: "GetAdonTbl")
        for product in self.productArr as? [GetProductTbl] ?? [] {
            product.isAdded = "true"
            if pvid == 13 {
                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
            } else{
                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
            }
        }
        
        let product  = fetchAllData(entityName: "GetProductTblBeef")
        for k in 0 ..< animalData.count{
            
            let animalId = animalData[k] as! BeefAnimaladdTbl
            
            for i in 0 ..< product.count {
                
                let data = product[i] as! GetProductTblBeef
                // todo:  23 nov changes
                
                if pvid == 13 {
                    saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(animalId.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                } else{
                    saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(animalId.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                }
                
                
                let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                
                for j in 0 ..< addonArr.count {
                    
                    let addonDat = addonArr[j] as! GetAdonTbl
                    
                    saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", farmId: animalId.farmId ?? "", animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    
                }
            }
        }
    }
    
    func addProduct() {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        deleteDataProduct(entityName:"ProductAdonAnimalTbl",status:"false")
        deleteDataProduct(entityName:"SubProductTbl", status: "false")
        UserDefaults.standard.removeObject(forKey: "identifyStore")
        UserDefaults.standard.removeObject(forKey: "productCount")
        UserDefaults.standard.removeObject(forKey: "breed")
        UserDefaults.standard.removeObject(forKey: "BVDVvalidation")
        UserDefaults.standard.set(nil, forKey: "On")
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        
        updateProductTablStatus(entity: "GetProductTbl")
        updateProductTablStatus(entity: "GetAdonTbl")
        
        let animalArr1 = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId)
        if animalArr1.count > 0 {
            for k in 0 ..< animalArr1.count {
                let  breedId1  = animalArr1[k] as! AnimaladdTbl
                let product = fetchproviderProductDataBreedId(entityName: "GetProductTbl", provId: pvid, breedId: breedId1.breedId!)
                let productCount = UserDefaults.standard.integer(forKey: "productCount")
                if productCount == 0{
                    UserDefaults.standard.set(breedId1.breedId, forKey: "breed")
                }
                UserDefaults.standard.set(true, forKey: "identifyStore")
              
                UserDefaults.standard.set( product.count, forKey: "productCount")
                var animalID = UserDefaults.standard.integer(forKey: "animalId")
                for i in 0 ..< product.count{
                    let data = product[i] as! GetProductTbl
                    
                    saveProductAdonTbl(entity: "ProductAdonAnimalTbl", animalTag: breedId1.animalTag ?? "" , barCodetag: breedId1.animalbarCodeTag ?? "",mkdId: data.marketId! ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: breedId1.farmId!, orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, animalId: Int(breedId1.animalId), marketName: breedId1.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),isCdcbProduct: data.isCdcbProduct)
                    
                    let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                    for j in 0 ..< addonArr.count{
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: "SubProductTbl", animalTag:  breedId1.animalTag ?? "", barCodetag: breedId1.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, farmId: breedId1.farmId!, animalId: Int(breedId1.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
                
            }
        }
    }
}



extension SettingsVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}


extension SettingsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        let cell = tableView.dequeueReusableCell(withIdentifier: "beefproducts", for: indexPath) as! BeefProductsTableViewCell
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        
        if product.productName == "Genotype Only"
        {
            var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
            if langId == 2{
                cell.productName.text = "Genotipagem"
            }
            else
            {
                cell.productName.text = product.productName
            }
        }
        else
        {
            cell.productName.text = product.productName
        }
        cell.radioBttn.isUserInteractionEnabled = false
        cell.iiBttn.isHidden = true
        
        
        if product.productId == 20 {
            cell.iiBttn.isHidden = false
            self.inheritInfoButtonFrame = cell.iiBttn.center.x - cell.iiBttn.frame.size.width / 2
            cell.iiBttn.addTarget(self, action: #selector(self.marketTipPop), for: .touchUpInside)
        }
        
        //for Global
        if pvid == 5 {
            
          //  tblViewhRIGHTcON.constant = 140
            if product.isAdded == "true" {
                
                cell.radioBttn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
            
            cell.isUserInteractionEnabled = true
            cell.radioBttn.alpha = 1
            cell.alpha = 1
            cell.productName.alpha = 1
            
            if UserDefaults.standard.integer(forKey: "IsGlobalHD50DisabledForBrazil") == 1 && indexPath.row == 0 {
                
                cell.isUserInteractionEnabled = false
                cell.radioBttn.alpha = 0.2
                cell.alpha = 0.2
                cell.productName.alpha = 0.2
            }
            else {
                cell.isUserInteractionEnabled = true
                cell.radioBttn.alpha = 1
                cell.alpha = 1
                cell.productName.alpha = 1
            }
            
            if UserDefaults.standard.integer(forKey: "IsInhertDisabledForBrazil") == 1 && indexPath.row == 1 {
                cell.isUserInteractionEnabled = false
                cell.radioBttn.alpha = 0.2
                cell.alpha = 0.2
                cell.productName.alpha = 0.2
            }
        
        }
        
        //for brazil
        if pvid == 6 {
          //  tblViewhRIGHTcON.constant = 188
            
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: "incrementalCheckIpad"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            cell.isUserInteractionEnabled = true
            cell.radioBttn.alpha = 1
            cell.alpha = 1
            cell.productName.alpha = 1
        }
        
        //for Newzealand
        if pvid == 7 {
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
        }
        
        return cell
    }
    
    @objc func marketTipPop() {
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        
        var yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
        
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = CGRect(x: 18,y: 370  ,width: screenSize.width - 80, height: 137)
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = CGRect(x: 36,y: 405  ,width: screenSize.width - 80, height: 137)
            case 2436:
                strDeviceType = "iPhone X"
                yFrame = CGRect(x: 18,y: 447  ,width: screenSize.width - 80, height: 137)
            case 2688,2796:
                strDeviceType = "iPhone Xs Max"
                yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
            case 1792:
                yFrame = CGRect(x: 37,y: 488  ,width: screenSize.width - 80, height: 137)
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        
        customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  + 5
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = yFrame
        customPopView1.textLabel1.text =  NSLocalizedString("INHERIT select will provide EPDs for replacement heifers. INHERIT connect allows for bulls to be included into the evaluation for heifer sire verification. EPDs are not provided for INHERIT connect.", comment: "")
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        let userId = UserDefaults.standard.integer(forKey: "userId")
        var data = fetchAllDataWithOrderIDWithBeef(entityName: "BeefAnimaladdTbl",pid:pid,userId:userId)
       
        var  strmsg = String()
        if data.count > 0{
            if pvid != 6{
                
                if pid == product.productId {
                    strmsg = "Removing product selection will clear all product selections applied in order. Do you wish to continue? "
                }else{
                    strmsg = "Changing product selection will clear all animals and corresponding product selections applied in order. Do you wish to continue? "
                }
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: strmsg, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.didselectTouched = true
                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                    if UserDefaults.standard.string(forKey: "name") == "Beef" {
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        
                        if pvid == 5 || pvid == 13 {
                            //for Global
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                    deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                    deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                                    UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                    if pvid == 5{
                                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                    } else {
                                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                    }
                                }
                            }
                        }
                        
                        if pvid == 6 {
                            //for Brazil
                            deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                          
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                } else {
                                    deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                                }
                            }
                        }
                        
                        if pvid == 7 {
                            //for Newzealand
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                    deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                    deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                    UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                    saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                }
                            }
                        }
                    }
  
                    if pvid == 5 || pvid == 13{
                        //for global
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                                
                                UserDefaults.standard.set(product.productId, forKey: "chpid")
                            }
                            products[indexPath.row].isAdded = "true"
                            
                        }
                        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") == true{
                            
                            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                            UserDefaults.standard.set(false, forKey: "brazilBarcode")
                            UserDefaults.standard.set(false, forKey: "series")
                        }
                        if UserDefaults.standard.bool(forKey: "brazilBarcode") == true {
                            UserDefaults.standard.set(false, forKey: "brazilBarcode")
                            UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                        }
                        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") == true{
                            
                            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                            UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                            UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                        }
                        if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC") == true {
                            UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                            UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                        }
                      
                        UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                        self.productTblView.reloadData()
                    }
                    
                    if pvid == 6 {
                        //for brazil
                        
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                            }
                            products[indexPath.row].isAdded = "false"
                           
                        }
                        self.brazilProduct.append(product.productName!)
                        UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                        UserDefaults.standard.set(product.productId, forKey: "chpid")
                        UserDefaults.standard.set(self.brazilProduct, forKey: "brazilproduct")
                       
                        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
                            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                            UserDefaults.standard.set(true, forKey: "brazilBarcode")
                        }
                        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" {
                            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                            UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                        }
                        self.productTblView.reloadData()
                    }
                    
                    if pvid == 7 {
                        //for Newzealand
                     
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                                UserDefaults.standard.set(product.productId, forKey: "chpid")
                            }
                            
                            if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") == true{
                                UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                                UserDefaults.standard.set(false, forKey: "series")
                            }
                            if UserDefaults.standard.bool(forKey:"brazilBarcode") == true {
                                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                                UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                            }
                            if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") == true{
                                
                                UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                                UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                                UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                            }
                            if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC") == true {
                                UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                                UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                            }
                            UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                            products[indexPath.row].isAdded = "true"
                        }
                        
                        self.productTblView.reloadData()
                    }
                }
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                self.didselectTouched = true
                if pvid == 6 {
                    //for brazil
                    
                    if let  products = productArr as? [GetProductTbl] {
                        if products[indexPath.row].isAdded == "true" {
                            products[indexPath.row].isAdded = "false"
                        } else {
                            products[indexPath.row].isAdded = "true"
                        }
                    }
                    brazilProduct.append(product.productName!)
                    UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                    UserDefaults.standard.set(product.productId, forKey: "chpid")
                    UserDefaults.standard.set(brazilProduct, forKey: "brazilproduct")
                  
                    if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
                        UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                        UserDefaults.standard.set(true, forKey: "brazilBarcode")
                    }
                    if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" {
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                        UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                    }
                    productTblView.reloadData()
                }
            }
        }else{
            self.didselectTouched = true
            if pvid == 5 || pvid == 13{
                //for global
                UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                        
                        UserDefaults.standard.set(product.productId, forKey: "chpid")
                    }
                    products[indexPath.row].isAdded = "true"
                    
                }
                if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") == true{
                    
                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                    UserDefaults.standard.set(false, forKey: "brazilBarcode")
                    UserDefaults.standard.set(false, forKey: "series")
                }
                if UserDefaults.standard.bool(forKey: "brazilBarcode") == true {
                    UserDefaults.standard.set(false, forKey: "brazilBarcode")
                    UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                }
                if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") == true{
                    
                    UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                    UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                }
                if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC") == true {
                    UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                    UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                }
                UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                productTblView.reloadData()
            }
            
            if pvid == 6 {
                //for brazil
                
                if let  products = productArr as? [GetProductTbl] {
                    if products[indexPath.row].isAdded == "true" {
                        products[indexPath.row].isAdded = "false"
                    } else {
                        products[indexPath.row].isAdded = "true"
                    }
                }
                brazilProduct.append(product.productName!)
                UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                UserDefaults.standard.set(product.productId, forKey: "chpid")
                UserDefaults.standard.set(brazilProduct, forKey: "brazilproduct")
             
                if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                    UserDefaults.standard.set(true, forKey: "brazilBarcode")
                }
                if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" {
                    UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                }
                productTblView.reloadData()
            }
            
            if pvid == 7 {
                //for Newzealand
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                        UserDefaults.standard.set(product.productId, forKey: "chpid")
                    }
                    
                    if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") == true{
                        UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                        UserDefaults.standard.set(false, forKey: "brazilBarcode")
                        UserDefaults.standard.set(false, forKey: "series")
                    }
                    if UserDefaults.standard.bool(forKey:"brazilBarcode") == true {
                        UserDefaults.standard.set(false, forKey: "brazilBarcode")
                        UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                    }
                    if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") == true{
                        
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                    }
                    if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC") == true {
                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                    }
                    UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                    products[indexPath.row].isAdded = "true"
                }
                
                productTblView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}


extension SettingsVC: InheritQuestionaireControllerDelegate {
    func inheritQuestionaireControllerDismissed() {
        if UserDefaults.standard.value(forKey: "settingDone") == nil || UserDefaults.standard.value(forKey: "settingDone") as? String == ""{
            UserDefaults.standard.set("true", forKey: "settingDone")
            let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "InheritBeefVC") as! InheritBeefVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
}

extension SettingsVC{
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custId ?? 0, providerID: pvidDairy)
        fetchDataEntry  = fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(self.custId ?? 0),listName:listName ,productName:"Dairy") as! [DataEntryList]
    }
    
    func createListNameAndCheckifExist(){
        let userId = UserDefaults.standard.integer(forKey: "userId")
        getListName()
        if fetchDataEntry.count > 0 {
            deleteList(listName: listName, customerId: Int64(custId ?? 0),listID: Int(fetchDataEntry[0].listId))
            deleteDataWithListIdDatEntry(entityString: "DataEntryAnimaladdTbl", listId: Int(fetchDataEntry[0].listId), customerId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),userId:userId)
            
            deleteDataWithListId(entityString: "DataEntryList", listId: Int64(fetchDataEntry[0].listId), customerId: Int(custId ),userId:userId )
        }
        
    }
    func updateProviderId() {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        updateProductTablDataaid(entity: "GetProductTbl", status: "false")
        let fethData =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
        for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
            updateProductTablaid(entity:"GetProductTbl",productId:
                                    Int(pName.productId),status: "true")
        }
        
        let animaltbl = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId) as! [AnimaladdTbl]
        for item in animaltbl {
            updateProviderIDAnimal(entityName: "AnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: orderId, userId: userId)
        }
    }
    
    func updateBeefProviderId() {
        UserDefaults.standard.set(false, forKey: "BeefBVDVSeleted")
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        self.createListNameAndCheckifExist()
        updateProductTablDataaid(entity: "GetProductTblBeef", status: "false")
        let fethData =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
        for pName in fethData as? [ProductAdonAnimlTbLBeef] ?? [] {
            updateProductTablaid(entity:"GetProductTblBeef",productId:
                                    Int(pName.productId),status: "true")
        }
        
        let product  = fetchAllData(entityName: "GetProductTblBeef")
        let animaltbl = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:1,userId:1) as! [BeefAnimaladdTbl]
        
        for k in 0 ..< animaltbl.count{
            let earTag = animaltbl[k].animalTag
            let eid = animaltbl[k].sireIDAU
            let existingPvid = animaltbl[k].providerId
            let barCode = animaltbl[k].animalbarCodeTag
            switch existingPvid {
            case 5:
                updateBeefAnimalProviderID_AnimalTag_Sireid(entityName: "BeefAnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: 1, userId: 1, earTag: eid ?? "", sireIDAU: earTag ?? "",barCode: barCode ?? "")
            case 13:
                updateBeefAnimalProviderID_AnimalTag_Sireid(entityName: "BeefAnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: 1, userId: 1, earTag: eid ?? "", sireIDAU: earTag ?? "", barCode: barCode ?? "")
            default:
                updateProviderIDAnimal(entityName: "BeefAnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: 1, userId: 1)
            }
        }
    }
    
    func deleteList(listName: String, customerId: Int64, listID: Int) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        let headerDict = ["Authorization": accessToken!,"Content-Type" : "application/x-www-form-urlencoded"]
        var header = HTTPHeaders(headerDict ?? ["Content-Type": "application/x-www-form-urlencoded","Accept": "application/json"])
        
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = ["customerId": customerId,"listName":listName]
        
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}

