//
//  Terms_ConditionsVC.swift
//  SearchPoint
//
//  Created by "" on 22/10/2019.
//  ""
//

import UIKit
import  WebKit
import MBProgressHUD
import Alamofire
import CoreData

//MARK: TERMS AND CONDITION VC
class Terms_ConditionsVC: UIViewController,WKUIDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var agreeBtn: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var dataModel:LoginScreenSetModel?
    var termsVm :TermsConditionViewModel?
    var group = DispatchGroup()
    var speiecCountCheck = NSArray()
    var isWKScrollOnTop = Bool()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        view.endEditing(true)
        UserDefaults.standard.set(true, forKey: keyValue.mustRegisterDevice.rawValue)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        isWKScrollOnTop = true
        self.agreeBtn.isEnabled = false
        self.agreeBtn.backgroundColor = UIColor.gray
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.frame = view.bounds
        webView.navigationDelegate = self
        
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let marketCode = UserDefaults.standard.value(forKey: keyValue.marketCode.rawValue) as? String
        var url : URL?
        
        if Connectivity.isConnectedToInternet() {
            if let marketCode = marketCode {
                showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
                let path =  Configuration.Dev(packet: ApiKeys.terms.rawValue).getUrl() + "/\(appID)/" + marketCode
                url = URL(string: path)
                var urlRequest = URLRequest(url: url!)
                urlRequest.httpMethod = HTTPMethod.get.rawValue
                urlRequest.addValue(accessToken!, forHTTPHeaderField: LocalizedStrings.authorizationHeader)
                var content = ""
                
                let task = URLSession.shared.dataTask(with: urlRequest) {
                    (data, response, error) in
                    
                    if data != nil {
                        content = String(data: data!, encoding: String.Encoding.utf8) ?? "Not Working"
                        deleteRecordFromDatabase(entityName: Entities.termsHTMLTblEntity)
                        let saveObject : [String:Any] = ["htmlContent": content,"urlString":url as Any]
                        insert(entity: Entities.termsHTMLTblEntity, attributeKey: nil, objectToSave: saveObject)
                        
                        DispatchQueue.main.async {
                            self.webView.loadHTMLString(content, baseURL: url)
                            self.webView.allowsBackForwardNavigationGestures = true
                            self.webView.scrollView.delegate = self
                        }
                    }
                }
                task.resume()
            }
        }
        else {
            let content = fetchAllData(entityName: Entities.termsHTMLTblEntity)
            if content.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noInternetConnection, comment: ""))
                self.view.isUserInteractionEnabled = true
            }
            else {
                let ab = content.object(at: 0)
                let cc = (ab as AnyObject).htmlContent
                let urlS = (ab as AnyObject).urlString
                DispatchQueue.main.async {
                    self.webView.loadHTMLString(cc as! String, baseURL: urlS as? URL)
                    self.webView.allowsBackForwardNavigationGestures = true
                    self.webView.scrollView.delegate = self
                }
            }
        }
    }
    
    //MARK: IB ACTIONS
    @IBAction func agreeAction(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() {
            termsVm = TermsConditionViewModel(ref: self, callBack: termsAcceptedSuccess)
            termsVm?.delegate = self
            termsVm?.callTermsApi(accepted: true)
        }
        else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noInternetConnection, comment: ""))
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func HomeAction(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
}

//MARK: SCROLL VIEW DELEGATE
extension Terms_ConditionsVC: WKNavigationDelegate,UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height < 100 {
            if isWKScrollOnTop == false {
                self.agreeBtn.backgroundColor = UIColor(red: 15.0/255, green: 134/255, blue: 155/255, alpha: 1.0)
                self.agreeBtn.isEnabled = true
            }
        }
        else if scrollView.contentOffset.y < scrollView.contentSize.height - 50 {
            self.agreeBtn.backgroundColor = UIColor.gray
            self.agreeBtn.isEnabled = false
        }
    }
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
        hideIndicator()
        isWKScrollOnTop = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if  navigationAction.targetFrame == nil {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            UIApplication.shared.openURL(navigationAction.request.url!)
        }
        decisionHandler( .allow )
    }
}

//MARK: TERMS CONDITION VIEW MODEL DELEGATE
extension Terms_ConditionsVC: TermsConditionViewModelDelegate {
    func termsAcceptedSuccess(){
        
        LoginManager.shared.dataModel = self.dataModel
        self.hideIndicator()
        UserDefaults.standard.set(true, forKey: keyValue.terms.rawValue)
        UserDefaults.standard.set("true", forKey: keyValue.firstLogin.rawValue)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.tutorialViewId)), animated: true)
        self.view.removeFromSuperview()
    }
    
    func responseRecieved(status:Bool) {
        self.hideIndicator()
        CommonClass.showAlertMessage(self, titleStr: AlertMessagesStrings.alertString, messageStr: LocalizedStrings.somethingWentWrong)
    }
}
