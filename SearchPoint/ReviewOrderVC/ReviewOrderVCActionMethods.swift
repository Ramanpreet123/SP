//
//  ReviewOrderVCActionmethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 03/03/24.
//

import Foundation
import UIKit

//MARK: IB ACTION METHODS
extension ReviewOrderVC {
    @IBAction func crossBtnAct(_ sender: Any) {
        tableViewBg.isHidden = true
        bckRoundView.isHidden = true
    }
    
    @IBAction func productAnimalToggleBtnClk(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderProductSelectionReviewVC) as! OrderProductSelectionReviewVC
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func emailBtnAction(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false {
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
                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSubmittedVC) as! OrderSubmittedVC
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSaveVC) as! OrderSaveViewController
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
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSubmittedVC) as! OrderSubmittedVC
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSaveVC) as! OrderSaveViewController
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
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSubmittedVC) as! OrderSubmittedVC
                newViewController.emailOrder=true
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            else {
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSaveVC) as! OrderSaveViewController
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
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSubmittedVC) as! OrderSubmittedVC
                newViewController.emailOrder=false
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            else{
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSaveVC) as! OrderSaveViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        
        else if (UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == false || UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) == nil)  &&
                    UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
            
            if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false{
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
                        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSubmittedVC) as! OrderSubmittedVC
                        newViewController.emailOrder=true
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    } else {
                        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSaveVC) as! OrderSaveViewController
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
                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSubmittedVC) as! OrderSubmittedVC
                    newViewController.emailOrder=true
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                else{
                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderSaveVC) as! OrderSaveViewController
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
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.productWiseTermsVC) as! ProductWiseTermsController
        self.navigationController?.present(vc, animated: false, completion: nil)
        return
    }
    
    @IBAction func leftMenuBtn(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
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
        customPopView1.frame = CGRect(x: 20,y: p.origin.y + 42   ,width: screenSize.width - 90, height: 100)
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
        if sender.titleLabel?.text == "N/A"{
            tableViewBg.isHidden = true
            bckRoundView.isHidden = true
        } else {
            tableViewBg.isHidden = false
            bckRoundView.isHidden = false
            billingViewHeightConst.constant = billingTblView.contentSize.height + 100
            billingTblView.reloadData()
        }
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func dropDownBtnAction(_ sender: UIButton) {
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        dropDown.anchorView = farmIdHideLbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 30
        searchTxt.resignFirstResponder()
        dropDown.dataSource = [NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""),NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
        if pviduser == 2 {
            dropDown.dataSource = [NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
        }
        if pviduser == 4 {
            dropDown.dataSource = [ NSLocalizedString(ButtonTitles.earTagText, comment: ""),NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.clickOnDropDown = item
            self.reviewOrderListObject.itemSelection =  self.clickOnDropDown
            self.tblView.reloadData()
            sender.setTitle(item, for: .normal)
            sender.layer.borderColor = UIColor.gray.cgColor
            if self.searchTxt.text != ""{
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
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
                }
                
                if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
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
                
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
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
                }
                
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
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
                }
            }
            else {
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
                    UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
                }
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                    UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
                }
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                    UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.foReviewOrderVC.rawValue)
                }
                
                if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
                    UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.foReviewOrderVC.rawValue)
                }
                UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue)
                self.search()
                self.tblView.reloadData()
            }
        }
        dropDown.show()
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
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
        customPopView1.frame = CGRect(x: 20,y: p.origin.y + 44   ,width: screenSize.width - 109, height: 125)
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 190 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 244 , y: -22, width: 26, height: 26)
        }
        customPopView1.textLabel1.text =  NSLocalizedString(ButtonTitles.finishOrderEmailToZoetis, comment: "")
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
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


