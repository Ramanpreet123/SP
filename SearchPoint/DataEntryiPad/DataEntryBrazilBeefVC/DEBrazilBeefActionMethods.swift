//
//  DEBrazilBeefActionMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 26/03/25.
//

import Foundation
import UIKit

// MARK: - IB ACTIONS
extension DEBrazilBeefVCIpad {
    
    @IBAction func genoTypeBackNavigateList(_ sender: Any) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC) as! DataEntryModeListVC
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func nonGenoExpandFormAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            //  nonGenoExpandOutlet.setAttributedTitle(attributeString, for: .normal)
            nonGenoExpandOutlet.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
            nonGenoExpandOutlet.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
            maleFemaleBttn.isHidden = false
            tissueBttn.isHidden = false
            if isGenostarblackOnlyAdded
            {
                genstarblackBreedBtn.isHidden = false
                breedTypeHeaderView.isHidden = false
                nonGenoBreedTypeStackView.isHidden = false
            }
            else
            {
                genstarblackBreedBtn.isHidden = true
                breedTypeHeaderView.isHidden = true
                nonGenoBreedTypeStackView.isHidden = true
            }
            
            nonGenoGenderHeaderView.isHidden = false
            nonGenderDOBStackView.isHidden = false
            nonGenoAnimalNameHeaderView.isHidden = false
            resetButtonBottomConstraint.constant = 42
            nonGenoAddAnimalStackTopConstraint.constant = 250
            nonGenoInnerScrollViewHeight.constant = 977
           
        }
        else {
            breedTypeHeaderView.isHidden = true
            nonGenoBreedTypeStackView.isHidden = true
            nonGenoGenderHeaderView.isHidden = true
            nonGenderDOBStackView.isHidden = true
            nonGenoAnimalNameHeaderView.isHidden = true
            resetButtonBottomConstraint.constant = 40
            nonGenoAddAnimalStackTopConstraint.constant = 40
            nonGenoInnerScrollViewHeight.constant = 767
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            // nonGenoExpandOutlet.setAttributedTitle(attributeString, for: .normal)
            nonGenoExpandOutlet.setTitle(LocalizedStrings.expandFormStr, for: .normal)
            nonGenoExpandOutlet.setImage(UIImage(named:"downiPad"), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        }
    }
    
    @IBAction func genoTypeExpandFormAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            UserDefaults.standard.set(true, forKey: keyValue.expandView.rawValue)
            genoTypeExpandFormBtn.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
            genoTypeExpandFormBtn.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
            genoGenderAndBreedStackView.isHidden = false
            genoGenderHeaderView.isHidden = false
            genoBreedTypeHeaderView.isHidden = false
            genoPrimaryStackView.isHidden = false
            genoAnimalNameHeaderView.isHidden = false
            genoPrimaryHeaderView.isHidden = false
            genoSecAndTerStackView.isHidden = false
            genoSecondaryHeaderView.isHidden = false
            genoTeritiaryHeaderView.isHidden = false
            genoResetButtonBottomConstraint.constant = 41
            genoAddAnimalStackTopConstraint.constant = 350
            genotypeInnerViewHeight.constant = 1076
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            //genoTypeExpandFormBtn.setAttributedTitle(attributeString, for: .normal)
            genoTypeExpandFormBtn.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
        }
        else {
            genoGenderAndBreedStackView.isHidden = true
            genoGenderHeaderView.isHidden = true
            genoBreedTypeHeaderView.isHidden = true
            genoPrimaryStackView.isHidden = true
            genoAnimalNameHeaderView.isHidden = true
            genoPrimaryHeaderView.isHidden = true
            genoSecAndTerStackView.isHidden = true
            genoSecondaryHeaderView.isHidden = true
            genoTeritiaryHeaderView.isHidden = true
            genoResetButtonBottomConstraint.constant = 175
            genoAddAnimalStackTopConstraint.constant = 40
            genotypeInnerViewHeight.constant = 900
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            // genoTypeExpandFormBtn.setAttributedTitle(attributeString, for: .normal)
            genoTypeExpandFormBtn.setTitle(LocalizedStrings.expandFormStr, for: .normal)
            genoTypeExpandFormBtn.setImage(UIImage(named:"downiPad"), for: .normal)
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
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
    }
    
    @IBAction func selectBreedTypeblackstar(_ sender: Any) {
        btnTag = 117
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
        var yFrame = (genstarblackBreedBtn.frame.minY + 130) - self.scrolView.contentOffset.y
        self.nonGenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (genstarblackBreedBtn.frame.minY + 860) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 140)
                    
                }
            case 810:
                yFrame = (genstarblackBreedBtn.frame.minY + 860) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 140)
                    
                }
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (genstarblackBreedBtn.frame.minY + 858) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 23,y: yFrame,width: 567,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 140)
                        
                    }
                }
                else {
                    yFrame = (genstarblackBreedBtn.frame.minY + 858) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 140)
                        
                    }
                }
              
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (genstarblackBreedBtn.frame.minY + 858) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 140)
                        
                    }
                } else {
                    yFrame = (genstarblackBreedBtn.frame.minY + 858) - self.scrolView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 140)
                        
                    }
                }
            case 1024:
                yFrame = (genstarblackBreedBtn.frame.minY + 858) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 140)
                    
                }
            case 1032:
                yFrame = (genstarblackBreedBtn.frame.minY + 858) - self.scrolView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 140)
                    
                }
            default:
                break
            }
        }
    //    droperTableView.frame = CGRect(x: genstarblackBreedBtn.frame.minX + 20,y: yFrame,width: 150,height: 300)
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
        var yFrame = (selectBreedBtn.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        self.GenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (selectBreedBtn.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 482,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 482,height: 140)
                    
                }
            case 810:
                yFrame = (selectBreedBtn.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 512,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 512,height: 140)
                    
                }
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (selectBreedBtn.frame.minY + 858) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                        
                    }
                }
                else {
                    yFrame = (selectBreedBtn.frame.minY + 858) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 512,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 512,height: 140)
                        
                    }
                }
              
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (selectBreedBtn.frame.minY + 858) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 527,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 527,height: 140)
                        
                    }
                } else {
                    yFrame = (selectBreedBtn.frame.minY + 858) - self.genotypeScrollView.contentOffset.y
                    if breedArr.count == 2 || breedArr.count == 1{
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 577,height: 95)
                        
                    } else {
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 577,height: 140)
                        
                    }
                }
            case 1024:
                yFrame = (selectBreedBtn.frame.minY + 858) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 652,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 652,height: 140)
                    
                }
            case 1032:
                yFrame = (selectBreedBtn.frame.minY + 858) - self.genotypeScrollView.contentOffset.y
                if breedArr.count == 2 || breedArr.count == 1{
                    droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 95)
                    
                } else {
                    droperTableView.frame = CGRect(x: 695,y: yFrame,width: 655,height: 140)
                    
                }
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
    
    @IBAction func tissureBtnAction(_ sender: Any) {
        btnTag = 10
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        self.GenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        self.tableViewpop()
        var yFrame = (genotypeTissueBttn.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (genotypeTissueBttn.frame.minY + 630) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 482,height: 95)
                
            case 810:
                yFrame = (genotypeTissueBttn.frame.minY + 630) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (genotypeTissueBttn.frame.minY + 577) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 95)
                } else {
                    yFrame = (genotypeTissueBttn.frame.minY + 630) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 95)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (genotypeTissueBttn.frame.minY + 627) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 95)
                } else {
                    yFrame = (genotypeTissueBttn.frame.minY + 627) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 95)
                }

            case 1024:
                yFrame = (genotypeTissueBttn.frame.minY + 575) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 95)

            case 1032:
                yFrame = (genotypeTissueBttn.frame.minY + 575) - self.genotypeScrollView.contentOffset.y
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
    
    @IBAction func prioorityBreddingAction(_ sender: Any) {
        btnTag = 20
        view.endEditing(true)
        priorityBreeding = fetchAllData(entityName: Entities.getPriorityBreedingTblEntity)
        self.tableViewpop()
        var yFrame = (priorityBreeingBtnOutlet.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
            case 810:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                }
                else {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                }
              
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                } else {
                    yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                }
            case 1024:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 140)
            case 1032:
                yFrame = (priorityBreeingBtnOutlet.frame.minY + 958) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 695,y: yFrame,width: 655,height: 140)
            default:
                break
            }
        }
        
       // droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
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
        var yFrame = (secondaryBreddingOutlet.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (secondaryBreddingOutlet.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 95)
                
            case 810:
                yFrame = (secondaryBreddingOutlet.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (secondaryBreddingOutlet.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 567,height: 95)
                } else {
                    yFrame = (secondaryBreddingOutlet.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 95)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (secondaryBreddingOutlet.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 527,height: 95)
                } else {
                    yFrame = (genotypeTissueBttn.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 577,height: 95)
                }

            case 1024:
                yFrame = (secondaryBreddingOutlet.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 95)

            case 1032:
                yFrame = (secondaryBreddingOutlet.frame.minY + 1057) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 95)

            default:
                break
            }
        }
        
      //  droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
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
        
        var yFrame = (territoryBreddingOutlet.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        var strDeviceType = ""
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (territoryBreddingOutlet.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
            case 810:
                yFrame = (territoryBreddingOutlet.frame.minY + 860) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (territoryBreddingOutlet.frame.minY + 1058) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                }
                else {
                    yFrame = (territoryBreddingOutlet.frame.minY + 1058) - self.genotypeScrollView.contentOffset.y
                        droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                        
                }
              
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (territoryBreddingOutlet.frame.minY + 1058) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                } else {
                    yFrame = (territoryBreddingOutlet.frame.minY + 1058) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 140)
                }
            case 1024:
                yFrame = (territoryBreddingOutlet.frame.minY + 1058) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 140)
            case 1032:
                yFrame = (territoryBreddingOutlet.frame.minY + 1058) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 695,y: yFrame,width: 655,height: 140)
            default:
                break
            }
        }
        
       // droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
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
            if success == true {
                self.changeColorToRed = false
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.changeColorToRed = false
                    self.genotypeScanBarcodeTextField.becomeFirstResponder()
                })
            }
            
        })
    }
    
    @IBAction func maleBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        btnTag = 210
