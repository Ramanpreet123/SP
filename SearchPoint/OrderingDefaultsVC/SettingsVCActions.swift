//
//  SettingsVCActions.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 11/01/25.
//

import Foundation
import UIKit
//MARK: IB ACTIONS

extension SettingsVC {
    @IBAction func dateAction(_ sender: UIButton) {
        UserDefaults.standard.set("MM", forKey: "date")
        self.setButtonState(button: dateBtnOutlet, isOn: true)
        self.setButtonState(button: date1BtnOutlet, isOn: false)
        
    }
    
    @IBAction func dateAction1(_ sender: UIButton) {
        UserDefaults.standard.set("DD", forKey: "date")
        self.setButtonState(button: date1BtnOutlet, isOn: true)
        self.setButtonState(button: dateBtnOutlet, isOn: false)
        
    }
    
    @IBAction func zoetisBtnAction(_ sender: Any) {
        UserDefaults.standard.set("Zoetis", forKey: "NominatorSave")
        self.setButtonState(button: zoetisBtnOutlet, isOn: true)
        self.setButtonState(button: holsteinBtnOutlet, isOn: false)
    }
    
    
    @IBAction func holsteinBtnAction(_ sender: Any) {
        UserDefaults.standard.set("Holstein USA", forKey: "NominatorSave")
        self.setButtonState(button: holsteinBtnOutlet, isOn: true)
        self.setButtonState(button: zoetisBtnOutlet, isOn: false)
    }
    
    @IBAction func rfidAction(_ sender: UIButton) {
        ScreenDef = "officialid"
        UserDefaults.standard.set(ScreenDef, forKey: "screen")
        UserDefaults.standard.set(ScreenDef, forKey: "FOSampleTrackingDetailVC")
        UserDefaults.standard.set(ScreenDef, forKey: "FOReviewOrderVC")
        self.setButtonState(button: rfidBttn, isOn: true)
        self.setButtonState(button: farmIdBttn, isOn: false)
    }
    
    @IBAction func farmIDAction(_ sender: UIButton) {
        ScreenDef = "farmid"
        UserDefaults.standard.set(ScreenDef, forKey: "screen")
        UserDefaults.standard.set(ScreenDef, forKey: "FOReviewOrderVC")
        UserDefaults.standard.set(ScreenDef, forKey: "FOSampleTrackingDetailVC")
        self.setButtonState(button: farmIdBttn, isOn: true)
        self.setButtonState(button: rfidBttn, isOn: false)
    }
    
    @IBAction func ocrBtnAction(_ sender: Any) {
        let spName = UserDefaults.standard.value(forKey: "name") as? String
        if spName != "Dairy" {
            if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 {
                UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
            }
        }else {
            UserDefaults.standard.set("ocr", forKey: "scannerSelection")
        }
        
        self.setButtonState(button: ocrBtnOutlet, isOn: true)
        self.setButtonState(button: rfidBtnOutlet, isOn: false)
    }
    
    @IBAction func rfidBtnAction(_ sender: Any) {
        let spName = UserDefaults.standard.value(forKey: "name") as? String
        
        if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 && spName != "Dairy" {
            UserDefaults.standard.set("rfid", forKey: "beefScannerSelection")
        } else {
            
            UserDefaults.standard.set("rfid", forKey: "scannerSelection")
        }
        self.setButtonState(button: rfidBtnOutlet, isOn: true)
        self.setButtonState(button: ocrBtnOutlet, isOn: false)
    }
    
    
    @IBAction func alphaNumericKeyboardAction(_ sender: Any) {
        self.setButtonState(button: alphaNumericbtnOutler, isOn: true)
        self.setButtonState(button: numericKeyBoardBtnOutle, isOn: false)
        UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
    }
    
    @IBAction func numericKeyBoardAction(_ sender: Any) {
        self.setButtonState(button: numericKeyBoardBtnOutle, isOn: true)
        self.setButtonState(button: alphaNumericbtnOutler, isOn: false)
        UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
    }
    
