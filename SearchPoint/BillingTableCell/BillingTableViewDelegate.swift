//
//  BillingTableCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 02/03/24.
//

import Foundation
import Alamofire
import CoreData

//MARK: BILLING TABLEVIEW DELEGATE
class BillingTableViewDelegate:NSObject, UITableViewDelegate,UITableViewDataSource{
    
    //MARK: VARIABLES AND CONSTANTS
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
    var farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int) as! [GetBillingContact]
    var delegate:BillingDelegate!
    
    
    //MARK: TABLEVIEW DATASOURCE AND DELEGATE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return farmAddr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.billingTableViewCell, for: indexPath) as? BillingTableViewCell
        cell?.selectionStyle = .none
        let filterArr = farmAddr.filter({$0.isDefault })
        if filterArr.count > 0{
            if farmAddr[indexPath.row].billToCustId! == filterArr[0].billToCustId{
                cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
            } else {
                cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
            }
        } else if Int(farmAddr[indexPath.row].billToCustId!) == self.custmerId{
            cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
            updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
        }
        else {
            cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
        }
        cell?.AddrLbl.text = farmAddr[indexPath.row].contactName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: keyValue.farmValue.rawValue)
        UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: keyValue.billToCustomerId.rawValue)
        delegate.UpdateUI(SelectedBillingCustomer: farmAddr[indexPath.row])
        tableView.reloadData()
    }
}
