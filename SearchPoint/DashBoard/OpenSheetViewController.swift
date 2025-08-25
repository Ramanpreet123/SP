//
//  OpenSheetViewController.swift
//  Searchpoint
//
//  Created by Mobile Programming on 12/10/24.
//

import UIKit

protocol OpenSheetViewControllerDelegate: AnyObject {
    func didSelectCustomer(_ customer: String, selectedCustomer : GetCustomer?)
}


class OpenSheetViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    let customers = ["Cookie Cutter Holstein, LLC", "Agricola La Martina", "Johnson & Co.,Cookie Cutter Holstein, LLC", "Agricola La Martina", "Johnson & Co."]
    var selectedCustomer: GetCustomer?
    var dependency:DashboardVC?
    var customerList = [GetCustomer]()
    weak var delegate: OpenSheetViewControllerDelegate?
    var searchText = String()
    var searchData = [GetCustomer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        customerList = fetchAllDataCustomer(entityName: Entities.getCustomerTblEntity) as! [GetCustomer]
        self.setupCurrentSelectedCustomer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.frame = UIScreen.main.bounds
    }
    
    //MARK: - METHODS AND FUNCTIONS
    func setupCurrentSelectedCustomer() {
        if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int {
            if let currentCustomer = fetchCurrentActiveCustomer(entityName: Entities.getCustomerTblEntity, customerId: currentCustomerId) as? [GetCustomer] {
                guard currentCustomer.count > 0 else {
                    return
                }
                self.selectedCustomer = currentCustomer[0]
            }
        }
    }
    
    func getMarketsForCurrentCustomer() -> String? {
        if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int {
            let customerMarkets = fetchAllDataWithCustomerID(entityName: Entities.customerMarketsTblEntity, customerId: currentCustomerId)
            guard customerMarkets.count > 0 else {
                return nil
            }
            return ""
        } else {
            return nil
        }
    }
    
    func madeLogoutIfCustomerHasNoMarkets() {
        let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.noAssociatedProviderProd, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            self.hideIndicator()
            
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}

extension OpenSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchData.count > 0 {
            return searchData.count
        }
        return customerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenSheetTableViewCell", for: indexPath) as! OpenSheetTableViewCell
        cell.lblTitle?.text = customerList[indexPath.row].customerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Customer: \(customerList[indexPath.row])")
        self.selectedCustomer = customerList[indexPath.row]
        dismiss(animated: true, completion: nil)
    }
}
