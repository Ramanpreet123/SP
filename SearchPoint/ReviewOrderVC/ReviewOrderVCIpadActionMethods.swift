//
//  ReviewOrderVCIpadActionMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 23/02/25.
//

import Foundation
import UIKit

//MARK: IB ACTION METHODS
extension ReviewOrderVCIpad {
    @IBAction func placeAnOrderCheckBoxSelection(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
            sender.isSelected = false
            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: keyValue.placeOrderCheck.rawValue)
        }
        else {
            sender.isSelected = true
            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: keyValue.placeOrderCheck.rawValue)
        }
        
        isAgree = !isAgree
        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                if pviduser == 3 {
                    if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) {
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    } else {
                        self.selectionObjectCheck(check :true)
                    }
                } else {
                    if !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue)  {
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    }else {
                        self.selectionObjectCheck(check :true)
                    }
                }
            }
        } else if pviduser == 4 || pviduser == 6 || pviduser == 8 {
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                self.selectionObjectCheck(check :true)
            }
        }
    }
    
    func selectionObjectCheck(check :Bool){
        if check {
            let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.confilictOrdersViewControllerVC) as! ConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.dismissDelegate = self
            vc.screenName = "OPSProductReview"
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func emailMeCheckBoxSelection(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
            let getAnimalData = fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser)
            
            if (getAnimalData.count == 0) || (pviduser == 2 && getAnimalData.count == 1) {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                    
                } else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 1
                
            } else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                    
                } else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 0.6
                placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
            }
        }
        else if pviduser == 4 || pviduser == 6 || pviduser == 8 {
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 1
            }
            else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 0.6
            }
        }
    }
    
    @IBAction func infoBtnSelection(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == true {
            sender.isSelected = false
            AgreeBtnImgView.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        else {
            sender.isSelected = true
            AgreeBtnImgView.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        isAgree = !isAgree
    }
    
    @IBAction func crossBtnAct(_ sender: Any) {
        tableViewBg.isHidden = true
        bckRoundView.isHidden = true
    }
    
    @IBAction func sortByCrossBtn(_ sender: Any) {
        
        sortByView.isHidden = true
        bckRoundView.isHidden = true
    }
    
    @IBAction func sortByBrazilCrossBtn(_ sender: Any) {
        
        sortByBrazilView.isHidden = true
        bckRoundView.isHidden = true
    }
    
    @IBAction func productAnimalToggleBtnClk(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OPSReviewVCIpad") as! OPSReviewVCIpad
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func emailBtnAction(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.emailEnteredData, comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                return
            }
            
            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                if Connectivity.isConnectedToInternet() {
                    self.showIndicator(self.view, withTitle: "", and: "")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: "", and: "")
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    @IBAction func submitAction(_ sender: UIButton){
        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true &&
            UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
            
            if (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == false) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == nil) {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.acceptOrderTerms, comment: ""))
                return
            }
            
            if Connectivity.isConnectedToInternet(){
                UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                showIndicator(self.view, withTitle: "", and: "")
                updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: false, custId: custmerId)
                updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: false)
                let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                newViewController.emailOrder=true
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        else if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true &&
                    UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false{
            
            if (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == false) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == nil){
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.acceptOrderTerms, comment: ""))
                return
            }
            
            DispatchQueue.background(delay: 3.0, background: {
                // do something in background
            }, completion: {
                // when background job finishes, wait 3 seconds and do something in main thread
            })
            
            if Connectivity.isConnectedToInternet(){
                UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                self.showIndicator(self.view, withTitle: "", and: "")
                
                updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: false, custId: custmerId)
                updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: false)
                let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                newViewController.emailOrder=false
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            else{
                let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        
        else if (UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == false || UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) == nil)  &&
                    UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
            
            if !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
                let alertController = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(AlertMessagesStrings.emailEnteredData, comment: ""), preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    return
                }
                let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                    if Connectivity.isConnectedToInternet() {
                        self.showIndicator(self.view, withTitle: "", and: "")
                        updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: true, custId: self.custmerId)
                        updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: true)
                        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                        newViewController.emailOrder=true
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    } else {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                }
                
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            else{
                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                if Connectivity.isConnectedToInternet(){
                    showIndicator(self.view, withTitle: "", and: "")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                    newViewController.emailOrder=true
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                else{
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
        }
        else if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == false &&
                    UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectOneCheckBox, comment: ""))
            return
        }
    }
    
    @IBAction func termsInfoBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductWiseTermsController") as! ProductWiseTermsController
        self.navigationController?.present(vc, animated: false, completion: nil)
        return
    }
    
    @IBAction func leftMenuBtn(_ sender: Any) {
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
    }
    
    @IBAction func conflictOrderAction(_ sender: Any) {
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
            }
            else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.confilictOrdersViewControllerVC) as! ConfilictOrdersViewController
                vc.delegateCustom1 = self
                vc.screenName = ScreenNames.reviewVC.rawValue
                self.present(vc, animated: true, completion: nil)
            }
        } else if pviduser == 4 {
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
            }
            else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.confilictOrdersViewControllerVC) as! ConfilictOrdersViewController
                vc.delegateCustom1 = self
                vc.screenName = ScreenNames.reviewVC.rawValue
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func infobtnAction(_ sender: UIButton) {
        let p = sender.convert(sender.bounds,to: self.view)
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: p.origin.x - 150,y: p.origin.y + 42   ,width: 200, height: 100)
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 140 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 150 , y: -22, width: 26, height: 26)
        }
        customPopView1.textLabel1.text =  NSLocalizedString(ButtonTitles.fieldsForEachAnimal, comment: "")
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func editbtnAction(_ sender: Any) {
        UserDefaults.standard.set(1, forKey: keyValue.orderSlideTag.rawValue)
        let storyboard = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC) as! OrderingDefaultsVC
        viewController.editflag = 0
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func billingBtnAction(_ sender: UIButton) {
        if customerNameLbl.text == "N/A"{
            tableViewBg.isHidden = true
            bckRoundView.isHidden = true
        }
        else {
            billingTblView.dataSource = self
            billingTblView.delegate = self
            tableViewBg.isHidden = false
            bckRoundView.isHidden = false
            if farmAddr.count > 1 {
                billingViewHeightConst.constant = billingTblView.contentSize.height + 100
            }
            
            billingTblView.reloadData()
        }
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewAnimalsControlleriPadVC") as? ViewAnimalsControlleriPadVC
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func sortDoneAction(_ sender: Any) {
      
        if self.searchTxt.text != ""{
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            let bPredicate = NSPredicate(format: "farmId contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
            let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
            if fetchcustRep.count > 0 {
                
                var productNameArray = [String]()
                for object in fetchcustRep  {
                    productNameArray.append(object.productName!)
                    self.set  =  Array(Set(productNameArray))
                }
                if ascendingFound{
                    self.set = self.set.sorted(by: {$0 < $1})
                } else {
                    self.set = self.set.sorted(by: {$0 > $1})
                }
                self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                self.reviewOrderListObject.set = self.set
                self.reviewOrderListObject.uniqueProductArray = self.uniqueProductArray
                self.tblView.reloadData()
            }
            else {
                self.reviewOrderListObject.set.removeAll()
                self.tblView.reloadData()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
            }
        } else {
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue)
            self.search()
            self.tblView.reloadData()
        }
        self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
        self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortByTitle.text = LocalizedStrings.onFarmIdText
        self.sortByView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = LocalizedStrings.onFarmIdText
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByEarTagAction(_ sender: UIButton) {
        if sortByEarTagImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            
        }
        if self.searchTxt.text != "" {
            UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.foReviewOrderVC.rawValue)
            let bPredicate = NSPredicate(format: "earTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
            let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
            if fetchcustRep.count > 0 {
                var productNameArray = [String]()
                for object in fetchcustRep  {
                    productNameArray.append(object.productName!)
                    self.set  =  Array(Set(productNameArray))
                }
                
                self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                self.reviewOrderListObject.set = self.set
                self.reviewOrderListObject.uniqueProductArray = self.uniqueProductArray
                self.tblView.reloadData()
            }
            else {
                self.reviewOrderListObject.set.removeAll()
                self.tblView.reloadData()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.4, position: .center)
            }
        }
        else {
            UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.foReviewOrderVC.rawValue)
            UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue)
            self.search()
            self.tblView.reloadData()
        }
        
        
        self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortByTitle.text = "EarTag"
        self.sortByBrazilView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = "EarTag"
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByBrazilBarcodeAction(_ sender: UIButton) {
        if sortByBrazilBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
        
        if self.searchTxt.text != "" {
            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
            let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
            if fetchcustRep.count > 0 {
                var productNameArray = [String]()
                for object in fetchcustRep  {
                    productNameArray.append(object.productName!)
                    self.set  =  Array(Set(productNameArray))
                }
                self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                self.reviewOrderListObject.set = self.set
                self.reviewOrderListObject.uniqueProductArray = self.uniqueProductArray
                self.tblView.reloadData()
            }
            else {
                self.reviewOrderListObject.set.removeAll()
                self.tblView.reloadData()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
            }
            
        } else {
            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue)
            self.search()
            self.tblView.reloadData()
        }
        
        
        self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
        self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByTitle.text = ButtonTitles.barcodeText
        self.sortByBrazilView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = "Barcode"
        reviewOrderListObject.itemSelection = itemSelection
        
    }
    
    @IBAction func sortByFarmIDAction(_ sender: UIButton) {
        
        if sortByFarmImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortByFarmImgView.image = UIImage(named: "radioBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
        }
        
        if self.searchTxt.text != ""{
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            let bPredicate = NSPredicate(format: "farmId contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
            let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
            if fetchcustRep.count > 0 {
                
                var productNameArray = [String]()
                for object in fetchcustRep  {
                    productNameArray.append(object.productName!)
                    self.set  =  Array(Set(productNameArray))
                }
                self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                self.reviewOrderListObject.set = self.set
                self.reviewOrderListObject.uniqueProductArray = self.uniqueProductArray
                self.tblView.reloadData()
            }
            else {
                self.reviewOrderListObject.set.removeAll()
                self.tblView.reloadData()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
            }
        } else {
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue)
            self.search()
            self.tblView.reloadData()
        }
        self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
        self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortByTitle.text = LocalizedStrings.onFarmIdText
        self.sortByView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = LocalizedStrings.onFarmIdText
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByOfficialIDAction(_ sender: UIButton) {
        if sortByOfficialIDImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
        if self.searchTxt.text != ""{
            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
            let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
            if fetchcustRep.count > 0 {
                
                var productNameArray = [String]()
                
                for object in fetchcustRep  {
                    productNameArray.append(object.productName!)
                    self.set  =  Array(Set(productNameArray))
                }
                self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                self.reviewOrderListObject.set = self.set
                self.reviewOrderListObject.uniqueProductArray = self.uniqueProductArray
                self.tblView.reloadData()
            }
            else {
                self.reviewOrderListObject.set.removeAll()
                self.tblView.reloadData()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.4, position: .center)
            }
        } else {
            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue)
            self.search()
            self.tblView.reloadData()
        }
        self.sortByFarmImgView.image = UIImage(named: "radioBtn")
        self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortByTitle.text = LocalizedStrings.officialIDText
        self.sortByView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = "Official ID"
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByBarcodeAction(_ sender: UIButton) {
        if sortByBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
        if self.searchTxt.text != ""{
            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
            let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
            if fetchcustRep.count > 0 {
                var productNameArray = [String]()
                for object in fetchcustRep  {
                    productNameArray.append(object.productName!)
                    self.set  =  Array(Set(productNameArray))
                }
                self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                self.reviewOrderListObject.set = self.set
                self.reviewOrderListObject.uniqueProductArray = self.uniqueProductArray
                self.tblView.reloadData()
            }
            else {
                self.reviewOrderListObject.set.removeAll()
                self.tblView.reloadData()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
            }
        } else {
            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
            UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue)
            self.search()
            self.tblView.reloadData()
        }
        self.sortByFarmImgView.image = UIImage(named: "radioBtn")
        self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
        self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByTitle.text = ButtonTitles.barcodeText
        self.sortByView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = "Barcode"
        reviewOrderListObject.itemSelection = itemSelection
    }
    @IBAction func sortAscendingAction(_ sender: UIButton) {
        if sender.tag == 100{
            ascendingFound = false
            self.sortByAscendingImgView.image = UIImage(named: "radioBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioSeletedBtn")
        } else if sender.tag == 500{
            ascendingFound = true
            self.sortByDescendingBrazilImgView.image = UIImage(named: "radioBtn")
            self.sortByAscendingBrazilImgView.image = UIImage(named: "radioSeletedBtn")
        } else if sender.tag == 600{
            ascendingFound = false
            self.sortByDescendingBrazilImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByAscendingBrazilImgView.image = UIImage(named: "radioBtn")
        }
        else {
            ascendingFound = true
            self.sortByAscendingImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioBtn")
        }
    }
    
    @IBAction func dropDownBtnAction(_ sender: UIButton) {
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser != 4 && pviduser != 6 {
            self.sortByView.isHidden = false
            self.bckRoundView.isHidden = false
            self.sortByBrazilView.isHidden = true
        } else {
            self.sortByView.isHidden = true
            self.bckRoundView.isHidden = false
            self.sortByBrazilView.isHidden = false
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func emailInfoBtnAction(_ sender: UIButton) {
        let p = sender.convert(sender.bounds,to: self.view)
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip1), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: p.origin.x - 140,y: p.origin.y + 44   ,width: 200, height: 160)
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: p.origin.x - 180 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 244 , y: -22, width: 26, height: 26)
        }
        customPopView1.textLabel1.text =  NSLocalizedString(ButtonTitles.finishOrderEmailToZoetis, comment: "")
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
        self.navigationController!.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(ReviewOrderVC.buttonbgPressed), for: .touchUpInside)
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
}


