//
//  SampleTrackingDetailVCiPadExtension.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 28/04/25.
//

import Foundation
import UIKit

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension SampleTrackingDetailVCiPad:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension SampleTrackingDetailVCiPad :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.samples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SampleTrackingDeetailCellIpad = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! SampleTrackingDeetailCellIpad
        cell.selectionStyle = .none
        cell.tableInnerview.layer.cornerRadius = 10
        cell.tableInnerview.layer.borderWidth = 2
        tableView.isHidden = false
        let data = samples[indexPath.row]
        
        cell.productCollectionView.dataSource = cell
        cell.productCollectionView.delegate = cell
        if filterName == LocalizedStrings.reportedFilterName {
            cell.orderIdBttn.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
            cell.tableInnerview.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
            cell.officialIDLbl.text = data.officialId ?? "NA"
            cell.barcode_Lbl.text = data.sampleBarcode ?? "NA"
            cell.onFarmIdTitleLabel.text = LocalizedStrings.onFarmIdText
            cell.onFarm_IDLbl.text = data.onFarmId ?? "NA"
            cell.earTagLbl.text = data.earTag ?? "NA"
            let orderID =  NSLocalizedString(LocalizedStrings.orderIdStr, comment: "") + ": " + (data.orderId ?? "")
            cell.orderIdBttn.setTitle(orderID, for: .normal)
            let sampleDetails = fetchSampleDetailData(entityName: Entities.sampleDetailsTblEntity, sampleId: Int(data.sampleId), orderId: serverOrderId) as! [SampleDetails]
          //  cell.productInProgress.attributedText = self.getProductWithStatus(sampleDetails: sampleDetails)
            cell.loadProductData(sampleDetails: sampleDetails, isActionRequired: true)
        }
        else if tagInt == 1 {
            cell.orderIdBttn.backgroundColor = UIColor(red: 92/255, green: 176/255, blue: 66/255, alpha: 1)
            cell.tableInnerview.layer.borderColor = UIColor(red: 92/255, green: 176/255, blue: 66/255, alpha: 1).cgColor
         //   cell.tableInnerview.layer.backgroundColor = UIColor(red: 247/255, green: 255/255, blue: 245/255, //alpha: 1).cgColor
            cell.officialIDLbl.text = data.officialId ?? "NA"
            cell.barcode_Lbl.text = data.sampleBarcode ?? "NA"
            cell.onFarmIdTitleLabel.text = LocalizedStrings.onFarmIdText
            cell.onFarm_IDLbl.text = data.onFarmId ?? "NA"
            cell.earTagLbl.text = data.earTag ?? "NA"
            let orderID = NSLocalizedString(LocalizedStrings.orderIdStr, comment: "") + ": " + (data.orderId ?? "NA")
            cell.orderIdBttn.setTitle(orderID, for: .normal)
            let sampleDetails = fetchSampleDetailData(entityName: Entities.sampleDetailsTblEntity, sampleId: Int(data.sampleId), orderId: serverOrderId) as! [SampleDetails]
           // cell.productInProgress.attributedText = self.getProductWithStatus(sampleDetails: sampleDetails)
            cell.loadProductData(sampleDetails: sampleDetails, isActionRequired: true)
        }
        else if filterName == NSLocalizedString(ButtonTitles.actionRequiredText, comment: "") {
            cell.orderIdBttn.backgroundColor = UIColor(red: 239/255, green: 80/255, blue: 80/255, alpha: 1)
            cell.tableInnerview.layer.borderColor  = UIColor(red: 239/255, green: 80/255, blue: 80/255, alpha: 1).cgColor
            cell.officialIDLbl.text = data.officialId ?? "NA"
            cell.barcode_Lbl.text = data.sampleBarcode ?? "NA"
            cell.earTagLbl.text = data.earTag ?? "NA"
            cell.onFarmIdTitleLabel.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.onFarm_IDLbl.text = data.onFarmId ?? "NA"
            let orderID = NSLocalizedString(LocalizedStrings.orderIdStr, comment: "") + ": " + (data.orderId ?? "NA")
            cell.orderIdBttn.setTitle(orderID, for: .normal)
            let sampleDetails = fetchSampleDetailData(entityName: Entities.sampleDetailsTblEntity, sampleId: Int(data.sampleId), orderId: serverOrderId) as! [SampleDetails]
          //  cell.productInProgress.attributedText = self.getProductWithStatus(sampleDetails: sampleDetails)
            cell.loadProductData(sampleDetails: sampleDetails, isActionRequired: false)
        }
        else {
//            if actionNeddTag == 1 {
//                tableView.isHidden = true
//            }
//            else if actionNeddTag == 2 {
//                tableView.isHidden = true
//            }
          //  else {
                cell.orderIdBttn.backgroundColor = UIColor.lightGray
                cell.tableInnerview.layer.borderColor = UIColor.lightGray.cgColor
                
                if let status = SampleStatuses(rawValue: Int(data.sampleStatusId ?? "5" ) ?? 5) {
                    switch status {
                    case .inProgress:
                        cell.orderIdBttn.backgroundColor = UIColor(red: 92/255, green: 176/255, blue: 66/255, alpha: 1)
                        cell.tableInnerview.layer.borderColor = UIColor(red: 92/255, green: 176/255, blue: 66/255, alpha: 1).cgColor
                    case .actionRequired:
                        cell.orderIdBttn.backgroundColor = UIColor(red: 239/255, green: 80/255, blue: 80/255, alpha: 1)
                        cell.tableInnerview.layer.borderColor  = UIColor(red: 239/255, green: 80/255, blue: 80/255, alpha: 1).cgColor
                    case .reported:
                        cell.orderIdBttn.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                        cell.tableInnerview.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    case .cancelled:
                        break
                    default:
                        cell.orderIdBttn.backgroundColor = UIColor.lightGray
                     //   cell.tableInnerview.layer.borderColor = UIColor.lightGray.cgColor
                    }
                }
                cell.officialIDLbl.text = data.officialId ?? "NA"
                cell.barcode_Lbl.text = data.sampleBarcode ?? "NA"
                cell.earTagLbl.text = data.earTag ?? "NA"
                cell.onFarmIdTitleLabel.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                cell.onFarm_IDLbl.text = data.onFarmId ?? "NA"
                let orderID = NSLocalizedString(LocalizedStrings.orderIdStr, comment: "") + ": " + (data.orderId ?? "")
                cell.orderIdBttn.setTitle(orderID, for: .normal)
                cell.officialIdTitleLabel.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
                cell.onFarmIdTitleLabel.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                cell.barcodeTitleLabel.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
                reportedBttn.setTitle(NSLocalizedString(LocalizedStrings.reportedFilterName, comment: ""), for: .normal)
                inProgressBttn.setTitle(NSLocalizedString(ButtonTitles.inProgressText, comment: ""), for: .normal)
                actionNeededBttn.setTitle(NSLocalizedString(ButtonTitles.actionRequiredText, comment: ""), for: .normal)
                allBttn.setTitle(NSLocalizedString(ButtonTitles.allText, comment: ""), for: .normal)
                let sampleDetails = fetchSampleDetailData(entityName: Entities.sampleDetailsTblEntity, sampleId: Int(data.sampleId), orderId: serverOrderId) as! [SampleDetails]
                //cell.productInProgress.attributedText = self.getProductWithStatus(sampleDetails: sampleDetails)
                cell.loadProductData(sampleDetails: sampleDetails, isActionRequired: true)
            }
      //  }
        return cell
    }
    
    
    
    func getProductWithStatus(sampleDetails: [SampleDetails]) -> NSMutableAttributedString {
        let titleColor = UIColor(red: 49/255, green: 141/255, blue: 181/255, alpha: 1)
        let firstString = NSMutableAttributedString()
        for detail in sampleDetails {
            let productTitle = NSMutableAttributedString(string:NSLocalizedString(LocalizedStrings.productText, comment: "")  , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: titleColor])
            let productNameValue = NSMutableAttributedString(string: ": \((detail.productName ?? "")) \n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black])
            productTitle.append(productNameValue)
            
            if detail.actionRequired?.isEmpty == false {
                let actionRequiredTitle = NSMutableAttributedString(string:NSLocalizedString(ButtonTitles.actionRequiredText, comment: "") , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: titleColor])
                let actionRequiredValue = NSMutableAttributedString(string: ": \((detail.actionRequired ?? "")) \n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black])
                actionRequiredTitle.append(actionRequiredValue)
                productTitle.append(actionRequiredTitle)
            }
            
            let statusTitle = NSMutableAttributedString(string: NSLocalizedString("Status", comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: titleColor])
            let statusValue = NSMutableAttributedString(string: ": \((detail.status ?? "")) \n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black])
            statusTitle.append(statusValue)
            productTitle.append(statusTitle)
            firstString.append(productTitle)
        }
        return firstString
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: SIDE MENU UI EXTENSION
extension SampleTrackingDetailVCiPad : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
