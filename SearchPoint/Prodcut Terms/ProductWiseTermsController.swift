//
//  ProductWiseTermsController.swift
//  SearchPoint
//
//  Created by "" 13/05/20.
//

import UIKit
import  WebKit

class ProductWiseTermsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    var orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
    var orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)

    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int

    @IBOutlet weak var orderTermstitle: UILabel!
    var dairyProducts = [ProductAdonAnimalTbl]()
    var beefProducts = [ProductAdonAnimlTbLBeef]()
    
    var activityView = UIActivityIndicatorView ()
    var isBeefOrder = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView = UIActivityIndicatorView(style: .medium)
        activityView.center = self.view.center

        self.view.addSubview(activityView)
        
        
        if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
            self.isBeefOrder = true
            
            let addedBeefProducts = fetchAllDataFarmIdStatusisSyncTerms(entityName: Entities.productAdonAnimlBeefTblEntity, asending: true, status: "true", isSync: "false",orderstatus:"false",orderId:orderIdBeef, userId:userId)
            
            for product in addedBeefProducts as? [ProductAdonAnimlTbLBeef] ?? [] {
                if !self.beefProducts.contains(where: {$0.productId == product.productId }) {
                    self.beefProducts.append(product)
                }
            }
            
        } else {
            let dairyProducts = fetchAllDataFarmIdStatusisSyncTerms(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", isSync: "false",orderstatus:"false",orderId:orderId, userId:userId)
            
            
            for product in dairyProducts as? [ProductAdonAnimalTbl] ?? [] {
                if !self.dairyProducts.contains(where: {$0.productId == product.productId }) {
                    self.dairyProducts.append(product)
                }
            }
            self.isBeefOrder = false
        }
        
       
        
        showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
        self.configureTableView()
       
      orderTermstitle.text = NSLocalizedString("Order Acceptance Terms", comment: "")
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    

    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight =  600
        self.tableView.separatorStyle = .none
        
        self.tableView.register(ProductwiseTermsCell.nib, forCellReuseIdentifier: ProductwiseTermsCell.identifier)
    }

    @IBAction func okayButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

//MARK: - Table View Delegates and Configuration
extension ProductWiseTermsController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.isBeefOrder  {
            return beefProducts.count
        } else {
            return dairyProducts.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductwiseTermsCell", for: indexPath) as! ProductwiseTermsCell
        
        var terms = ""
        
        if self.isBeefOrder  {
            terms = beefProducts[indexPath.section].orderAcceptTerms ?? ""
        } else {
            terms = dairyProducts[indexPath.section].orderAcceptTerms ?? ""
        }
         activityView.startAnimating()
        cell.webView.loadHTMLString(terms, baseURL: nil)
        cell.webView.uiDelegate = self
        cell.webView.navigationDelegate = self
        cell.webView.frame = view.bounds
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isBeefOrder  {
            return beefProducts[section].productName ?? ""
        } else {
            return dairyProducts[section].productName ?? ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  500
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}


extension ProductWiseTermsController: WKNavigationDelegate, WKUIDelegate {
    
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
        hideIndicator()
   
         activityView.stopAnimating()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //  let shouldLoad = shouldStartLoad(withRequest: navigationAction.request) // check the url if necessary
        
        if  navigationAction.targetFrame == nil {
            // WKWebView ignores links that open in new window
            // heightofAgreeBttn.constant = 0
            // webView.load(navigationAction.request)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            UIApplication.shared.openURL(navigationAction.request.url!)
            
        }
        
        // always pass a policy to the decisionHandler
        decisionHandler( .allow )
    }
}
