//
//  ReviewOrderVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 03/03/24.
//

import Foundation
import UIKit
import CoreData

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension ReviewOrderVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SIDE MENU UI EXTENSION
extension ReviewOrderVC: SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension ReviewOrderVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == billingTblView {
            return farmAddr.count
        }else {
            return self.tissueArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == billingTblView {
            let cell = billingTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BillingTableViewCell
            cell!.selectionStyle = .none
            let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
                if farmAddr[indexPath.row].billToCustId! == filterArr[0].billToCustId{
                    cell?.radioBtnReview.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                } else {
                    cell?.radioBtnReview.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                }
            } else if Int(farmAddr[indexPath.row].billToCustId!) == self.custmerId{
                cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            }
            else {
                cell?.radioBtnReview.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
            }
            cell?.addressReviewLbl.text = farmAddr[indexPath.row].contactName
            return cell!
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.textLabel?.text = (self.tissueArr[indexPath.row] as? String)!
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == billingTblView {
            UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: keyValue.farmValue.rawValue)
            UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: keyValue.billToCustomerId.rawValue)
            let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
                updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
                
            }
            UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: keyValue.farmValue.rawValue)
            UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: keyValue.billToCustomerId.rawValue)
            
            updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            
            farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: self.custmerId) as! [GetBillingContact]
            tableViewBg.isHidden = true
            bckRoundView.isHidden = true
            tblView.reloadData()
            billingTblView.reloadData()
        } else{
            let tissue = self.tissueArr[indexPath.row] as! String
            itemSelection = tissue
            dropDownBtn.setTitle(tissue, for: .normal)
            buttonbg2.removeFromSuperview()
            reviewOrderListObject.itemSelection = itemSelection
            tblView.reloadData()
        }
    }
}

//MARK: TEXTFIELD DELEGATES
extension ReviewOrderVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTxt.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        tblView.isHidden = false
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
                let bPredicate = NSPredicate(format: "farmId contains[cd] %@ || productName contains[cd] %@", newString,newString)
                let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
                if fetchcustRep.count > 0 {
                    
                    var productNameArray = [String]()
                    for object in fetchcustRep  {
                        productNameArray.append(object.productName!)
                        set  =  Array(Set(productNameArray))
                    }
                    uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                    reviewOrderListObject.set = set
                    reviewOrderListObject.uniqueProductArray = uniqueProductArray
                    tblView.reloadData()
                }
                else {
                    reviewOrderListObject.set.removeAll()
                    tblView.reloadData()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                }
            }
            
            if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
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
                let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString)
                let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
                if fetchcustRep.count > 0 {
                    var productNameArray = [String]()
                    for object in fetchcustRep  {
                        productNameArray.append(object.productName!)
                        set  =  Array(Set(productNameArray))
                    }
                    uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                    reviewOrderListObject.set = set
                    reviewOrderListObject.uniqueProductArray = uniqueProductArray
                    tblView.reloadData()
                }
                else {
                    reviewOrderListObject.set.removeAll()
                    tblView.reloadData()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", newString,newString)
                let fetchcustRep =   fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimalTbl]
                if fetchcustRep.count > 0 {
                    var productNameArray = [String]()
                    for object in fetchcustRep  {
                        productNameArray.append(object.productName!)
                        set  =  Array(Set(productNameArray))
                    }
                    uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                    reviewOrderListObject.set = set
                    reviewOrderListObject.uniqueProductArray = uniqueProductArray
                    tblView.reloadData()
                }
                else {
                    reviewOrderListObject.set.removeAll()
                    tblView.reloadData()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                }
            }
        } else {
            search()
            tblView.reloadData()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: OBJECT PICK FROM CONFLICT EXTENSION
extension ReviewOrderVC : objectPickfromConfilict{
    func selectionObject(check: Bool) {
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 4  {
            if check == true{
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVCGirlando) as! OrderingAnimalVCGirlando
                navigationController?.pushViewController(vc,animated: false)
            }
            else {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
                self.navigationController!.pushViewController(secondViewController, animated: false)
            }
        }
        else {
            if check == true{
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC) as! OrderingAnimalVC
                vc.iscomingFromCart = true
                navigationController?.pushViewController(vc,animated: false)
            }
            else {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
                self.navigationController!.pushViewController(secondViewController, animated: false)
            }
        }
    }
    
    func dataReload(check :Bool){
        if check == true{
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.reviewOrderVC) as! ReviewOrderVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
}

//MARK: OBJECT PICK FOR CELL DELEGATE EXTENSION
extension ReviewOrderVC : objectPickforcellDelegate {
    func selectionObjectcell(check :Bool){
        if check == true{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.confilictOrdersViewControllerVC) as! ConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.screenName = ScreenNames.reviewVC.rawValue
            self.present(vc, animated: true, completion: nil)
        }
    }
}

//MARK: OFFLINE CUSTOM VIEW1 EXTENSION
extension ReviewOrderVC : offlineCustomView1 {
    func crossBtn() { }
}

//MARK: OBJECT PICK CART SCREEN EXTENSION
extension ReviewOrderVC : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {}
}
