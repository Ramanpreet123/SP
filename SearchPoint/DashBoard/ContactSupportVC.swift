//
//  ContactSupportVC.swift
//  SearchPoint
//
//  Created by "" on 11/11/2019.
//  ""
//

import UIKit
import MessageUI

//MARK: CONTACT SUPPORT CLASS
class ContactSupportVC: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var appHelpIcon: UIButton!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var offlineBtn: UIButton!
    @IBOutlet weak var menuBtnOutlet: UIButton!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    //MARK: VARIABES AND CONSTANTS
    var heartBeatViewModel:HeartBeatViewModel?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var contactSuppportArray = [ContactSupportTbl]()
    let contactArray = [String]()
    var contactViewModel:ContactSupportViewModel!
    var imagesArray = [UIImage(named: "UsaImage"), UIImage(named: "UKImage"), UIImage(named: "BrazilImage"), UIImage(named: "AUSImage"),UIImage(named: "NZImage"), UIImage(named: "CANImage"), UIImage(named: "ItalyImage"), UIImage(named: "NETHImage"), UIImage(named: "LUXImage"), UIImage(named: "BELImage")]
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice().userInterfaceIdiom == .pad {
            self.navigationView.isHidden = false
            self.tblView.separatorStyle = .none
        }
        else {
            self.navigationView.isHidden = true
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let contactSupport = UserDefaults.standard.value(forKey: keyValue.contactSupport.rawValue) as? String
        if contactSupport  == "true" {
            menuBtnOutlet.isHidden = false
            self.setSideMenu()
            appHelpIcon.isHidden = false
        } else {
            menuBtnOutlet.isHidden = true
            if UIDevice().userInterfaceIdiom == .pad {
                appHelpIcon.isHidden = true
            }
            
        }
        initialNetworkCheck()
        self.navigationController?.navigationBar.isHidden = true
        contactSuppportArray =  fetchAllData(entityName: Entities.contactSupportTblEntity) as! [ContactSupportTbl]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
     
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification){
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
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.offlineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func phoneBtnnClick(btnTag:UIButton){
        let arry = contactSuppportArray[btnTag.tag]
        if arry.country == "US"  {
            let str = "tel:\(arry.phone!)"
            guard let number = URL(string: str) else { return }
            UIApplication.shared.open(number)
        }
        else {
            let str = "tel:\(arry.phone!.replacingOccurrences(of: " ", with: ""))"
            guard let number = URL(string: str) else { return }
            UIApplication.shared.open(number)
        }
    }
    
    @objc func textbttnClick(btnTag:UIButton){
        guard let url = URL(string: "https://www.zoetis.com.br/especies/bovinos/clarifide/searchpoint.aspx") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func emailbttnClick(btnTag:UIButton){
        let arry =   contactSuppportArray[btnTag.tag]
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([arry.email!])
            mail.setSubject("Support")
            present(mail, animated: true, completion: nil)
        }
        else {
            print("Mail services are not available on this device (likely the Simulator).")
        }
    }
    
    //MARK: UI METHODS AND FUNCTIONS
    func initialNetworkCheck() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        } else {
            self.offlineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    //MARK: SIDE MENU UI METHODS
    func setSideMenu(){
        if UIDevice.current.orientation.isLandscape {
            self.sideMenuRevealWidth = 300
        }
        else {
            self.sideMenuRevealWidth = 260
            
        }
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewVC!.view, at: self.revealSideMenuOnTop ? 1 : 0)
        addChild(self.sideMenuViewVC!)
        self.sideMenuViewVC!.didMove(toParent: self)
        self.sideMenuViewVC.view.backgroundColor = UIColor.white
        
        // Side Menu AutoLayout
        
        self.sideMenuViewVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewVC.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            self.sideMenuViewVC.searchpointImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 42.0)
        ])
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    @IBAction open func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            if UIDevice.current.orientation.isLandscape {
                self.menuIconLeadingConstraint.constant = 320
                print("Landscape")
            } else {
                self.menuIconLeadingConstraint.constant = 270
                print("Portrait")
            }
            
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
                
            }
         
        }
        else {
            self.menuIconLeadingConstraint.constant = 30
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
                
            }
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        self.view.bringSubviewToFront(self.sideMenuViewVC.view)
        self.sideMenuViewVC.tblView.reloadData()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    func sideMenuRevealSettingsViewController() -> ContactSupportVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is ContactSupportVC {
            return viewController! as? ContactSupportVC
        }
        while (!(viewController is ContactSupportVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is ContactSupportVC {
            return viewController as? ContactSupportVC
        }
        return nil
    }
    
    
    //MARK: IB ACTIONS
    @IBAction func bckBtnClick(_ sender: Any) {
        let login =  UserDefaults.standard.value(forKey: keyValue.firstLogin.rawValue) as? String
        if login == "true"{
            
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            if UIDevice().userInterfaceIdiom == .phone {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            }
            else {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            }
            
        }
        else{
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            if UIDevice().userInterfaceIdiom == .phone {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
            }
            else {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
            }
        }
    }
    
    @IBAction func showMenuBtnClick(_ sender: Any) {
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController?.presentRightMenuViewController()
            self.view.makeCorner(withRadius: 40)
        }  else {
            self.sideMenuRevealSettingsViewController()?.revealSideMenu()
        }
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(ContactSupportVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed(ClassIdentifiers.offlineViewNib) as? OfflinePopUp
        customPopView.delegate = self
        if UIDevice().userInterfaceIdiom == .phone {
            customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
            
        } else {
            customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 330,height: screenSize.height/1.7)
            
        }
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
        
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        if UIDevice().userInterfaceIdiom == .phone {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
            vc?.module = LocalizedStrings.contactSupportText.localized
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: false, completion: nil)
        }
        else {
            CommonClass.showAlertMessage(self, titleStr:AlertMessagesStrings.alertString.localized + "!", messageStr: "In progress")
        }
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension ContactSupportVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELGATE, MAIL COMPOSE VIEW CONTROLLER DELEGATE
extension ContactSupportVC :UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return 140
        }
        else {
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactSuppportArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContactSupportCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! ContactSupportCell
        let contactSupportData = contactSuppportArray[indexPath.row]
        cell.selectionStyle = .none
        cell.cellContentView.layer.borderColor = UIColor.init(red: 57/255, green: 69/255, blue: 73/255, alpha: 1.0).cgColor
        cell.cellContentView.layer.borderWidth = 2.0
        cell.cellContentView.layer.cornerRadius = 10.0
        cell.phoneNoBttnClick.tag = indexPath.row
        cell.emailBttnClick.tag =  indexPath.row
        cell.contactButton.tag =  indexPath.row
        cell.phoneNoBttnClick.setTitle(contactSupportData.phone, for: .normal)
        let attrs = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                     NSAttributedString.Key.foregroundColor : UIColor.init(red: 57/255, green: 69/255, blue: 73/255, alpha: 1.0)]
        as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        let phoneattrs = [NSAttributedString.Key.foregroundColor : UIColor.init(red: 57/255, green: 69/255, blue: 73/255, alpha: 1.0)]  as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        let attrString = NSMutableAttributedString(string: contactSupportData.email!, attributes:attrs)
        cell.emailBttnClick.setAttributedTitle(attrString, for: .normal)
        cell.emailBttnClick.addTarget(self, action: #selector(self.emailbttnClick), for: .touchUpInside)
        
        if (contactSupportData.text != nil) && contactSupportData.text != "" {
            var titleAttrs = [NSAttributedString.Key: Any]()
            if UIDevice().userInterfaceIdiom == .pad {
                titleAttrs = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                              NSAttributedString.Key.foregroundColor : UIColor.init(red: 57/255, green: 69/255, blue: 73/255, alpha: 1.0),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)] as [NSAttributedString.Key : Any]
            } else {
                titleAttrs = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                              NSAttributedString.Key.foregroundColor : UIColor.init(red: 29/225, green: 131/225, blue: 174/225, alpha: 1.0),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)] as [NSAttributedString.Key : Any]
            }
            
            let attrString = NSMutableAttributedString(string: NSLocalizedString("Additional Resources", comment: ""), attributes:titleAttrs)
            cell.contactButton.setAttributedTitle(attrString, for: .normal)
            if UIDevice().userInterfaceIdiom == .pad {
                cell.additionalResourceView.isHidden = false
            }
            
            cell.contactButton.isHidden = false
            cell.contactButton.addTarget(self, action: #selector(self.textbttnClick), for: .touchUpInside)
        } else {
            cell.additionalResourceView.isHidden = true
            cell.contactButton.isHidden = true
        }
        let attrString1 = NSMutableAttributedString(string: contactSupportData.phone!, attributes:phoneattrs)
        cell.phoneNoBttnClick.setAttributedTitle(attrString1, for: .normal)
        cell.phoneNoBttnClick.addTarget(nil, action: #selector(self.phoneBtnnClick), for: .touchUpInside)
        cell.countryBtn.setTitle(contactSupportData.country!, for: .normal)
        cell.flagImgView.image = imagesArray[indexPath.row]
        cell.hoursOpertionLbl.text = contactSupportData.hoursOfOpertion!
        return cell
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK: SIDE MENU UI EXTENSION
extension ContactSupportVC :SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
