//
//  OrderingDefaultsVCActionMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 11/06/24.
//

import Foundation
import UIKit


// MARK: - IB ACTONS
extension OrderingDefaultsVC {
    
    @IBAction func actionBtnIKeyBoardnfo(_ sender: Any) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        
        if langId == 1{
            var yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    break
                case 1334:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
                    
                case 2436:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                    
                case 2688,2796:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                    
                default:
                    break
                }
            }
            
            customPopView1.elipseImage2.isHidden = true
            customPopView1.elipseImage1.isHidden = false
            customPopView1.textLbl2.isHidden = false
            customPopView1.textLabel1.isHidden = false
            
            if(self.keyBoardViewHeight.constant == 90){
                customPopView1.frame = CGRect(x: 52,y: yFrame+20 ,width: 310, height: 120)
            }
            else{
                customPopView1.frame = CGRect(x: 52,y: yFrame+140 ,width: 310, height: 120)
            }
            
            customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.keyBoardCloseWhileScroll, comment: "")
            customPopView1.textLbl2.isHidden = true
            customPopView1.arrow_left.isHidden = true
            customPopView1.arrow_Top.frame = CGRect(x: btn_KeyboardInfo.frame.minX - 45 , y: -24, width: 26, height: 26)
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
        }else {
            var yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    break
                    
                case 1334:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    break
                    
                case 2436:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                    
                case 2688,2796:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 3621) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 36) -  self.scrolView.contentOffset.y
                    
                default:
                    break
                }
            }
            
            customPopView1.elipseImage2.isHidden = true
            customPopView1.elipseImage1.isHidden = false
            customPopView1.textLbl2.isHidden = false
            customPopView1.textLabel1.isHidden = false
            if(self.keyBoardViewHeight.constant == 90){
                customPopView1.frame = CGRect(x: 52,y: yFrame+20 ,width: 310, height: 120)
            }
            else{
                customPopView1.frame = CGRect(x: 52,y: yFrame+120 ,width: 310, height: 120)
            }
            customPopView1.textLabel1.text =  NSLocalizedString(LocalizedStrings.keyBoardCloseWhileScroll, comment: "")
            customPopView1.textLbl2.isHidden = true
            customPopView1.arrow_left.isHidden = true
            customPopView1.arrow_Top.frame = CGRect(x: btn_KeyboardInfo.frame.minX - 45 , y: -24, width: 26, height: 26)
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
        }
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.orderingDefaultsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func alphaNumericKeyboardAction(_ sender: Any) {
        alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
        alphaNumericbtnOutler.layer.borderWidth = 2
        numericKeyBoardBtnOutle.layer.borderWidth = 1
        UserDefaults.standard.set(keyValue.alphaNumericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
    }
    
    @IBAction func numericKeyBoardAction(_ sender: Any) {
        numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
        numericKeyBoardBtnOutle.layer.borderWidth = 2
        alphaNumericbtnOutler.layer.borderWidth = 1
        UserDefaults.standard.set(keyValue.numericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
    }
    
    @IBAction func donePopUpClick(_ sender: Any) {
        let pid =   UserDefaults.standard.integer(forKey: keyValue.bfProductId.rawValue)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        UserDefaults.standard.set(nil, forKey: "On")
        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
        
        if  didselectTouched == true {
            UserDefaults.standard.set(false, forKey: keyValue.showBeefProductTbl.rawValue)
            if pvid == 5 || pvid == 13 {
                //for Global
                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if pvid == 5 {
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    } else {
                        if product.isAdded == "true" {
                            
                            UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                            saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                }
            }
            
            if pvid == 6 {
                //for Brazil
                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        
                    }
                    else {
                        deleteDataWithProductBeef(entityName: Entities.getProductBeefTblEntity, productId: Int(product.productId))
                    }
                    
                }
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
                let animalData =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid)
                
                if animalData.count > 0 {
                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                    for k in 0 ..< animalData.count{
                        let animalId = animalData[k] as! BeefAnimaladdTbl
                        for i in 0 ..< product.count {
                            
                            let data = product[i] as! GetProductTblBeef
                            
                            beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: userId,udid:animalId.udid ?? "", animalId:  Int(animalId.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                            
                        }
                    }
                }
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
                
                
                if isGenotypeOnlyAdded == true
                {
                    if isGenostarblackOnlyAdded == true && isGenotypeOnlyAdded == true
                    {
                        UserDefaults.standard.set(keyValue.genoTypeStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                    else{
                        UserDefaults.standard.set(keyValue.genoTypeOnly.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                    
                }
                else {
                    if isGenostarblackOnlyAdded == true
                    {
                        UserDefaults.standard.set(keyValue.genStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                    else
                    {
                        UserDefaults.standard.set(keyValue.nonGenoType.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                }
            }
            
            if pvid == 7 {
                //for Newzealand
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                        UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                }
            }
        }
        
        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        if fetchPid.count > 0 {
            if let productTblBeef = fetchPid[0] as? GetProductTblBeef {
                if UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) == nil || UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) as? String == ""{
                    if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue{
                        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                        if pvid == 13 {
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                        }
                        if pvid == 5 {
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                            if productTblBeef.productId == 20 {
                                UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                                UserDefaults.standard.set(keyValue.capsInherit.rawValue, forKey: keyValue.beefProduct.rawValue)
                                
                                
                            }
                            else{
                                UserDefaults.standard.set(keyValue.globalHD50K.rawValue, forKey: keyValue.beefProduct.rawValue)
                            }
                            
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                            
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as? String == ScreenNames.dataEntry.rawValue {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC)), animated: true)
                            }
                        }
                        if pvid == 6{
                            
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as? String == ScreenNames.dataEntry.rawValue {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC)), animated: true)
                            }}
                        if pvid == 7{
                            
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalNZVC)), animated: true)
                            }}
                    }
                    
                    
                    
                } else {
                    if UserDefaults.standard.string(forKey: "name") == marketNameType.Dairy.rawValue{
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    }
                    if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue{
                        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                        if pvid == 5 {
                            
                            if productTblBeef.productId == 20 {
                                UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                                UserDefaults.standard.set(keyValue.capsInherit.rawValue, forKey: keyValue.beefProduct.rawValue)
                                
                            }
                            else {
                                UserDefaults.standard.set(keyValue.globalHD50K.rawValue, forKey: keyValue.beefProduct.rawValue)
                            }
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                            
                        }
                        if pvid == 6{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                        }
                        if pvid == 7{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                        }
                    }
                }
            }
            calendarViewBkg.isHidden = true
            billingView.isHidden = true
        } else {
            if pvid == 6 {
                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
            }else{
                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
            }
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectProducts, comment: ""))
        }
    }
    
    
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.customerOrderSetting.saveCustomerSetting()
        
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
        dateBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        dateBtnOutlet.layer.borderWidth = 2
        date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        date1BtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        date1BtnOutlet.layer.borderWidth = 1
        
    }
    
    @IBAction func dateAction1(_ sender: UIButton) {
        UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
        date1BtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        dateBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        date1BtnOutlet.layer.borderWidth = 2
        dateBtnOutlet.layer.borderWidth = 1
        dateBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        
    }
    
    @IBAction func zoetisBtnAction(_ sender: Any) {
        UserDefaults.standard.set(keyValue.zoetis.rawValue, forKey: keyValue.nominatorSave.rawValue)
        zoetisBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        holsteinBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        zoetisBtnOutlet.layer.borderWidth = 2
        holsteinBtnOutlet.layer.borderWidth = 1
    }
    
    
    @IBAction func holsteinBtnAction(_ sender: Any) {
        UserDefaults.standard.set(keyValue.holsteinUSA.rawValue, forKey: keyValue.nominatorSave.rawValue)
        holsteinBtnOutlet.layer.borderColor =    UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        zoetisBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        zoetisBtnOutlet.layer.borderWidth = 1
        holsteinBtnOutlet.layer.borderWidth = 2
    }
    
    @IBAction func continueToOrderBtnClk(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: "name") as? String  == "Beef"{
            if (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) as? Int)! == nil || (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) as? Int)! == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:NSLocalizedString(AlertMessagesStrings.selectProductGrouping, comment: "") )
                return
            }
        } else {
            var pvid = UserDefaults.standard.value(forKey: keyValue.providerID.rawValue) as? Int
            if pvid  == 0 || pvid == nil {
                UserDefaults.standard.setValue(Constants.providerId, forKey: keyValue.providerID.rawValue)
                pvid = Constants.providerId
                Constants.providerId = Int()
            }
            if  pvid == nil ||  pvid == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:NSLocalizedString("Please select an evaluation provider.", comment: "") )
                return
            }
        }
        
        if UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) == nil || UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String == ""{
            UserDefaults.standard.set(keyValue.zoetis.rawValue, forKey: keyValue.nominatorSave.rawValue)
        }
        UserDefaults.standard.set("true", forKey: keyValue.settingDefault.rawValue)
        
        if UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) == nil || UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) as? String == ""{
            let marketName = UserDefaults.standard.value(forKey: "name") as? String
            if marketName == "" || marketName == nil {
                UserDefaults.standard.setValue(Constants.marketName, forKey: "name")
                Constants.marketName = ""
            }
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Dairy.rawValue{
                UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)
                
                if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as? String == ScreenNames.dataEntry.rawValue {
                    
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                    
                    
                } else {
                    
                    if pviduser == 4 {
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVCGirlando)), animated: true)
                    } else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC)), animated: true)
                    }
                }
                
            }
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                
                guard UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) != 0 else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:NSLocalizedString(AlertMessagesStrings.selectProductGrouping, comment: "") )
                    return
                }
                let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                
                UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                if pvid == 5 {
                    deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                    UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                    if let products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                        }
                        
                    }
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                    UserDefaults.standard.set(keyValue.capsInherit.rawValue, forKey: keyValue.beefProduct.rawValue)
                    //For Global
                    if productPopupFlag == 0{
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        }
                        else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            
                        }else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC)), animated: true)
                        }
                        productTblView.reloadData()
                        
                    } else {
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            
                        }else {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC)), animated: true)
                        }
                    }
                }
                if pvid == 13 {
                    self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                    
                    if let products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                        }
                        
                    }
                    
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            
                            UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                            saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: "87c30632-8da0-4f86-8d94-46da17c520dd", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                    
                    //For Global
                    if productPopupFlag == 0{
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefUSAddAnimalVC)), animated: true)
                        productTblView.reloadData()
                    }
                }
                
                if pvid == 6 {
                    //For Brazil
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                            saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                        else {
                            deleteDataWithProductBeef(entityName: Entities.getProductBeefTblEntity, productId: Int(product.productId))
                        }
                        
                    }
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                            
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        calendarViewBkg.isHidden = false
                        billingView.isHidden = false
                        productTblView.reloadData()
                        
                    } else {
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            
                        } else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC)), animated: true)
                        }}
                }
                
                if pvid == 7 {
                    //For Newzealand
                    if productPopupFlag == 0 {
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            product.isAdded = "true"
                        }
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                                saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!,status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            }
                        }
                        UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as? String == ScreenNames.dataEntry.rawValue {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            
                        } else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalNZVC)), animated: true)
                        }
                    } else {
                        productPopupFlag = 0
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalNZVC)), animated: true)
                    }
                }
                
                UserDefaults.standard.set("true", forKey: keyValue.beefProductAdded.rawValue)
            }
            
        } else {
            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
            
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Dairy.rawValue{
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            }
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue{
                guard UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) != 0 else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectProductGrouping, comment: ""))
                    return
                }
                
                UserDefaults.standard.set("true", forKey: keyValue.beefProductAdded.rawValue)
                let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                
                if pvid == 5 {
                    deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                    UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                    if let products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                        }
                        
                    }
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                    UserDefaults.standard.set(keyValue.capsInherit.rawValue, forKey: keyValue.beefProduct.rawValue)
                    //For Global
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        productTblView.reloadData()
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    }
                    else{
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            
                        }else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC)), animated: true)
                        }
                    }
                }
                if pvid == 13 {
                    deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    if let products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                        }
                        
                    }
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            
                            UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                            saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                    UserDefaults.standard.set(keyValue.capsInherit.rawValue, forKey: keyValue.beefProduct.rawValue)
                    //For Global
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        productTblView.reloadData()
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    }
                    else{
                        productPopupFlag = 0
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefUSAddAnimalVC")), animated: true)
                    }
                }
                
                
                if pvid == 6 {
                    if productPopupFlag == 0 {
                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                
                                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                                saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            }
                        }
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    } else {
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            
                        } else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC)), animated: true)
                        }}
                }
                
                if pvid == 7 {
                    if productPopupFlag == 0 {
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            product.isAdded = "true"
                        }
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                                
                                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                                saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            }
                        }
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                        
                    } else {
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            
                        }else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalNZVC)), animated: true)
                        }}
                }
            }
        }
        self.customerOrderSetting.saveCustomerSetting()
    }
    
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        self.customerOrderSetting.saveCustomerSetting()
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    @IBAction func farmIDAction(_ sender: UIButton) {
        farmIdBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        rfidBttn.layer.borderColor = UIColor.lightGray.cgColor
        ScreenDef = "farmid"
        UserDefaults.standard.set(ScreenDef, forKey: keyValue.screen.rawValue)
        UserDefaults.standard.set(ScreenDef, forKey: keyValue.foReviewOrderVC.rawValue)
        UserDefaults.standard.set(ScreenDef, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        farmIdBttn.layer.borderWidth = 2
        rfidBttn.layer.borderWidth = 1
    }
   
    
    @IBAction func ocrInfoCrossBtnAction(_ sender: UIButton) {
        ocrViewShow.isHidden = true
        ocrBackroundBtnOutlet.isHidden = true
    }
    
    @IBAction func ocrInfoPopAction(_ sender: UIButton) {
        self.ocrViewShow.isHidden = false
        ocrBackroundBtnOutlet.isHidden = false
        ocrViewShow.layer.cornerRadius = 13
    }
    
    @IBAction func ocrBackRoundInfoBtn(_ sender: UIButton) {
        ocrViewShow.isHidden = true
        ocrBackroundBtnOutlet.isHidden = true
    }
    
    @IBAction func rfidAction(_ sender: UIButton) {
        ScreenDef = keyValue.officialId.rawValue
        UserDefaults.standard.set(ScreenDef, forKey: keyValue.screen.rawValue)
        UserDefaults.standard.set(ScreenDef, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        UserDefaults.standard.set(ScreenDef, forKey: keyValue.foReviewOrderVC.rawValue)
        
        farmIdBttn.layer.borderColor =    UIColor.lightGray.cgColor
        rfidBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        farmIdBttn.layer.borderWidth = 1
        rfidBttn.layer.borderWidth = 2
        
    }
    
    @IBAction func marketTipPopClick(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        var yFrame = (marketView.layer.frame.minY + 148) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (marketView.layer.frame.minY + 148 - 7 + 3) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (marketView.layer.frame.minY + 148 - 7 + 15) - self.scrolView.contentOffset.y
                
            case 2436:
                yFrame = (marketView.layer.frame.minY + 148 + 15) - self.scrolView.contentOffset.y
                
            case 2688,2796:
                yFrame = (marketView.layer.frame.minY + 148 + 27) - self.scrolView.contentOffset.y
                
            case 1792:
                yFrame = (marketView.layer.frame.minY + 148 + 27) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: 39,y: yFrame + 16 ,width: screenSize.width - 80, height: 155)
        customPopView1.textLabel1.text =  NSLocalizedString(LocalizedStrings.geneticEvaluationBody, comment: "")
        customPopView1.arrow_Top.frame = CGRect(x: marketView.layer .frame.minX - 32 , y: -24, width: 26, height: 26)
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
    }
    
    @IBAction func primarlyBasedTipPopClock(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        var yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
                
            case 2436:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                
            case 2688,2796:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                
            case 1792:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        
        customPopView1.elipseImage2.isHidden = false
        customPopView1.elipseImage1.isHidden = false
        customPopView1.textLbl2.isHidden = false
        customPopView1.textLabel1.isHidden = false
        customPopView1.frame = CGRect(x: 52,y: yFrame + 10 ,width: 310, height: 133)
        customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.herdManagement, comment: "")
        customPopView1.textLbl2.text = NSLocalizedString(LocalizedStrings.uniqueMetalEarTag, comment: "")
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.frame = CGRect(x: primaryBasedOutlet.frame.minX - 45 , y: -24, width: 26, height: 26)
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func closeAction(_ sender: UIButton) {
        productPopupFlag = 0
        calendarViewBkg.isHidden = true
        billingView.isHidden = true
        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        if fetchPid.count == 0 {
            UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
        }
    }
    
    @IBAction func ocrBtnAction(_ sender: Any) {
        let spName = UserDefaults.standard.value(forKey: "name") as? String
        if spName != marketNameType.Dairy.rawValue {
            if UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 13 || UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 5 {
                UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
            }
        }else {
            UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
        }
        
        ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        ocrBtnOutlet.layer.borderWidth = 2
        rfidBtnOutlet.layer.borderWidth = 1
        
    }
    
    @IBAction func rfidBtnAction(_ sender: Any) {
        let spName = UserDefaults.standard.value(forKey: "name") as? String
        
        if UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 13 || UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 5 && spName != marketNameType.Dairy.rawValue {
            UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
        } else {
            UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
        }
        
        rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        rfidBtnOutlet.layer.borderWidth = 2
        ocrBtnOutlet.layer.borderWidth = 1
    }
    
    @IBAction func datePickerEntryAction(_ sender: Any) {
        UserDefaults.standard.set(keyValue.pickerMode.rawValue, forKey: keyValue.defaultDatePicker.rawValue)
        self.datePickerEntryOutlet.setImage(UIImage(named: ImageNames.filledImg), for: .normal)
        self.defaultEntryModeOutlet.setImage(UIImage(named: ImageNames.emptyImg), for: .normal)
    }
    
    @IBAction func defaultEntryModeAction(_ sender: Any) {
        UserDefaults.standard.set(keyValue.defaultEntry.rawValue, forKey: keyValue.defaultDatePicker.rawValue)
        self.defaultEntryModeOutlet.setImage(UIImage(named: ImageNames.filledImg), for: .normal)
        self.datePickerEntryOutlet.setImage(UIImage(named: ImageNames.emptyImg), for: .normal)
        
    }
}
