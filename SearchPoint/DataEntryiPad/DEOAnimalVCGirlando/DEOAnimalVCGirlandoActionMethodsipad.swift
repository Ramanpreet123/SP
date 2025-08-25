//
//  DEOAnimalVCGirlandoActionMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 19/03/25.
//

import Foundation
import UIKit

//MARK: IB ACTIONS
extension DEOAnimalVCGirlando {
    @IBAction func clearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.textFieldBackroungWhite()
            self.byDefaultSetting()
            let tissueName = UserDefaults.standard.string(forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
            if UserDefaults.standard.string(forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue) == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                for items in self.tissueArr{
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    if checkdefault == true
                    {
                        self.tissueBttnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                }
            }
            else {
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.tissueBttnOutlet.setTitle(tissueName?.localized, for: .normal)
                UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            if inrementCheck {
                self.isBarcodeAutoIncrementedEnabled = true
                self.incrementalBarcodeCheckBox.image = UIImage(named: "incrementalCheckIpad")
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
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
    
    @IBAction func bckToListNavigate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "DataEntryModeListiPadVC") as! DataEntryModeListiPadVC
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
    }
    @IBAction func expandFormAction(_ sender: Any) {
        if !UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
            expandFormOutlet.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
            expandFormOutlet.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
            innerScrollViewHeight.constant = 1180
            sampleTypeAndGenderStackView.isHidden = false
            sampleTypeHeaderView.isHidden = false
            breedAndDateStackView.isHidden = false
            genderHeaderView.isHidden = false
            bornTypeView.isHidden = false
            sampleBreedHeaderView.isHidden = false
            dobHeaderView.isHidden = false
            breedRegAndAssociationTypeStackView.isHidden = false
            animalNameAndSireRegStackView.isHidden = false
            damIdStackView.isHidden = false
            damIDHeaderView.isHidden = false
            sireIDHeaderView.isHidden = false
            animalNameHeaderView.isHidden = false
            breedRegHeaderView.isHidden = false
            associationTypeHeaderView.isHidden = false
            bornTypeHeaderView.isHidden = false
            clearFormBottomConstraint.constant = 20
            addAAnimalStackViewTopConstraint.constant = 680
          
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                scrolView.isScrollEnabled = true
            }
            else {
                scrolView.isScrollEnabled = false
            }
        }
        else {
            expandFormOutlet.setTitle(LocalizedStrings.expandFormStr, for: .normal)
            expandFormOutlet.setImage(UIImage(named:"downiPad"), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
            innerScrollViewHeight.constant = 620
            sampleTypeAndGenderStackView.isHidden = true
            sampleTypeHeaderView.isHidden = true
            breedAndDateStackView.isHidden = true
            genderHeaderView.isHidden = true
            bornTypeView.isHidden = true
            sampleBreedHeaderView.isHidden = true
            dobHeaderView.isHidden = true
            breedRegAndAssociationTypeStackView.isHidden = true
            animalNameAndSireRegStackView.isHidden = true
            damIdStackView.isHidden = true
            damIDHeaderView.isHidden = true
            sireIDHeaderView.isHidden = true
            animalNameHeaderView.isHidden = true
            breedRegHeaderView.isHidden = true
            associationTypeHeaderView.isHidden = true
            bornTypeHeaderView.isHidden = true
            clearFormBottomConstraint.constant = 100
            addAAnimalStackViewTopConstraint.constant = 40
        }}
    
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
        if  UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlag.rawValue) {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeSelectedStr, comment: "") )
        }
        else {
            guard scanBarcodeTextfield.text?.isEmpty == false else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
                return
            }
            guard isBarcodeEndingWithNumberAndGetIncremented(scanBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
                if !checkBarcode {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
                }
                else {
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
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                
            } else {
                sender.isSelected = true
                incrementalBarcodeCheckBox.image = UIImage(named: "incrementalCheckIpad")
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = true
                checkBarcode = false
            }
        }
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
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        barcodeScreen = false
        selectedDate = Date()
        let vc = UIStoryboard.init(name: "DataEntryiPad", bundle: Bundle.main).instantiateViewController(withIdentifier: "DataEntryListViewAnimalListiPadVC") as? DataEntryListViewAnimalListiPadVC
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func EtBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        selectedBornTypeId = 3
        etBtn = "Et"
        etBttn.layer.borderColor = UIColor.clear.cgColor
        multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        etBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
        etBttn.setTitleColor(UIColor.white, for: .normal)
        
        singleBttn.backgroundColor = UIColor.white
        multipleBirthBttn.backgroundColor = UIColor.white
        singleBttn.setTitleColor(UIColor.black, for: .normal)
        multipleBirthBttn.setTitleColor(UIColor.black, for: .normal)
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func multiBirthBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        selectedBornTypeId = 2
        etBtn = LocalizedStrings.multipleBirthStr
        multipleBirthBttn.layer.borderColor = UIColor.clear.cgColor
        etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        multipleBirthBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
        multipleBirthBttn.setTitleColor(UIColor.white, for: .normal)
        
        singleBttn.backgroundColor = UIColor.white
        etBttn.backgroundColor = UIColor.white
        singleBttn.setTitleColor(UIColor.black, for: .normal)
        etBttn.setTitleColor(UIColor.black, for: .normal)
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func singleBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        selectedBornTypeId = 1
        etBtn = LocalizedStrings.singlesText
        singleBttn.layer.borderColor = UIColor.clear.cgColor
        etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        singleBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
        singleBttn.setTitleColor(UIColor.white, for: .normal)
        multipleBirthBttn.backgroundColor = UIColor.white
        etBttn.backgroundColor = UIColor.white
        multipleBirthBttn.setTitleColor(UIColor.black, for: .normal)
        etBttn.setTitleColor(UIColor.black, for: .normal)
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func dateAction(_ sender: Any) {
        barcodeEnable = true
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
        }
        else {
            dateTextField.isHidden = true
            calenderView.isHidden = false
            calenderbkg.isHidden = false
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
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func maleFemaleAction(_ sender: UIButton) {
        self.view.endEditing(true)
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        btnTag = 50
        
        self.genderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: genderView, removeShadow: false)
        
        self.tableViewpop()
        var yFrame = (male_femaleBttnOutlet.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (male_femaleBttnOutlet.frame.minY + 635) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 562,height: 95)
                
            case 810:
                yFrame = (male_femaleBttnOutlet.frame.minY + 635) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 592,height: 95)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (male_femaleBttnOutlet.frame.minY + 662) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 95)
                } else {
                    yFrame = (male_femaleBttnOutlet.frame.minY + 662) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                }
                
                
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (male_femaleBttnOutlet.frame.minY + 652) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 95)
                } else {
                    yFrame = (male_femaleBttnOutlet.frame.minY + 652) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 95)
                }
                
            case 1024:
                yFrame = (male_femaleBttnOutlet.frame.minY + 647) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 95)
                
            case 1032:
                yFrame = (male_femaleBttnOutlet.frame.minY + 647) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 695,y: yFrame,width: 655,height: 95)
                
            default:
                break
            }
        }
        
        droperTableView.reloadData()
    }
    
    @IBAction func offLineRestrictionPopUp(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: ClassIdentifiers.offLineRestrictionVC) as! OffLineRestrictionVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    
    @IBAction func addAnimalAction(_ sender: Any) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            print(success)
            self.scanBarcodeTextfield.becomeFirstResponder()
            self.scanBarcodeTextfield.backgroundColor = .white
        })
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        
        addContiuneBtn = 2
        let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        identify1 = true
        let data1 = fetchAllDataOrderStatusWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false", orderId:orderId,userId:userId)
        validateBreed(completionHandler: { (success) -> Void in
            if success {
                let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                if  identyCheck == false || identyCheck == nil{
                    if data1.count > 0 {
                        if scanEarTagTextField.text == "" {
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                                let data1 = fetchAllDataOrderStatusWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false", orderId:orderId,userId:userId)
                                if data1.count > 0 {
                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                }
                                
                            } else {
                                if identyCheck == false || identyCheck == nil {
                                    if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                    }
                                    else{
                                        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                    }
                                }
                                else {
                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                }
                            }
                        }
                        else {
                            addAnimalBtn(completionHandler: { (success) -> Void in
                                if success  {
                                    self.validateBreed(completionHandler: { (success) -> Void in
                                        if success {
                                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                            if  identyCheck == true {
                                                let data1 = fetchAllDataOrderStatusWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false", orderId:orderId,userId:userId)
                                                if data1.count > 0 {
                                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                                }
                                            }
                                            else {
                                                if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                                }
                                                else{
                                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                                }
                                            }
                                        }
                                    })
                                }
                            })
                        }
                    }
                    else {
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success  {
                                self.validateBreed(completionHandler: { (success) -> Void in
                                    if success {
                                        if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                            let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                        }
                                        else {
                                            let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                        }
                                    }
                                })
                            }
                        })
                    }
                }
                else{
                    if data1.count > 0 {
                        if scanEarTagTextField.text == "" {
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                            }
                            else {
                                if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                    
                                }
                                else{
                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                }
                            }
                        }
                        else{
                            addAnimalBtn(completionHandler: { (success) -> Void in
                                if success  {
                                    self.validateBreed(completionHandler: { (success) -> Void in
                                        if success {
                                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                            if  identyCheck == true {
                                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                                
                                            }
                                            else {
                                                if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                                }
                                                else{
                                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
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
                                            let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                        }
                                        else {
                                            if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
                                            }
                                            else{
                                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DataEntryReviewDataiPadVC")), animated: true)
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
    
    @IBAction func breedRegAction(_ sender: Any) {
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 17)
        if breedRegArr.count == 1 {
            return
        }
        btnTag = 30
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (breedRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (breedRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (breedRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (breedRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        if breedRegArr.count < 2 {
            droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegBttn.frame.width,height: 80)
        }
        else {
            droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegBttn.frame.width,height: 180)
        }
        droperTableView.reloadData()
    }
    @IBAction func breedAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        breedArr =  fetchBreedData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        
        if breedArr.count == 1 {
            return
        }
        
        btnTag = 20
        view.endEditing(true)
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
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 80)
        droperTableView.reloadData()
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    @IBAction func tissueBtnnAction(_ sender: UIButton) {
        self.sampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: sampleTypeView, removeShadow: false)
        btnTag = 10
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        tissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        var yFrame = (tissueBttnOutlet.frame.minY + 640) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (tissueBttnOutlet.frame.minY + 640) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 150)
                
                
            case 810:
                yFrame = (tissueBttnOutlet.frame.minY + 665) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (tissueBttnOutlet.frame.minY + 665) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                } else {
                    yFrame = (tissueBttnOutlet.frame.minY + 665) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                }
                
                
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (tissueBttnOutlet.frame.minY + 635) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 532,height: 150)
                } else {
                    yFrame = (tissueBttnOutlet.frame.minY + 635) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                }
                
            case 1024:
                yFrame = (tissueBttnOutlet.frame.minY + 645) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)
                
            case 1032:
                yFrame = (tissueBttnOutlet.frame.minY + 645) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)
                
            default:
                break
            }
        }
        droperTableView.reloadData()
        _ = statusOrderTrue()
        
        if statusOrder  {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
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
        buttonbg.addTarget(self, action: #selector(DataEntryOrderingAnimalVCGirlando.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func ocrBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
        vc!.delegate = self
        self.navigationController?.pushViewController(vc!, animated: false)
    }
}
