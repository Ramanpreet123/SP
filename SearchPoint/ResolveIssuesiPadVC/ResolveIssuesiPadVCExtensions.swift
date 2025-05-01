//
//  ResolveIssuesiPadVCExtensions.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 21/04/25.
//

import Foundation
import UIKit

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension ResolveIssuesiPadVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SIDE MENU UI EXTENSION
extension ResolveIssuesiPadVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension ResolveIssuesiPadVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == filter1TblView{
            if filter1Array.count == 0 {
                filter1TblView.setMessage(LocalizedStrings.noActionOrIssues.localized)
            }
            return 1
        }
        else if tableView == filter2TblView{
            if filter2Array.count == 0 {
                filter2TblView.setMessage(LocalizedStrings.noActionOrIssues.localized)
            }
            return 1
        }
        else{
            if sampleTrack.count == 0 {
                ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
            }
            return sampleTrack.count
        }
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == filter1TblView{
            if filter1Array.count == 0 {
                filter1TblView.setMessage(LocalizedStrings.noActionOrIssues.localized)
            }
            return filter1Array.count
        }
        else if tableView == filter2TblView{
            if filter2Array.count == 0 {
                filter2TblView.setMessage(LocalizedStrings.noActionOrIssues.localized)
            }
            return filter2Array.count
        }
        else{
           return 1
        }
    }
    
    @objc func didSelectRadio1(_sender: UIButton){
        let cell = filter1TblView.cellForRow(at: IndexPath(row: 0, section: _sender.tag)) as! RadioCell
        cell.radioButton1.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
        UserDefaults.standard.set(_sender.tag, forKey: keyValue.radio1Key.rawValue)
        filter1TblView.reloadData()
        
    }
    
    @objc func didSelectRadio2(_sender: UIButton){
        let cell = filter2TblView.cellForRow(at: IndexPath(row: 0, section: _sender.tag)) as! RadioCell
        cell.radioButton2.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
        UserDefaults.standard.set(_sender.tag, forKey: keyValue.radio2Key.rawValue)
        filter2TblView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == filter1TblView{
            indexpathTag = indexPath.section
            tableviewName = tableView
            let cell = filter1TblView.cellForRow(at: IndexPath(row: 0, section: indexPath.section)) as! RadioCell
            cell.radioButton1.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            UserDefaults.standard.set(indexPath.section, forKey: keyValue.radio1Key.rawValue)
            filter1TblView.reloadData()
        }
        else  if tableView == filter2TblView{
            tableviewName1 = tableView
            indexpathTag1 = indexPath.row
            let cell = filter2TblView.cellForRow(at: IndexPath(row: 0, section: indexPath.section)) as! RadioCell
            cell.radioButton2.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            UserDefaults.standard.set(indexPath.section, forKey: keyValue.radio2Key.rawValue)
            filter2TblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == filter1TblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1",
                                                     for: indexPath) as! RadioCell
            cell.filter1Lbl.text = filter1Array[indexPath.section] as? String
            cell.radioButton1.tag = indexPath.section
            cell.radioButton1.addTarget(self, action: #selector(didSelectRadio1(_sender:)), for: .touchUpInside)
            cell.selectionStyle = .none
            if UserDefaults.standard.integer(forKey: keyValue.radio1Key.rawValue) == indexPath.section {
                cell.radioButton1.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            }
            else{
                cell.radioButton1.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
            
            return cell
        }
        else if tableView == filter2TblView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2",
                                                     for: indexPath) as! RadioCell
            cell.radioButton2.tag = indexPath.section
            cell.radioButton2.addTarget(self, action: #selector(didSelectRadio2(_sender:)), for: .touchUpInside)
            
            cell.filter2Lbl.text = filter2Array[indexPath.section] as? String
            cell.radioButton2.setImage(UIImage(named: "radioBtn"), for: .normal)
            cell.radioButton2.tag = indexPath.section
            cell.selectionStyle = .none
            if UserDefaults.standard.integer(forKey: keyValue.radio2Key.rawValue) == indexPath.section {
                cell.radioButton2.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            }
            else{
                cell.radioButton2.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.resolveIssuesCellId, for: indexPath) as! ResolveIssueCell
            cell.selectionStyle = .none
            let data = sampleTrack[indexPath.row]
            cell.OfficialId.text = data.offcialPermanenetId ?? "NA"
            cell.barcode.text = data.sampleBarcode ?? "NA"
            cell.products.text = data.product ?? "NA"
            cell.actionRequired.text = data.actionRequired ?? "NA"
            cell.OnFarmId.text = data.onFarmId ?? "NA"
            cell.orderId.text = data.orderId ?? "NA"
            cell.status.text =  data.sampleStatus ?? "NA"
            cell.earTagLabel.text = data.earTag ?? "NA"
            cell.LabelOfficalId.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.LabelOnFarmId.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.LabelEarTag.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.LabelBarcode.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.LabelOrderId.text = LocalizedStrings.orderIdStr.localized
            cell.LabelProduct.text = ButtonTitles.productText.localized
            cell.LabelStatus.text = "Status".localized
            cell.LabelActionRequired.text = ButtonTitles.actionRequiredText.localized
            searchTextfield.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == filter2TblView || tableView == filter1TblView{
            return 35
        }
        else {
            return 340
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        let headerView = UIView()
        // 2
        headerView.backgroundColor = view.backgroundColor
        // 3
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == filter2TblView || tableView == filter1TblView{
            return 5
        }
        return 0
        
    }
}

//MARK: TEXTFIELD DELEGATE
extension ResolveIssuesiPadVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTextfield.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        ResolveIssuetableView.isHidden = false
        
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: ""){
                sampleTrack = (fetchAllDatasampleDataFROMPRODUCTBarcodeResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID:newString as String , userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as NSArray) as! [GetActionRequired]
                if sampleTrack.count > 0{
                    ResolveIssuetableView.setMessage("")
                    ResolveIssuetableView.reloadData()
                    
                }
                else{
                    ResolveIssuetableView.reloadData()
                   // ResolveIssuetableView.isHidden = true
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                   // self.view.makeToast(NSLocalizedString(LocalizedStrings.noActionOrIssues, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                sampleTrack = (fetchAllDatasampleDataFROMPRODUCToFFidResolve(entityName: Entities.getActionRequiredTblEntity, officialId: newString as String, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as NSArray) as! [GetActionRequired]
                if sampleTrack.count > 0{
                    ResolveIssuetableView.setMessage("")
                    ResolveIssuetableView.reloadData()
                }
                else{
                    ResolveIssuetableView.reloadData()
                  //  ResolveIssuetableView.isHidden = true
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                    //self.view.makeToast(NSLocalizedString(LocalizedStrings.noActionOrIssues, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                sampleTrack = (fetchAllDatasampleDataFROMPRODUCTfarmIdResolve(entityName: Entities.getActionRequiredTblEntity, onfarmId: newString as String, userId: userId, asending: true, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as NSArray) as! [GetActionRequired]
                if sampleTrack.count > 0{
                    ResolveIssuetableView.setMessage("")
                    ResolveIssuetableView.reloadData()
                }
                else{
                  //  ResolveIssuetableView.isHidden = true
                    ResolveIssuetableView.reloadData()
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                  //  self.view.makeToast(NSLocalizedString(LocalizedStrings.noActionOrIssues, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                sampleTrack = (fetchAllDatasampleDataEarTag(entityName: Entities.getActionRequiredTblEntity, onfarmId: newString as String, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as NSArray) as! [GetActionRequired]
                if sampleTrack.count > 0{
                    ResolveIssuetableView.setMessage("")
                    ResolveIssuetableView.reloadData()
                }
                else{
                    ResolveIssuetableView.reloadData()
                    //ResolveIssuetableView.isHidden = true
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                    //self.view.makeToast(NSLocalizedString(LocalizedStrings.noActionOrIssues.localized, comment: ""), duration: 1, position: .center)
                }
            }
            
        } else {
          //  dropUpDownBtn.setImage(UIImage(named: ImageNames.imageImg), for: .normal)
            sampleTrack = fetchAllDatasampleDataFROMPRODUCTAllResolvedIssue(entityName: Entities.getActionRequiredTblEntity, userId: userId, customerId: customerId, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
            }
            ResolveIssuetableView.reloadData()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
