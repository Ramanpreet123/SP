//  SampleTrackingDetailVC.swift
//  SearchPoint
//
//  Created by "" on 08/11/19.
//  ""
//

import UIKit
import DropDown
import CoreData

var direction: Direction = .left

//MARK: SAMPLE TRACKING DETAIL CONTROLLER
class SampleTrackingDetailVC: UIViewController {
    
    // MARK: - SAMPLE STATUS
    enum SampleStatuses: Int {
        case inProgress = 0
        case actionRequired = 1
        case reported = 2
        case cancelled = 3
        case all = 4
    }
    
    //MARK: IB OUTLETS
    @IBOutlet weak var farmIdDisplyOutlet: customButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resolveIssueBttn: customButton!
    @IBOutlet weak var farmIdHideLbl: UILabel!
    @IBOutlet weak var offlineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var networkStatusLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var resolveIssueHeight: NSLayoutConstraint!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var actionNeededBttn: customButton!
    @IBOutlet weak var inProgressBttn: customButton!
    @IBOutlet weak var reportedBttn: customButton!
    @IBOutlet weak var allBttn: customButton!
    @IBOutlet weak var reportedTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionNeddedTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inProgressTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var allTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dropUpDownBtn: UIButton!
    @IBOutlet weak var sampleTrackingLbl: UILabel!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var sortLbl: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var bckBtnOutlet: customButton!
    
