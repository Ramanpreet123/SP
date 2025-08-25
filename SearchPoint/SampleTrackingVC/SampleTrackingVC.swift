//d
//  SampleTrackingVC.swift
//  SearchPoint
//
//  Created by "" on 06/11/19.
//  ""
//let previousMonth = Calendar.current.date(byAdding: .month, value: -3, to: Date())


import UIKit
import DropDown

//MARK: SAMPLE TRACKING VC
class SampleTrackingVC: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusLbl: UILabel!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var dropUpDownBtn: UIButton!
    @IBOutlet weak var dateToBttn: customButton!
    @IBOutlet weak var dateFromBttn: customButton!
    @IBOutlet weak var searchTxtfield: UITextField!
    @IBOutlet weak var dateHiddenLbl: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var dateOrderedOutlet: customButton!
    @IBOutlet weak var sampleTrackingLbl: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var dateSubmitedLB: UILabel!
    @IBOutlet weak var SORTbYlBL: UILabel!
    
    //MARK: VARIABLES AND CONSTANTS
    let dropDown = DropDown()
    var sampleTrack = NSArray()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var farmId = Int()
    var barCodeId = Int()
    var animaId = Int()
    var   userId = Int()
    var BttnTag = Int()
    var fromDate = Date()
    var ToDate = Date()
    var originalArray = NSArray()
    var clickOnDropDown = String()
    let dateFormatter3 = DateFormatter()
    var dateFrom = String()
    var dateTo = String()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var sampleOrders = [SampleOrders]()
    var orderDetailNinetyDays:OrderDetailByPastDaysVM?
    var customerId = String(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
    var heartBeatViewModel:HeartBeatViewModel?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
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
    func setUIOnDidLoad() {
        let email = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
        let singleTime = fetchAllSingleTimeToastSetting(entityName: Entities.singleTimeToastTblEntity,emailId: email.lowercased()) as! [SingleTimeToastsample]
        if singleTime.count == 0 {
            saveSingleTimeSampleToastSetting(emailId: email.lowercased(),sampleTracking:"done")
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dataDelay48Hours, comment: ""))
        }
        heartBeatViewModel?.callGetHearBeatData()
        self.getToDateFromDate()
        searchTxtfield.autocorrectionType = .no
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        initialNetworkCheck()
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        originalArray = sampleTrack
        tableView.isHidden = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        initialNetworkCheck()
        searchTxtfield.addPadding(.left(20))
        self.navigationController?.navigationBar.isHidden = true
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        self.clickOnDropDown = NSLocalizedString(LocalizedStrings.dateOrderedStr, comment: "")
        dateOrderedOutlet.setTitle(self.clickOnDropDown, for: .normal)
        
        if  UserDefaults.standard.string(forKey: ScreenNames.sampleTrackVC.rawValue) == nil {
            sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText :self.searchTxtfield.text ?? "", fromDate: fromDate as NSDate, toDate: ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.dateOrderedStr, comment: "")
            self.dateOrderedOutlet.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        if  UserDefaults.standard.string(forKey: ScreenNames.sampleTrackVC.rawValue) == LocalizedStrings.dateOrderedStr || UserDefaults.standard.string(forKey: ScreenNames.sampleTrackVC.rawValue) == "Data da Encomenda"{
            sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText :self.searchTxtfield.text ?? "", fromDate: fromDate as NSDate, toDate: ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.dateOrderedStr, comment: "")
            self.dateOrderedOutlet.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        if  UserDefaults.standard.string(forKey: ScreenNames.sampleTrackVC.rawValue) == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
            sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText :self.searchTxtfield.text ?? "", fromDate: fromDate as NSDate, toDate: ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.orderIdStr, comment: "")
            self.dateOrderedOutlet.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        tableView.reloadData()
        if sampleOrders.count == 0 {
            tableView.setMessage(LocalizedStrings.noOrdersFound)
        } else {
            nodataLbl.isHidden = true
        }
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
        if BttnTag == 0{
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
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        self.datePicker.maximumDate = Date()
        let doneButton = UIBarButtonItem(title:  NSLocalizedString(LocalizedStrings.doneStr, comment: ""), style: .plain, target: self, action: #selector(self.doneClick) )
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title:  NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    func initialNetworkCheck() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized {
            self.offLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        } else {
            self.offLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func navigateToAnotherVc() {
        self.view.isUserInteractionEnabled = true
        self.hideIndicator()
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
            if self.barCodeId == 0 {
                self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            } else {
                self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            }
        }
        
        if self.clickOnDropDown == LocalizedStrings.dateOrderedStr || self.clickOnDropDown == "Data da Encomenda"{
            if self.barCodeId == 0 {
                self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            } else {
                self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            }
        }
        
        if sampleOrders.count == 0{
            tableView.setMessage(LocalizedStrings.noOrdersFound)
        }
        tableView.reloadData()
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
    
    //MARK: SELECTOR METHODS
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized {
            self.offLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        } else{
            self.offLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func orderIdAction(_ sender : UIButton) {
        let data = self.sampleOrders[sender.tag]
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.sampleTrackingDetailVC) as! SampleTrackingDetailVC
        newViewController.orderStatus = data.status ?? "No Status"
        newViewController.serverOrderId = data.orderId ?? ""
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
        
        if BttnTag == 0 {
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            let selectedDate = dateFormatter3.string(from: datePicker.date)
            dateFromBttn.setTitle(selectedDate, for: .normal)
            
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM" {
                dateFormatter3.dateFormat = DateFormatters.MMddyyyy0000Format
            } else {
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyy0000Format
            }
            dateFormatter3.timeZone = TimeZone(abbreviation: "UTC")
            let dates = dateFormatter3.string(from: datePicker.date)
            fromDate = dateFormatter3.date(from: dates)!
        }
        else {
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            let selectedDate = dateFormatter3.string(from: datePicker.date)
            dateToBttn.setTitle(selectedDate, for: .normal)
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyy0000Format
            } else {
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyy0000Format
            }
            dateFormatter3.timeZone = TimeZone(abbreviation: "UTC")
            let dates = dateFormatter3.string(from: datePicker.date)
            ToDate = dateFormatter3.date(from: dates)!
            let isLessThan = fromDate.isSmallerThan(ToDate)
            if isLessThan  {
                dateFrom  = selectedDate
                dateTo = selectedDate
            } else{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
            }
        }
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
    }
    
    //MARK: IB ACTIONS
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.trackSamplesText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func menuClick(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func dateOrderedDroper(_ sender: UIButton) {
        searchTxtfield.resignFirstResponder()
        dropDown.anchorView = dateHiddenLbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 35
        DropDown.appearance().shadowColor = UIColor(white: 0.6, alpha: 1)
        DropDown.appearance().shadowOpacity = 0.9
        DropDown.appearance().shadowRadius = 25
        dropDown.dataSource = [NSLocalizedString(LocalizedStrings.dateOrderedStr, comment: ""),NSLocalizedString(LocalizedStrings.orderIdStr, comment: "")]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.clickOnDropDown = item
            self.dateOrderedOutlet.setTitle(item, for: .normal)
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: "") {
                UserDefaults.standard.set(self.clickOnDropDown, forKey: ScreenNames.sampleTrackVC.rawValue)
                if self.barCodeId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [SampleOrders]
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [SampleOrders]
                }
            }
            if  self.clickOnDropDown == LocalizedStrings.dateOrderedStr || self.clickOnDropDown == "Data da Encomenda"{
                UserDefaults.standard.set(self.clickOnDropDown, forKey: ScreenNames.sampleTrackVC.rawValue)
                if self.barCodeId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: LocalizedStrings.orderedDateStr, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [SampleOrders]
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: self.customerId) as! [SampleOrders]
                }
            }
            
            self.tableView.reloadData()
        }
        dropDown.show()
    }
    
    @IBAction func dateFromAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calendarViewBkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        BttnTag =  sender.tag
        doFromDatePicker()
    }
    
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func searchIconAction(_ sender: UIButton) {
        let days = self.getDaysFromSelectedDates()
        let daysSaving = Int(days) ?? 90
        tableView.isHidden = false
        let isLessThan = fromDate.isSmallerThan(ToDate)
        if !isLessThan {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
            return
        }
        
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            let orderDetailNinetyDays = OrderDetailByPastDaysVM(callBack: navigateToAnotherVc)
            orderDetailNinetyDays.callOrderDetailByPastApi(days: String(daysSaving + 1))
        }
        else {
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
                if self.barCodeId == 0 {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                } else {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                }
            }
            
            if self.clickOnDropDown == LocalizedStrings.dateOrderedStr || self.clickOnDropDown == "Data da Encomenda"{
                if self.barCodeId == 0 {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: LocalizedStrings.orderedDateStr, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                } else {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText: searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                }
            }
            
            if sampleOrders.count == 0{
                tableView.setMessage(LocalizedStrings.noOrdersFound)
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        if clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
            if self.barCodeId == 0 {
                if fromDate < ToDate || fromDate == ToDate {
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                    self.barCodeId = 1
                }
            }
            else{
                if fromDate < ToDate || fromDate == ToDate{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                    self.barCodeId = 0
                }}
        }
        
        if  self.clickOnDropDown == LocalizedStrings.dateOrderedStr || self.clickOnDropDown == "Data da Encomenda"{
            if self.barCodeId == 0 {
                
                if fromDate < ToDate || fromDate == ToDate{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: LocalizedStrings.orderedDateStr, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                    self.barCodeId = 1
                }
            }
            else {
                if fromDate < ToDate || fromDate == ToDate{
                    dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText: self.searchTxtfield.text ?? "", fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                    self.barCodeId = 0
                }
            }
        }
        tableView.reloadData()
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
extension SampleTrackingVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension SampleTrackingVC :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sampleOrders.count == 0 {
            self.tableView.setMessage(LocalizedStrings.noOrdersFound)
        }
        return self.sampleOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SampleTrackingCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! SampleTrackingCell
        let sampleOrder = self.sampleOrders[indexPath.row]
        cell.selectionStyle = .none
        cell.bckGroundView.layer.cornerRadius = 12
        cell.orderIdBtnOutlet.layer.cornerRadius = 17.5
        cell.orderIdBtnOutlet.tag = indexPath.row
        
        let orderIdAppened = NSLocalizedString(LocalizedStrings.orderIdStr, comment: "") + " : " + (sampleOrder.orderId ?? "")
        cell.orderIdBtnOutlet.setTitle(orderIdAppened, for: .normal)
        cell.labelDateOrdered.text = NSLocalizedString(LocalizedStrings.dateOrderedStr, comment: "")
        searchTxtfield.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
        cell.labelPackageRecievde.text = ButtonTitles.packageReceivedText.localized
        cell.labelSampleCount.text = ButtonTitles.sampleCountText.localized
        sampleTrackingLbl.text = NSLocalizedString(ButtonTitles.sampleTrackingText, comment: "")
        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        dateSubmitedLB.text = NSLocalizedString(ButtonTitles.dateSubmitText.localized, comment: "")
        SORTbYlBL.text = NSLocalizedString(ButtonTitles.sortByText, comment: "")
        
        var formatter = DateFormatters.MMddyyyyFormat
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            formatter = DateFormatters.MMddyyyyFormat
        } else {
            formatter = DateFormatters.ddMMyyyyFormat
        }
        
        let orderDate = getOrderedDateStringFrom(date: (sampleOrder.orderedDate ?? Date()), outputformatter: formatter)
        let latestSampleRecDate = getDateString(date: (sampleOrder.latestSampleRecDate ?? ""), inputformatter: DateFormatters.yyyyMMddTHHmmssFormat, outputformatter: formatter)
        cell.dateOrderedLbl.text = ": " + orderDate
        
        if let status = sampleOrder.status {
            cell.packagedRecievedLbl.text = ": " + status
        } else {
            cell.packagedRecievedLbl.text = ": " + latestSampleRecDate
        }
        
        cell.sampleCountLbl.text = ": " + String(sampleOrder.sampleCount )
        cell.orderIdBtnOutlet.addTarget(nil, action: #selector(orderIdAction(_:)), for: .touchUpInside)
        return cell
    }
    
}


