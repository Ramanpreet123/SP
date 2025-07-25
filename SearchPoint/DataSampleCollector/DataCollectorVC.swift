//
//  DataCollectorVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 24/05/22.
//

import UIKit

//MARK: DATA COLLECTOR VC
class DataCollectorVC: UIViewController , ResponseDataCollectorApi, offlineCustomView {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblsampleCollector: UILabel!
    @IBOutlet weak var lblAddressHeader: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtSampleCollector: UITextField!
    @IBOutlet weak var txtaddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    
    //MARK: VARIABLES AND CONSTANTS
    var offline = Bool()
    var dataViewModel: DataCollectorViewModel!
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
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
        self.navigationController?.navigationBar.isHidden = true
        txtSampleCollector.placeholder = ButtonTitles.pleaseEnterText.localized
        if UIDevice().userInterfaceIdiom == .phone {
            setupUI()

        }
        else {
            self.setSideMenu()
            txtSampleCollector.setLeftPaddingPoints(20)
            txtaddress.setLeftPaddingPoints(20)
            txtZipCode.setLeftPaddingPoints(20)
            txtCity.setLeftPaddingPoints(20)
            btnSubmit.layer.cornerRadius = 30.0
            btnCancel.layer.cornerRadius = 30.0
        }
        setupLangaugeBR()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialNetworkCheck()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    
    //MARK: INITIAL UI METHODS
    func setupUI() {
        txtSampleCollector.layer.cornerRadius = 22
        txtCity.layer.cornerRadius = 22
        txtaddress.layer.cornerRadius = 22
        txtZipCode.layer.cornerRadius = 22
        txtSampleCollector.clipsToBounds = true
        txtCity.clipsToBounds = true
        txtaddress.clipsToBounds = true
        txtZipCode.clipsToBounds = true
        txtSampleCollector.layer.borderWidth = 0.5
        txtCity.layer.borderWidth = 0.5
        txtaddress.layer.borderWidth = 0.5
        txtZipCode.layer.borderWidth = 0.5
        txtSampleCollector.layer.borderColor = UIColor.lightGray.cgColor
        txtCity.layer.borderColor = UIColor.lightGray.cgColor
        txtaddress.layer.borderColor = UIColor.lightGray.cgColor
        txtZipCode.layer.borderColor = UIColor.lightGray.cgColor
        btnCancel.layer.borderWidth = 0.5
        btnCancel.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        btnCancel.setTitleColor(UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1), for: .normal)
    }
    
    func setupLangaugeBR() {
        lblHeader.text = NSLocalizedString(ButtonTitles.orderSampleCollectors, comment: "")
        lblsampleCollector.text = NSLocalizedString(ButtonTitles.sampleCollectorsNeeded, comment: "") //
        lblAddressHeader.text = NSLocalizedString(ButtonTitles.pleaseEnterAddress, comment: "")
        txtSampleCollector.placeholder = NSLocalizedString(ButtonTitles.pleaseEnterText, comment: "")
        txtaddress.placeholder = NSLocalizedString(ButtonTitles.addressBlockText, comment: "")
        txtCity.placeholder = NSLocalizedString(ButtonTitles.cityText, comment: "")
        txtZipCode.placeholder = NSLocalizedString(ButtonTitles.zipCodeText, comment: "")
        btnCancel.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        btnSubmit.setTitle(NSLocalizedString(ButtonTitles.submitText, comment: ""), for: .normal)
    }
    
    func initialNetworkCheck() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.hideIndicator()
            self.offLineBtn.isUserInteractionEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc  func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            if offline == false {
                offline = true
            }
        } else {
            self.offLineBtn.isUserInteractionEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
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
            // When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    // Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
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
            // Animate Shadow (Fade In)
            //  UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            self.menuIconLeadingConstraint.constant = 30
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
                
            }
            // Animate Shadow (Fade Out)
            //  UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
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
    
    func sideMenuRevealDCViewController() -> DataCollectorVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is DataCollectorVC {
            return viewController! as? DataCollectorVC
        }
        while (!(viewController is DataCollectorVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is DataCollectorVC {
            return viewController as? DataCollectorVC
        }
        return nil
    }
    
    // MARK: - IB ACTIONS
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
    
    @IBAction func showMenu(_ sender: UIButton) {
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController?.presentRightMenuViewController()
            self.view.makeCorner(withRadius: 40)

        }  else {
            self.sideMenuRevealDCViewController()?.revealSideMenu()
        }
    }
    
    @IBAction func acnCancel(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func SubmitButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if txtSampleCollector.text == "" && txtaddress.text == "" && txtCity.text == "" && txtZipCode.text == "" {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
        }
        else if txtSampleCollector.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterSampleCollectors, comment: ""))
        }
        else if txtaddress.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterAddressBlock, comment: ""))
        }
        else if txtCity.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterCity, comment: ""))
        }
        else if txtZipCode.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterZipCode, comment: ""))
        }
        else{
            self.CallAddCollectorApi()
        }
        
    }
    
    func CallAddCollectorApi() {
        dataViewModel =  DataCollectorViewModel(ref: self, callBack: navigateToAnotherVc)
        dataViewModel.delegate = self
    }
    
    func navigateToAnotherVc(){
        UserDefaults.standard.setValue(true, forKey: keyValue.collectorIdentifier.rawValue)
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    func responseRecievedStatus(status: Bool) {}
}
