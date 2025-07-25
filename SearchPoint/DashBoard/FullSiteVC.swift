//
//  FullSiteVC.swift
//  SearchPoint
//
//  Created by "" on 13/12/19.
//

import UIKit
import WebKit

//MARK: FULL SITE VIEW CONTROLLER
class FullSiteVC: UIViewController,WKUIDelegate {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var webVieww: WKWebView!
    @IBOutlet weak var networkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    
    //MARK: VARIABLES AND CONSTANTS
    var heartBeatViewModel:HeartBeatViewModel?
    var value = 0
    let buttonbg = UIButton()
    var customPopView :OfflinePopUp!
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        heartBeatViewModel?.callGetHearBeatData()
        self.navigationController?.isNavigationBarHidden = true
        guard let url = URL(string: "https://mysearchpoint.com") else { return }
        UIApplication.shared.open(url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialNetworkCheck()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
   
    @objc  func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            loadWebView()
        } else {
            self.offLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
   
    //MARK: METHODS AND FUNCTIONS
    func loadWebView(){
        webVieww.uiDelegate = self
        webVieww.frame = view.bounds
        webVieww.navigationDelegate = self as? WKNavigationDelegate
        let url = URL (string: "https://mysearchpoint.com")
        let requestObj = URLRequest(url: url!)
        if Connectivity.isConnectedToInternet() {
            webVieww.load(requestObj)
        } else {
            hideIndicator()
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noInternetConnection, comment: ""))
        }
        webVieww.allowsBackForwardNavigationGestures = true
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            loadWebView()
        }
        else {
            self.offLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    //MARK: IB ACTIONS
    @IBAction func menuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DashboardVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed(ClassIdentifiers.offlineViewNib) as? OfflinePopUp
        customPopView.delegate = self
        customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension FullSiteVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: WEBVIEW DELEGATE EXTENSION
extension FullSiteVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideIndicator()
    }
}