//MARK:- UITEXTFIELD DELEGATES
extension SampleTrackingVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTxtfield.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        
        if newString != "" {
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.orderIdStr, comment: ""){
                if self.barCodeId == 0 {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, searchText: newString as String, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                } else {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: keyValue.orderId.rawValue, searchText: newString as String, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                }
                
                if sampleOrders.count == 0{
                    tableView.setMessage(LocalizedStrings.noOrdersFound)
                }
                tableView.reloadData()
            }
            
            if self.clickOnDropDown == "Date Ordered".localized {
                if self.barCodeId == 0 {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: LocalizedStrings.orderedDateStr, searchText: newString as String, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                } else {
                    self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: false, sortingKey: LocalizedStrings.orderedDateStr, searchText: newString as String, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
                }
                
                if sampleOrders.count == 0{
                    tableView.setMessage(LocalizedStrings.noOrdersFound)
                }
                tableView.reloadData()
            }
        } else {
            self.sampleOrders = fetchOrdersWithFilter(entityName: Entities.sampleOrdersTblEntity, ascending: true, sortingKey: keyValue.orderId.rawValue, fromDate: self.fromDate as NSDate, toDate: self.ToDate as NSDate, customerId: customerId) as! [SampleOrders]
            
            dropUpDownBtn.setImage(UIImage(named: ImageNames.imageImg), for: .normal)
            tableView.reloadData()
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: SIDE MENU UI EXTENSION
extension SampleTrackingVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