    //MARK: VARIABLES AND CONSTANTS
    let earTagPortugueseText = "marca de orelha"
    var actionNeddTag = 0
    var farmId = Int()
    var barCodeId = Int()
    var animaId = Int()
    var earTag = Int()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var clickOnDropDown = String()
    var sampleTrack = NSArray()
    var orderStatus = String()
    var serverOrderId = String()
    var tagInt : Int?
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var userId = Int()
    let dropDown = DropDown()
    var filterName = ButtonTitles.allText
    var sampleStatusId = 5
    var samples = [Samples]()
    var heartBeatViewModel:HeartBeatViewModel?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        heartBeatViewModel?.callGetHearBeatData()
        sampleTrackingLbl.text = NSLocalizedString(ButtonTitles.sampleTrackingText, comment: "")
        filterLbl.text = NSLocalizedString("Filter", comment: "") + ":"
        sortLbl.text = NSLocalizedString(ButtonTitles.sortByText, comment: "")
        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        reportedBttn.setTitle(NSLocalizedString(LocalizedStrings.reportedFilterName, comment: ""), for: .normal)
        inProgressBttn.setTitle(NSLocalizedString(ButtonTitles.inProgressText, comment: ""), for: .normal)
        bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
        actionNeededBttn.setTitle(NSLocalizedString(ButtonTitles.actionNeededText, comment: ""), for: .normal)
        allBttn.setTitle(NSLocalizedString(ButtonTitles.allText, comment: ""), for: .normal)
        searchTextField.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
        searchTextField.autocorrectionType = .no
        self.configureTableView()
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, orderId: serverOrderId) as! [Samples]
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.capsOfficialId.rawValue, orderId: serverOrderId) as! [Samples]
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, orderId: serverOrderId) as! [Samples]
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == ButtonTitles.earTagText {
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.earTagKey.rawValue, orderId: serverOrderId) as! [Samples]
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == "" {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, orderId: serverOrderId) as! [Samples]
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
        }
        reportedTopConstraint.constant = 14
        actionNeddedTopConstraint.constant = 14
        inProgressTopConstraint.constant = 14
        allTopConstraint.constant = 5
        resolveIssueHeight.constant = 0
        self.setUpFilterStatusButtons(newString: "")
        reportedBttn.backgroundColor = UIColor.white
        reportedBttn.setTitleColor(UIColor.lightGray, for: .normal)
        actionNeededBttn.backgroundColor = UIColor.white
        actionNeededBttn.setTitleColor(UIColor.lightGray, for: .normal)
        inProgressBttn.backgroundColor = UIColor.white
        inProgressBttn.setTitleColor(UIColor.lightGray, for: .normal)
        allBttn.backgroundColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        allBttn.setTitleColor(UIColor.white, for: .normal)
        tblView.reloadData()
        if samples.count == 0 {
            self.view.makeToast(NSLocalizedString("No samples found", comment: ""), duration: 1, position: .center)
        }
        initialNetworkCheck()
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        searchTextField.addPadding(.left(10))
        self.reportedBttn.layer.borderColor = UIColor(red: 1/255, green: 166/255, blue: 198/255, alpha: 1).cgColor
        self.actionNeededBttn.layer.borderColor = UIColor(red: 239/255, green: 80/255, blue: 80/255, alpha: 1).cgColor
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
    }
 
    //MARK: METHODS AND FUNCTIONS
    fileprivate func getSampleFromDB() {
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
            if self.farmId == 0 {
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            }
            
        } else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
            if self.animaId == 0 {
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.capsOfficialId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.capsOfficialId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            }
        }
        else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == earTagPortugueseText {
            
            if self.earTag == 0 {
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            }
        }
        else {
            if self.barCodeId == 0 {
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
            }
        }
    }
    
    func setUpFilterStatusButtons(newString: String) {
        let sampleStatus = fetchAllData(entityName: Entities.sampleStatusTblEntity) as! [SamplesStatus]
        for sample in sampleStatus {
            if let status = SampleStatuses(rawValue: Int(sample.sampleStatusID )) {
                switch status {
                case .inProgress:
                    let inprogressSamples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: sample.sampleStatus ?? "", sampleStatusId: Int(sample.sampleStatusID ), ascending: true, searchText: newString, orderId: serverOrderId) as! [Samples]
                    self.inProgressBttn.setTitle("\(String(describing: sample.sampleStatus ?? "")) (\(inprogressSamples.count))", for: .normal)
                case .actionRequired:
                    let actionNeededSamples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: sample.sampleStatus ?? "", sampleStatusId: Int(sample.sampleStatusID ), ascending: true, searchText: newString, orderId: serverOrderId) as! [Samples]
                    self.actionNeededBttn.setTitle("\(String(describing: sample.sampleStatus ?? "")) (\(actionNeededSamples.count))", for: .normal)
                case .reported:
                    let reportedSamples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: sample.sampleStatus ?? "", sampleStatusId: Int(sample.sampleStatusID ), ascending: true, searchText: newString, orderId: serverOrderId) as! [Samples]
                    self.reportedBttn.setTitle("\(String(describing: sample.sampleStatus ?? "")) (\(reportedSamples.count))", for: .normal)
                case .cancelled:
                    break
                default:
                    break
                }
            }
        }
        let allSamples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: ButtonTitles.allText, sampleStatusId: 5, ascending: true, searchText: newString, orderId: serverOrderId) as! [Samples]
        self.allBttn.setTitle("All (\(allSamples.count))", for: .normal)
        self.tblView.reloadData()
    }
    
    func initialNetworkCheck() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            self.offlineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    private func configureTableView() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight =  600
        self.tblView.separatorStyle = .none
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
    }
    
    @objc  func checkForReachability(notification:Notification) {
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized {
            self.offlineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        } else {
            self.offlineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    //MARK: IB ACTIONS
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
    
    @IBAction func homeAction(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func bckBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func upDownAction(_ sender: UIButton) {
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
            if self.farmId == 0 {
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.farmId = 1
                
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.farmId = 0
            }
            
        } else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
            if self.animaId == 0{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.capsOfficialId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.animaId = 1
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.capsOfficialId.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.animaId = 0
            }
        }
        else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == earTagPortugueseText {
            if self.earTag == 0{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.earTag = 1
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.earTag = 0
            }
        }
        else {
            if self.barCodeId == 0{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.barCodeId = 1
            } else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextField.text ?? "", orderId: serverOrderId) as! [Samples]
                self.barCodeId = 0
            }
        }
        tblView.reloadData()
    }
    
    @IBAction func resolveIssueAction(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.resolveIssuesVC)), animated: true)
    }
    
    @IBAction func reportedBtnAction(_ sender: UIButton) {
        actionNeddTag = 2
        tagInt = 0
        reportedTopConstraint.constant = 5
        actionNeddedTopConstraint.constant = 14
        inProgressTopConstraint.constant = 14
        allTopConstraint.constant = 14
        resolveIssueHeight.constant = 0
        self.filterName = NSLocalizedString(LocalizedStrings.reportedFilterName, comment: "")
        self.sampleStatusId = 2
        self.getSampleFromDB()
        if self.samples.count == 0 {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.noOrdersFound, comment: ""), duration: 1, position: .center)
        }
        
        sender.setTitle("Reported (\(self.samples.count))", for: .normal)
        sender.backgroundColor = UIColor(red: 1/255, green: 166/255, blue: 198/255, alpha: 1)
        sender.setTitleColor(UIColor.white, for: .normal)
        actionNeededBttn.backgroundColor = UIColor.white
        actionNeededBttn.setTitleColor(UIColor.lightGray, for: .normal)
        inProgressBttn.backgroundColor = UIColor.white
        inProgressBttn.setTitleColor(UIColor.lightGray, for: .normal)
        allBttn.backgroundColor = UIColor.white
        allBttn.setTitleColor(UIColor.lightGray, for: .normal)
        tblView.reloadData()
    }
    
    @IBAction func actionNeededBtnAction(_ sender: UIButton) {
        actionNeddTag = 1
        tagInt = 0
        reportedTopConstraint.constant = 14
        actionNeddedTopConstraint.constant = 5
        inProgressTopConstraint.constant = 14
        allTopConstraint.constant = 14
        self.filterName = NSLocalizedString(ButtonTitles.actionRequiredText, comment: "")
        self.sampleStatusId = 1
        self.getSampleFromDB()
        sender.setTitle( "Action Required".localized(with: (self.samples.count)), for: .normal)
        if self.samples.count == 0 {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.noOrdersFound, comment: ""), duration: 1 , position: .center)
        }
        
        sender.backgroundColor = UIColor(red: 239/255, green: 80/255, blue: 80/255, alpha: 1)
        sender.setTitleColor(UIColor.white, for: .normal)
        reportedBttn.backgroundColor = UIColor.white
        reportedBttn.setTitleColor(UIColor.lightGray, for: .normal)
        inProgressBttn.backgroundColor = UIColor.white
        inProgressBttn.setTitleColor(UIColor.lightGray, for: .normal)
        allBttn.backgroundColor = UIColor.white
        allBttn.setTitleColor(UIColor.lightGray, for: .normal)
        resolveIssueHeight.constant = 30
        tblView.reloadData()
    }
    
    @IBAction func inProgressBtnAction(_ sender: UIButton) {
        tagInt = 1
        actionNeddTag = 0
        reportedTopConstraint.constant = 14
        actionNeddedTopConstraint.constant = 14
        inProgressTopConstraint.constant = 5
        allTopConstraint.constant = 14
        resolveIssueHeight.constant = 0
        self.filterName = ButtonTitles.inProgressText
        self.sampleStatusId = 0
        self.getSampleFromDB()
        if self.samples.count == 0 {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.noOrdersFound, comment: ""), duration: 1, position: .center)
        }
        sender.setTitle("In Progress (\(self.samples.count))", for: .normal)
        sender.backgroundColor = UIColor(red: 92/255, green: 176/255, blue: 66/255, alpha: 1)
        sender.setTitleColor(UIColor.white, for: .normal)
        reportedBttn.backgroundColor = UIColor.white
        reportedBttn.setTitleColor(UIColor.lightGray, for: .normal)
        actionNeededBttn.backgroundColor = UIColor.white
        actionNeededBttn.setTitleColor(UIColor.lightGray, for: .normal)
        allBttn.backgroundColor = UIColor.white
        allBttn.setTitleColor(UIColor.lightGray, for: .normal)
        tblView.reloadData()
    }
    
    @IBAction func allinProgressBtnAction(_ sender: UIButton) {
        tagInt = 0
        actionNeddTag = 0
        reportedTopConstraint.constant = 14
        actionNeddedTopConstraint.constant = 14
        inProgressTopConstraint.constant = 14
        allTopConstraint.constant = 5
        resolveIssueHeight.constant = 0
        self.filterName = ButtonTitles.allText
        self.sampleStatusId = 5
        self.getSampleFromDB()
        if self.samples.count == 0 {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.noOrdersFound, comment: ""), duration: 1, position: .center)
        }
        sender.setTitle("All (\(self.samples.count))", for: .normal)
        sender.backgroundColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        sender.setTitleColor(UIColor.white, for: .normal)
        reportedBttn.backgroundColor = UIColor.white
        reportedBttn.setTitleColor(UIColor.lightGray, for: .normal)
        actionNeededBttn.backgroundColor = UIColor.white
        actionNeededBttn.setTitleColor(UIColor.lightGray, for: .normal)
        inProgressBttn.backgroundColor = UIColor.white
        inProgressBttn.setTitleColor(UIColor.lightGray, for: .normal)
        tblView.reloadData()
    }
    
    @IBAction func farmIdDropDown(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        dropDown.anchorView = farmIdHideLbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 30
        dropDown.dataSource = [ NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""),NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: ""),NSLocalizedString(ButtonTitles.earTagText, comment: "")]
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.clickOnDropDown = item
            UserDefaults.standard.set(item, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
            weakSelf.farmIdDisplyOutlet.setTitle(item, for: .normal)
            weakSelf.farmIdDisplyOutlet.layer.borderColor = UIColor.gray.cgColor
            
            if weakSelf.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if weakSelf.farmId == 0 {
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    
                } else {
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                }
                
            } else if weakSelf.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
                
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if weakSelf.animaId == 0 {
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: true, sortingKey: keyValue.capsOfficialId.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                }
                else{
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: false, sortingKey: keyValue.capsOfficialId.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                }
            }
            else if weakSelf.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "")  || weakSelf.clickOnDropDown == self!.earTagPortugueseText{
                
                UserDefaults.standard.set(keyValue.earTagKey.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if weakSelf.earTag == 0 {
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: true, sortingKey: keyValue.earTagKey.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                }
                else{
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: false, sortingKey: keyValue.earTagKey.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                }
            }
            
            else{
                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if weakSelf.barCodeId == 0 {
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                    
                } else {
                    weakSelf.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    weakSelf.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: weakSelf.filterName, sampleStatusId: weakSelf.sampleStatusId, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: weakSelf.searchTextField.text ?? "", orderId: weakSelf.serverOrderId) as! [Samples]
                }
                
            }
            weakSelf.tblView.reloadData()
        }
        dropDown.show()
    }
}

