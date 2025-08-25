
import UIKit
import DropDown

//MARK: RESOLVE ISSUES VC
class ResolveIssuesVC: UIViewController{
    
    //MARK: OUTLETS
    @IBOutlet weak var dateFromBttn: customButton!
    @IBOutlet weak var backgroundBttn: UIButton!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var offlineBtn: UIButton!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var NetworkStatusImg: UIImageView!
    @IBOutlet weak var filter2TblView: UITableView!
    @IBOutlet weak var filter1TblView: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var  calenderView: UIView!
    @IBOutlet weak var dateToBttn: customButton!
    @IBOutlet weak var ResolveIssuetableView: UITableView!
    @IBOutlet weak var sortByBttn: customButton!
    @IBOutlet weak var dateHiddenLbl: UILabel!
    @IBOutlet weak var dropUpDownBtn: UIButton!
    @IBOutlet weak var actionRequiredLbl: UILabel!
    @IBOutlet weak var dateSubmittedLbl: UILabel!
    @IBOutlet weak var sortByLbl: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var filter1Title: UILabel!
    @IBOutlet weak var filter2Title: UILabel!
    @IBOutlet weak var applyBtnOutlet: customButton!
    @IBOutlet weak var cancelBtnOutlet: customButton!
    
    //MARK: VARIABLES AND CONSTANTS
    let dropDown = DropDown()
    var indexpathTag = -1
    var indexpathTag1 = -1
    var resolveSortName = String()
    var farmId = Int()
    var barCodeId = Int()
    var earTagId = Int()
    var animaId = Int()
    var orderID = Int()
    var clickOnDropDown = String()
    var sampleTrack = [GetActionRequired]()
    var filter1Array = NSArray()
    var filter2Array = NSArray()
    var tableviewName = UITableView()
    var tableviewName1 = UITableView()
    var BttnTag = Int()
    let toolBar = UIToolbar()
    let dateFormatter3 = DateFormatter()
    var actionRequiredNinetyDays:ActionRequiredVM?
    var dateFrom = String()
    var dateTo = String()
    var fromDate = Date()
    var ToDate = Date()
    var datePicker : UIDatePicker!
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as! Int
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var oldValue1 = Int()
    var oldValue2 = Int()
    var customerId = String(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
    var value = 0
    let buttonbg1 = UIButton()
    
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
        self.getToDateFromDate()
        let email = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
        var singleTime = fetchAllSingleTimeToastSetting(entityName: Entities.singleTimeToastTblEntity,emailId: email.lowercased()) as! [SingleTimeToastAction]
        if singleTime.count == 0 {
            saveSingleTimeActionToastSetting(emailId: email.lowercased(),actionRequired:LocalizedStrings.doneStr.localized)
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dataDelay48Hours, comment: ""))
        }
        calenderView.isHidden = true
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        initialNetworkCheck()
        sampleTrack = fetchAllDatasampleDataFROMPRODUCTAllResolvedIssue(entityName: Entities.getActionRequiredTblEntity, userId: userId, customerId: customerId, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
        if sampleTrack.count == 0{
          //  self.view.makeToast( NSLocalizedString(LocalizedStrings.noActionOrIssues, comment: ""), duration: 2, position: .center)
            //ResolveIssuetableView.isHidden = true
            ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues.localized)
        }
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        self.getToDateFromDate()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        backgroundBttn.isHidden = true
        oldValue1 = UserDefaults.standard.integer(forKey: keyValue.radio1Key.rawValue)
        oldValue2 = UserDefaults.standard.integer(forKey: keyValue.radio2Key.rawValue)
        self.filter1Array = [NSLocalizedString(LocalizedStrings.consumerServiceAction, comment: ""),NSLocalizedString(LocalizedStrings.breedSocietyAction, comment: ""),NSLocalizedString(LocalizedStrings.actionsToAct, comment: ""),NSLocalizedString(LocalizedStrings.showFailedSamples, comment: ""),NSLocalizedString(LocalizedStrings.showAllStr, comment: "")]
        self.filter2Array = [NSLocalizedString(LocalizedStrings.showParentageCorr, comment: ""),NSLocalizedString(LocalizedStrings.showGenomicCorr, comment: ""),NSLocalizedString(LocalizedStrings.showMeAllStr, comment: "")]
        
        actionRequiredLbl.text = NSLocalizedString(ButtonTitles.actionRequiredText, comment: "")
        dateSubmittedLbl.text = NSLocalizedString(ButtonTitles.dateSubmitText.localized, comment: "")
        sortByLbl.text = NSLocalizedString(ButtonTitles.sortByText, comment: "")
        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        searchTextfield.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
        filter1Title.text = NSLocalizedString(ButtonTitles.filter1Text, comment: "")
        filter2Title.text = NSLocalizedString(ButtonTitles.filter2Text, comment: "")
        applyBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.applyText, comment: ""), for: .normal)
        cancelBtnOutlet.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        filterView.isHidden = true
        initialNetworkCheck()
        if UserDefaults.standard.value(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == nil{
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.sortByBttn.setTitle(clickOnDropDown, for: .normal)
            self.sampleTrack =   fetchAllDatasampleDataFROMPRODUCTfarmIdResolveDate(entityName: Entities.getActionRequiredTblEntity, onfarmId: self.searchTextfield.text!, userId: userId, asending: false, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
            self.ResolveIssuetableView.reloadData()
        }
        else{
            if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
                self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                self.sortByBttn.setTitle(self.clickOnDropDown, for: .normal)
                
                self.sampleTrack =   fetchAllDatasampleDataFROMPRODUCTfarmIdResolve(entityName: Entities.getActionRequiredTblEntity, onfarmId: self.searchTextfield.text!, userId: userId, asending: false, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.ResolveIssuetableView.reloadData()
            }
            
            if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
                self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
                self.sortByBttn.setTitle(self.clickOnDropDown, for: .normal)
                
                self.sampleTrack = fetchAllDatasampleDataFROMPRODUCToFFidResolve(entityName: Entities.getActionRequiredTblEntity, officialId: self.searchTextfield.text!, userId: userId, asending: false, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.ResolveIssuetableView.reloadData()
            }
            
            if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
                self.sortByBttn.setTitle(self.clickOnDropDown, for: .normal)
                
                self.sampleTrack = fetchAllDatasampleDataFROMPRODUCTBarcodeResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: self.searchTextfield.text!, userId: userId, asending: false, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate)  as! [GetActionRequired]
                self.ResolveIssuetableView.reloadData()
            }
            
            if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.earTagKey.rawValue {
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.sortByBttn.setTitle(self.clickOnDropDown, for: .normal)
                
                self.sampleTrack = fetchAllDatasampleDataEarTag(entityName: Entities.getActionRequiredTblEntity, onfarmId: self.searchTextfield.text!, userId: userId, asending: false, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate)  as! [GetActionRequired]
                self.ResolveIssuetableView.reloadData()
            }
        }
        if UserDefaults.standard.string(forKey: keyValue.orderIDRIKey.rawValue) != nil{
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.orderIdStr, comment: "")
            self.sortByBttn.setTitle(self.clickOnDropDown, for: .normal)
            
            self.sampleTrack = fetchAllDatasampleDataFROMPRODUCTOrderIDResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: self.searchTextfield.text!, userId: userId, asending: false, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
            self.ResolveIssuetableView.reloadData()
        }
        searchTextfield.addPadding(.left(20))
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
    }
    
    //MARK: OBJC SELECTOR AND OTHER METHODS
    @objc func doneClick() {
        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
        
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter3.dateFormat = DateFormatters.MMddyyyy0000Format
        }
        else{
            dateFormatter3.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
        dateFormatter3.timeZone = TimeZone(abbreviation: "UTC")
        
        if BttnTag == 0 {
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else{
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            let selectedDate = dateFormatter3.string(from: datePicker.date)
            dateFromBttn.setTitle(selectedDate, for: .normal)
            
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyy0000Format
            }
            else{
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyy0000Format
            }
            dateFormatter3.timeZone = TimeZone(abbreviation: "UTC")
            let dates = dateFormatter3.string(from: datePicker.date)
            fromDate = dateFormatter3.date(from: dates)!
        }
        else {
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else{
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            let selectedDate = dateFormatter3.string(from: datePicker.date)
            dateToBttn.setTitle(selectedDate, for: .normal)
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyy0000Format
            }
            else{
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyy0000Format
            }
            dateFormatter3.timeZone = TimeZone(abbreviation: "UTC")
            let dates = dateFormatter3.string(from: datePicker.date)
            ToDate = dateFormatter3.date(from: dates)!
            let isLessThan = fromDate.isSmallerThan(ToDate)
            
            if isLessThan == true {
                dateFrom  = selectedDate
                dateTo = selectedDate
            }
        }
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        backgroundBttn.isHidden = true
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        backgroundBttn.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
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
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == NSLocalizedString(ButtonTitles.connectedText, comment: ""){
            NetworkStatusLbl?.text = NSLocalizedString(ButtonTitles.connectedText, comment: "")
            self.offlineBtn.isHidden = true
            self.NetworkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            NetworkStatusLbl?.text =  NSLocalizedString(ButtonTitles.notConnectedText, comment: "")
            self.offlineBtn.isHidden = false
            self.NetworkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }

    //MARK: METHODS AND FUNCTIONS
    func getToDateFromDate() {
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        dateToBttn.setTitle(dateFormatter.string(from: Date()), for: .normal)
        let previousMonth = Calendar.current.date(byAdding: .day, value: -90, to: Date())
        dateFromBttn.setTitle(dateFormatter.string(from: previousMonth!), for: .normal)
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
        let dates = dateFormatter.string(from: previousMonth!)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        fromDate = dateFormatter.date(from: dates)!
        let currentDates = dateFormatter.string(from: Date())
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        ToDate = dateFormatter.date(from: currentDates)!
    }
    
    func doFromDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2{
            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        }
        else if langId == 3{
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else{
            self.datePicker?.locale = Locale(identifier: Languages.eng)
        }
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        if BttnTag == 0 {
                self.datePicker.setDate(fromDate, animated: true)
        }
        else{
                self.datePicker.setDate(ToDate, animated: true)
        }
        if #available(iOS 14, *) {
            self.datePicker?.preferredDatePickerStyle = .wheels
        }
        calenderView.backgroundColor = UIColor.white
        calenderView.addSubview(self.datePicker)
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        self.datePicker.maximumDate = Date()
        let doneButton = UIBarButtonItem(title: LocalizedStrings.doneStr.localized, style: .plain, target: self, action: #selector(self.doneClick) )
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    func getDaysFromSelectedDates() -> String {
        let calendar = Calendar.current
        let date1 = calendar.date(byAdding: .day, value: 0, to: fromDate)!
        var date2 = calendar.date(byAdding: .day, value: 0, to: ToDate)!
        if date2 < Date() {
            date2 = Date()
        }
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return "\(String(describing: components.day ?? 90))"
    }
    
    func initialNetworkCheck(){
        self.offlineBtn.isHidden = true
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == NSLocalizedString(ButtonTitles.connectedText, comment: "") {
            NetworkStatusLbl?.text = NSLocalizedString(ButtonTitles.connectedText, comment: "")
            self.offlineBtn.isHidden = true
            self.NetworkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            NetworkStatusLbl?.text = NSLocalizedString(ButtonTitles.notConnectedText, comment: "")
            self.offlineBtn.isHidden = false
            self.NetworkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func navigateToAnotherVc() {
        self.view.isUserInteractionEnabled = true
        self.hideIndicator()
        if self.clickOnDropDown == "" || self.clickOnDropDown == nil{
            
            if self.farmId == 0 {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            } else {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            }
        }
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
            if self.orderID == 0 {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            } else {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            }
        }
        
        if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "") {
            if self.barCodeId == 0 {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            } else {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            }
        }
        
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
            if self.farmId == 0 {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            } else {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            }
        }
        
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
            if self.animaId == 0 {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallOfficialTag.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            } else {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallOfficialTag.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            }
        }
        if self.clickOnDropDown ==  NSLocalizedString(ButtonTitles.earTagText, comment: ""){
            if self.earTagId == 0 {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            } else {
                self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate , customerId: self.customerId) as! [GetActionRequired]
            }
        }
        if sampleTrack.count == 0{
            ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues)
          //  self.view.makeToast(NSLocalizedString(LocalizedStrings.noActionOrIssues, comment: ""), duration: 0.5, position: .center)
        }
        ResolveIssuetableView.reloadData()
    }
   
    //MARK: IB ACTIONS
    @IBAction func dateFromAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        backgroundBttn.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        BttnTag =  sender.tag
        doFromDatePicker()
    }
 
    @IBAction func searchIconAction(_ sender: UIButton) {
        let days = self.getDaysFromSelectedDates()
        ResolveIssuetableView.isHidden = false
        let isLessThan = fromDate.isSmallerThan(ToDate)
        
        if !isLessThan {
            CommonClass.showAlertMessage(self, titleStr: AlertMessagesStrings.alertString, messageStr: AlertMessagesStrings.fromDateSmallerThanDate)
            return
        }
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            let actionRequiredNinetyDays = ActionRequiredVM(callBack: navigateToAnotherVc)
            actionRequiredNinetyDays.callNineteyDaysApi(days: Int(days)! + 1 )
        }
        else {
            let dateFrom  = dateFromBttn.titleLabel?.text
            let dateTo = dateToBttn.titleLabel?.text
            ResolveIssuetableView.isHidden = false
            let isLessThan = fromDate.isSmallerThan(ToDate)
            
            if dateFrom == dateTo {
                
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
                    if self.orderID == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "") {
                    if self.barCodeId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                    if self.farmId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                    if self.animaId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallOfficialTag.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallOfficialTag.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
                    if self.earTagId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                
                if sampleTrack.count == 0{
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues)
                   // self.view.makeToast(NSLocalizedString(LocalizedStrings.noActionOrIssues, comment: ""), duration: 0.5, position: .center)
                }
                
            } else if isLessThan == true {
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
                    if self.orderID == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "") {
                    if self.barCodeId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallSampleBarcode.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                    if self.farmId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallOnFarmId.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                    if self.animaId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.smallOfficialTag.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.smallOfficialTag.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                    if self.earTagId == 0 {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: true, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    } else {
                        self.sampleTrack = fetchOrdersWithFilter(entityName: Entities.getActionRequiredTblEntity, ascending: false, sortingKey: keyValue.earTagKey.rawValue, searchText: searchTextfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [GetActionRequired]
                    }
                }
                if sampleTrack.count == 0{
                    ResolveIssuetableView.setMessage(LocalizedStrings.noActionOrIssues)
                 //   self.view.makeToast(NSLocalizedString(LocalizedStrings.noActionOrIssues, comment: ""), duration: 0.5, position: .center)
                }
                
            } else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
            }
        }
        
        ResolveIssuetableView.reloadData()
    }
    
    @IBAction func sortByAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        searchTextfield.resignFirstResponder()
        dropDown.anchorView = dateHiddenLbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 35
        dropDown.dataSource = [ NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""),NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: ""),NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""),NSLocalizedString(ButtonTitles.earTagText, comment: "")]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.sortByBttn.setTitle(item, for: .normal)
            self.clickOnDropDown = item
            self.resolveSortName = item
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.orderIDRIKey.rawValue)
                
                self.sampleTrack =   fetchAllDatasampleDataFROMPRODUCTfarmIdResolve(entityName: Entities.getActionRequiredTblEntity, onfarmId: self.searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.ResolveIssuetableView.reloadData()
                self.filter1TblView.reloadData()
                self.filter2TblView.reloadData()
            }
            else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.orderIDRIKey.rawValue)
                self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.sampleTrack = fetchAllDatasampleDataFROMPRODUCToFFidResolve(entityName: Entities.getActionRequiredTblEntity, officialId: self.searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.ResolveIssuetableView.reloadData()
            }
            else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
                UserDefaults.standard.set(self.clickOnDropDown, forKey: keyValue.orderIDRIKey.rawValue)
                self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.sampleTrack = fetchAllDatasampleDataFROMPRODUCTOrderIDResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: self.searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.ResolveIssuetableView.reloadData()
            }
            else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                UserDefaults.standard.set(keyValue.earTagKey.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.orderIDRIKey.rawValue)
                self.sampleTrack =   fetchAllDatasampleDataEarTag(entityName: Entities.getActionRequiredTblEntity, onfarmId: self.searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.ResolveIssuetableView.reloadData()
                self.filter1TblView.reloadData()
                self.filter2TblView.reloadData()
            }
            else {
                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.orderIDRIKey.rawValue)
                self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.sampleTrack = fetchAllDatasampleDataFROMPRODUCTBarcodeResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: self.searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.ResolveIssuetableView.reloadData()
            }
        }
        dropDown.show()
    }
    
    @IBAction func upDownAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
            if self.farmId == 0{
                sampleTrack =  fetchAllDatasampleDataFROMPRODUCTfarmIdResolve(entityName: Entities.getActionRequiredTblEntity, onfarmId: searchTextfield.text!, userId: userId , asending: true, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.farmId = 1
                ResolveIssuetableView.reloadData()
                filter1TblView.reloadData()
                filter2TblView.reloadData()
            }
            else {
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                sampleTrack =   fetchAllDatasampleDataFROMPRODUCTfarmIdResolve(entityName: Entities.getActionRequiredTblEntity, onfarmId: searchTextfield.text!, userId: userId, asending: false, customerId: customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.farmId = 0
                ResolveIssuetableView.reloadData()
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
            if self.animaId == 0{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                sampleTrack =   fetchAllDatasampleDataFROMPRODUCToFFidResolve(entityName: Entities.getActionRequiredTblEntity, officialId: searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.animaId = 1
                ResolveIssuetableView.reloadData()
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                sampleTrack =   fetchAllDatasampleDataFROMPRODUCToFFidResolve(entityName: Entities.getActionRequiredTblEntity, officialId: searchTextfield.text!, userId: userId, asending: false, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.animaId = 0
                ResolveIssuetableView.reloadData()
            }
        }
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
            if self.orderID == 0{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                sampleTrack =   fetchAllDatasampleDataFROMPRODUCTOrderIDResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: self.searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.orderID = 1
                ResolveIssuetableView.reloadData()
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                sampleTrack =   fetchAllDatasampleDataFROMPRODUCTOrderIDResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: self.searchTextfield.text!, userId: userId, asending: false, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.orderID = 0
                ResolveIssuetableView.reloadData()
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
            if self.earTagId == 0 {
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                sampleTrack =  fetchAllDatasampleDataEarTag(entityName: Entities.getActionRequiredTblEntity, onfarmId: self.searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.earTagId = 1
                ResolveIssuetableView.reloadData()
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                sampleTrack =   fetchAllDatasampleDataEarTag(entityName: Entities.getActionRequiredTblEntity, onfarmId: self.searchTextfield.text!, userId: userId, asending: false, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.earTagId = 0
                ResolveIssuetableView.reloadData()
            }
        }
        
        else {
            if self.barCodeId == 0{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                sampleTrack = fetchAllDatasampleDataFROMPRODUCTBarcodeResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: searchTextfield.text!, userId: userId, asending: true, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.barCodeId = 1
                ResolveIssuetableView.reloadData()
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                sampleTrack = fetchAllDatasampleDataFROMPRODUCTBarcodeResolve(entityName: Entities.getActionRequiredTblEntity, barcodeID: searchTextfield.text!, userId: userId, asending: false, customerId: self.customerId,fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate) as! [GetActionRequired]
                self.barCodeId = 0
                ResolveIssuetableView.reloadData()
            }
        }
    }

    @IBAction func showMenu(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        self.view.endEditing(true)
        filterView.isHidden = false
        backgroundBttn.isHidden = false
    }
    
    @IBAction func closeClick(_ sender: customButton) {
        UserDefaults.standard.set(oldValue1, forKey: keyValue.radio1Key.rawValue)
        UserDefaults.standard.set(oldValue2, forKey: keyValue.radio2Key.rawValue)
        filter2TblView.reloadData()
        filter1TblView.reloadData()
        filterView.isHidden = true
        backgroundBttn.isHidden = true
    }
    
    @IBAction func applyClick(_ sender: customButton) {
        backgroundBttn.isHidden = true
        if tableviewName == filter1TblView{
            UserDefaults.standard.set(indexpathTag, forKey: keyValue.radio1Key.rawValue)
            oldValue1 = indexpathTag
        }
        if tableviewName1 == filter2TblView{
            UserDefaults.standard.set(indexpathTag1, forKey: keyValue.radio2Key.rawValue)
            oldValue2 = indexpathTag1
        }
        filterView.isHidden = true
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
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
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.actionsRequiredText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}
