//
//  AppHelpListVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 31/08/22.
//

import UIKit

// MARK: - APPHELP CELL CLASS


class AppHelpListCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
}

// MARK: - APPHELP CLASS

class AppHelpListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IB OUTLETS
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var appList: UITableView!
    
    // MARK: - VARIABLES
    
    let titleArray = [NSLocalizedString(LocalizedStrings.dashboardText, comment: ""),NSLocalizedString(LocalizedStrings.menuText, comment: ""),NSLocalizedString(LocalizedStrings.addOrderingAnimalsText, comment: ""),NSLocalizedString(LocalizedStrings.addOrderingAnimalsTextBeef, comment: ""),NSLocalizedString(LocalizedStrings.orderingDefaultsText, comment: ""),NSLocalizedString(LocalizedStrings.dataEntryModeText, comment: ""),NSLocalizedString(LocalizedStrings.resultsText, comment: ""),NSLocalizedString(LocalizedStrings.actionsRequiredText, comment: ""),NSLocalizedString(LocalizedStrings.trackSamplesText, comment: ""),NSLocalizedString(LocalizedStrings.contactSupportText, comment: "")]
    
    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        titleLbl.text = LocalizedStrings.appHelpText
        appList.tableFooterView = UIView()
        appList.layer.cornerRadius = 15
        
    }
    
    // MARK: - IB ACTIONS

    @IBAction func showMenuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func acndashboard(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    // MARK: - TABLEVIEW DATASOURCE AND DELEGATE

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.appHelpListCell) as? AppHelpListCell else { return UITableViewCell() }
        
        cell.lblTitle.text = titleArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = titleArray[indexPath.row]
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
}

// MARK: - DICTIONARY EXTENSION

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