//        if genderToggleFlag == 0 {
//            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
//            genderToggleFlag = 1
//            genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
//            
//        } else {
//            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//            genderToggleFlag = 0
//            genderString = ButtonTitles.femaleText.localized
//        }
        
        self.GenoGenderView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
        self.tableViewpop()
        var yFrame = (genotypeMaleFemaleBttn.frame.minY + 640) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 640) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 150)

                
            case 810:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 640) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 850) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                } else {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 850) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                }
             

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 850) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 532,height: 150)
                } else {
                    yFrame = (genotypeMaleFemaleBttn.frame.minY + 850) - self.genotypeScrollView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                }

            case 1024:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 850) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 150)

            case 1032:
                yFrame = (genotypeMaleFemaleBttn.frame.minY + 850) - self.genotypeScrollView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 652,height: 150)

            default:
                break
            }
        }
        
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
    
    @IBAction func otherMaleBtnAction(_ sender: Any) {
        self.view.endEditing(true)
//        if othersGenderToggleFlag == 0 {
//            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
//            othersGenderToggleFlag = 1
//            othersGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
//            genderString = othersGenderString
//        }
//        else {
//            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//            othersGenderToggleFlag = 0
//            othersGenderString = ButtonTitles.femaleText.localized
//            genderString = othersGenderString
//        }
        btnTag = 200
        
        self.nonGenoGenderView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
        self.tableViewpop()
        var yFrame = (maleFemaleBttn.frame.minY + 640) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (maleFemaleBttn.frame.minY + 950) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 482,height: 150)

                
            case 810:
                yFrame = (maleFemaleBttn.frame.minY + 950) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (maleFemaleBttn.frame.minY + 950) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                } else {
                    yFrame = (maleFemaleBttn.frame.minY + 950) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 512,height: 150)
                }
             

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (maleFemaleBttn.frame.minY + 950) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 532,height: 150)
                } else {
                    yFrame = (maleFemaleBttn.frame.minY + 950) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 20,y: yFrame,width: 562,height: 150)
                }

            case 1024:
                yFrame = (maleFemaleBttn.frame.minY + 955) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            case 1032:
                yFrame = (maleFemaleBttn.frame.minY + 955) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 20,y: yFrame,width: 655,height: 150)

            default:
                break
            }
        }
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
    
    @IBAction func OtherTissuebtnAction(_ sender: Any) {
        btnTag = 40
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        self.nonGenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        self.tableViewpop()
        var yFrame = (tissueBttn.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = (tissueBttn.frame.minY + 630) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 520,y: yFrame,width: 482,height: 150)
                
            case 810:
                yFrame = (tissueBttn.frame.minY + 630) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 150)
                
            case 820:
                if UIScreen.main.nativeBounds.height == 2360.0 {
                    yFrame = (tissueBttn.frame.minY + 577) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 595,y: yFrame,width: 567,height: 150)
                } else {
                    yFrame = (tissueBttn.frame.minY + 630) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 550,y: yFrame,width: 512,height: 150)
                }
                

            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = (tissueBttn.frame.minY + 627) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 565,y: yFrame,width: 527,height: 150)
                } else {
                    yFrame = (tissueBttn.frame.minY + 627) - self.scrolView.contentOffset.y
                    droperTableView.frame = CGRect(x: 615,y: yFrame,width: 577,height: 150)
                }

            case 1024:
                yFrame = (tissueBttn.frame.minY + 575) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 690,y: yFrame,width: 655,height: 150)

            case 1032:
                yFrame = (tissueBttn.frame.minY + 575) - self.scrolView.contentOffset.y
                droperTableView.frame = CGRect(x: 700,y: yFrame,width: 655,height: 150)

            default:
                break
            }
        }
        
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
        changeColorToRed = true
        addAnimalBtn(completionHandler: { (success) -> Void in
            print(success)
            if success == true {
                self.changeColorToRed = false
                self.scanBarcodeTextfield.becomeFirstResponder()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.changeColorToRed = false
                })
                self.scanBarcodeTextfield.becomeFirstResponder()
            }
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
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        let vc = UIStoryboard.init(name: "DataEntryBeefiPad", bundle: Bundle.main).instantiateViewController(withIdentifier: "DataEntryBeefViewAnimalList") as? DataEntryBeefViewAnimalList
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
            
            if !self.changeColorToRed {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
            }
            
            
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
            if !self.changeColorToRed {
                self.scanBarcodeTextfield.becomeFirstResponder()
            }
            
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
