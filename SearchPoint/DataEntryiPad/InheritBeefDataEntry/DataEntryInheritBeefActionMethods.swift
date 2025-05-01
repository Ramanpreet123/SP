//
//  DataEntryInheritBeefActionMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 25/03/25.
//

import Foundation
import UIKit
import CoreBluetooth

// MARK: - IB ACTIONS
extension DataEntryInheritBeefVC {
    
    @IBAction func bckBtnNavigateToList(_ sender: Any) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC) as! DataEntryModeListVC
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func inheritBckBtnNavigateToList(_ sender: Any) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC) as! DataEntryModeListVC
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func inheritBtnAction(_ sender: Any) {
       
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                inheritScrollView.isScrollEnabled = true
            }
            else {
                inheritScrollView.isScrollEnabled = false
                
            }
            self.eidAndSecondaryStackView.isHidden = false
            self.eidHeaderView.isHidden = false
            self.secondaryHeaderView.isHidden = false
            self.breedAndDobStackView.isHidden = false
            self.breedTypeHeaderView.isHidden = false
            self.dobHeaderView.isHidden = false
            self.breedRegStackView.isHidden = false
            self.breedAssociationHeaderView.isHidden = false
            self.breedRegHeaderView.isHidden = false
//            self.sireRegStackView.isHidden = false
//            self.sireRegNumberHeaderView.isHidden = false
//            self.sireRegAssociationHeaderView.isHidden = false
//            self.sireYOBStackView.isHidden = false
//            self.sireYOBHeaderView.isHidden = false
//            self.damIDHeaderView.isHidden = false
//            self.damYOBStackView.isHidden = false
//            self.damIDHeaderView.isHidden = false
//            self.damYOBHeaderView.isHidden = false
            self.resetBottomConstraint.constant = 92
            self.addAnimalStackTopConstraint.constant = 350
            inheritScrollView.bringSubviewToFront(self.view)
            
            //  let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            inheritExpandBtnOutlet.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
            inheritExpandBtnOutlet.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
       //     innerScrollViewHeight.constant = 1220
            let lastView : UIView! = inheritScrollView.subviews[0].subviews.last!
            let height = lastView.frame.size.height
            let pos = lastView.frame.origin.y
            let sizeOfContent = height + pos + 570
            inheritScrollView.contentSize.height = sizeOfContent
           
        } else {
            self.eidAndSecondaryStackView.isHidden = true
            self.eidHeaderView.isHidden = true
            self.secondaryHeaderView.isHidden = true
            self.breedAndDobStackView.isHidden = true
            self.breedTypeHeaderView.isHidden = true
            self.dobHeaderView.isHidden = true
            self.breedRegStackView.isHidden = true
            self.breedAssociationHeaderView.isHidden = true
            self.breedRegHeaderView.isHidden = true
//            self.sireRegStackView.isHidden = true
//            self.sireRegNumberHeaderView.isHidden = true
//            self.sireRegAssociationHeaderView.isHidden = true
//            self.sireYOBStackView.isHidden = true
//            self.sireYOBHeaderView.isHidden = true
//            self.damIDHeaderView.isHidden = true
//            self.damYOBStackView.isHidden = true
//            self.damIDHeaderView.isHidden = true
//            self.damYOBHeaderView.isHidden = true
            self.resetBottomConstraint.constant = 390
            self.addAnimalStackTopConstraint.constant = 50
            
            //  let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            inheritExpandBtnOutlet.setTitle(LocalizedStrings.expandFormStr, for: .normal)
            inheritExpandBtnOutlet.setImage(UIImage(named:"downiPad"), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
           
        }
        
    }
    
    @IBAction func expandFromAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            expanBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            expanBtnOutlet.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
            damRegAssoHeightConstraint.constant = 40
            damRegAssoTopConstraint.constant = 20
            damRegNumberHeightConstraint.constant = 40
            damRegNumberTopConstraint.constant = 20
            sireRegAssoHeightConstraint.constant = 40
            sireRegAssoTopConstraint.constant = 20
            sireRegNumberHeightConstraint.constant = 40
            sireRegNumberTopConstraint.constant = 20
            animalNameHeightConstraint.constant = 40
            animalNameTopConstraint.constant = 20
            breedAssocationHeightConstraint.constant = 40
            breedAssocationTopConstraint.constant = 20
            breedRegNumberHeightConstraint.constant = 40
            breedRegNumberTopConstraint.constant = 20
            breedBtnHeightConstraint.constant = 40
            breedBtnTopConstraint.constant = 20
            dobHeighConstraint.constant = 40
            tissueHeightConstraint.constant = 40
            maleFemailHeightConstraint.constant = 56
            dobLbl.isHidden = false
            globalTissueDropDownArroe.isHidden = false
            globalBreedDropDownArroe.isHidden = false
            globalBreedAssDropDownArroe.isHidden = false
            globalsireREgDropDownArroe.isHidden = false
            globalDamRegDropDownArroe.isHidden = false
            tissueBttnOutlet.isHidden = false
            breedBtnOutlet.isHidden = false
            sireRegDropdownOutlet.isHidden = false
            breedRegBttn.isHidden = false
            damRegDropdownOutlet.isHidden = false
            scrolView.isScrollEnabled = true
            dateBttnOutlet.isHidden = false
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                globalDateTextField.isHidden = true
            }else {
                globalDateTextField.isHidden = false
            }
        } else {
            dobLbl.isHidden = false
            damRegAssoHeightConstraint.constant = 0
            damRegAssoTopConstraint.constant = 0
            damRegNumberHeightConstraint.constant = 0
            damRegNumberTopConstraint.constant = 0
            sireRegAssoHeightConstraint.constant = 0
            sireRegAssoTopConstraint.constant = 0
            sireRegNumberHeightConstraint.constant = 0
            sireRegNumberTopConstraint.constant = 0
            animalNameHeightConstraint.constant = 0
            animalNameTopConstraint.constant = 0
            breedAssocationHeightConstraint.constant = 0
            breedAssocationTopConstraint.constant = 0
            breedRegNumberHeightConstraint.constant = 0
            breedRegNumberTopConstraint.constant = 0
            breedBtnHeightConstraint.constant = 0
            breedBtnTopConstraint.constant = 0
            dobHeighConstraint.constant = 0
            tissueHeightConstraint.constant = 0
            maleFemailHeightConstraint.constant = 0
            globalTissueDropDownArroe.isHidden = true
            globalBreedDropDownArroe.isHidden = true
            globalBreedAssDropDownArroe.isHidden = true
            globalsireREgDropDownArroe.isHidden = true
            globalDamRegDropDownArroe.isHidden = true
            tissueBttnOutlet.isHidden = false
            breedBtnOutlet.isHidden = true
            sireRegDropdownOutlet.isHidden = true
            breedRegBttn.isHidden = true
            damRegDropdownOutlet.isHidden = true
            scrolView.isScrollEnabled = false
            dateBttnOutlet.isHidden = true
            globalDateTextField.isHidden = true
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            expanBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            expanBtnOutlet.setImage(UIImage(named:"downiPad"), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
            
        }
    }
    
    @IBAction func incrementalBarcodeButtonActionInherit(_ sender: UIButton) {
        guard inheritBarcodeTextfield.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
            return
        }
        
        guard isBarCodeEndsWithNumber_GetIncrementedBarCode(inheritBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
            if checkBarcode == false{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
                
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            sender.isSelected = false
            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        }
        else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
    }
    
    @IBAction func incrementalBarcodeButtonActionGlobal(_ sender: UIButton) {
        
        guard scanBarcodeTextfield.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
            return
        }
        
        guard isBarCodeEndsWithNumber_GetIncrementedBarCode(scanBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
            if checkBarcode == false{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
                
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
            }
            
            return
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            sender.isSelected = false
            incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        }
        else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
    }
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
    }
    
    @IBAction func backClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            addContiuneBtn = 2
            identify1 = true
            let data1 = fetchAllDataOrderStatusListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false",listId:listIdGet)
            if data1.count > 0 {
                if scanEarTagTextField.text == ""{
                    pageLoading()
                }
                else {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            self.pageLoading()
                        }
                    })
                }
            }
            else {
                
                if scanEarTagTextField.text == "" {
                    if scanEarTagTextField.text == "" {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.addOneAnimal, comment: ""))
                        self.validation()
                    }
                    else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
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
        }
        
        else {
            addContiuneBtn = 2
            identify1 = true
            let data1 = fetchAllDataOrderStatusListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false",listId:listIdGet)
            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
            if  identyCheck == false || identyCheck == nil{
                if data1.count > 0 {
                    if inheritEarTagTextfield.text == "" {
                        if isAnimalComingFromCart == false{
                            self.pageLoading()
                        } else {
                            self.inheritValidation()
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            return
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
                else {
                    if inheritEarTagTextfield.text == "" {
                        if inheritEarTagTextfield.text == "" {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.addOneAnimal, comment: ""))
                            self.inheritValidation()
                        }
                        else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
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
                    if inheritEarTagTextfield.text == "" {
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
        }
    }
    
    @IBAction func inheritAddAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        changeColorToRed = true
        addAnimalBtn(completionHandler: { (success) -> Void in
            print(success)
            if success == true {
                self.changeColorToRed = false
                self.inheritEarTagTextfield.becomeFirstResponder()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.changeColorToRed = false
                })
                self.inheritEarTagTextfield.becomeFirstResponder()
            }
            
        })
    }
    
    @IBAction func inheritSireYobAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        inheritSireYOBDoDatePicker()
    }
    
    @IBAction func inheritDamYObAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        inheritDamYOBDoDatePicker()
    }
    
    @IBAction func inheritRegAssociationAction(_ sender: UIButton){
        btnTag = 70
        view.endEditing(true)
        inheritRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 20)
        self.tableViewpop()
        var yFrame = (inheritRegAssociationBttn.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        self.breedAssociationView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)
                
            case 810:
                yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)
                } else {
                    yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)
                } else {
                    yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)
                }

            case 1024:
                yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)

            case 1032:
                yFrame = (inheritRegAssociationBttn.frame.minY + 850) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 588,y: yFrame,width: 567,height: 150)

            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 20,y: yFrame,width: inheritRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func inheritDateAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            inheritDateTextField.isHidden = false
        }
        else {
            inheritDateTextField.isHidden = true
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            inheritDoDatePicker()
        }
        
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func inheritMaleFemaleBttnAction(_ sender: UIButton) {
        btnTag = 110
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        self.view.endEditing(true)
        
//        if(inheritGenderToggleFlag == 0) {
//            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
//            inheritGenderToggleFlag = 1
//            inheritGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
//        }
//        else {
//            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//            inheritGenderToggleFlag = 0
//            inheritGenderString = ButtonTitles.femaleText.localized
//            
//        }
        
        self.inheritGenderView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        self.tableViewpop()
        var yFrame = (inheritMaleFemaleBttn.frame.minY + 130) - self.inheritScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 482,height: 95)
                
            case 810:
                yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 95)
                } else {
                    yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 95)
                } else {
                    yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 95)
                }

            case 1024:
                yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 95)

            case 1032:
                yFrame = (inheritMaleFemaleBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 700,y: yFrame,width: 655,height: 95)

            default:
                break
            }
        }
        
        droperTableView.reloadData()
        
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func inheritBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func inheritOCRbtn(_ sender: UIButton) {
        let marketId = UserDefaults.standard.object(forKey: keyValue.currentActiveMarketId.rawValue) as? String ?? ""
        if marketId == MarketID.USMarketId{
            if UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                vc?.delegate = self
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else {
                
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
        else {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func globalOcrBtnAction(_ sender: Any) {
        let marketId = UserDefaults.standard.object(forKey: keyValue.currentActiveMarketId.rawValue) as? String ?? ""
        if marketId == MarketID.USMarketId{
            if UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                vc?.delegate = self
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else {
                
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
        else {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func globalclearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.byDefaultSetting()
            let ab =  UserDefaults.standard.string(forKey: keyValue.dataEntryBeeftsuClear.rawValue)
            if ab == nil || ab == "" {
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
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
            }
            
            else {
                self.tissueBttnOutlet.setTitle(ab, for: .normal)
                UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryBeeftsu.rawValue)
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity, provId: pvid, tissueName: ab!)
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
            }
            
            var breed = UserDefaults.standard.string(forKey: keyValue.dataEntryBeefbreedClear.rawValue)
            if breed == nil || breed == "" {
                breed = ButtonTitles.ANGText
                self.breedBtnOutlet.setTitle(breed, for: .normal)
            }
            else {
                self.breedBtnOutlet.setTitle(breed, for: .normal)
                UserDefaults.standard.set(self.breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeefbreed.rawValue)
                let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (self.breedBtnOutlet.titleLabel?.text!)!, productId: 19)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    self.breedId = medbreedRegArr1!.breedId ?? ""
                }
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                print(ImageNames.checkImg)
                self.incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                self.incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            self.scanEarTagTextField.becomeFirstResponder()
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func inheritClearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.inheritByDefaultSetting()
            let ab =  UserDefaults.standard.string(forKey: keyValue.dataEntryBeefInheritTsuClear.rawValue)
            if ab == nil || ab == "" {
                self.inheritTissueBttn.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                self.tissuId = 1
            }
            else {
                self.inheritTissueBttn.setTitle(ab?.localized, for: .normal)
                UserDefaults.standard.set(self.inheritTissueBttn.titleLabel!.text, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity, provId: pvid, tissueName: ab!)
                
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
            }
            
            let breed = UserDefaults.standard.string(forKey: keyValue.dataEntryInheritBeefbreedClear.rawValue)
            if breed != nil || breed != "" {
                self.inheritBreedBttn.setTitle(breed, for: .normal)
                UserDefaults.standard.set(self.inheritBreedBttn.titleLabel?.text, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                
                let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (self.inheritBreedBttn.titleLabel?.text!)!, productId: 20)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    self.breedId = medbreedRegArr1!.breedId ?? ""
                }
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                print(ImageNames.checkImg)
                self.incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                self.incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            if !self.changeColorToRed{
                self.inheritEarTagTextfield.becomeFirstResponder()
            }
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func crossPairedAction(_ sender: Any) {
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
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
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        self.view.endEditing(true)
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            globalDateTextField.isHidden = false
        }
        else {
            globalDateTextField.isHidden = true
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            doDatePicker()
        }
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        InheritSelectedDate = Date()
        let vc = UIStoryboard.init(name: "DataEntryBeefiPad", bundle: Bundle.main).instantiateViewController(withIdentifier: "DataEntryBeefViewAnimalList") as? DataEntryBeefViewAnimalList
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func inheritSireRedNumberAction(_ sender: UIButton) {
        if inheritEarTagTextfield.text?.count == 0 {
            return
        }
        
        btnTag = 90
        view.endEditing(true)
        inheritRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 20)
        self.tableViewpop()
        var yFrame = (inheriSireRedOutlet.frame.minY + 135) - self.inheritScrollView.contentOffset.y
        self.sireRegAssociationView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)
                
            case 810:
                yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)
                } else {
                    yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)
                } else {
                    yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)
                }

            case 1024:
                yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)

            case 1032:
                yFrame = (inheriSireRedOutlet.frame.minY + 890) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)

            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 595,y: yFrame + 60,width: inheritRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func breedRegAction(_ sender: UIButton) {
        btnTag = 80
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 19)
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
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegBttn.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func inheritTissueBttnAction(_ sender: UIButton) {
        btnTag = 50
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        inheritTissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        var yFrame = (inheritTissueBttn.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        self.sampleTypeView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 150)
                
            case 810:
                yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 150)
                } else {
                    yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 150)
                } else {
                    yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 150)
                }

            case 1024:
                yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            case 1032:
                yFrame = (inheritTissueBttn.frame.minY + 470) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            default:
                break
            }
        }
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func scanBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func tissueBtnnAction(_ sender: UIButton) {
        btnTag = 20
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        tissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
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
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func inheritBreedAction(_ sender: UIButton) {
        btnTag = 60
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        inheritBreedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 20)
        var yFrame = (inheritBreedBttn.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        self.breedTypeView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (inheritBreedBttn.frame.minY + 755) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 150)
                
            case 810:
                yFrame = (inheritBreedBttn.frame.minY + 745) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (inheritBreedBttn.frame.minY + 745) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 150)
                } else {
                    yFrame = (inheritBreedBttn.frame.minY + 745) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (inheritBreedBttn.frame.minY + 745) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 150)
                } else {
                    yFrame = (inheritBreedBttn.frame.minY + 745) - self.inheritScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 150)
                }

            case 1024:
                yFrame = (inheritBreedBttn.frame.minY + 745) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            case 1032:
                yFrame = (inheritBreedBttn.frame.minY + 745) - self.inheritScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            default:
                break
            }
        }
        
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func breedAction(_ sender: UIButton) {
        btnTag = 10
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 19)
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
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 300)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func sireRegAction(_ sender: UIButton) {
        btnTag = 30
        view.endEditing(true)
        sireRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 19)
        self.tableViewpop()
        var yFrame = (sireRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (sireRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (sireRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (sireRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: sireRegDropdownOutlet.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func damRegAction(_ sender: UIButton) {
        btnTag = 40
        damRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 19)
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (damRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (damRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (damRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (damRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: sireRegDropdownOutlet.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func maleFemaleAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        self.view.endEditing(true)
        if(genderToggleFlag == 0) {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
        }
        
        else {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            
        }
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
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
}
