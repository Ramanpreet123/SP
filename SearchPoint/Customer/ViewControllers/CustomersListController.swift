//
//  CustomersListController.swift
//  SearchPoint
//
//  Created by "" 05/06/20.
//

import UIKit

//MARK: CUSTOMERS LIST CONTROLLER
class CustomersListController: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var customerListContainer: UIView!
    @IBOutlet weak var dropDownListContainerView: UIView!
    @IBOutlet weak var dopDownIcon: UIImageView!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var selectedCustomerLabel: UILabel!
    @IBOutlet weak var containerCerter: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: UIView!
    @IBOutlet weak var doneBtnOutlet: UIButton!
    @IBOutlet weak var selectCustomerLbl: UILabel!
    
    //MARK: VARIABLES AND CONSTANTS
    var selectedCustomer: GetCustomer?
    var dependency:DashboardVC?
    weak var delegate: CustomersListControllerDelegate?
    var customerList = [GetCustomer]()
    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedCustomerLabel.text = NSLocalizedString(ButtonTitles.selectCustomerText, comment: "")
        doneBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.doneStr.localized, comment: ""), for: .normal)
        self.tableView.isHidden = true
        self.configureTableView()
        self.dropDownListContainerView.layer.borderWidth = 0.5
        self.dropDownListContainerView.layer.borderColor = UIColor.lightGray.cgColor
        customerList = fetchAllDataCustomer(entityName: Entities.getCustomerTblEntity) as! [GetCustomer]
        
        if customerList.count == 0 {
            let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.contactCustomerService, comment: ""), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
                self.hideIndicator()
                self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                self.sideMenuViewController?.hideMenuViewController()
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
        self.setupCurrentSelectedCustomer()
    }
    
    //MARK: - METHODS AND FUNCTIONS
    func setupCurrentSelectedCustomer() {
        if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int,
           let currentCustomer = fetchCurrentActiveCustomer(entityName: Entities.getCustomerTblEntity, customerId: currentCustomerId) as? [GetCustomer],
           !currentCustomer.isEmpty {
            
            self.selectedCustomerLabel.text = currentCustomer[0].customerName ?? ""
            self.selectedCustomer = currentCustomer[0]
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
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - IB ACTIONS
    @IBAction func showCustomerList(_ sender: UIButton) {
        if tableView.isHidden {
            self.tableView.isHidden = false
            
        } else {
            self.tableView.isHidden = true
        }
        self.tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        if selectedCustomerLabel.text == ButtonTitles.selectCustomerText || selectedCustomerLabel.text == "Selecionar Cliente"{
            self.view.makeToast(NSLocalizedString(LocalizedStrings.pleaseSelectCustomer, comment: ""), duration: 2, position: .top)
            return
        }
        dependency?.pageapi = 0
        UserDefaults.standard.setValue(0, forKey: keyValue.totalAnimalsCount.rawValue)
        UserDefaults.standard.set(selectedCustomer?.customerId, forKey: keyValue.currentActiveCustomerId.rawValue)
        UserDefaults.standard.set(selectedCustomer?.billToCustomerId,forKey: keyValue.billToCustomerId.rawValue)
        UserDefaults.standard.set(selectedCustomer?.marketCode,forKey: keyValue.marketName.rawValue)
        UserDefaults.standard.set(selectedCustomer?.marketId,forKey: keyValue.marketNameID.rawValue)
        UserDefaults.standard.set(selectedCustomer?.country,forKey: keyValue.country.rawValue)
        let curentCustId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        let email = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
        let customerSetting =  fetchAllCustomerSettingData(entityName: Entities.customerSettingSaveEntity,emailId:email.lowercased())
        
        if customerSetting.count == 0 {
            savecustomerSettingData(customerID: curentCustId!,emailId: email.lowercased())
            
        } else {
            UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
            updateCustomerSettingData(entity: Entities.customerSettingSaveEntity,emailId: email.lowercased(),customerId:curentCustId!)
            
        }
        
        if self.getMarketsForCurrentCustomer() == nil {
            self.madeLogoutIfCustomerHasNoMarkets()
            return
        }
        
        guard UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) != nil || UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int != 0 else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:NSLocalizedString(LocalizedStrings.pleaseSelectCustomer, comment: "") )
            return
        }
        UserDefaults.standard.removeObject(forKey: keyValue.capsBrazil.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.dataEntryTsu.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.beefProduct.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.breedNameClear.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.capsBreedName.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedName.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedId.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.beefBreed.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        self.dismiss(animated: false, completion: nil)
        self.tableView.isHidden = true
        delegate?.selectedCustomer(selectedCustomer: self.selectedCustomer, isForSingleUser: false)
        dependency?.collectionView.reloadData()
    }
}

//MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension CustomersListController: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 40
        self.tableView.layer.borderWidth = 0.5
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
        self.tableView.register(CustomerCell.nib, forCellReuseIdentifier: CustomerCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customerCellId, for: indexPath) as! CustomerCell
        cell.titleLabel.text = customerList[indexPath.row].customerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCustomer = customerList[indexPath.row]
        selectedCustomerLabel.text = customerList[indexPath.row].customerName ?? ""
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
