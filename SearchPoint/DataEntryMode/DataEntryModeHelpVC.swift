//
//  DataEntryModeHelpVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/12/20.
//

import UIKit
import Foundation

// MARK: - CLASS

class DataEntryModeHelpVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var appStatusText: UILabel!
    @IBOutlet weak var screenTitleHelp: UILabel!
    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var acknoeledgeBtnOutlet: UIButton!
    @IBOutlet weak var menuBtnOutelt: UIButton!
    @IBOutlet weak var helpTextView1: UILabel!
    @IBOutlet weak var helpTextView2: UILabel!
    @IBOutlet weak var helpTextView3: UILabel!
    
    // MARK: - VARIABLES
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    // MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        
    }
    
    // MARK: - METHODS AND FUNCTIONS
    
    func setInitialUI(){
        self.navigationController?.navigationBar.isHidden = true
        if UserDefaults.standard.value(forKey: keyValue.dataEntryHelpScreen.rawValue) as? Bool == true {
            if UIDevice().userInterfaceIdiom == .phone {
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: Bundle.main)
                let secondViewController = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC) as! DataEntryModeListVC
                self.navigationController?.pushViewController(secondViewController, animated: false)
            } else {
                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "DataEntryModeListiPadVC") as! DataEntryModeListiPadVC
                self.navigationController?.pushViewController(secondViewController, animated: false)
            }
          
            
            
        }
        initialNetworkCheck()
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        screenTitleHelp.text = LocalizedStrings.dataEntryModeHelp.localized
        acknoeledgeBtnOutlet.setTitle(LocalizedStrings.acknowledge.localized, for: .normal)
     //   appStatusText.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        helpTextView1.text = LocalizedStrings.focusedDataEntryMode.localized
        helpTextView2.text = LocalizedStrings.previousAnimalData.localized
        helpTextView3.text = LocalizedStrings.sampleBarcodeCollector.localized
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    
    // MARK: - OBJC SELECTOR METHODS

    @objc func methodOfReceivedNotification(notification: Notification)
    {
        
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
        
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }

    // MARK: - IB ACTIONS
    
    @IBAction func acknowledgeBtnAction(_ sender: UIButton) {
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
        } else {
            let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeListiPadVC")), animated: true)
        }
        UserDefaults.standard.set(true, forKey: keyValue.dataEntryHelpScreen.rawValue)
      
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
        
    }
    
    @IBAction func connectedBtnAction(_ sender: Any) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DataEntryModeHelpVC.buttonbgPressed), for: .touchUpInside)
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

// MARK: - OFFLINE CUSTOM VIEW EXTENSION

extension DataEntryModeHelpVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - SIDE MENU UI EXTENSION

extension DataEntryModeHelpVC: SideMenuUI {
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
