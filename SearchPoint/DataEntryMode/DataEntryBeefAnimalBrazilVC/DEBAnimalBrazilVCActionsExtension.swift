//
//  DEBAnimalBrzilVCActionsExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation
import UIKit

// MARK: - IB ACTIONS
extension DataEntryBeefAnimalBrazilVC {
    
    @IBAction func genoTypeBackNavigateList(_ sender: Any) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC) as! DataEntryModeListVC
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func nonGenoExpandFormAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            nonGenoExpandOutlet.setAttributedTitle(attributeString, for: .normal)
            maleFemaleBttn.isHidden = false
            tissueImageDown.isHidden = false
            tissueBttn.isHidden = false
            if isGenostarblackOnlyAdded
            {
                genstarblackBreedBtn.isHidden = false
                genstardropdown.isHidden = false
            }
            else
            {
                genstarblackBreedBtn.isHidden = true
                genstardropdown.isHidden = true
            }
            nonGenoAnimalNameHeight.constant = 40
            nonGenoAnimalNameTop.constant = 10
        }
        else {
            nonGenoAnimalNameHeight.constant = 0
            nonGenoAnimalNameTop.constant = 0
            maleFemaleBttn.isHidden = true
            tissueImageDown.isHidden = false
            tissueBttn.isHidden = false
            genstarblackBreedBtn.isHidden = true
            genstardropdown.isHidden = true
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            nonGenoExpandOutlet.setAttributedTitle(attributeString, for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        }
    }
    
    @IBAction func genoTypeExpandFormAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
            genoTypeSecondaryBreedHeight.constant = 40
            genoTypeSecondaryBrTop.constant = 20
            genoTypePriorityBreedHeight.constant = 40
            genoTypePriorityBrTop.constant = 20
            genoTypeAnimalNameHeight.constant = 40
            genoTypeAnimalNameTop.constant = 10
            genoTypePriorityBreedingDropDown.isHidden = false
            genoTypeSecondaryBreedingDropDown.isHidden = false
            genoTypeTerritoryBreedingDropDown.isHidden = false
            genotypeTissueBttn.isHidden = false
            priorityBreeingBtnOutlet.isHidden = false
            secondaryBreddingOutlet.isHidden = false
            territoryBreddingOutlet.isHidden = false
            genotypeMaleFemaleBttn.isHidden = false
            tissueDropDownImage.isHidden = false
            selectBreedBtn.isHidden = false
            selectbreeddropdown.isHidden = false
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            genoTypeExpandFormBtn.setAttributedTitle(attributeString, for: .normal)
        }
        else {
            genoTypeSecondaryBreedHeight.constant = 0
            genoTypeSecondaryBrTop.constant = 0
            genoTypePriorityBreedHeight.constant = 0
            genoTypePriorityBrTop.constant = 0
            genoTypeAnimalNameHeight.constant = 0
            genoTypeAnimalNameTop.constant = 0
            genoTypePriorityBreedingDropDown.isHidden = true
            genoTypeSecondaryBreedingDropDown.isHidden = true
            priorityBreeingBtnOutlet.isHidden = true
            secondaryBreddingOutlet.isHidden = true
            territoryBreddingOutlet.isHidden = true
            genotypeMaleFemaleBttn.isHidden = true
            selectBreedBtn.isHidden = true
            selectbreeddropdown.isHidden = true
            genoTypeTerritoryBreedingDropDown.isHidden = true
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            genoTypeExpandFormBtn.setAttributedTitle(attributeString, for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
            
        }
    }
    
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
        guard isautoPopulated == false else {
            return
        }
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
                incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            sender.isSelected = false
            incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
        }
        else {
            sender.isSelected = true
            incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
    }
    
    @IBAction func incrementalBarcodeButtonActionGenotype(_ sender: UIButton) {
        guard isautoPopulated == false else {
            return
        }
        
        guard genotypeScanBarcodeTextField.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
            return
        }
        
        guard isBarCodeEndsWithNumber_GetIncrementedBarCode(genotypeScanBarcodeTextField.text ?? "").isBarCodeEndsWithNumber else {
            if checkBarcode == false{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                
            }
            return
        }
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            sender.isSelected = false
            incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.incrementalCheckImg)
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
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
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    @IBAction func selectBreedTypeblackstar(_ sender: Any) {
        btnTag = 117
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
        var yFrame = (breedblackstarlablehide.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (breedblackstarlablehide.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (breedblackstarlablehide.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                yFrame = (breedblackstarlablehide.frame.minY + 180) - self.scrolView.contentOffset.y

            case 1792:
                yFrame = (breedblackstarlablehide.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: genstarblackBreedBtn.frame.minX + 20,y: yFrame,width: 150,height: 300)
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
    
    @IBAction func selectBreedTypeBtnAction(_ sender: Any) {
        btnTag = 116
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 23, speciesName: "")
        var yFrame = (breedlablehide.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (breedlablehide.frame.minY + 105) - self.genotypeScrollView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (breedlablehide.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (breedlablehide.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: selectBreedBtn.frame.minX + 20,y: yFrame,width: 150,height: 300)
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
    
    @IBAction func tissureBtnAction(_ sender: Any) {
        btnTag = 10
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        var yFrame = (genotypeTissueHideLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                
            case 1136:
                break
                
            case 1334:
                yFrame = (genotypeTissueHideLbl.frame.minY + 105) - self.genotypeScrollView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (genotypeTissueHideLbl.frame.minY + 113) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (genotypeTissueHideLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
                
            }
        }
        
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 200)
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
    
    @IBAction func prioorityBreddingAction(_ sender: Any) {
        btnTag = 20
        view.endEditing(true)
        priorityBreeding = fetchAllData(entityName: Entities.getPriorityBreedingTblEntity)
        self.tableViewpop()
        var yFrame = (priorityBreddingLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (priorityBreddingLbl.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (priorityBreddingLbl.frame.minY + 120) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (priorityBreddingLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
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
    
    @IBAction func secondayBtnAction(_ sender: Any) {
        btnTag = 30
        view.endEditing(true)
        secondaryBreeding = fetchAllData(entityName: Entities.getSecondaryBreedingProgramsTblEntity)
        self.tableViewpop()
        var yFrame = (secondaryHidenLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (secondaryHidenLbl.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (secondaryHidenLbl.frame.minY + 119) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (secondaryHidenLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func tertiaryButtonAction(_ sender: Any) {
        btnTag = 50
        view.endEditing(true)
        
        tertiaryBreeding = fetchAllData(entityName: Entities.getTertiaryBreedingProgramsTblEntity)
        self.tableViewpop()
        
        var yFrame = (territoryHidenLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (territoryHidenLbl.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (territoryHidenLbl.frame.minY + 119) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (territoryHidenLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    @IBAction func genotypeAddAnimalAction(_ sender: UIButton) {
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            print(success)
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
        })
    }
    
    @IBAction func maleBtnClick(_ sender: Any) {
        
      
        self.view.endEditing(true)
        if genderToggleFlag == 0 {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
            UserDefaults.standard.set("M", forKey: "DEGenoGender")
        } else {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            UserDefaults.standard.set("F", forKey: "DEGenoGender")
        }
        
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func otherMaleBtnAction(_ sender: Any) {
        self.view.endEditing(true)
      
        if othersGenderToggleFlag == 0 {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            othersGenderToggleFlag = 1
            othersGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
            genderString = othersGenderString
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
        }
        else {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            othersGenderToggleFlag = 0
            othersGenderString = ButtonTitles.femaleText.localized
            genderString = othersGenderString
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
        }
        
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func OtherTissuebtnAction(_ sender: Any) {
        btnTag = 40
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        var yFrame = (tissueHideLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (tissueHideLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (tissueHideLbl.frame.minY + 113) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (tissueHideLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            print(success)
            self.scanBarcodeTextfield.becomeFirstResponder()
        })
    }
    
    @IBAction func addAnimalkeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            if self.isGenotypeOnlyAdded
            {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
            }
            else
            {
                self.scanBarcodeTextfield.becomeFirstResponder()
            }
        })
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefViewAnimalControllerVC) as? DataEntryBeefViewAnimalController
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
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
    
    @IBAction func dateAction(_ sender: UIButton) {
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
    
    @IBAction func genotypeDateAction(_ sender: UIButton) {
        barcodeEnable = true
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            genotypeDateTextField.isHidden = false
        }
        else {
            genotypeDateTextField.isHidden = true
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            genotypeDoDatePicker()
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
    
    @IBAction func genotypeContinueProductAction(_ sender: UIButton)
    {
        addContiuneBtn = 2
        genotypecontinueproduct()
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
    
    @IBAction func BarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func genotypeBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func clearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.GenotypebyDefaultScreen()
            if let breedName = UserDefaults.standard.object(forKey: keyValue.dataBeefBreedName.rawValue) {
                self.selectBreedBtn.setTitle(breedName as? String, for: .normal)
            } else {
                if let breed1 = self.breedArr[0] as? GetBreedsTbl
                {
                    self.selectBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
                }
            }
            let tissueName = UserDefaults.standard.string(forKey: keyValue.dataEntrygenotypeTissueBttnClear.rawValue)
            if UserDefaults.standard.string(forKey: keyValue.dataEntrygenotypeTissueBttnClear.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntrygenotypeTissueBttnClear.rawValue) == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true
                    {
                        self.genotypeTissueBttn.setTitle(tissue?.sampleName, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                }
            }
            else {
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count == 0 {
                } else {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.genotypeTissueBttn.setTitle(tissueName, for: .normal)
                UserDefaults.standard.set(self.genotypeTissueBttn.titleLabel!.text, forKey: keyValue.dataEntrygenotypeTissueBttn.rawValue)
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                print(ImageNames.checkImg)
                self.checkBarcode = false
                self.incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                    if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                        self.genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                        if self.genotypeScanBarcodeTextField.text?.isEmpty == false {
                            self.GenotypebyDefaultbackroundWhite()
                        }
                    }
                }
                
            } else {
                self.incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func nonGenotypeclearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            
            self.byDefaultSetting()
            if let breed = self.breedArrblack[0] as? GetBreedsTbl
            {
                self.genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
            }
            let tissueName = UserDefaults.standard.string(forKey: keyValue.dataEntrytissueBttnClear.rawValue)
            if UserDefaults.standard.string(forKey: keyValue.dataEntrytissueBttnClear.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntrytissueBttnClear.rawValue) == ""{
                
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true
                    {
                        self.tissueBttn.setTitle(tissue?.sampleName, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                }
            }
            else {
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count == 0 {
                    
                } else {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.tissueBttn.setTitle(tissueName, for: .normal)
                UserDefaults.standard.set(self.tissueBttn.titleLabel!.text, forKey: keyValue.dataEntrytissueBttn.rawValue)
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                print(ImageNames.checkImg)
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.checkBarcode = false
                if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                    if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                        self.scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                        
                        if self.scanBarcodeTextfield.text?.isEmpty == false {
                            self.othersByDefaultBackroundWhite()
                        }
                    }
                }
            }
            else {
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            self.scanBarcodeTextfield.becomeFirstResponder()
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
