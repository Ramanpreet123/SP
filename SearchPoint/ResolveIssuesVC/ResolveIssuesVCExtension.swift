//
//  ResolveIssuesVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 02/03/24.
//

import Foundation
import UIKit

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension ResolveIssuesVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SIDE MENU UI EXTENSION
extension ResolveIssuesVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension ResolveIssuesVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            if sampleTrack.count == 0 {
                ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
            }
            return sampleTrack.count
        }
    }
    
    @objc func didSelectRadio1(_sender: UIButton){
        let cell = filter1TblView.cellForRow(at: IndexPath(row: _sender.tag, section: 0)) as! RadioCell
        cell.radioButton1.setImage(UIImage(named:ImageNames.forma1Copy5Img), for: .normal)
        UserDefaults.standard.set(_sender.tag, forKey: keyValue.radio1Key.rawValue)
        filter1TblView.reloadData()
        
    }
    
    @objc func didSelectRadio2(_sender: UIButton){
        let cell = filter2TblView.cellForRow(at: IndexPath(row: _sender.tag, section: 0)) as! RadioCell
        cell.radioButton2.setImage(UIImage(named:ImageNames.forma1Copy5Img), for: .normal)
        UserDefaults.standard.set(_sender.tag, forKey: keyValue.radio2Key.rawValue)
        filter2TblView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == filter1TblView{
            indexpathTag = indexPath.row
            tableviewName = tableView
            let cell = filter1TblView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! RadioCell
            cell.radioButton1.setImage(UIImage(named:ImageNames.forma1Copy5Img), for: .normal)
            UserDefaults.standard.set(indexPath.row, forKey: keyValue.radio1Key.rawValue)
            filter1TblView.reloadData()
        }
        else  if tableView == filter2TblView{
            tableviewName1 = tableView
            indexpathTag1 = indexPath.row
            let cell = filter2TblView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! RadioCell
            cell.radioButton2.setImage(UIImage(named:ImageNames.forma1Copy5Img), for: .normal)
            UserDefaults.standard.set(indexPath.row, forKey: keyValue.radio2Key.rawValue)
            filter2TblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == filter1TblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1",
                                                     for: indexPath) as! RadioCell
            cell.filter1Lbl.text = filter1Array[indexPath.row] as? String
            cell.radioButton1.tag = indexPath.row
            cell.radioButton1.addTarget(self, action: #selector(didSelectRadio1(_sender:)), for: .touchUpInside)
            cell.selectionStyle = .none
            if UserDefaults.standard.integer(forKey: keyValue.radio1Key.rawValue) == indexPath.row {
                cell.radioButton1.setImage(UIImage(named: ImageNames.forma1Copy5Img), for: .normal)
            }
            else{
                cell.radioButton1.setImage(UIImage(named: ImageNames.forma1Copy8Img), for: .normal)
            }
            
            return cell
        }
        else if tableView == filter2TblView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2",
                                                     for: indexPath) as! RadioCell
            cell.radioButton2.tag = indexPath.row
            cell.radioButton2.addTarget(self, action: #selector(didSelectRadio2(_sender:)), for: .touchUpInside)
            
            cell.filter2Lbl.text = filter2Array[indexPath.row] as? String
            cell.radioButton2.setImage(UIImage(named: ImageNames.forma1Copy8Img), for: .normal)
            cell.radioButton2.tag = indexPath.row
            cell.selectionStyle = .none
            if UserDefaults.standard.integer(forKey: keyValue.radio2Key.rawValue) == indexPath.row {
                cell.radioButton2.setImage(UIImage(named: ImageNames.forma1Copy5Img), for: .normal)
            }
            else{
                cell.radioButton2.setImage(UIImage(named: ImageNames.forma1Copy8Img), for: .normal)
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
            return 20
        }
        else {
            return 280
        }
    }
}

//MARK: TEXTFIELD DELEGATE
extension ResolveIssuesVC:UITextFieldDelegate{
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
                    ResolveIssuetableView.reloadData()
                }
                else{
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                sampleTrack = (fetchAllDatasampleDataFROMPRODUCToFFidResolve(entityName: Entities.getActionRequiredTblEntity, officialId: newString as String, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as NSArray) as! [GetActionRequired]
                if sampleTrack.count > 0{
                    ResolveIssuetableView.reloadData()
                }
                else{
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                sampleTrack = (fetchAllDatasampleDataFROMPRODUCTfarmIdResolve(entityName: Entities.getActionRequiredTblEntity, onfarmId: newString as String, userId: userId, asending: true, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as NSArray) as! [GetActionRequired]
                if sampleTrack.count > 0{
                    ResolveIssuetableView.reloadData()
                }
                else{
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                sampleTrack = (fetchAllDatasampleDataEarTag(entityName: Entities.getActionRequiredTblEntity, onfarmId: newString as String, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as NSArray) as! [GetActionRequired]
                if sampleTrack.count > 0{
                    ResolveIssuetableView.reloadData()
                }
                else{
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
                }
            }
            
        } else {
            dropUpDownBtn.setImage(UIImage(named: ImageNames.imageImg), for: .normal)
            sampleTrack = fetchAllDatasampleDataFROMPRODUCTAllResolvedIssue(entityName: Entities.getActionRequiredTblEntity, userId: userId, customerId: customerId, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
            ResolveIssuetableView.reloadData()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
