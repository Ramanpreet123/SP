//
//  OrderingAnimalVCActionMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 22/03/24.
//

import Foundation
import UIKit
import CoreBluetooth
import Alamofire

//MARK: ACTION METHODS
extension OrderingAnimalVC {
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func yesBtnAction(_ sender: UIButton) {
        UserDefaults.standard.set("True", forKey: keyValue.isAuSelected.rawValue)
        auSelectionView.isHidden = true
        calendarViewBkg.isHidden = true
        self.AUbackroundView.isHidden = true
        self.scanAnimalTagText.becomeFirstResponder()
    }
    
    @IBAction func noBtnAction(_ sender: UIButton) {
        auSelectionView.isHidden = true
        UserDefaults.standard.set(keyValue.noNeedAuPopUp.rawValue, forKey: keyValue.isAuSelected.rawValue)
        calendarViewBkg.isHidden = true
        self.AUbackroundView.isHidden = true
        self.scanAnimalTagText.becomeFirstResponder()
    }
    
    @IBAction func crossPairedAction(_ sender: Any) {
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        barcodeScreen = false
        selectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func AlertAction(_ sender: UIButton) {
        view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc!.delegate = self
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else  {
            if BluetoothCentre.shared.manager.state == .poweredOff{
                let alertController = UIAlertController (title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: ""), preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.settingsText, comment: ""), style: .default) { (_) -> Void in
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
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func EtBtnAction(_ sender: UIButton) {
        etBtn = "Et"
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderWidth = 2
        multipleBirthBttn.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 0.5
        cloneOutlet.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func multiBirthBtnAction(_ sender: UIButton) {
        etBtn = LocalizedStrings.multipleBirthStr
        multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 2
        singleBttn.layer.borderWidth = 0.5
        cloneOutlet.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func singleBtnAction(_ sender: UIButton) {
        etBtn = LocalizedStrings.singlesText
        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 2
        cloneOutlet.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
        _ = statusOrderTrue()
        if statusOrder{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func splitEmbryoAction(_ sender: UIButton) {
        etBtn = NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: "")
        SplitEmbryoOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
        cloneOutlet.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 0.5
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 2
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func cloneBtnClick(_ sender: Any) {
        etBtn = LocalizedStrings.cloneText
        cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderWidth = 0.5
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        cloneOutlet.layer.borderWidth = 2
        internalBtnOulet.layer.borderWidth = 0.5
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func internalBtnAction(_ sender: Any) {
        etBtn = LocalizedStrings.internalStr
        internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderWidth = 0.5
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        cloneOutlet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 2
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func rfidTippopClick(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        let providerID = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        if defaltscreen == keyValue.farmId.rawValue {
            customPopView1.frame = CGRect(x: 33,y: innerView.layer.frame.minY + 41 ,width: screenSize.width - 90, height: 70)
            customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.herdManagement, comment: "")
        } else {
            if providerID == 3{
                customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.herdbookNumberRequired, comment: "")
                customPopView1.frame = CGRect(x: 33,y: innerView.layer.frame.minY + 41 ,width: screenSize.width - 90, height: 105)
            } else {
                customPopView1.frame = CGRect(x: 33,y: innerView.layer.frame.minY + 41 ,width: screenSize.width - 90, height:90)
                customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.uniqueMetalEarTag, comment: "")
            }
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
    
    @IBAction func farmIdTipPopClick(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.textLbl2.isHidden = true
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        let ySize = (innerView.frame.minY + 70) - self.scrolView.contentOffset.y
        let providerID = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        
        if defaltscreen == keyValue.farmId.rawValue {
            if  providerID == 3{
                customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.herdbookNumberRequired, comment: "")
                customPopView1.frame = CGRect(x: 33,y: ySize+30  ,width: screenSize.width - 90, height: 105)
            }
            else {
                customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.uniqueMetalEarTag, comment: "")
                customPopView1.frame = CGRect(x: 33,y: ySize+30  ,width: screenSize.width - 90, height: 90)
            }
        } else  {
            customPopView1.frame = CGRect(x: 33,y: ySize+30 ,width: screenSize.width - 90, height:70)
            customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.herdManagement, comment: "")
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
    
    @IBAction func sireTipAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.textLbl2.isHidden = true
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        var ySize = (innerView.frame.minY + 420) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                ySize = (innerView.frame.minY + 435) - self.scrolView.contentOffset.y
            case 1920, 2208:
                ySize = (innerView.frame.minY + 435) - self.scrolView.contentOffset.y
            case 2436:
                ySize = (innerView.frame.minY + 435) - self.scrolView.contentOffset.y
            case 2688,2796:
                ySize = (innerView.frame.minY + 435) - self.scrolView.contentOffset.y
            case 1792:
                ySize = (innerView.frame.minY + 435) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        
        customPopView1.frame = CGRect(x: 33,y: ySize ,width: screenSize.width - 90, height:92)
        customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.dataGeneWebsiteLink, comment: "")
        customPopView1.arrow_Top.isHidden = true
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
    }
    
    @IBAction func addAnimal(_ sender: UIButton) {
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            self.scanAnimalTagText.becomeFirstResponder()
        })
    }
    
    @IBAction func ContinueAction(_ sender: UIButton) {
        addContiuneBtn = 2
        let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        identify1 = true
        let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
        validateBreed(completionHandler: { (success) -> Void in
            if success  {
                let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                if  identyCheck == false || identyCheck == nil{
                    if data1.count > 0 {
                        if scanAnimalTagText.text == "" && farmIdTextField.text == ""{
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                                self.NavigateToOrderingProductSelectionScreen()
                                
                            } else {
                                if identyCheck == false || identyCheck == nil {
                                    if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                        self.NavigateToOrderingProductSelectionScreen()
                                    }
                                    else{
                                        self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                        
                                    }
                                }
                                else {
                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                }
                            }
                        } else {
                            if scanBarcodeText.text == "" {
                                barcodeView.layer.borderColor = UIColor.red.cgColor
                                contiuneValidation()
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                                return
                            }
                            
                            addAnimalBtn(completionHandler: { (success) -> Void in
                                self.validateBreed(completionHandler: { (success) -> Void in
                                    if success {
                                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                        if  identyCheck == true {
                                            self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                            
                                        }  else {
                                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                                self.NavigateToOrderingProductSelectionScreen()
                                            } else {
                                                self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                            }
                                        }
                                    }
                                })
                            })
                        }
                    }
                    else {
                        if scanAnimalTagText.tag ==  1 &&  scanAnimalTagText.text == "" || scanBarcodeText.text == "" && data1.count == 0{
                            if scanAnimalTagText.text != ""{
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                                officalTagView.layer.borderColor = UIColor.gray.cgColor
                                
                                if scanBarcodeText.text == "" {
                                    barcodeView.layer.borderColor = UIColor.red.cgColor
                                }
                                
                                return
                            }
                            else {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.addOneAnimal, comment: ""))
                                self.contiuneValidation()
                            }
                            
                        } else if scanAnimalTagText.tag ==  0 && scanAnimalTagText.text == "" || scanBarcodeText.text == "" && data1.count == 0{
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.addOneAnimal, comment: ""))
                            self.contiuneValidation()
                        }
                        else {
                            addAnimalBtn(completionHandler: { (success) -> Void in
                                if success  {
                                    self.validateBreed(completionHandler: { (success) -> Void in
                                        if success {
                                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                                self.NavigateToOrderingProductSelectionScreen()
                                                
                                            } else {
                                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                                    self.NavigateToOrderingProductSelectionScreen()
                                                } else {
                                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                                }
                                            }
                                        }
                                    })
                                }
                            })
                        }
                        
                    }
                }
                else{
                    if data1.count > 0 {
                        if scanAnimalTagText.text == "" && farmIdTextField.text == ""{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                
                            }  else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    self.NavigateToOrderingProductSelectionScreen()
                                } else {
                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                }
                            }
                        }
                        else{
                            addAnimalBtn(completionHandler: { (success) -> Void in
                                if success  {
                                    self.validateBreed(completionHandler: { (success) -> Void in
                                        if success {
                                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                            if identyCheck == true {
                                                self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                                
                                            }  else {
                                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                                    self.NavigateToOrderingProductSelectionScreen()
                                                } else {
                                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                                }
                                            }
                                        }
                                    })
                                }
                            })
                        }
                    }
                    else{
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success  {
                                self.validateBreed(completionHandler: { (success) -> Void in
                                    if success {
                                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                        if  identyCheck == true {
                                            self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                        }
                                        else {
                                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                                self.NavigateToOrderingProductSelectionScreen()
                                            } else {
                                                self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                            }
                                        }
                                    }
                                })
                            }
                        })
                    }
                }
            }
        })
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func male_Female_toggleBtnClk(_ sender: UIButton) {
        view.endEditing(true)
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        self.view.endEditing(true)
        
        if(genderToggleFlag == 0) {
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString("Male", comment: "")
            UserDefaults.standard.set("M", forKey: "USDairyGender")
        }
        else {
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = NSLocalizedString("Female", comment: "")
            UserDefaults.standard.set("F", forKey: "USDairyGender")
        }
        
        _ = statusOrderTrue()
    }
    
    @IBAction func dateAction(_ sender: Any) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        self.view.endEditing(true)
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
        }
        else {
            dateTextField.isHidden = true
            calenderView.isHidden = false
            calendarViewBkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            doDatePicker()
        }
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func offLineRestrictionPopUp(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: ClassIdentifiers.offLineRestrictionVC) as! OffLineRestrictionVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @IBAction func tissueBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            let sampleId = orederStatus.object(at: 0) as! AnimalMaster
            if sampleId.tissuId == -100 {
                barcodeEnable = false
            } else {
                barcodeEnable = true
            }
        }
        
        btnTag = 20
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        tissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        var yFrame = (tissueLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (tissueLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (tissueLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (tissueLbl.frame.minY + 143) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 150)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder  {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func breedBtnClick(_ sender: UIButton) {
        view.endEditing(true)
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        UserDefaults.standard.set(sireIdTextField.text!, forKey: keyValue.sireIdSaveTemp.rawValue)
        UserDefaults.standard.set(damtexfield.text!, forKey: keyValue.naabIdSaveTemp.rawValue)
        btnTag = 10
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        breedArr =  fetchBreedData(entityName: Entities.getBreedsTblEntity, provId: pvid) as! [GetBreedsTbl] as NSArray
        self.tableViewpop()
        var yFrame = (breedLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (breedLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (breedLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (breedLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        if breedArr.count == 2 || breedArr.count == 1{
            droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 95)
            
        } else {
            droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 140)
            
        }
        
        droperTableView.reloadData()
        _ = statusOrderTrue()
        
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
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
    
    @IBAction func clearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            
            self.byDefaultSetting()
            let ab =  UserDefaults.standard.string(forKey: keyValue.tsuClear.rawValue)
            if ab == nil || ab == "" {
                if self.pvid == 2 {
                    self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: self.pvid)
                    for items in self.tissueArr
                    {
                        let tissue = items  as? GetSampleTbl
                        let checkdefault  = tissue?.isDefault
                        
                        if checkdefault == true
                        {
                            self.saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                        }
                    }
                }
                else {
                    self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: self.pvid)
                    for items in self.tissueArr{
                        let tissue = items  as? GetSampleTbl
                        let checkdefault  = tissue?.isDefault
                        
                        if checkdefault == true{
                            self.saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                            
                        }
                    }
                }
            }
            else {
                self.tissueBtnOutlet.setTitle(ab?.localized, for: .normal)
                UserDefaults.standard.set(self.sampleName, forKey: keyValue.tsuKey.rawValue)
            }
            let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: self.pvid,tissueName:(self.sampleName))
            let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
            if naabFetch1!.count != 0 {
                let breedIdGet = naabFetch1![0] as? Int
                self.tissuId = breedIdGet!
            }
            
            var breed =  UserDefaults.standard.string(forKey: keyValue.breedNameClear.rawValue)
            
            if breed == nil || breed == "" {
                breed = "HO"
                self.breedBtnOutlet.setTitle(breed, for: .normal)
                
            }
            else {
                self.breedBtnOutlet.setTitle(breed, for: .normal)
                UserDefaults.standard.set(self.breedBtnOutlet.titleLabel?.text, forKey: keyValue.capsBreedName.rawValue)
            }
            let codeId1 = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: self.pvid,breedCode:(self.breedBtnOutlet.titleLabel?.text)!)
            let naabFetch11 = codeId1.value(forKey: keyValue.breedId.rawValue) as? NSArray
            
            if naabFetch11!.count != 0 {
                let breedIdGet = (naabFetch11![0] as? String)!
                self.breedId = breedIdGet
                UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
            }
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            
            if inrementCheck  {
                self.isBarcodeAutoIncrementedEnabled = true
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.checkBarcode = false
            }
            else {
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            self.matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
            self.barcodefixed = false
            self.scanAnimalTagText.becomeFirstResponder()
            
            if self.pvid == 3 {
                if self.scanAnimalTagText.tag == 1 {
                    let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.autoD,orderStatus:"false", providerId: self.pvid)
                    if animalCount.count == 0 {
                        self.calendarViewBkg.isHidden = false
                        self.auSelectionView.isHidden = false
                        self.AUbackroundView.isHidden = false
                        self.scanAnimalTagText.resignFirstResponder()
                    } else {
                        self.calendarViewBkg.isHidden = true
                        self.auSelectionView.isHidden = true
                        self.AUbackroundView.isHidden = true
                    }
                } else {
                    self.calendarViewBkg.isHidden = true
                    self.auSelectionView.isHidden = true
                    self.AUbackroundView.isHidden = true
                }
            }
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func matchedBarcodeAction(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.barcodeAlreadySelected, comment: "") )
            
        } else {
            if matchedBarcodeBtnOutlet.isSelected {
                matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                barcodefixed = false
                incrementalBarcodeTitleLabel.textColor = UIColor.black
                incrementalBarcodeButton.isEnabled = true
                incrementalBarcodeCheckBox.alpha = 1
                incrementalBarcodeTitleLabel.alpha = 1
            }
            else {
                matchedBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                barcodefixed = true
                incrementalBarcodeTitleLabel.textColor = UIColor.gray
                incrementalBarcodeButton.isEnabled = false
                incrementalBarcodeCheckBox.alpha = 0.6
                incrementalBarcodeTitleLabel.alpha = 0.6
                let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                
                if screenRefernce == keyValue.officialId.rawValue || screenRefernce == ""{
                    
                    if scanBarcodeText.text?.count == 0 {
                        if scanAnimalTagText.text?.count == 17 {
                            let str = scanAnimalTagText.text!
                            let start = str.index(str.startIndex, offsetBy: 2)
                            let end = str.index(str.endIndex, offsetBy: -12)
                            let range = start..<end
                            let subStr = str[range]
                            
                            if subStr == "840" {
                                scanBarcodeText.text = String(scanAnimalTagText.text!.dropFirst(2))
                            }
                            else
                            {
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.cannotCopyOfficialId, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { [self]  (_) in
                                    matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                                    UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                    barcodefixed = false
                                    matchedBarcodeBtnOutlet.isSelected = false
                                    incrementalBarcodeTitleLabel.textColor = UIColor.black
                                    incrementalBarcodeButton.isEnabled = true
                                    incrementalBarcodeCheckBox.alpha = 1
                                    incrementalBarcodeTitleLabel.alpha = 1
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else if farmIdTextField.text?.count == 17{
                            let str = farmIdTextField.text!
                            let start = str.index(str.startIndex, offsetBy: 2)
                            let end = str.index(str.endIndex, offsetBy: -12)
                            let range = start..<end
                            let subStr = str[range]
                            
                            if subStr == "840" {
                                scanBarcodeText.text = String(farmIdTextField.text!.dropFirst(2))
                            }
                            else
                            {
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.cannotCopyOfficialId, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { [self]  (_) in
                                    matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                                    UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                    barcodefixed = false
                                    matchedBarcodeBtnOutlet.isSelected = false
                                    incrementalBarcodeTitleLabel.textColor = UIColor.black
                                    incrementalBarcodeButton.isEnabled = true
                                    incrementalBarcodeCheckBox.alpha = 1
                                    incrementalBarcodeTitleLabel.alpha = 1
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    if scanBarcodeText.text?.count == 0 {
                        if farmIdTextField.text?.count == 17{
                            let str = farmIdTextField.text!
                            let start = str.index(str.startIndex, offsetBy: 2)
                            let end = str.index(str.endIndex, offsetBy: -12)
                            let range = start..<end
                            let subStr = str[range]
                            
                            if subStr == "840" {
                                scanBarcodeText.text = String(farmIdTextField.text!.dropFirst(2))
                            }
                            else
                            {
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.cannotCopyOfficialId, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { [self]  (_) in
                                    matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                                    UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                    barcodefixed = false
                                    matchedBarcodeBtnOutlet.isSelected = false
                                    incrementalBarcodeTitleLabel.textColor = UIColor.black
                                    incrementalBarcodeButton.isEnabled = true
                                    incrementalBarcodeCheckBox.alpha = 1
                                    incrementalBarcodeTitleLabel.alpha = 1
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            matchedBarcodeBtnOutlet.isSelected = !matchedBarcodeBtnOutlet.isSelected
        }
    }
    
    @IBAction func importFromListAction(_ sender: Any) {
        view.endEditing(true)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        tempImportListArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId, providerId: pvid) as!  [DataEntryList]
        if tempImportListArray.count > 0{
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
        }
        
        if importListArray.count == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noListsAvailable, comment: ""))
            importListMainView.isHidden = true
            importBGView.isHidden = true
            return
        }
        
        
        showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
        conflictArr.removeAll()
        let data1 = fetchAllDataWithOrderID(entityName: Entities.animalAddTblEntity,orderId:orderId,userId:userId)
        
        if data1.count > 0{
            let animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.animalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.prodSelectionCleared, comment: ""), preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    self.importListMainView.isHidden = true
                    self.importBGView.isHidden = true
                    return
                })
                alert.addAction(cancel)
                
                let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                    updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                    updateProductTablDataaid(entity: Entities.getAdonTblEntity, status: "false")
                    for j in 0 ..< data1.count {
                        let animal = data1.object(at: j) as! AnimaladdTbl
                        updateAnimalTblDataDairystatus(entity: Entities.productAdonAnimalTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                        updateAnimalTblDataDairystatus(entity: Entities.animalAddTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                        updateProductTablDataaid(entity: Entities.subProductTblEntity, status: "false")
                    }
                    if self.importListArray.count != 0 {
                        self.importListMainView.isHidden = false
                        self.importBGView.isHidden = false
                        self.importTblView.reloadData()
                        
                    }
                })
                alert.addAction(ok)
                
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
                
            } else {
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBGView.isHidden = false
                    importTblView.reloadData()
                }
            }
        } else {
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBGView.isHidden = false
                importTblView.reloadData()
                
            }
        }
        self.hideIndicator()
    }
    
    @IBAction func acnADHAnimalList(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.adhAnimalVC) as? ADHAnimalVC
        vc!.bckRetain = true
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func cancelBtnClickImportView(_ sender: Any) {
        listId = 0
        importListMainView.isHidden = true
        importBGView.isHidden = true
    }
    
    @IBAction func mergeListBtnClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.animalMergePopVC) as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func crossedBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removingOrdersList, comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
        })
        
        alert.addAction(cancel)
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            let listArray = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ))
            
            for i in 0 ..< listArray.count{
                let listObj = listArray[i] as! MergeDataEntryList
                let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.animalAddTblEntity, customerId: Int(listObj.customerId), listId: listObj.listId)
                
                if animalData.count > 0 {
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! AnimaladdTbl
                        deleteDataWithProduct(Int(ad.animalId))
                        deleteDataWithSubProduct(Int(ad.animalId))
                        self.deleteSigalAnimalFromList(animalTagStr: String(ad.animalId) )
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.animalAddTblEntity, listId:Int(listObj.listId), customerId: Int(listObj.customerId),userId:self.userId)
                }
            }
            deleteDataWithPvidCustomerId(entityString: Entities.mergeDataEntryListTblEntity ,providerId: Int64(self.pvid),customerId: Int64(self.custmerId ))
            
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.importMyListStr, comment: ""), attributes: self.attrs)
            self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
            
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            self.importFromListOutlet.isEnabled = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                
            }
            self.crossedBtnOutlet.isHidden = true
            
            
            if fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count == 0 {
                self.crossedBtnOutlet.isHidden = true
                self.mergeListBtnOulet.isHidden = true
            } else {
                self.mergeListBtnOulet.isHidden = false
                self.crossedBtnOutlet.isHidden = false
            }
            
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    func deleteSigalAnimalFromList(animalTagStr:String) {
        let objApiSync = ApiSyncList()
        let listName = orderingDataListViewModel.makeListName(custmerId: custmerId,providerID: pvid)
        
        let fetchDataEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:"Dairy") as! [DataEntryList]
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ), providerId: pvid) as! [DataEntryAnimaladdTbl]
            if fetchAllDatalistAnimals.count > 0{
                let filterdatalistAnimal = fetchAllDatalistAnimals.filter{String($0.animalId) == animalTagStr}
                if filterdatalistAnimal.count > 0 {
                    let animalVal = filterdatalistAnimal[0]
                    deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
                    if Connectivity.isConnectedToInternet() {
                        objApiSync.postListDataDelete(listId: fetchDataEntry[0].listId, custmerId: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                    }
                }
            }
        }
    }
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
        if  UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlag.rawValue) {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeSelectedStr, comment: "") )
        } else {
            guard !isautoPopulated else {
                return
            }
            
            guard scanBarcodeText.text?.isEmpty == false else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
                return
            }
            
            guard isBarcodeEndingWithNumberAndGetIncremented(scanBarcodeText.text ?? "").isBarCodeEndsWithNumber else {
                if !checkBarcode {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
                    
                } else {
                    sender.isSelected = false
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    self.isBarcodeAutoIncrementedEnabled = false
                    checkBarcode = false
                }
                return
            }
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) {
                sender.isSelected = false
                incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                matchedBarcodeLbl.textColor = UIColor.black
                matchedBarcodeBtnOutlet.isEnabled = true
                matchedBarcodeCheckBox.alpha = 1
                matchedBarcodeLbl.alpha = 1
                
            } else {
                sender.isSelected = true
                incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = true
                checkBarcode = false
                matchedBarcodeLbl.textColor = UIColor.gray
                matchedBarcodeBtnOutlet.isEnabled = false
                matchedBarcodeCheckBox.alpha = 0.6
                matchedBarcodeLbl.alpha = 0.6
                incrementalBarcodeButton.isEnabled = true
                incrementalBarcodeCheckBox.alpha = 1
                incrementalBarcodeTitleLabel.alpha = 1
            }
        }
    }
    
    @IBAction func addAction(_ sender: UIButton){
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
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        view1.isHidden = true
        view2.isHidden = true
    }
    
    @IBAction func continueToProductSelectionAction(_ sender: UIButton) {
        view1.isHidden = true
        view2.isHidden = true
    }
}
