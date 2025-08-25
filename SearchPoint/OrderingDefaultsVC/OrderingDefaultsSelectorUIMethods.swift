//
//  OrderingDefaultsSelectorUIMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 11/06/24.
//

import Foundation
import UIKit

// MARK: - OBJC SELECTOR METHODS
extension OrderingDefaultsVC {               
    @objc func specisButton(_ sender:UIButton) {
        
        self.speiecCountCheck = NSArray()
        self.speiecCountCheck = fetchSpeciesAllData(entityName: Entities.getSpeciesTblEntity)
        UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
        let specisObject : GetSpeciesTbl = speiecCountCheck.object(at: sender.tag) as! GetSpeciesTbl
        sender.titleLabel?.text = (specisObject.speciesName)?.localized
        
        
        
        if specisObject.speciesName ==  marketNameType.Dairy.rawValue {
            if sender.layer.borderColor == UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor {
                return
            }
            self.provideCountCheck = fetchdataOfProvider(specisId: SpeciesID.dairySpeciesId) as! [GetProviderTbl]
            if providerEvaliuater(arr: provideCountCheck).count == 0{
                self.evalutionProviderCV.reloadData()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noEvalProvider, comment: ""))
                self.provideCountCheck = fetchdataOfProvider(specisId: SpeciesID.beefSpeciesId) as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                return
                
            } else {
                getListProvider = providerEvaliuater(arr: provideCountCheck)
            }
            
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noEvalProvider, comment: ""))
                return
            } else {
                let selectedDairyProvider = getListProvider.filter({$0.isDefault == true })
                if UserDefaults.standard.object(forKey: keyValue.providerID.rawValue) == nil {
                    if selectedDairyProvider.count > 0{
                        UserDefaults.standard.setValue(selectedDairyProvider[0].providerId ?? 0, forKey: keyValue.providerID.rawValue)
                    }
                }
                marketTipYopOutlet.isHidden = false
                marketView.isHidden = false
                providerTitleLbl.isHidden = false
            }
                        
            switchFromDairy = true
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = false
            providerTitleLbl.text = NSLocalizedString(LocalizedStrings.providerMarkets, comment: "")
            
            if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 1 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 3
                || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 8 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 ||
                UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 12 ||
                UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 10{
                self.keyBoardViewHeight.constant = 200
                self.scannerViewHeight.constant = 100
                self.keyBoardTopView.constant = 115
                ocrInfoBtnOutle.isHidden = false
                self.keyBaordSepratorView.isHidden = false
                primarlyHeightConst.constant = 156
                keyboardTtile.isHidden = false
                keyboardSepratorTitle.isHidden = false
                alphaNumericbtnOutler.isHidden = false
                idScannerTitle.isHidden = false
                scannerSepratorBar.isHidden = false
                numericKeyBoardBtnOutle.isHidden = false
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
                if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2{
                    primarlyHeightConst.constant = 0
                }
            }
            else {
                self.keyBaordSepratorView.isHidden = false
                self.keyBoardViewHeight.constant = 90
                self.keyBoardTopView.constant = 5
                keyboardSepratorTitle.isHidden = false
                self.scannerViewHeight.constant = 0
                keyboardTtile.isHidden = true
                alphaNumericbtnOutler.isHidden = true
                idScannerTitle.isHidden = true
                scannerSepratorBar.isHidden = true
                numericKeyBoardBtnOutle.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                primarlyHeightConst.constant = 0
            }
            
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue || UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.USDairyProducts.rawValue{
                self.nominatorHeightConst.constant = 100
                
            }
            else if  UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBBR.rawValue{
                self.nominatorHeightConst.constant = 100
            }
            else {
                self.nominatorHeightConst.constant = 0
            }
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                sender.isSelected = true
                sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            } else {
                
                sender.setImage(nil, for: .normal)
                sender.layer.borderColor = UIColor.lightGray.cgColor
                sender.backgroundColor = UIColor.white
            }
            for _ in 0 ..< provideCountCheck.count{
                isSelectedArray.append(false)
            }
            specname = specisObject.speciesName!
            UserDefaults.standard.set(specname, forKey: "name")
            UserDefaults.standard.set(specisObject.speciesId, forKey: keyValue.speciesId.rawValue)
            saveSettingData(entity: Entities.settingTblEntity, specisId: specisObject.speciesId ?? "", specisName: specisObject.speciesName ?? "", providerName: "", providerId: 0, nominater: keyValue.zoetis.rawValue, fromDatae: "", toDate: "", status: "true",index: sender.tag)
            
            if UserDefaults.standard.object(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
            } else {
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
            }
            
        }  else if specisObject.speciesName ==  marketNameType.Beef.rawValue {
            if sender.layer.borderColor == UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor {
                return
            }
            let marketId = UserDefaults.standard.object(forKey: keyValue.currentActiveMarketId.rawValue) as? String ?? ""
            self.provideCountCheck = fetchdataOfProvider(specisId: SpeciesID.beefSpeciesId) as! [GetProviderTbl]
            let providercheck = providerEvaliuater(arr: provideCountCheck)
            
            if providercheck.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noAssociatedProductStr, comment: ""))
                self.provideCountCheck = fetchdataOfProvider(specisId: SpeciesID.dairySpeciesId) as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                return
                
            } else {
                getListProvider = providercheck
                let selectedProvider = getListProvider.filter({$0.isDefault == true })
                if selectedProvider.count > 0 {
                    // raman commented this because of default product selection in beef
                  //  UserDefaults.standard.setValue(selectedProvider[0].providerId, forKey: keyValue.beefPvid.rawValue)
                    if UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 13 || UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 5 {
                        if UserDefaults.standard.object(forKey: keyValue.beefScannerSelection.rawValue) as? String ==  nil && UserDefaults.standard.string(forKey: keyValue.providerName.rawValue) == keyValue.USDairyProducts.rawValue {
                            UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
                        }
                    }
                }
                marketView.isHidden = true
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = false
            }
            
            self.keyBaordSepratorView.isHidden = false
            self.keyBoardViewHeight.constant = 90
            self.keyBoardTopView.constant = 5
            keyboardSepratorTitle.isHidden = false
            self.scannerViewHeight.constant = 0
            keyboardTtile.isHidden = true
            alphaNumericbtnOutler.isHidden = true
            idScannerTitle.isHidden = true
            scannerSepratorBar.isHidden = true
            numericKeyBoardBtnOutle.isHidden = true
            ocrBtnOutlet.isHidden = true
            rfidBtnOutlet.isHidden = true
            ocrInfoBtnOutle.isHidden = true
            switchFromDairy = true
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString(LocalizedStrings.productGroupings, comment: "")
            primarlyHeightConst.constant = 0
            nominatorHeightConst.constant = 0
            sender.isSelected = !sender.isSelected
            
            if sender.isSelected {
                sender.isSelected = true
                sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            } else {
                sender.setImage(nil, for: .normal)
                sender.layer.borderColor = UIColor.lightGray.cgColor
                sender.backgroundColor = UIColor.white
            }
            
            for _ in 0 ..< provideCountCheck.count{
                isSelectedArray.append(false)
            }
            
            specname = specisObject.speciesName!
            UserDefaults.standard.set(specname, forKey: "name")
            UserDefaults.standard.set( specisObject.speciesId, forKey: keyValue.speciesId.rawValue)
            saveSettingData(entity: Entities.settingTblEntity, specisId: specisObject.speciesId ?? "", specisName: specisObject.speciesName ?? "", providerName: "", providerId: 0, nominater: "", fromDatae: "", toDate: "", status: "true",index: sender.tag)
            let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
            
            if let  products = productArr as? [GetProductTbl] {
                for product in products {
                    product.isAdded = "false"
                }
                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                
            }
            productTblView.reloadData()
            if UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 13  || UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 5 && marketId == MarketID.USMarketId {
                self.scannerViewHeight.constant = 100
                idScannerTitle.isHidden = false
                scannerViewShow.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                
                if UserDefaults.standard.object(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
                } else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
                }
            }
        }
        self.evalutionProviderCV.reloadData()
        self.speciesCollectionView.reloadItems(at: self.speciesCollectionView.indexPathsForVisibleItems)
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    
    @objc func switchScrollChanged(mySwitch: UISwitch) {
        if(!mySwitch.isOn){
            UserDefaults.standard.set(false, forKey: keyValue.scrollIsEnable.rawValue)
        }
        else{
            UserDefaults.standard.set(true, forKey: keyValue.scrollIsEnable.rawValue)
        }
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        
        if value == 0
        {
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
        
    }
  

    
    
    @objc  func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected".localized{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            
        } else {
            self.offLineBtn.isUserInteractionEnabled = false
            
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
 
    @objc func buttonbgPressedTipInof (){
        buttonbg1.removeFromSuperview()
    }
    
    @objc func marketTipPop() {
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        
        var yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = CGRect(x: 18,y: 370  ,width: screenSize.width - 80, height: 137)
                
            case 1920, 2208:
                yFrame = CGRect(x: 36,y: 405  ,width: screenSize.width - 80, height: 137)
                
            case 2436:
                yFrame = CGRect(x: 18,y: 447  ,width: screenSize.width - 80, height: 137)
                
            case 2688,2796:
                yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
                
            case 1792:
                yFrame = CGRect(x: 37,y: 488  ,width: screenSize.width - 80, height: 137)
                
            default:
                break
            }
        }
        
        customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  + 5
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = yFrame
        customPopView1.textLabel1.text =  NSLocalizedString(LocalizedStrings.inheritConnectString, comment: "")
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
    }
    
    @objc func providerButton(_ sender:UIButton) {
        let speciesName = UserDefaults.standard.value(forKey: "speciesName") as? String
        if speciesName != ""{
            UserDefaults.standard.setValue(speciesName, forKey: keyValue.name.rawValue)
            UserDefaults.standard.removeObject(forKey: "speciesName")
        }
        UserDefaults.standard.removeObject(forKey: keyValue.capsBrazil.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.page.rawValue)
        UserDefaults.standard.removeObject(forKey: "on")
        if UserDefaults.standard.string(forKey: "name") == marketNameType.Dairy.rawValue {
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            
            let providerObject : GetProviderTbl = self.getListProvider[sender.tag] as! GetProviderTbl
            let pviduser = UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue )
            
            if pviduser != providerObject.providerId {
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.changeProviderAlert, comment: ""),   preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
                    
                    
                }))
                alert.addAction(UIAlertAction(title:  NSLocalizedString("OK", comment: ""),style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                    
                    let sampleType =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: Int(providerObject.providerId) )
                    var animaltbl = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                    for i in 0 ..< sampleType.count {
                        let samType  = sampleType[i] as! GetSampleTbl
                        animaltbl = animaltbl.filter { (item) -> Bool in
                            if let value = item as? AnimaladdTbl, value.tissuName != samType.sampleName{
                                return true
                            } else {
                                return false
                            }
                        }
                    }
                    
                    let breedType = fetchBreedData(entityName: Entities.getBreedsTblEntity, provId:  Int(providerObject.providerId) )
                    var animaltbl1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                    
                    for i in 0 ..< breedType.count {
                        let bredTy  = breedType[i] as! GetBreedsTbl
                        animaltbl1 = animaltbl1.filter { (item) -> Bool in
                            if let value = item as? AnimaladdTbl, value.breedId != bredTy.breedId{
                                return true
                            } else {
                                return false
                            }
                        }
                    }
                    
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                    
                    
                    var strinBreed = String()
                    var StringSampleType = String()
                    if animaltbl1.count > 0 || animaltbl.count > 0 {
                        if animaltbl1.count > 0{
                            strinBreed =  "Breed of \(animaltbl1.count) animal(s) not available in the selected provider."
                        }
                        else if animaltbl.count > 0{
                            StringSampleType = "Sample type of \(animaltbl.count) animal(s) not available in the selected provider."
                        }
                        
                        
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("\(strinBreed) \(StringSampleType) Do you want to remove animal(s) from the order?",comment : ""),  preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
                            return
                        }))
                        alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default,
                                                      handler: {(_: UIAlertAction!) in
                            sender.isSelected = !sender.isSelected
                            UserDefaults.standard.set(true, forKey: keyValue.isProviderChange.rawValue)
                            UserDefaults.standard.set(providerObject.providerName!, forKey: keyValue.providerNameUS.rawValue)
                            
                            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                            UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
                            deleteRecordFromDatabase(entityName: Entities.saveProviderTblEntity)
                            
                            saveSettingProviderData(entity: Entities.saveProviderTblEntity, specisId: providerObject.speciesId ?? "", specisName: self.specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: keyValue.zoetis.rawValue, fromDatae: "", toDate: "", status: "true", index: sender.tag)
                            let fetchAray = fetchAllData(entityName: Entities.saveProviderTblEntity)
                            let pvId = fetchAray.object(at: 0) as! Saveprovider
                            
                            self.byDefaultProvider = pvId.providerName!
                            
                            UserDefaults.standard.set(providerObject.providerName!, forKey: keyValue.providerName.rawValue)
                            UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                            
                            
                            for item1 in animaltbl{
                                if let value = item1 as? AnimaladdTbl{
                                    if animaltbl.count == 1 {
                                        
                                        deleteDataWithAnimalSampleType(value.tissuName!,orderstatus:"false")
                                        self.createListNameAndCheckifExist()
                                    } else {
                                        deleteDataWithAnimalSampleType(value.tissuName!,orderstatus:"false")
                                    }
                                }
                            }
                            
                            for item in animaltbl1{
                                if let value = item as? AnimaladdTbl{
                                    if animaltbl1.count == 1 {
                                        deleteDataWithAnimalBreedId(value.breedId!,orderstatus:"false")
                                        self.createListNameAndCheckifExist()
                                    } else {
                                        deleteDataWithAnimalBreedId(value.breedId!,orderstatus:"false")
                                    }
                                }
                            }
                            UserDefaults.standard.set(Int(pvId.providerId), forKey: keyValue.providerID.rawValue)
                            self.updateProviderId()
                            self.createListNameAndCheckifExist()
                            if sender.isSelected {
                                self.isSelectedArray[sender.tag] = true
                                for i in 0 ..<  self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                  let arrData =    self.getListProvider[i] 
                                    if pvid == arrData.providerId{
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                    }
                                    else{
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                    }
                                    
                                }
                                
                            } else {
                                
                                self.isSelectedArray[sender.tag] = false
                                for i in 0 ..<  self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                    let arrData = self.getListProvider[i] as! GetProviderTbl
                                    if pvid == arrData.providerId{
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        
                                    } else {
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                    }
                                }
                            }
                            self.addProduct()
                            
                            
                            
                            guard let providerChange = UserDefaults.standard.bool(forKey: keyValue.isProviderChange.rawValue) as? Bool else { return }
                            UserDefaults.standard.removeObject(forKey: keyValue.isProviderChange.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                            UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
                            UserDefaults.standard.set(providerObject.providerName!, forKey: keyValue.providerName.rawValue)
                            UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                            UserDefaults.standard.set("", forKey: keyValue.foReviewOrderVC.rawValue)
                            UserDefaults.standard.set("", forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(false, forKey: "BVDVSeleted")
                            
                            let sampleType =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: Int(pvId.providerId)  )
                            var animaltbl = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                            for i in 0 ..< sampleType.count {
                                let samType  = sampleType[i] as! GetSampleTbl
                                animaltbl = animaltbl.filter { (item) -> Bool in
                                    if let value = item as? AnimaladdTbl, value.tissuName != samType.sampleName{
                                        return true
                                    } else {
                                        return false
                                    }
                                }
                            }
                            
                            let breedType = fetchBreedData(entityName: Entities.getBreedsTblEntity, provId:  Int(pvId.providerId) )
                            var animaltbl1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                            
                            for i in 0 ..< breedType.count {
                                let bredTy  = breedType[i] as! GetBreedsTbl
                                animaltbl1 = animaltbl1.filter { (item) -> Bool in
                                    if let value = item as? AnimaladdTbl, value.breedId != bredTy.breedId{
                                        return true
                                    } else {
                                        return false
                                    }
                                }
                            }
                            
                            if sender.tag == 3 {
                                
                            } else {
                                
                                if sender.tag == 2 {
                                    UserDefaults.standard.set(true, forKey: keyValue.clickAuProvider.rawValue)
                                    
                                } else {
                                    
                                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                                    
                                }
                            }
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else {
                        
                        UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                        
                        sender.isSelected = !sender.isSelected
                        UserDefaults.standard.set(true, forKey: keyValue.isProviderChange.rawValue)
                        UserDefaults.standard.set(providerObject.providerName!, forKey: keyValue.providerNameUS.rawValue)
                        
                        UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
                        deleteRecordFromDatabase(entityName: Entities.saveProviderTblEntity)
                        
                        saveSettingProviderData(entity: Entities.saveProviderTblEntity, specisId: providerObject.speciesId ?? "", specisName: self.specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: keyValue.zoetis.rawValue, fromDatae: "", toDate: "", status: "true", index: sender.tag)
                        let fetchAray = fetchAllData(entityName: Entities.saveProviderTblEntity)
                        let pvId = fetchAray.object(at: 0) as! Saveprovider
                        
                        self.byDefaultProvider = pvId.providerName!
                        
                        UserDefaults.standard.set(providerObject.providerName!, forKey: keyValue.providerName.rawValue)
                        UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                        
                        if  sender.isSelected {
                            self.isSelectedArray[sender.tag] = true
                            for i in 0 ..<  self.getListProvider.count {
                                
                                let myIndexPath = NSIndexPath(row: i, section: 0)
                                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                let arrData =    self.getListProvider[i] as! GetProviderTbl
                                if pvid == arrData.providerId{
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    
                                }
                                else{
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                    item.EcalutionProviderBttn.layer.borderWidth = 1
                                }
                            }
                            
                        } else {
                            
                            self.isSelectedArray[sender.tag] = false
                            for i in 0 ..<  self.getListProvider.count {
                                let myIndexPath = NSIndexPath(row: i, section: 0)
                                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                let arrData =    self.getListProvider[i] as! GetProviderTbl
                                if pvid == arrData.providerId{
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    
                                } else {
                                    item.EcalutionProviderBttn.layer.borderWidth = 1
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                }
                            }
                        }
                        self.addProduct()
                        self.updateProviderId()
                    }
                    
                    if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue{
                        self.nominatorHeightConst.constant = 100
                        
                    }else  if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBBR.rawValue{
                        self.nominatorHeightConst.constant = 100
                        
                    }
                    else{
                        self.nominatorHeightConst.constant = 0
                    }
                    UserDefaults.standard.set(keyValue.noNeedAuPopUp.rawValue, forKey: keyValue.isAuSelected.rawValue)
                    
                    
                    if providerObject.providerId == 1 || providerObject.providerId == 3 || providerObject.providerId == 8{
                        
                        self.primarlyHeightConst.constant = 156
                    } else {
                        
                        self.primarlyHeightConst.constant = 0
                    }
                    
                    if providerObject.providerId == 1 ||  providerObject.providerId == 2 || providerObject.providerId == 3 || providerObject.providerId == 8 {
                        self.scannerViewHeight.constant = 100
                        self.keyBoardViewHeight.constant = 200
                        self.keyBoardTopView.constant = 115
                        self.keyBaordSepratorView.isHidden = true
                        self.keyboardTtile.isHidden = false
                        self.keyboardSepratorTitle.isHidden = false
                        self.alphaNumericbtnOutler.isHidden = false
                        self.idScannerTitle.isHidden = false
                        self.scannerSepratorBar.isHidden = false
                        self.numericKeyBoardBtnOutle.isHidden = false
                        self.ocrBtnOutlet.isHidden = false
                        self.rfidBtnOutlet.isHidden = false
                        
                        
                        self.ocrInfoBtnOutle.isHidden = false
                    } else{
                        self.keyBaordSepratorView.isHidden = false
                        self.keyBoardViewHeight.constant = 90
                        self.keyBoardTopView.constant = 5
                        self.keyboardSepratorTitle.isHidden = false
                        self.scannerViewHeight.constant = 0
                        self.keyboardTtile.isHidden = true
                        
                        self.alphaNumericbtnOutler.isHidden = true
                        self.idScannerTitle.isHidden = true
                        self.scannerSepratorBar.isHidden = true
                        self.numericKeyBoardBtnOutle.isHidden = true
                        self.ocrBtnOutlet.isHidden = true
                        self.rfidBtnOutlet.isHidden = true
                        self.ocrInfoBtnOutle.isHidden = true
                        
                    }
                    
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                
                sender.isSelected = !sender.isSelected
                UserDefaults.standard.set(true, forKey: keyValue.isProviderChange.rawValue)
                UserDefaults.standard.set(providerObject.providerName!, forKey: keyValue.providerNameUS.rawValue)
                
                UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
                deleteRecordFromDatabase(entityName: Entities.saveProviderTblEntity)
                
                saveSettingProviderData(entity: Entities.saveProviderTblEntity, specisId: providerObject.speciesId ?? "", specisName: specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: keyValue.zoetis.rawValue, fromDatae: "", toDate: "", status: "true", index: sender.tag)
                let fetchAray = fetchAllData(entityName: Entities.saveProviderTblEntity)
                let pvId = fetchAray.object(at: 0) as! Saveprovider
                
                self.byDefaultProvider = pvId.providerName!
                
                UserDefaults.standard.set(providerObject.providerName!, forKey: keyValue.providerName.rawValue)
                UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
            }
        } else {
            
            let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            self.keyBaordSepratorView.isHidden = false
            self.keyBoardViewHeight.constant = 90
            self.keyBoardTopView.constant = 5
            self.keyboardSepratorTitle.isHidden = false
            UserDefaults.standard.removeObject(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
            
            UserDefaults.standard.set("GLobal", forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
            let pid =   UserDefaults.standard.integer(forKey: keyValue.bfProductId.rawValue)
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            var pvid1 = UserDefaults.standard.value(forKey: keyValue.beefPvid.rawValue) as? Int
            if pvid1  == 0 || pvid1 == nil {
                UserDefaults.standard.setValue(Constants.beefPvId, forKey: keyValue.beefPvid.rawValue)
                pvid1 = Constants.beefPvId
                Constants.beefPvId = Int()
            }
            if pvid1 == 13 || pvid1 == 5 {
                scannerViewHeight.constant = 100
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
            } else {
                scannerViewHeight.constant = 0
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                
            }
            let providerObjects : GetProviderTbl = (self.getListProvider[sender.tag] as! GetProviderTbl)
            
            if pvid1 ?? 0 != providerObjects.providerId{
                
                
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.changeProductGrouping, comment: "") , preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    action in
                    
                    let providerObject : GetProviderTbl = self.getListProvider[sender.tag] as! GetProviderTbl
                    UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                    
                    if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) != Int(providerObject.providerId) {
                        
                        
                        
                        if pvid == 5 || pvid ==  13{
                            let sampleType =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: Int(providerObject.providerId) )
                            var animaltbl = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:1,userId:userId).mutableCopy() as! [BeefAnimaladdTbl]
                            
                            var animaltbl1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:1,userId:userId).mutableCopy() as! [BeefAnimaladdTbl]
                            
                            for i in 0 ..< sampleType.count {
                                let samType  = sampleType[i] as! GetSampleTbl
                                animaltbl = animaltbl.filter { (item) -> Bool in
                                    if let value = item as? BeefAnimaladdTbl, value.tissuName != samType.sampleName{
                                        return true
                                    } else {
                                        return false
                                    }
                                }
                            }
                            
                            var StringSampleType = String()
                            
                            if animaltbl.count > 0{
                                StringSampleType = "Sample type of \(animaltbl.count) animal(s) not available in the selected provider."
                                
                                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("\(StringSampleType) Do you want to remove animal(s) from the order?",comment : ""),  preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default, handler: {_ in
                                    return
                                }))
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style:UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
                                    
                                    UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.beefPvid.rawValue)
                                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                                    
                                    self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: Int(providerObject.providerId))
                                    
                                    self.productPopupFlag = 0
                                    
                                    
                                    for i in 0 ..<  self.getListProvider.count {
                                        let myIndexPath = NSIndexPath(row: i, section: 0)
                                        let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                                        let arrData =  self.getListProvider[i] as! GetProviderTbl
                                        
                                        if pvid == arrData.providerId {
                                            item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                            item.EcalutionProviderBttn.layer.borderWidth = 2
                                            
                                        } else {
                                            item.EcalutionProviderBttn.layer.borderWidth = 1
                                            item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                            item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                        }
                                    }
                                    self.productTblView.reloadData()
                                    
                                    
                                    UserDefaults.standard.removeObject(forKey: keyValue.beefProduct.rawValue)
                                    if let  products = self.productArr as? [GetProductTbl] {
                                        for product in products {
                                            product.isAdded = "false"
                                        }
                                    }
                                    deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                                    sender.isSelected = !sender.isSelected
                                    UserDefaults.standard.set(true, forKey: keyValue.isProviderChange.rawValue)
                                    UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                                    UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
                                    deleteRecordFromDatabase(entityName: Entities.saveProviderTblEntity)
                                    
                                    saveSettingProviderData(entity: Entities.saveProviderTblEntity, specisId: providerObject.speciesId ?? "", specisName: self.specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: keyValue.zoetis.rawValue, fromDatae: "", toDate: "", status: "true", index: sender.tag)
                                    let fetchAray = fetchAllData(entityName: Entities.saveProviderTblEntity)
                                    let pvId = fetchAray.object(at: 0) as! Saveprovider
                                    
                                    self.byDefaultProvider = pvId.providerName!
                                    
                                    for item1 in animaltbl{
                                        if let value = item1 as? BeefAnimaladdTbl{
                                            if animaltbl.count == 1 {
                                                  
                                                deleteDataWithAnimalSampleTypeforBeef(value.tissuName!,orderstatus:"false")
                                            } else {
                                                deleteDataWithAnimalSampleTypeforBeef(value.tissuName!,orderstatus:"false")
                                            }
                                        }
                                    }
                                    UserDefaults.standard.set(Int(pvId.providerId), forKey: keyValue.providerID.rawValue)
                                    self.updateBeefProviderId()
                                    self.addBeefProducts()
                                    self.createListNameAndCheckifExist()
                                    
                                    
                                }))
                                
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                                UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.beefPvid.rawValue)
                                
                                self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: Int(providerObject.providerId))
                                
                                self.productPopupFlag = 0
                                
                                self.updateBeefProviderId()
                                self.addBeefProducts()
                                for i in 0 ..<  self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                                    let arrData =  self.getListProvider[i] as! GetProviderTbl
                                    
                                    if pvid == arrData.providerId {
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        
                                    } else {
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                    }
                                }
                                self.productTblView.reloadData()
                            }
                        } else {
                            deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                            UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.beefPvid.rawValue)
                            
                            self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: Int(providerObject.providerId))
                            
                            self.productPopupFlag = 0
                            
                            self.updateBeefProviderId()
                            self.addBeefProducts()
                            for i in 0 ..<  self.getListProvider.count {
                                let myIndexPath = NSIndexPath(row: i, section: 0)
                                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                                let arrData =  self.getListProvider[i] as! GetProviderTbl
                                
                                if pvid == arrData.providerId {
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    
                                } else {
                                    item.EcalutionProviderBttn.layer.borderWidth = 1
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                }
                            }
                            self.productTblView.reloadData()
                        }
                        
                    }
                    
                }
                
                let cancelAction = UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                    return
                }
                
                alertController.addAction(cancelAction)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
            else {
                let providerObject : GetProviderTbl = self.getListProvider[sender.tag] as! GetProviderTbl
                if UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) == nil || UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) as? String == ""{
                    UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                    if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) != Int(providerObject.providerId) {
                        UserDefaults.standard.removeObject(forKey: keyValue.beefProduct.rawValue)
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                            }
                            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                        }
                    }
                    
                    UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.beefPvid.rawValue)
                    let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                    self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
                    
                    self.productPopupFlag = 0
                    
                    for i in 0 ..<  self.getListProvider.count {
                        let myIndexPath = NSIndexPath(row: i, section: 0)
                        let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                        let arrData = getListProvider[i] as! GetProviderTbl
                        
                        
                        if pvid == arrData.providerId {
                            item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                            item.EcalutionProviderBttn.layer.borderWidth = 2
                            
                        } else {
                            item.EcalutionProviderBttn.layer.borderWidth = 1
                            item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                            item.EcalutionProviderBttn.backgroundColor = UIColor.white
                        }
                    }
                    self.productTblView.reloadData()
                } else{
                    if switchFromDairy == true{
                        switchFromDairy = false
                        UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
                        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) != Int(providerObject.providerId) {
                            
                            
                            UserDefaults.standard.removeObject(forKey: keyValue.beefProduct.rawValue)
                            if let  products = self.productArr as? [GetProductTbl] {
                                for product in products {
                                    product.isAdded = "false"
                                }
                                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                            }
                        }
                        
                        UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.beefPvid.rawValue)
                        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                        self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
                        
                        self.productPopupFlag = 0
                        
                        for i in 0 ..< self.getListProvider.count {
                            let myIndexPath = NSIndexPath(row: i, section: 0)
                            let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                            let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                            let arrData = getListProvider[i] as! GetProviderTbl
                            
                            
                            if pvid == arrData.providerId {
                                item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                item.EcalutionProviderBttn.layer.borderWidth = 2
                                
                            } else {
                                item.EcalutionProviderBttn.layer.borderWidth = 1
                                item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                item.EcalutionProviderBttn.backgroundColor = UIColor.white
                            }
                        }
                        self.productTblView.reloadData()
                    }
                    else{
                        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) != providerObjects.providerId{
                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.changeProductGrouping, comment: "") , preferredStyle: .alert)
                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default){
                                UIAlertAction in
                                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) != Int(providerObject.providerId) {
                                    
                                    
                                    UserDefaults.standard.removeObject(forKey: keyValue.beefProduct.rawValue)
                                    if let  products = self.productArr as? [GetProductTbl] {
                                        for product in products {
                                            product.isAdded = "false"
                                        }
                                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                                        if pvid == 5 || pvid ==  13{
                                            
                                        } else {
                                            deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                                        }
                                        deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                        deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                                        deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                                    }
                                }
                                
                                UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.beefPvid.rawValue)
                                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                                self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
                                
                                self.productPopupFlag = 0
                                
                                for i in 0 ..< self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                                    let arrData = self.getListProvider[i] as! GetProviderTbl
                                    
                                    
                                    if pvid == arrData.providerId {
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        
                                    } else {
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                    }
                                }
                                self.productTblView.reloadData()
                            }
                            let cancelAction = UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: UIAlertAction.Style.default) {
                                UIAlertAction in
                            }
                            alertController.addAction(cancelAction)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            return
                        }
                    }
                }
            }
            
        }
        
    }
    
    // MARK: - DID LOAD AND WILL APPEAR
    func setUIOnDidLoad(){
        if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
            btnSwitch.isOn = true
        }
        else{
            btnSwitch.isOn = false
        }
        btnSwitch.addTarget(self, action: #selector(switchScrollChanged), for: UIControl.Event.valueChanged)
        holsteinBtnOutlet.isHidden = true
        ocrViewShow.isHidden = true
        ocrBackroundBtnOutlet.isHidden = true
        getMarketsForCurrentCustomer()
        UserDefaults.standard.set( 1, forKey: keyValue.speciesId.rawValue)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        calendarViewBkg.isHidden = true
        let datevalue = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if datevalue == "MM"{
            dateBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            date1BtnOutlet.layer.borderWidth = 1
            dateBtnOutlet.layer.borderWidth = 2
        }
        else if datevalue == "DD" {
            date1BtnOutlet.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            dateBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            date1BtnOutlet.layer.borderWidth = 2
            dateBtnOutlet.layer.borderWidth = 1
        } else {
            dateBtnOutlet.layer.borderWidth = 2
        }
        
        self.speiecCountCheck = fetchSpeciesAllData(entityName: Entities.getSpeciesTblEntity)
        if UserDefaults.standard.value(forKey: "name") as? String == keyValue.clarifideCDCBUS.rawValue {
            UserDefaults.standard.setValue(marketNameType.Dairy.rawValue, forKey: "name")
        }
        if UserDefaults.standard.value(forKey: "name") as? String == marketNameType.Dairy.rawValue ||  UserDefaults.standard.value(forKey: "name") as? String == nil  {
            self.provideCountCheck = fetchdataOfProvider(specisId: SpeciesID.dairySpeciesId) as! [GetProviderTbl]
            getListProvider = providerEvaliuater(arr: provideCountCheck) as! [GetProviderTbl]
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noEvalProvider, comment: ""))
                marketView.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketView.isHidden = false
                providerTitleLbl.isHidden = false
            }
        }
        
        else if UserDefaults.standard.value(forKey: "name") as? String == marketNameType.Beef.rawValue {
            self.provideCountCheck = fetchdataOfProvider(specisId: SpeciesID.beefSpeciesId) as! [GetProviderTbl]
            getListProvider = providerEvaliuater(arr: provideCountCheck) as! [GetProviderTbl]
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noAssociatedProductStr, comment: ""))
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
                providerTitleLbl.isHidden = false
            }
        }
        self.speciesCollectionView.delegate = self
        self.speciesCollectionView.dataSource = self
        self.speciesCollectionView.reloadData()
        self.evalutionProviderCV.delegate = self
        self.evalutionProviderCV.dataSource = self
        self.evalutionProviderCV.reloadData()
        
        if self.revealViewController() != nil {
            self.menuBttn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside);
            self.revealViewController()?.rightViewRevealWidth = 200;
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        let fetchSettingData = fetchAllOrderSetting(entityName: Entities.orderSettingsTblEntity, customerId: custId,userId:userId)
        
        if fetchSettingData.count == 0 {
            if UserDefaults.standard.string(forKey: "name") == marketNameType.Dairy.rawValue{
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
            } else {
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
            }
            
            if pvidDairy == 2 {
                UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
            }
            else {
                UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
            }
            
            if pvidDairy == 3{
                numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
                numericKeyBoardBtnOutle.layer.borderWidth = 2
                alphaNumericbtnOutler.layer.borderWidth = 1
                UserDefaults.standard.set(keyValue.numericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
                
            } else {
                alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
                alphaNumericbtnOutler.layer.borderWidth = 2
                numericKeyBoardBtnOutle.layer.borderWidth = 1
                UserDefaults.standard.set(keyValue.alphaNumericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
            }
            UserDefaults.standard.set(keyValue.pickerMode.rawValue, forKey: keyValue.defaultDatePicker.rawValue)
            self.datePickerEntryOutlet.setImage(UIImage(named: ImageNames.filledImg), for: .normal)
            self.defaultEntryModeOutlet.setImage(UIImage(named: ImageNames.emptyImg), for: .normal)
  
        } else {
            let fetchDat = fetchSettingData.object(at: 0) as? OrderSettings
            let fetchDat1 = fetchDat?.scannerSelection
            let beefScanner = fetchDat?.beefUSscannerSelection
            let keyboardSelection = fetchDat?.keyboardSelection
            let defaultDatePicker = fetchDat?.defaultDatePicker
            if fetchDat?.speciesName == marketNameType.Dairy.rawValue && fetchDat?.providerName == keyValue.USDairyProducts.rawValue{
                UserDefaults.standard.set(fetchDat1, forKey: keyValue.scannerSelection.rawValue)
                if fetchDat1 == keyValue.ocrKey.rawValue  {
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
                }
                else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
                }
                
            } else if (fetchDat?.speciesName == marketNameType.Beef.rawValue && fetchDat?.providerName == keyValue.USDairyProducts.rawValue) || (fetchDat?.speciesName == marketNameType.Beef.rawValue && fetchDat?.providerName == keyValue.clarifideCDCBUS.rawValue)  {
                if beefScanner == keyValue.ocrKey.rawValue && fetchDat?.providerName == keyValue.USDairyProducts.rawValue {
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
                } else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
                }
            }
            
            else if pvidDairy == 2 {
                UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
            } else {
                UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
            }
            
            
            if defaultDatePicker == keyValue.defaultEntry.rawValue {
                UserDefaults.standard.set(keyValue.defaultEntry.rawValue, forKey: keyValue.defaultDatePicker.rawValue)
                self.defaultEntryModeOutlet.setImage(UIImage(named: ImageNames.filledImg), for: .normal)
                self.datePickerEntryOutlet.setImage(UIImage(named: ImageNames.emptyImg), for: .normal)
            } else {
                UserDefaults.standard.set(keyValue.pickerMode.rawValue, forKey: keyValue.defaultDatePicker.rawValue)
                self.datePickerEntryOutlet.setImage(UIImage(named: ImageNames.filledImg), for: .normal)
                self.defaultEntryModeOutlet.setImage(UIImage(named: ImageNames.emptyImg), for: .normal)
            }
            
            if keyboardSelection == keyValue.alphaNumericKeyboard.rawValue {
                alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
                alphaNumericbtnOutler.layer.borderWidth = 2
                numericKeyBoardBtnOutle.layer.borderWidth = 1
                UserDefaults.standard.set(keyValue.alphaNumericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
                
            } else if keyboardSelection == keyValue.numericKeyboard.rawValue {
                numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
                numericKeyBoardBtnOutle.layer.borderWidth = 2
                alphaNumericbtnOutler.layer.borderWidth = 1
                UserDefaults.standard.set(keyValue.numericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
                
            } else {
                if pvidDairy == 3{
                    numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
                    numericKeyBoardBtnOutle.layer.borderWidth = 2
                    alphaNumericbtnOutler.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.numericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
                } else {
                    alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
                    alphaNumericbtnOutler.layer.borderWidth = 2
                    numericKeyBoardBtnOutle.layer.borderWidth = 1
                    UserDefaults.standard.set(keyValue.alphaNumericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
                }
            }
        }
        idScannerTitle.text = LocalizedStrings.selectScannerTypeText.localized
        sampleTagsTitle.text = NSLocalizedString(LocalizedStrings.sampleTagsText, comment: "")
        keyboardTtile.text = NSLocalizedString(LocalizedStrings.selectKeyboard, comment: "")
        rfidBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.rfidScannerText, comment: ""), for: .normal)
        alphaNumericbtnOutler.setTitle(NSLocalizedString(LocalizedStrings.alphaNumericText, comment: ""), for: .normal)
        numericKeyBoardBtnOutle.setTitle(NSLocalizedString(keyValue.numericKeyboard.rawValue, comment: ""), for: .normal)
        ocrBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.mobileCameraOCR, comment: ""), for: .normal)
        dateOfBirthTile.text = NSLocalizedString(LocalizedStrings.dateBirthInput, comment: "")
        datePickerLabel.text = NSLocalizedString(LocalizedStrings.datePickerText, comment: "")
        manualEnteryLabel.text = NSLocalizedString(LocalizedStrings.manualEntry, comment: "")
        selctProductLbl.text = NSLocalizedString(LocalizedStrings.selectProductStr, comment: "")
        productDoneClick.setTitle(NSLocalizedString(LocalizedStrings.doneStr, comment: ""), for: .normal)
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        calendarViewBkg.isHidden = true
        productTblView.delegate = self
        productTblView.dataSource = self
        initialNetworkCheck()
        billingView.isHidden = true
        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        
        let screen  = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
        if screen == "farmid"{
            farmIdBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            rfidBttn.layer.borderColor = UIColor.lightGray.cgColor
            farmIdBttn.layer.borderWidth = 2
            rfidBttn.layer.borderWidth = 1
        }
        else if  screen == keyValue.officialId.rawValue{
            farmIdBttn.layer.borderWidth = 1
            rfidBttn.layer.borderWidth = 2
            farmIdBttn.layer.borderColor =    UIColor.lightGray.cgColor
            rfidBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        }
        
        if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == nil{
            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
        }
        if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == nil{
            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
        }
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == ""{
            UserDefaults.standard.set("farmid", forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        }
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == ""{
            UserDefaults.standard.set("farmid", forKey: keyValue.foReviewOrderVC.rawValue)
        }
        let tag = UserDefaults.standard.integer(forKey: keyValue.orderSlideTag.rawValue)
        if tag == 1{
            
        } else {
            let settingDefault = UserDefaults.standard.value(forKey: keyValue.settingDefault.rawValue) as? String
            
            if settingDefault == "true" {
                if editflag == 0 {
                } else {
                    if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int == 0 {
                    } else {
                        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC) as! OrderingAnimalVC
                        self.navigationController?.pushViewController(newViewController, animated: false)
                    }
                }
            }
        }
        
        for _ in 0 ..< provideCountCheck.count{
            isSelectedArray.append(false)
        }
        
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        let checkValue = UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) as? String
        
        if checkValue == "true" {
            continueOrderBttn.setTitle(NSLocalizedString(LocalizedStrings.doneStr, comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString(LocalizedStrings.settingsText, comment: "")
        }
        else {
            continueOrderBttn.setTitle(NSLocalizedString("Continue to Ordering", comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString("Ordering Defaults", comment: "")
        }
        let zoeties = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
        
        if zoeties == nil || zoeties == keyValue.zoetis.rawValue || zoeties == ""{
            zoetisBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            holsteinBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            zoetisBtnOutlet.layer.borderWidth = 2
            holsteinBtnOutlet.layer.borderWidth = 1
        }
        else{
            holsteinBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            zoetisBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            zoetisBtnOutlet.layer.borderWidth = 1
            holsteinBtnOutlet.layer.borderWidth = 2
        }
        
        if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == nil {
            byDefaultProvider = keyValue.clarifideCDCBUS.rawValue
        }
        else{
            byDefaultProvider = UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue)!
            if byDefaultProvider == keyValue.clarifideGirolandoBR.rawValue
            {
                UserDefaults.standard.set(4, forKey: keyValue.providerID.rawValue)
            }
        }
        if UserDefaults.standard.string(forKey: "name") == nil{
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: "name")
        }
        getListProvider = providerEvaliuater(arr: provideCountCheck) as! [GetProviderTbl]
        
        if UserDefaults.standard.string(forKey: "name") == marketNameType.Dairy.rawValue{
            if  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 1 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 3 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 8 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 10 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 12 {
                
                self.keyBaordSepratorView.isHidden = true
                self.keyBoardViewHeight.constant = 200
                self.scannerViewHeight.constant = 100
                keyboardTtile.isHidden = false
                keyboardSepratorTitle.isHidden = false
                keyboardTtile.isHidden = false
                keyboardSepratorTitle.isHidden = false
                alphaNumericbtnOutler.isHidden = false
                idScannerTitle.isHidden = false
                scannerSepratorBar.isHidden = false
                numericKeyBoardBtnOutle.isHidden = false
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                
                if getListProvider.count == 0 {
                    marketTipYopOutlet.isHidden = true
                    marketView.isHidden = true
                    providerTitleLbl.isHidden = true
                } else {
                    marketTipYopOutlet.isHidden = false
                    marketView.isHidden = false
                    providerTitleLbl.isHidden = false
                }
                
                if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 {
                    primarlyHeightConst.constant = 0
                    nominatorHeightConst.constant = 100
                    
                } else if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2{
                    primarlyHeightConst.constant = 0
                }
                
                else {
                    primarlyHeightConst.constant = 156
                }
            }else {
                self.keyBaordSepratorView.isHidden = false
                self.keyBoardViewHeight.constant = 90
                self.keyBoardTopView.constant = 5
                keyboardSepratorTitle.isHidden = false
                self.scannerViewHeight.constant = 0
                keyboardTtile.isHidden = true
                keyboardTtile.isHidden = true
                ocrInfoBtnOutle.isHidden = true
                primarlyHeightConst.constant = 0
                alphaNumericbtnOutler.isHidden = true
                idScannerTitle.isHidden = true
                scannerSepratorBar.isHidden = true
                numericKeyBoardBtnOutle.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                
                if getListProvider.count == 0 {
                    marketTipYopOutlet.isHidden = true
                    marketView.isHidden = true
                    providerTitleLbl.isHidden = true
                } else {
                    marketTipYopOutlet.isHidden = false
                    marketView.isHidden = false
                    providerTitleLbl.isHidden = false
                }
                
            }
            
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
                nominatorHeightConst.constant = 100
                
            }else  if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBBR.rawValue{
                nominatorHeightConst.constant = 100
                
            }
            else  if UserDefaults.standard.string(forKey: keyValue.providerName.rawValue) == keyValue.clarifideCDCBIT.rawValue || UserDefaults.standard.string(forKey: keyValue.providerName.rawValue) == keyValue.clarifideCDCBBenelux.rawValue || UserDefaults.standard.string(forKey: keyValue.providerName.rawValue) == keyValue.clarifideCDCBCan.rawValue {
                nominatorHeightConst.constant = 100
            }
            else{
                nominatorHeightConst.constant = 0
            }
            providerTitleLbl.text = NSLocalizedString(LocalizedStrings.providerMarkets, comment: "")
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = false
            productTblView.reloadData()
        }
        else{
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString(LocalizedStrings.productGroupings, comment: "")
            let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
            primarlyHeightConst.constant = 0
            nominatorHeightConst.constant = 0
            productTblView.reloadData()
            self.keyBaordSepratorView.isHidden = false
            self.keyBoardViewHeight.constant = 90
            self.keyBoardTopView.constant = 5
            keyboardSepratorTitle.isHidden = false
            self.scannerViewHeight.constant = 0
            keyboardTtile.isHidden = true
            alphaNumericbtnOutler.isHidden = true
            idScannerTitle.isHidden = true
            scannerSepratorBar.isHidden = true
            numericKeyBoardBtnOutle.isHidden = true
            ocrBtnOutlet.isHidden = true
            rfidBtnOutlet.isHidden = true
            ocrInfoBtnOutle.isHidden = true
            if getListProvider.count == 0 {
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
                providerTitleLbl.isHidden = false
            }
            
            if UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 13 || UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 5 && (UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue || UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.USDairyProducts.rawValue)  {
                self.scannerViewHeight.constant = 100
                idScannerTitle.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                if UserDefaults.standard.object(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                } else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                }
            } else {
                self.scannerViewHeight.constant = 0
                idScannerTitle.isHidden = true
                rfidBtnOutlet.isHidden = true
                ocrBtnOutlet.isHidden = true
                ocrInfoBtnOutle.isHidden = true
            }
        }
    }
}