    @IBAction func action_keyBoardPersistenceOn(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "scrollIsEnable")
        self.setButtonState(button: persistenceOnBtn, isOn: true)
        self.setButtonState(button: persistenceOffBtn, isOn: false)
        
    }
    
    @IBAction func action_keyBoardPersistenceOff(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "scrollIsEnable")
        self.setButtonState(button: persistenceOffBtn, isOn: true)
        self.setButtonState(button: persistenceOnBtn, isOn: false)
    }
    
    @IBAction func actionBtnIKeyBoardnfo(_ sender: Any) {
        if UIDevice().userInterfaceIdiom == .pad {
            return
        }
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        
        if langId == 1{
            
            var yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
            var strDeviceType = ""
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    strDeviceType = "iPhone 5 or 5S or 5C"
                case 1334:
                    strDeviceType = "iPhone 6/6S/7/8"
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    strDeviceType = "iPhone 6+/6S+/7+/8+"
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
                    
                case 2436:
                    strDeviceType = "iPhone X"
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                    
                case 2688,2796:
                    strDeviceType = "iPhone Xs Max"
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                    
                    strDeviceType = "iPhone Xr"
                default:
                    strDeviceType = "unknown"
                }
            }
            
            customPopView1.elipseImage2.isHidden = true
            customPopView1.elipseImage1.isHidden = false
            customPopView1.textLbl2.isHidden = false
            customPopView1.textLabel1.isHidden = false
            
            if UIDevice().userInterfaceIdiom == .phone{
                if(self.keyBoardViewHeight.constant == 90){
                    customPopView1.frame = CGRect(x: 52,y: yFrame+20 ,width: 310, height: 120)
                }
                else{
                    customPopView1.frame = CGRect(x: 52,y: yFrame+120 ,width: 310, height: 120)
                }
            }
            else {
                marketView.isHidden = true
                switch UIScreen.main.bounds.height {
                case 768:
                    customPopView1.frame = CGRect(x: evalutionProviderCV.frame.origin.x + 50,y: evalutionProviderCV.frame.origin.y + 370 ,width: 310, height: 133)
                case 810:
                    //primarlyBasedView.layer.frame.minY + 11 + 133 + 8
                    yFrame = (primarlyBasedView.layer.frame.minY + 152) -  self.scrolView.contentOffset.y
                    
                case 820:
                    // primarlyBasedView.layer.frame.minY + 11 + 133 + 18
                    yFrame = (primarlyBasedView.layer.frame.minY + 162) -  self.scrolView.contentOffset.y
                    
                case 834:
                    //primarlyBasedView.layer.frame.minY + 11 + 133 + 24
                    yFrame = (primarlyBasedView.layer.frame.minY + 168) -  self.scrolView.contentOffset.y
                    
                case 1024:
                    //  primarlyBasedView.layer.frame.minY + 11 + 133 + 38
                    yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                    
                case 1032:
                    yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                    
                default:
                    customPopView1.frame = CGRect(x: primaryBasedOutlet.frame.origin.x + 50,y: primaryBasedOutlet.frame.origin.y + 500 ,width: 310, height: 133)
                    
                }
                
            }
            customPopView1.textLabel1.text = NSLocalizedString("When enabled, keyboard will be persisted while screen scrolling and when disabled, keyboard will close while scrolling the screen.", comment: "")
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
            var strDeviceType = ""
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    strDeviceType = "iPhone 5 or 5S or 5C"
                case 1334:
                    strDeviceType = "iPhone 6/6S/7/8"
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    strDeviceType = "iPhone 6+/6S+/7+/8+"
                case 2436:
                    strDeviceType = "iPhone X"
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                    
                case 2688,2796:
                    strDeviceType = "iPhone Xs Max"
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 3621) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 36) -  self.scrolView.contentOffset.y
                    
                    strDeviceType = "iPhone Xr"
                default:
                    strDeviceType = "unknown"
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
            customPopView1.textLabel1.text =  NSLocalizedString("When enabled, keyboard will be persisted while screen scrolling and when disabled, keyboard will close while scrolling the screen.", comment: "")
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
    
    @IBAction func marketTipPopClick(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        
        var yFrame = (marketView.layer.frame.minY + 148) - self.scrolView.contentOffset.y
        
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = (marketView.layer.frame.minY + 148 - 7 + 3) - self.scrolView.contentOffset.y
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = (marketView.layer.frame.minY + 148 - 7 + 15) - self.scrolView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
                yFrame = (marketView.layer.frame.minY + 148 + 15) - self.scrolView.contentOffset.y
            case 2688,2796:
                strDeviceType = "iPhone Xs Max"
                yFrame = (marketView.layer.frame.minY + 148 + 27) - self.scrolView.contentOffset.y
            case 1792:
                yFrame = (marketView.layer.frame.minY + 148 + 27) - self.scrolView.contentOffset.y
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        
        
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        if UIDevice().userInterfaceIdiom == .phone{
            customPopView1.frame = CGRect(x: 39,y: yFrame  ,width: screenSize.width - 80, height: 155)
            
        }
        else {
            marketView.isHidden = true
            switch UIScreen.main.bounds.height {
            case 768:
                customPopView1.frame = CGRect(x: evalutionProviderCV.frame.origin.x + 50,y: evalutionProviderCV.frame.origin.y + 370 ,width: 310, height: 133)
            case 810:
                //primarlyBasedView.layer.frame.minY + 11 + 133 + 8
                yFrame = (primarlyBasedView.layer.frame.minY + 152) -  self.scrolView.contentOffset.y
                
            case 820:
                // primarlyBasedView.layer.frame.minY + 11 + 133 + 18
                yFrame = (primarlyBasedView.layer.frame.minY + 162) -  self.scrolView.contentOffset.y
                
            case 834:
                //primarlyBasedView.layer.frame.minY + 11 + 133 + 24
                yFrame = (primarlyBasedView.layer.frame.minY + 168) -  self.scrolView.contentOffset.y
                
            case 1024:
                //  primarlyBasedView.layer.frame.minY + 11 + 133 + 38
                yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                
            case 1032:
                yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                
            default:
                customPopView1.frame = CGRect(x: primaryBasedOutlet.frame.origin.x + 50,y: primaryBasedOutlet.frame.origin.y + 500 ,width: 310, height: 133)
            }
        }
        customPopView1.textLabel1.text =  NSLocalizedString("This is the genetic evaluation body that will provide your genomic test results. This will be selected by default based upon your market, but may be switched if required to order an evaluation from a different provider. There are restrictions on being able to change this setting.", comment: "")
        customPopView1.arrow_Top.frame = CGRect(x: marketView.layer .frame.minX - 32 , y: -24, width: 26, height: 26)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
    }
    
    @IBAction func datePickerEntryAction(_ sender: Any) {
        if !datepickerEntryBtn.isSelected {
            UserDefaults.standard.set("pickerMode", forKey: "defaultDatePicker")
            self.setButtonState(button: datepickerEntryBtn, isOn: true)
            self.setButtonState(button: defaultModeEntryBtn, isOn: false)
        }
        
    }
    
    @IBAction func defaultEntryModeAction(_ sender: Any) {
        if !defaultModeEntryBtn.isSelected {
            UserDefaults.standard.set("defaultEntry", forKey: "defaultDatePicker")
            self.setButtonState(button: defaultModeEntryBtn, isOn: true)
            self.setButtonState(button: datepickerEntryBtn, isOn: false)
        }
    }
    
    @IBAction func action_BiometricOn(_ sender: UIButton) {
        
        if !biometricOnOutlet.isSelected {
            self.setButtonState(button: biometricOnOutlet, isOn: true)
            self.setButtonState(button: biometricOffOutlet, isOn: false)
            gigya.biometric.optIn { (result) in
                
                switch result {
                case .success:
                    UserDefaults.standard.setValue(true, forKey: "BioMetricEnabled")
                case .failure: break
                    // Action failed
                }
            }
        }
        
    }
    
    @IBAction func action_BiometricOff(_ sender: Any) {
        if !biometricOffOutlet.isSelected {
            self.setButtonState(button: biometricOffOutlet, isOn: true)
            self.setButtonState(button: biometricOnOutlet, isOn: false)
            gigya.biometric.optOut{ (result) in
                
                switch result {
                case .success:
                    UserDefaults.standard.setValue(false, forKey: "BioMetricEnabled")
                case .failure: break
                    // Action failed
                }
            }
        }
    }
    
    
    @IBAction func showMenu(_ sender: UIButton) {
        //        self.saveResulyByPageViewModel?.timer.invalidate()
        //        self.workItem?.cancel()
        //        checkworkitem = true
        //        self.view.makeCorner(withRadius: 40)
        self.customerOrderSetting.saveCustomerSetting()
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController?.presentRightMenuViewController()
            
        }  else {
            self.sideMenuRevealSettingsViewController()?.revealSideMenu()
        }
    }
    
    @IBAction func bckBtnClick(_ sender: Any) {
        self.customerOrderSetting.saveCustomerSetting()
        
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        productPopupFlag = 0
        //   calendarViewBkg.isHidden = true
        billingView.isHidden = true
        let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
        if fetchPid.count == 0 {
            UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
        }
    }
    
    @IBAction func donePopUpClick(_ sender: Any) {
        let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
        let pid1 =   UserDefaults.standard.integer(forKey: "chpid")
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let data = fetchAllDataWithOrderIDWithBeef(entityName: "BeefAnimaladdTbl",pid:pid,userId:userId)
        let  pvid1 = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        UserDefaults.standard.set(nil, forKey: "On")
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        UserDefaults.standard.set(nil, forKey: "page")
        
        if  didselectTouched == true {
            UserDefaults.standard.set(false, forKey: "showbeefproductTbl")
            if pvid == 5 || pvid == 13 {
                //for Global
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                // deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if pvid == 5 {
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    } else {
                        if product.isAdded == "true" {
                            
                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                    
                }
            }
            if pvid == 6 {
                //for Brazil
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                // deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        
                    }
                    else {
                        deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                    }
                    
                }
                let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                let  orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
                
                let animalData =  beefFetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid)
                if animalData.count > 0 {
                    
                    
                    let product  = fetchAllData(entityName: "GetProductTblBeef")
                    
                    for k in 0 ..< animalData.count{
                        
                        let animalId = animalData[k] as! BeefAnimaladdTbl
                        
                        for i in 0 ..< product.count {
                            
                            let data = product[i] as! GetProductTblBeef
                            
                            beefSaveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: userId,udid:animalId.udid ?? "", animalId:  Int(animalId.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), orderTerrms: data.orderAcceptTerms ?? "")
                            
                        }
                    }
                }
                let selectedProduct = fetchAllData(entityName: "GetProductTblBeef")
                
                // let selectedProduct = fetchAllData(entityName: "GetProductTblBeef")
                let name = "GeneSTAR\u{00ae} Black"
                for product in selectedProduct as? [GetProductTblBeef] ?? [] {
                    if product.productName?.uppercased() == "Genotype Only".uppercased() {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        isGenotypeOnlyAdded = true
                    }
                    else if product.productName == name
                    {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        self.isGenostarblackOnlyAdded = true
                    }
                    else
                    {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        
                    }
                }
                
                
                if isGenotypeOnlyAdded == true
                {
                    if isGenostarblackOnlyAdded == true && isGenotypeOnlyAdded == true
                    {
                        UserDefaults.standard.set("GenotypeStarblack", forKey: "beefProduct")
                    }
                    else{
                        UserDefaults.standard.set("Genotype Only", forKey: "beefProduct")
                    }
                    
                }
                else {
                    if isGenostarblackOnlyAdded == true
                    {
                        UserDefaults.standard.set("GenStarblack", forKey: "beefProduct")
                    }
                    else
                    {
                        UserDefaults.standard.set("Non-Genotype", forKey: "beefProduct")
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
                        deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                }
            }
            
        }
        
        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
        if fetchPid.count > 0 {
            if let productTblBeef = fetchPid[0] as? GetProductTblBeef {
                if UserDefaults.standard.value(forKey: "settingDone") == nil || UserDefaults.standard.value(forKey: "settingDone") as? String == ""{
                    if UserDefaults.standard.string(forKey: "name") == "Beef"{
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        if pvid == 13 {
                            UserDefaults.standard.set("true", forKey: "settingDone")
                        }
                        if pvid == 5 {
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            if productTblBeef.productId == 20 {
                                UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                                UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
                                
                                //                                let vc = self.storyboard!.instantiateViewController(withIdentifier: "InheritQuestionaireController") as! InheritQuestionaireController
                                //                                vc.delegate = self
                                //                                self.navigationController?.present(vc, animated: false, completion: nil)
                            }
                            else{
                                UserDefaults.standard.set("Global HD50K", forKey: "beefProduct")
                            }
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            
                            if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as? String == "dataEntry" {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                                // }
                            }
                        }
                        if pvid == 6{
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as? String == "dataEntry" {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
                            }}
                        if pvid == 7{
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
                            }}
                    }
                    
                    
                    
                } else {
                    if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    }
                    if UserDefaults.standard.string(forKey: "name") == "Beef"{
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        if pvid == 5 {
                            
                            if productTblBeef.productId == 20 {
                                UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                                UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
                                
                            }
                            else {
                                UserDefaults.standard.set("Global HD50K", forKey: "beefProduct")
                            }
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                            
                        }
                        if pvid == 6{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                        if pvid == 7{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                    }
                }
            }
            //            calendarViewBkg.isHidden = true
            billingView.isHidden = true
        } else {
            if pvid == 6 {
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
            }else{
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
            }
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select the product(s)", comment: ""))
        }
    }
    
    @IBAction func continueToOrderBtnClk(_ sender: UIButton) {
        if UIDevice().userInterfaceIdiom == .pad {
            CommonClass.showAlertMessage(self, titleStr: "Alert!", messageStr: "In Progress.")
        }
        //  if UserDefaults.standard.value(forKey: "name") as? String  == "Beef"{
        //            if (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)! == nil || (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)! == 0 {
        //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr:NSLocalizedString("Please select a product grouping.", comment: "") )
        //                return
        //            }
        //        } else {
        //            if  (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)! == nil ||  (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)! == 0 {
        //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr:NSLocalizedString("Please select an evaluation provider.", comment: "") )
        //                return
        //            }
        //        }
        //
        //        if UserDefaults.standard.value(forKey: "NominatorSave") == nil || UserDefaults.standard.value(forKey: "NominatorSave") as? String == ""{
        //            UserDefaults.standard.set("Zoetis", forKey: "NominatorSave")
        //        }
        //        UserDefaults.standard.set("true", forKey: "settingDefault")
        //        let del =  UIApplication.shared.delegate as? AppDelegate
        //
        //        if UserDefaults.standard.value(forKey: "settingDone") == nil || UserDefaults.standard.value(forKey: "settingDone") as? String == ""{
        //
        //            if UserDefaults.standard.string(forKey: "name") == "Dairy"{
        //                UserDefaults.standard.set("true", forKey: "settingDone")
        //                let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        //
        //                if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as? String == "dataEntry" {
        //
        //                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //
        //                } else {
        //
        //                    if pviduser == 4 {
        //
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingAnimalVCGirlando")), animated: true)
        //                    } else {
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingAnimalVC")), animated: true)
        //                    }
        //                }
        //
        //            }
        //            if UserDefaults.standard.string(forKey: "name") == "Beef" {
        //
        //                guard UserDefaults.standard.integer(forKey: "BeefPvid") != 0 else {
        //                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr:NSLocalizedString("Please select a product grouping.", comment: "") )
        //                    return
        //                }
        //                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        //
        //                UserDefaults.standard.set("true", forKey: "settingDone")
        //                if pvid == 5 {
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
        //                    let product =  self.productArr.object(at: 0) as! GetProductTbl
        //                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
        //                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
        //                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
        //                    if let  products = productArr as? [GetProductTbl] {
        //                        for product in products {
        //                            product.isAdded = "true"
        //
        //                            UserDefaults.standard.set(product.productId, forKey: "chpid")
        //                        }
        //                    }
        //                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //
        //                    for product in self.productArr as? [GetProductTbl] ?? [] {
        //
        //                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //                    }
        //                    UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
        //                    //For Global
        //                    if productPopupFlag == 0{
        //                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
        //                        if fetchPid.count > 0 {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
        //                                if foundProductName.count > 0 {
        //                                    product.isAdded = foundProductName[0].isAdded
        //                                } else {
        //                                    product.isAdded = "false"
        //                                }
        //                            }
        //                        }
        //                        else {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                product.isAdded = "false"
        //                            }
        //                        }
        //
        //                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //                        }else {
        //
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
        //                        }
        //                   productTblView.reloadData()
        //
        //                    } else {
        //                        productPopupFlag = 0
        //
        //                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //                        }else {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
        //                        }
        //                    }
        //                }
        //                if pvid == 13 {
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
        //                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //
        //                    let product =  self.productArr.object(at: 0) as! GetProductTbl
        //                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
        //                    // UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
        //                    if let  products = productArr as? [GetProductTbl] {
        //                        for product in products {
        //                            product.isAdded = "true"
        //
        //                            UserDefaults.standard.set(product.productId, forKey: "chpid")
        //                        }
        //                    }
        //
        //                    for product in self.productArr as? [GetProductTbl] ?? [] {
        //                        if product.isAdded == "true" {
        //
        //                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: "87c30632-8da0-4f86-8d94-46da17c520dd", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //                        }
        //                    }
        //
        //                    //For Global
        //                    if productPopupFlag == 0{
        //                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
        //                        if fetchPid.count > 0 {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
        //                                if foundProductName.count > 0 {
        //                                    product.isAdded = foundProductName[0].isAdded
        //                                } else {
        //                                    product.isAdded = "false"
        //                                }
        //                            }
        //                        } else {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                product.isAdded = "false"
        //                            }
        //                        }
        //
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefUSAddAnimalVC")), animated: true)
        //
        //                        productTblView.reloadData()
        //
        //                    }
        //
        //                }
        //
        //                if pvid == 6 {
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
        //                    //For Brazil
        //                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //                    deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
        //                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
        //                    deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
        //                    for product in self.productArr as? [GetProductTbl] ?? [] {
        //                        if product.isAdded == "true" {
        //                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //
        //                        }
        //                        else {
        //                            deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
        //                        }
        //
        //                    }
        //                    if productPopupFlag == 0 {
        //                        // deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
        //                        if fetchPid.count > 0 {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                product.isAdded = "false"
        //                            }
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
        //                                if foundProductName.count > 0 {
        //                                    product.isAdded = foundProductName[0].isAdded
        //                                } else {
        //                                    product.isAdded = "false"
        //                                }
        //                            }
        //
        //                        } else {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                product.isAdded = "false"
        //                            }
        //                        }
        //
        //                        productPopupFlag = 1
        ////                        calendarViewBkg.isHidden = false
        //                        billingView.isHidden = false
        //                        productTblView.reloadData()
        //
        //                    } else {
        //                        productPopupFlag = 0
        //                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //                        } else {
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
        //                        }}
        //                }
        //
        //                if pvid == 7 {
        //                    //For Newzealand
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
        //                    if productPopupFlag == 0 {
        //                        for product in self.productArr as? [GetProductTbl] ?? [] {
        //                            product.isAdded = "true"
        //                        }
        //
        //                        for product in self.productArr as? [GetProductTbl] ?? [] {
        //                            if product.isAdded == "true" {
        //                                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //                                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
        //                                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
        //                                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
        //                                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
        //                                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!,status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //                            }
        //                        }
        //                        UserDefaults.standard.set("true", forKey: "settingDone")
        //                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as? String == "dataEntry" {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //                        } else {
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
        //                        }
        //                    } else {
        //                        productPopupFlag = 0
        //
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
        //                    }
        //                }
        //
        //                UserDefaults.standard.set("true", forKey: "beefProductAdded")
        //            }
        //
        //        } else {
        //            UserDefaults.standard.set("true", forKey: "settingDone")
        //
        //            if UserDefaults.standard.string(forKey: "name") == "Dairy"{
        //
        //                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        //            }
        //            if UserDefaults.standard.string(forKey: "name") == "Beef"{
        //
        //                guard UserDefaults.standard.integer(forKey: "BeefPvid") != 0 else {
        //                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select a product grouping.", comment: ""))
        //                    return
        //                }
        //
        //                UserDefaults.standard.set("true", forKey: "beefProductAdded")
        //
        //                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        //
        //                if pvid == 5 {
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: Int(pvid))
        //                    let product =  self.productArr.object(at: 0) as! GetProductTbl
        //                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
        //                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
        //                    if let  products = productArr as? [GetProductTbl] {
        //                        for product in products {
        //                            product.isAdded = "true"
        //
        //                            UserDefaults.standard.set(product.productId, forKey: "chpid")
        //                        }
        //
        //                    }
        //                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //
        //                    for product in self.productArr as? [GetProductTbl] ?? [] {
        //
        //                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //                    }
        //                    UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
        //                    //For Global
        //                    if productPopupFlag == 0 {
        //                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
        //                        if fetchPid.count > 0 {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
        //                                if foundProductName.count > 0 {
        //                                    product.isAdded = foundProductName[0].isAdded
        //                                } else {
        //                                    product.isAdded = "false"
        //                                }
        //                            }
        //                        } else {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                product.isAdded = "false"
        //                            }
        //                        }
        //
        //                        productPopupFlag = 1
        //
        //                        productTblView.reloadData()
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        //                    }
        //                    else{
        //                        productPopupFlag = 0
        //
        //                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //                        }else {
        //
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
        //                        }
        //                    }
        //                }
        //                if pvid == 13 {
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
        //                    let product =  self.productArr.object(at: 0) as! GetProductTbl
        //                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
        //                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //                    //UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
        //                    if let  products = productArr as? [GetProductTbl] {
        //                        for product in products {
        //                            product.isAdded = "true"
        //
        //                            UserDefaults.standard.set(product.productId, forKey: "chpid")
        //                        }
        //
        //                    }
        //                    for product in self.productArr as? [GetProductTbl] ?? [] {
        //                        if product.isAdded == "true" {
        //
        //                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //                        }
        //                    }
        //                    UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
        //                    //For Global
        //                    if productPopupFlag == 0 {
        //                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
        //                        if fetchPid.count > 0 {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
        //                                if foundProductName.count > 0 {
        //                                    product.isAdded = foundProductName[0].isAdded
        //                                } else {
        //                                    product.isAdded = "false"
        //                                }
        //                            }
        //                        } else {
        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
        //                                product.isAdded = "false"
        //                            }
        //                        }
        //
        //                        productPopupFlag = 1
        //                        productTblView.reloadData()
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        //                    }
        //                    else{
        //                        productPopupFlag = 0
        //
        //
        //
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefUSAddAnimalVC")), animated: true)
        //
        //                    }
        //                }
        //
        //
        //                if pvid == 6 {
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
        //
        //                    if productPopupFlag == 0 {
        //
        //                        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //                        for product in self.productArr as? [GetProductTbl] ?? [] {
        //                            if product.isAdded == "true" {
        //
        //                                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //                            }
        //                        }
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        //                    } else {
        //                        productPopupFlag = 0
        //                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //                        } else {
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
        //                        }}
        //                }
        //
        //                if pvid == 7 {
        //                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
        //                    if productPopupFlag == 0 {
        //
        //                        for product in self.productArr as? [GetProductTbl] ?? [] {
        //                            product.isAdded = "true"
        //                        }
        //
        //                        for product in self.productArr as? [GetProductTbl] ?? [] {
        //                            if product.isAdded == "true" {
        //                                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        //
        //                                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
        //                                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
        //                            }
        //                        }
        //
        //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        //
        //                    } else {
        //                        productPopupFlag = 0
        //                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
        //
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
        //
        //                        }else {
        //                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
        //                        }}
        //                }
        //            }
        //        }
        //        self.customerOrderSetting.saveCustomerSetting()
    }
    
    @IBAction func ocrInfoPopAction(_ sender: UIButton) {
        if UIDevice().userInterfaceIdiom == .pad {
            return
        }
        let screenSize = UIScreen.main.bounds
        //        self.ocrViewShow.isHidden = false
        //        ocrBackroundBtnOutlet.isHidden = false
        //        ocrViewShow.layer.cornerRadius = 13
    }
    
    @IBAction func primarlyBasedTipPopClock(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        // primarlyBasedView.layer.frame.minY + 11 + 133 + 18
        var yFrame = (primarlyBasedView.layer.frame.minY + 162) -  self.scrolView.contentOffset.y
        var strDeviceType = ""
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                //primarlyBasedView.layer.frame.minY + 11 + 133 + 8
                yFrame = (primarlyBasedView.layer.frame.minY + 152) -  self.scrolView.contentOffset.y
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                // primarlyBasedView.layer.frame.minY + 11 + 133 + 18
                yFrame = (primarlyBasedView.layer.frame.minY + 162) -  self.scrolView.contentOffset.y
                
            case 2436:
                strDeviceType = "iPhone X"
                //primarlyBasedView.layer.frame.minY + 11 + 133 + 24
                yFrame = (primarlyBasedView.layer.frame.minY + 168) -  self.scrolView.contentOffset.y
                
            case 2688,2796:
                strDeviceType = "iPhone Xs Max"
                //  primarlyBasedView.layer.frame.minY + 11 + 133 + 38
                yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                
            case 1792:
                // primarlyBasedView.layer.frame.minY + 11 + 133 + 38
                yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        customPopView1.elipseImage2.isHidden = false
        customPopView1.elipseImage1.isHidden = false
        customPopView1.textLbl2.isHidden = false
        customPopView1.textLabel1.isHidden = false
        if UIDevice().userInterfaceIdiom == .phone{
            customPopView1.frame = CGRect(x: 52,y: yFrame ,width: 310, height: 133)
            
        }
        else {
            switch UIScreen.main.bounds.height {
            case 768:
                customPopView1.frame = CGRect(x: primarlyBasedView.frame.origin.x + 70,y: primarlyBasedView.frame.origin.y + 510 ,width: 310, height: 133)
            case 810:
                //primarlyBasedView.layer.frame.minY + 11 + 133 + 8
                yFrame = (primarlyBasedView.layer.frame.minY + 152) -  self.scrolView.contentOffset.y
                
            case 820:
                // primarlyBasedView.layer.frame.minY + 11 + 133 + 18
                yFrame = (primarlyBasedView.layer.frame.minY + 162) -  self.scrolView.contentOffset.y
                
            case 834:
                //primarlyBasedView.layer.frame.minY + 11 + 133 + 24
                yFrame = (primarlyBasedView.layer.frame.minY + 168) -  self.scrolView.contentOffset.y
                
            case 1024:
                //  primarlyBasedView.layer.frame.minY + 11 + 133 + 38
                yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                
            case 1032:
                yFrame = (primarlyBasedView.layer.frame.minY + 182) -  self.scrolView.contentOffset.y
                
            default:
                customPopView1.frame = CGRect(x: primaryBasedOutlet.frame.origin.x + 50,y: primaryBasedOutlet.frame.origin.y + 500 ,width: 310, height: 133)
                
            }
            
        }
        
        customPopView1.textLabel1.text = NSLocalizedString("On-Farm ID can be the Herd Management #.", comment: "")//\n\n
        customPopView1.textLbl2.text = NSLocalizedString("Official ID can be an Official RFID Tag, Unique Metal Ear Tag, Breed Registration#.", comment: "")
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
    
}
