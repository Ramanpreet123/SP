//
//  DEBAnimalNZVCActionMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation
import UIKit

// MARK: - IB ACTIONS
extension DataEntryBeefAnimalNZ_VC {
    
    @IBAction func breedRegAction(_ sender: UIButton) {
        btnTag = 80
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 25)
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (breedRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = (breedRegLbl.frame.minY + 100) - self.scrolView.contentOffset.y
                
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
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
    }
    
    @IBAction func breedAction(_ sender: UIButton) {
        btnTag = 10
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        breedArr = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
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
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 150,height: 70)
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
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        barcodeEnable = true
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
        }
        else {
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        doDatePicker()
        dateTextField.isHidden = true
        }
    }
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            self.scanAnimalTagTextField.becomeFirstResponder()
        })
    }
    
    @IBAction func maleFemaleAction(_ sender: UIButton) {
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
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        addContiuneBtn = 2
        identify1 = true
        let data1 = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),productId:25) as!  [DataEntryBeefAnimaladdTbl]
        if data1.count > 0 {
            if scanAnimalTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                self.pageLoading()
            } else {
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success == true{
                        self.pageLoading()
                    }
                })
            }
        }
        else {
            if scanAnimalTagTextField.text == "" || scanBarcodeTextfield.text == ""{
                if scanAnimalTagTextField.text == "" && scanBarcodeTextfield.text == ""{
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
    
    @IBAction func earTagOCRbtn(_ sender: UIButton) {
        setUpGallary()
    }
    
    @IBAction func clearFromAction(_ sender: Any) {
      self.view.endEditing(true)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.byDefaultSetting()
            let tissueName = UserDefaults.standard.string(forKey: keyValue.dataEntryNZBeeftsuClear.rawValue)
            if UserDefaults.standard.string(forKey: keyValue.dataEntryNZBeeftsuClear.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntryNZBeeftsuClear.rawValue) == "" {
                self.tissueBttnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                self.tissuId = 1
            } 
            else {
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: self.pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.tissueBttnOutlet.setTitle(tissueName, for: .normal)
                UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.tsuKey.rawValue)
            }
                        
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                
            } else {
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            self.scanAnimalTagTextField.becomeFirstResponder()
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
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
        }
        else {
            sender.isSelected = true
            incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
            
        }
    }
    
    @IBAction func bckNavigateToList(_ sender: Any) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC) as! DataEntryModeListVC
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func expandFromAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
        let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
        expandFormOutlet.setAttributedTitle(attributeString, for: .normal)
        damREGBottomConstraint.constant = 57
        damREGHeightConstraint.constant = 40
        damREGTopConstraint.constant = 20
        sireRegHeightConstraint.constant = 40
        sireRegTopConstraint.constant = 20
        animalNameHeightConstraint.constant = 40
        animalNameTopConstraint.constant = 20
        nzAngusHeightConstraint.constant = 40
        nzAngusTopConstraint.constant = 20
        breedRegHeightConstraint.constant = 40
        breedRegTopConstraint.constant = 20
        breedBtnHeightConstraint.constant = 40
        breedBtnTopConstraint.constant = 20
        dobViewHeightConsraint.constant = 40
        dobTitleLbl.isHidden = false
        maleFemaleHeightConstrant.constant = 56
        tissueBtnHeightConstraint.constant = 40
        tissueImageIcon.isHidden = false
        tissueBttnOutlet.isHidden = false
        breedBtnOutlet.isHidden = false
        dateTextField.isHidden = false
        dateBtnOutlet.isHidden = false
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = true
        }else {
            dateTextField.isHidden = false
        }
       } 
    else {
        damREGBottomConstraint.constant = 0
        damREGHeightConstraint.constant = 0
        damREGTopConstraint.constant = 0
        sireRegHeightConstraint.constant = 0
        sireRegTopConstraint.constant = 0
        animalNameHeightConstraint.constant = 0
        animalNameTopConstraint.constant = 0
        nzAngusHeightConstraint.constant = 0
        nzAngusTopConstraint.constant = 0
        breedRegHeightConstraint.constant = 0
        breedRegTopConstraint.constant = 0
        breedBtnHeightConstraint.constant = 0
        breedBtnTopConstraint.constant = 0
        dobViewHeightConsraint.constant = 0
        dobTitleLbl.isHidden = true
        maleFemaleHeightConstrant.constant = 0
        tissueBtnHeightConstraint.constant = 0
        tissueImageIcon.isHidden = true
        tissueBttnOutlet.isHidden = true
        breedBtnOutlet.isHidden = true
        dateTextField.isHidden = true
        dateBtnOutlet.isHidden = true
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            expandFormOutlet.setAttributedTitle(attributeString, for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
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
    
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        InheritSelectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefViewAnimalControllerVC) as? DataEntryBeefViewAnimalController
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func scanBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true

    }
}