//MARK: TEXTFIELD DELEGATE
extension SampleTrackingDetailVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.setUpFilterStatusButtons(newString: textField.text ?? "")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                if self.farmId == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                }
                
            } else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
                
                if self.animaId == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.capsOfficialId.rawValue, searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.capsOfficialId.rawValue, searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                }
            }
            else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == earTagPortugueseText {
                if self.earTag == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.earTagKey.rawValue,searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.earTagKey.rawValue,searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                }
            }
            else {
                if self.barCodeId == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText:  newString as String, orderId: serverOrderId) as! [Samples]
                }
            }
            tblView.reloadData()
            if samples.count == 0{
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noOrdersFound, comment: ""), duration: 1, position: .center)
            }
        } else {
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                if self.farmId == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, orderId: serverOrderId) as! [Samples]
                }
            } else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
                if self.animaId == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.capsOfficialId.rawValue, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.capsOfficialId.rawValue, orderId: serverOrderId) as! [Samples]
                }
            }
            else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == earTagPortugueseText {
                
                if self.earTag == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.earTagKey.rawValue, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.earTagKey.rawValue, orderId: serverOrderId) as! [Samples]
                }
            }
            else {
                if self.barCodeId == 0 {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, orderId: serverOrderId) as! [Samples]
                } else{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.samples = fetchSamplesWithFilter(entityName: Entities.sampleTblEntity, sampleStatus: self.filterName, sampleStatusId: sampleStatusId, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, orderId: serverOrderId) as! [Samples]
                }
            }
            tblView.reloadData()
            if samples.count == 0{
                self.view.makeToast(NSLocalizedString(LocalizedStrings.noOrdersFound, comment: ""), duration: 1, position: .center)
            }
        }
        self.setUpFilterStatusButtons(newString: newString as String)
        return true
    }
}
