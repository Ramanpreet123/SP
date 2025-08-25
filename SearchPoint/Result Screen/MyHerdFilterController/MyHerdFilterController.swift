//
//  MyHerdFilterController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 17/03/21.
//

import UIKit
import DropDown

// MARK: - CLASS
class MyHerdFilterController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var CancleBtnFilterScreenOutlet: customButton!
    @IBOutlet weak var clearFilterBtnOutlet: customButton!
    @IBOutlet weak var doneBtnFilterScreenOutlet: customButton!
    @IBOutlet weak var maleBtnOutlet: customButton!
    @IBOutlet weak var femaleBtnOutlet: customButton!
    @IBOutlet weak var allBtnOutlet: customButton!
    @IBOutlet weak var lblHerditySeperator: UILabel!
    @IBOutlet weak var imgViewIsHerdity: UIImageView!
    @IBOutlet weak var herdityViewHeight: NSLayoutConstraint!
    @IBOutlet weak var isherdityBtn: UIButton!
    @IBOutlet weak var lblIsHerdity: UILabel!
    @IBOutlet weak var maxDobValueLbl: UILabel!
    @IBOutlet weak var minDobValueLbl: UILabel!
    @IBOutlet weak var totalAnimalValueLbl: UILabel!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var providerLbl: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var dateRangeLbl: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var filterBackroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var innerview: UIView!
    @IBOutlet weak var scroolingview: UIScrollView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var trailsindexbutton: UIButton!
    @IBOutlet weak var trailsindexlable: UILabel!
    @IBOutlet weak var providerCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var providerCollectionView: UICollectionView!
    @IBOutlet weak var dateToBttn: UIButton!
    @IBOutlet weak var dateFromBttn: UIButton!
    @IBOutlet weak var dropdowntrail: DropDown!
    @IBOutlet weak var breedCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var breedCollectionvIEW: UICollectionView!
    @IBOutlet weak var breedCollectionTrailing: NSLayoutConstraint!
    @IBOutlet weak var OfflicalIDbuttonoutlet: UIButton!
    @IBOutlet weak var OnfarmIDbuttonoutlet: UIButton!
    @IBOutlet weak var ascending: UIButton!
    @IBOutlet weak var descending: UIButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    var value = 0
    var  newfromDaten = Date()
    var newToDaten = Date()
    var displayNamesArray = [String]()
    var selectedProviderName = String()
    var selectedProductName = String()
    var selectedProviderID = Int()
    var resultMasterGet = [ResultMasterTemplate]()
    var userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
    var selectedtabTitles = String()
    var isHerditySelected: Bool = false {
        didSet {
            UserDefaults.standard.set(isHerditySelected, forKey: keyValue.isHerditySelected.rawValue)
            imgViewIsHerdity.image = UIImage(named: isHerditySelected ? ImageNames.checkImg : ImageNames.unCheckImg)
            
        }
    }
    var buttonbg = UIButton()
    var selectedBreed = String()
    var group = DispatchGroup()
    var saveResulyByPageViewModel: ResulyByPageViewModel?
    var saveAnimalGroupUpdatedViewModel: AnimalGroupsForCustomerUpdateVM?
    weak var delegate: filterInfoUpdate?
    var breedIndexPath = 0
    var providerIndexPath = 0
    var genderRetain = String()
    var displayModelArray = [DisplayModel]()
    var headerisselected : Bool? = false
    var traitisselected : Bool? = false
    var dropDown = DropDown()
    var dropDown1 = DropDown()
    var fromDate = Date()
    var ToDate = Date()
    var fromDaten = Date()
    var ToDaten = Date()
    var tempArray = Bool()
    var nav = String()
    var customeridsave = Int64()
    let buttonbg2 = UIButton ()
    let buttonbgAutoSuggestion = UIButton ()
    let labletbale = UILabel()
    var AutoSuggestionTableView  = UITableView ()
    var droperTableView  = UITableView ()
    var productArray = [String]()
    var providerIDArray = [Int64]()
    var breedArray = [String]()
    var breedIdArray = [String]()
    var BttnTag = Int()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var dateFrom = String()
    var dateTo = String()
    let dateFormatter3 = DateFormatter()
    var custmerID = Int64()
    var  selectedDatefrom = String()
    var  selectedDateto = String()
    var myHerdArray1 = [ResultMyHerdData]()
    var isProviderSelected: Bool = false
    var datefromstring = String()
    let tofromstring = String()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setUIOnDidAppear()
    }
    
    // MARK: - INITIAL UI METHODS
    func setUIOnDidLoad(){
        isherdityBtn.setTitle("", for: .normal)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.breedCollectionvIEW?.collectionViewLayout = layout
        self.trailsindexbutton.layer.borderColor = UIColor.lightGray.cgColor
        self.trailsindexbutton.layer.borderWidth = 1
        self.trailsindexbutton.layer.cornerRadius = 20
        let totalanimal = UserDefaults.standard.value(forKey: keyValue.filterTotalAnimalAccount.rawValue) as? Int ?? 0
        totalAnimalValueLbl.text = "\(totalanimal)"
        if let minDOB = UserDefaults.standard.value(forKey: keyValue.filterMinDOB.rawValue) as? String, let maxDOB = UserDefaults.standard.value(forKey: keyValue.filterMaxDOB.rawValue) as? String {
            minDobValueLbl.text = (minDOB == "" || minDOB.contains("0001-01-01T")) ? "NA" : getOrderDate(dateStr: maxDOB)
            maxDobValueLbl.text = (maxDOB == "" || maxDOB.contains("0001-01-01T")) ? "NA" : getOrderDate(dateStr: minDOB)
            
        }
        selectedProviderID = UserDefaults.standard.object(forKey: keyValue.resultproviderID.rawValue) as? Int ?? 0
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        UserDefaults.standard.setValue(true, forKey: keyValue.sortOrder.rawValue)
        bydefaultidselect()
        byDefaultValueSet()
        bydefaultsortorder()
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        self.filterBackroundView.isHidden = false
        self.filterView.isHidden = false
        self.innerview.isHidden = false
        self.scroolingview.isHidden = false
        providerIndexPath = 0
        breedIndexPath = 0
        getToDateFromDate()
        let fetchObj = fetchResultFilterData(entityName: Entities.resultFilterDataTblEntity,customerId: Int(custmerID))
        
        if fetchObj.count != 0{
            for i in 0 ..< fetchObj.count{
                let obj = fetchObj[i] as! ResultFilterData
                let getProvidrName = obj.providerName ?? ""
                let getProviderID = obj.providerID
                providerIDArray.append(getProviderID)
                productArray.append(getProvidrName)
            }
            productArray = productArray.removeDuplicates()
            providerIDArray = providerIDArray.removeDuplicates()
            
            if productArray.count > 2 {
                providerCollectionViewHeight.constant = 95
            }
        }
        
        breedCollectionvIEW.allowsMultipleSelection = false
        let fetchFilterData = fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID), isheridity: UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue) , productID: selectedProviderID)
        
        for items in fetchFilterData{
            let newfetch = items as? ResultFIlterDataSave
            selectedProviderID = Int(Int64(newfetch?.productID ?? 0))
            selectedProductName = newfetch?.productName ?? ""
            isHerditySelected = newfetch?.isHeriditySelected ?? false
        }
        providerLbl.text = NSLocalizedString(ButtonTitles.providerText, comment: "")
        breedLbl.text = NSLocalizedString(ButtonTitles.breedText, comment: "")
        dateRangeLbl.text = NSLocalizedString(ButtonTitles.dateRangeText, comment: "")
        sexLabel.text = NSLocalizedString(ButtonTitles.sexTest, comment: "")
        doneBtnFilterScreenOutlet.setTitle(NSLocalizedString(LocalizedStrings.doneStr, comment: ""), for: .normal)
        clearFilterBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.clearFilterText, comment: ""), for: .normal)
    }
    
    func setUIOnDidAppear(){
        let resultFIlterDataSave =  fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue) , productID: selectedProviderID)
        
        if resultFIlterDataSave.count == 0 {
            let selectedIndexPath = IndexPath(row: 0, section: 0)
            providerCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .right)
            self.collectionView(self.providerCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
            providerCollectionView.allowsMultipleSelection = false
            let selectIndexBreedCollection = IndexPath(row: 0, section: 0)
            breedCollectionvIEW.selectItem(at: selectIndexBreedCollection, animated: true, scrollPosition: .right)
            self.collectionView(self.breedCollectionvIEW, didSelectItemAt: IndexPath(item: 0, section: 0))
            breedCollectionvIEW.allowsMultipleSelection = false
            headerisselected = false
            traitisselected = false
            trailsindexbutton.setTitle(ButtonTitles.selectIndexText, for: .normal)
        } else {
            let resultObject = resultFIlterDataSave.object(at: 0) as! ResultFIlterDataSave
            let productIndex = resultObject.productIndex
            let sexvalue = resultObject.sex
            providerIndexPath = Int(resultObject.productIndex)
            breedIndexPath = Int(resultObject.breedIndex)
            genderRetain = resultObject.sex ?? ""
            let traidname = resultObject.traidsave ?? ""
            if traidname == "" {
                trailsindexbutton.setTitle(ButtonTitles.selectIndexText, for: .normal)
            } else {
                trailsindexbutton.setTitle(traidname, for: .normal)
            }
            let selectedIndexPath = IndexPath(row: Int(productIndex), section: 0)
            let todateget = resultObject.dateto ?? ""
            let fromdateget = resultObject.datefrom ?? ""
            let sortvalue = resultObject.sortorder
            let idselect = resultObject.idselection ?? ""
            let traidsave = resultObject.traidsave ?? ""
            UserDefaults.standard.set(traidsave, forKey: keyValue.traitName.rawValue)
            isHerditySelected = resultObject.isHeriditySelected
            providerCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .right)
            self.collectionView(self.providerCollectionView, didSelectItemAt: IndexPath(item: Int(productIndex), section: 0))
            providerCollectionView.allowsMultipleSelection = false
            breedCollectionvIEW.allowsMultipleSelection = false
            headerisselected = true
            traitisselected = true
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            
            if fromdateget != "" {
                newfromDaten = dateFormatter.date(from: fromdateget)!
            }
            
            if todateget != "" {
                newToDaten = dateFormatter.date(from: todateget)!
            }
            
            let fmt = DateFormatter()
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                fmt.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                fmt.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            let fromdatecheck = fmt.string(from: newfromDaten)
            let todatecheck = fmt.string(from: newToDaten)
            dateToBttn.setTitle(todatecheck, for: .normal)
            dateFromBttn.setTitle(fromdatecheck, for: .normal)
            UserDefaults.standard.setValue(todatecheck, forKey: keyValue.todate.rawValue)
            UserDefaults.standard.setValue(fromdatecheck, forKey: keyValue.fromdate.rawValue)
            UserDefaults.standard.setValue(sortvalue, forKey: keyValue.sortOrder.rawValue)
            UserDefaults.standard.set(sexvalue, forKey: keyValue.savesex.rawValue)
            UserDefaults.standard.setValue(idselect, forKey: keyValue.idSelect.rawValue)
            bydefaultidselect()
            bydefaultsortorder()
            byDefaultValueSet()
        }
    }
    
    // MARK: - OBJC SELECTOR METHODS
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
    
    @objc func doneClick() {
        if UserDefaults.standard.value(forKey: keyValue.fromdate.rawValue) as! String == "" {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateStyle = .medium
            dateFormatter1.timeStyle = .none
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter1.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter1.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            if BttnTag == 0 {
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                let selectedDate = dateFormatter3.string(from: datePicker.date)
                dateFromBttn.setTitle(selectedDate, for: .normal)
                fromDate = dateFormatter3.date(from: selectedDate)!
            }
            else {
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                let selectedDate = dateFormatter3.string(from: datePicker.date)
                dateToBttn.setTitle(selectedDate, for: .normal)
                ToDate = dateFormatter3.date(from: selectedDate)!
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
        else{
            UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateStyle = .medium
            dateFormatter1.timeStyle = .none
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            if BttnTag == 0{
                let dateToNw = dateToBttn.titleLabel?.text ?? ""
                ToDate = dateFormatter3.date(from: dateToNw)!
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                let selectedDate = dateFormatter3.string(from: datePicker.date)
                dateFromBttn.setTitle(selectedDate, for: .normal)
                fromDate = dateFormatter3.date(from: selectedDate)!
                let isLessThan = fromDate.isSmallerThan(ToDate)
                if isLessThan  {
                    dateFrom  = selectedDate
                    dateTo = selectedDate
                } else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
                }
            }
            else{
                let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
                fromDate = dateFormatter3.date(from: dateFromNw)!
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                let selectedDate = dateFormatter3.string(from: datePicker.date)
                dateToBttn.setTitle(selectedDate, for: .normal)
                ToDate = dateFormatter3.date(from: selectedDate)!
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
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    // MARK: - NAVIGATION METHODS
    func navigateToAnotherVc(){
        group.leave()
        hideIndicator()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).sync {
            self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
            self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM(callBack: self.navigateTosaveanimal)
            self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
        }
    }
    
    func navigateTosaveanimal(){
        self.filterBackroundView.isHidden = true
        self.filterView.isHidden = true
        self.innerview.isHidden = true
        self.scroolingview.isHidden = true
        self.view.isUserInteractionEnabled = true
        self.dismiss(animated: false) {
            self.delegate?.reloaddata()
        }
    }
    
    // MARK: - API CALL BACKS
    func callfromAPIfliters(){
        self.filterBackroundView.isHidden = true
        self.filterView.isHidden = true
        self.innerview.isHidden = true
        self.scroolingview.isHidden = true
        self.dismiss(animated: false) {
            self.delegate?.reloaddata()
        }
    }
    
    func resultcallbackaction(){
        group.leave()
        hideIndicator()
        self.view.isUserInteractionEnabled = false
        self.filterBackroundView.isHidden = true
        self.filterView.isHidden = true
        self.innerview.isHidden = true
        self.scroolingview.isHidden = true
        self.dismiss(animated: false) {
            self.delegate?.reloaddata()
        }
    }
    
    // MARK: - METHODS AND FUNCTIONS
    func getOrderDate(dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        let date = dateFormatter.date(from: dateStr) ?? Date()
        
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        let datefinal = dateFormatter.string(from: date)
        return datefinal
    }
    
    func bydefaultidselect(){
        let checkid = UserDefaults.standard.value(forKey: keyValue.idSelect.rawValue) as? String ?? ""
        if checkid  == LocalizedStrings.officialCheckId{
            OfflicalIDbuttonoutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            OnfarmIDbuttonoutlet.layer.backgroundColor = UIColor.white.cgColor
            OfflicalIDbuttonoutlet.setTitleColor(.white, for: .normal)
            OnfarmIDbuttonoutlet.setTitleColor(.black, for: .normal)
        }
        else{
            OnfarmIDbuttonoutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            OfflicalIDbuttonoutlet.layer.backgroundColor = UIColor.white.cgColor
            OnfarmIDbuttonoutlet.setTitleColor(.white, for: .normal)
            OfflicalIDbuttonoutlet.setTitleColor(.black, for: .normal)
        }
    }
    
    func bydefaultsortorder(){
        let checkid = UserDefaults.standard.value(forKey: keyValue.sortOrder.rawValue) as? Bool ?? false
        if checkid  == true{
            ascending.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            descending.layer.backgroundColor = UIColor.white.cgColor
            ascending.setTitleColor(.white, for: .normal)
            descending.setTitleColor(.black, for: .normal)
        }
        else{
            descending.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            ascending.layer.backgroundColor = UIColor.white.cgColor
            descending.setTitleColor(.white, for: .normal)
            ascending.setTitleColor(.black, for: .normal)
        }
    }
    
    func removeDup(arr: [String]) -> [String] {
        var temp = [String]()
        
        for i in arr {
            if !temp.contains(i) {
                temp.append(i)
            }
        }
        return temp
    }
    
    func removeDup1(arr: [DisplayModel?]) -> [DisplayModel?] {
        var temparray = [DisplayModel?]()
        var namesarray = [String]()
        for i in arr{
            if !namesarray.contains(i?.attrubuteName ?? ""){
                namesarray.append(i?.attrubuteName ?? "")
                temparray.append(DisplayModel(displayName: i?.displayName, attrubuteName: i?.attrubuteName))
            }
        }
        return temparray
    }
    
    func fetchTrailData(trailName:String,trailValue:String) {
        var displayNamesArray = [String]()
        var attributesarray = [String]()
        var fetchTraitObj = [ResultTraitHeader]()
        displayModelArray.removeAll()
        if (selectedProductName == LocalizedStrings.clarifideCDCB) && isHerditySelected {
            fetchTraitObj = fetchResultTraitIndex(entityName: Entities.resultTraitHeaderTblEntity, species: marketNameType.Dairy.rawValue, productName: LocalizedStrings.herdity) as! [ResultTraitHeader]
        } else {
            fetchTraitObj = fetchResultTraitIndex(entityName: Entities.resultTraitHeaderTblEntity, species: marketNameType.Dairy.rawValue, productName: selectedProductName ) as! [ResultTraitHeader]
        }
        
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i]
            let traitId = productName.traitId
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: selectedtabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            
            if resultHideIndex.count == 0 {
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                if isHerditySelected {
                    if let displayname = objFetch.attributeName {
                        displayModelArray.append(DisplayModel(displayName: objFetch.displayName ?? "", attrubuteName: displayname))
                    }
                } else {
                    if let displayname = objFetch.attributeName, objFetch.productName != LocalizedStrings.herdity {
                        displayModelArray.append(DisplayModel(displayName: objFetch.displayName ?? "", attrubuteName: displayname))
                    }
                }
                self.resultMasterGet.append(objFetch)
            }
        }
        let fliterarray = removeDup1(arr: displayModelArray)
        for i in fliterarray{
            attributesarray.append(i?.attrubuteName ?? "")
            displayNamesArray.append(i?.displayName ?? "")
        }
        
        if displayNamesArray.contains(trailName){
            if trailName == "" && selectedProviderName != LocalizedStrings.clarifideCDCB{
                UserDefaults.standard.set("", forKey: keyValue.traitName.rawValue)
                UserDefaults.standard.set("", forKey: keyValue.traitValue.rawValue)
                trailsindexbutton.setTitle(ButtonTitles.selectIndexText, for: .normal)
                traitisselected = false
            } else {
                traitisselected = true
                trailsindexbutton.setTitle(trailName, for: .normal)
                UserDefaults.standard.set(trailName, forKey: keyValue.traitName.rawValue)
                UserDefaults.standard.set(trailValue, forKey: keyValue.traitValue.rawValue)
            }
        }
        else {
            UserDefaults.standard.set("", forKey: keyValue.traitName.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.traitValue.rawValue)
            trailsindexbutton.setTitle(ButtonTitles.selectIndexText, for: .normal)
            traitisselected = false
        }
    }
    
    func getToDateFromDate() {
        if UserDefaults.standard.value(forKey: keyValue.fromdate.rawValue) as! String == "" {
            var dateFormatter = DateFormatter()
            dateFormatter = DateFormatter()
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            dateToBttn.setTitle(dateFormatter.string(from: Date()), for: .normal)
            let previousMonth = Calendar.current.date(byAdding: .month, value: -15, to: Date())
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
        else{
            let fromdateStr: String = UserDefaults.standard.value(forKey: keyValue.fromdate.rawValue) as! String
            let tovalueStr: String = UserDefaults.standard.value(forKey: keyValue.todate.rawValue) as! String
            var dateFormatter = DateFormatter()
            dateFormatter = DateFormatter()
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            let fromDate =  dateFormatter.date(from: fromdateStr)!
            let toDate = dateFormatter.date(from: tovalueStr)!
            dateToBttn.setTitle(dateFormatter.string(from: toDate), for: .normal)
            dateFromBttn.setTitle(dateFormatter.string(from: fromDate), for: .normal)
            dateFromBttn.titleLabel?.text = dateFormatter.string(from: fromDate)
            dateToBttn.titleLabel?.text = dateFormatter.string(from: toDate)
        }
    }
    
    static func printDatesBetweenInterval(_ startDate: Date, _ endDate: Date) {
        var startDate = startDate
        let calendar = Calendar.current
        let fmt = DateFormatter()
        fmt.dateFormat = DateFormatters.yyyyMMddFormat
        while startDate <= endDate {
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
    }
    
    func doFromDatePicker(){
        let langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
        if langId == 2{
            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        }
        else if langId == 3{
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else if langId == 3{
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else{
            self.datePicker?.locale = Locale(identifier: Languages.eng)
        }
        
        if UserDefaults.standard.value(forKey: keyValue.fromdate.rawValue) as! String == "" {
            
            self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
            self.datePicker?.backgroundColor = UIColor.white
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
            let langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
            if langId == 2{
                self.datePicker?.locale = Locale(identifier: Languages.portuguese)
            }
            else  if langId == 3{
                self.datePicker?.locale = Locale(identifier: Languages.italian)
            }
            else{
                self.datePicker?.locale = Locale(identifier: Languages.eng)
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
        
        else  if UserDefaults.standard.value(forKey: keyValue.checkDate.rawValue) as? String == keyValue.newKey.rawValue{
            self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
            self.datePicker?.backgroundColor = UIColor.white
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
        else{
            let resultFIlterDataSave =  fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID))
            if resultFIlterDataSave.count != 0 {
                let resultObject = resultFIlterDataSave.object(at: 0) as! ResultFIlterDataSave
                let todateget = resultObject.dateto ?? ""
                let fromdateget = resultObject.datefrom ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
                dateFormatter.timeZone = TimeZone.current
                dateFormatter.locale = Locale.current
                
                if fromdateget != ""{
                    fromDaten = dateFormatter.date(from: fromdateget)!
                }
                
                if todateget != ""{
                    ToDaten = dateFormatter.date(from: todateget)!
                }
                
                let fmt = DateFormatter()
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    fmt.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    fmt.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                let fromdatecheck = fmt.string(from: fromDaten)
                let todatecheck = fmt.string(from: ToDaten)
                
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
                } else {
                    dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
                }
                fromDaten = dateFormatter.date(from: fromdatecheck )!
                ToDaten = dateFormatter.date(from: todatecheck )!
            }
            
            self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
            self.datePicker?.backgroundColor = UIColor.white
            self.datePicker?.datePickerMode = UIDatePicker.Mode.date
            if BttnTag == 0{
                self.datePicker.setDate(fromDaten, animated: true)
            }
            else{
                self.datePicker.setDate(ToDaten, animated: true)
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
    }
    
    func byDefaultValueSet(){
        maleBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.maleText, comment: ""), for: .normal)
        femaleBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.femaleText, comment: ""), for: .normal)
        allBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.allText, comment: ""), for: .normal)
        let malevale = UserDefaults.standard.value(forKey: keyValue.savesex.rawValue) as? String
        if malevale  == "M"{
            maleBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
            allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
            maleBtnOutlet.setTitleColor(.white, for: .normal)
            femaleBtnOutlet.setTitleColor(.black, for: .normal)
            allBtnOutlet.setTitleColor(.black, for: .normal)
        }
        else if malevale == "A"{
            maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
            femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
            allBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            maleBtnOutlet.setTitleColor(.black, for: .normal)
            femaleBtnOutlet.setTitleColor(.black, for: .normal)
            allBtnOutlet.setTitleColor(.white, for: .normal)
        }
        else{
            UserDefaults.standard.setValue("F", forKey: keyValue.savesex.rawValue)
            maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
            femaleBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
            maleBtnOutlet.setTitleColor(.black, for: .normal)
            femaleBtnOutlet.setTitleColor(.white, for: .normal)
            allBtnOutlet.setTitleColor(.black, for: .normal)
        }
    }
    
    // MARK: - DATABSE UPDATION METHODS
    func updateProviderSelection() {
        var resultFIlterDataSave = [ResultFIlterDataSave]()
        switch selectedProviderID {
        case 1:
            resultFIlterDataSave =  fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: isHerditySelected, productID: selectedProviderID) as! [ResultFIlterDataSave]
            if (resultFIlterDataSave.count == 0) {
                if isHerditySelected {
                    let breedName = breedArray.joined(separator: ",")
                    UserDefaults.standard.set(breedName, forKey: keyValue.breedName.rawValue)
                    let breedId = breedIdArray.joined(separator: ",")
                    UserDefaults.standard.set(breedId, forKey: keyValue.resultBreedID.rawValue)
                } else {
                    if let breedname = UserDefaults.standard.object(forKey: keyValue.breedName.rawValue) as? String
                    {
                        let breeds = breedname.components(separatedBy: ",")
                        if breeds.count == 1{
                            let i = breedArray.firstIndex(where: {$0 == breedname })
                            delegate?.breedInfoUpdate(index: i ?? 0)
                            breedIndexPath = i ?? 0
                        } else {
                            delegate?.breedInfoUpdate(index: 0)
                            breedIndexPath = 0
                            UserDefaults.standard.set(breedArray[0], forKey: keyValue.breedName.rawValue)
                            UserDefaults.standard.set(breedIdArray[0], forKey: keyValue.resultBreedID.rawValue)
                        }
                        
                        let traitstring = UserDefaults.standard.value(forKey: keyValue.traitValue.rawValue) as? String ?? ""
                        let traidsave = UserDefaults.standard.value(forKey: keyValue.traitName.rawValue) as? String ?? ""
                        fetchTrailData(trailName: traidsave, trailValue: traitstring)
                    } else{
                        delegate?.breedInfoUpdate(index: 0)
                        breedIndexPath = 0
                        UserDefaults.standard.set(breedArray[0], forKey: keyValue.breedName.rawValue)
                        UserDefaults.standard.set(breedIdArray[0], forKey: keyValue.resultBreedID.rawValue)
                    }
                }
            }
            breedCollectionvIEW.reloadData()
            
        case 2,4,6,8,10,11,12:
            resultFIlterDataSave =  fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: false, productID: selectedProviderID) as! [ResultFIlterDataSave]
        case 3:
            resultFIlterDataSave =  fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: isHerditySelected, productID: selectedProviderID) as! [ResultFIlterDataSave]
            if resultFIlterDataSave.count == 0 {
                if isHerditySelected{
                    delegate?.breedInfoUpdate(index: 0)
                    breedIndexPath = 0
                    UserDefaults.standard.set(breedArray[0], forKey: keyValue.breedName.rawValue)
                    UserDefaults.standard.set(breedIdArray[0], forKey: keyValue.resultBreedID.rawValue)
                    let traitstring = UserDefaults.standard.value(forKey: keyValue.traitValue.rawValue) as? String ?? ""
                    let traidsave = UserDefaults.standard.value(forKey: keyValue.traitName.rawValue) as? String ?? ""
                    fetchTrailData(trailName: traidsave, trailValue: traitstring)
                } else{
                    if let breedname = UserDefaults.standard.object(forKey: keyValue.breedName.rawValue) as? String
                    {
                        let breeds = breedname.components(separatedBy: ",")
                        if breeds.count == 1{
                            let i = breedArray.firstIndex(where: {$0 == breedname })
                            delegate?.breedInfoUpdate(index: i ?? 0)
                            breedIndexPath = i ?? 0
                        } else {
                            delegate?.breedInfoUpdate(index: 0)
                            breedIndexPath = 0
                        }
                        
                        let traitstring = UserDefaults.standard.value(forKey: keyValue.traitValue.rawValue) as? String ?? ""
                        let traidsave = UserDefaults.standard.value(forKey: keyValue.traitName.rawValue) as? String ?? ""
                        fetchTrailData(trailName: traidsave, trailValue: traitstring)
                    } else{
                        delegate?.breedInfoUpdate(index: 0)
                        breedIndexPath = 0
                        UserDefaults.standard.set(breedArray[0], forKey: keyValue.breedName.rawValue)
                        UserDefaults.standard.set(breedIdArray[0], forKey: keyValue.resultBreedID.rawValue)
                    }
                }
            }
            breedCollectionvIEW.reloadData()
        default:
            resultFIlterDataSave =  fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: isHerditySelected, productID: selectedProviderID) as! [ResultFIlterDataSave]
        }
        
        if resultFIlterDataSave.count > 0 {
            let resultObject = resultFIlterDataSave[0]
            fetchTrailData(trailName: resultObject.traidsave ?? "", trailValue: resultObject.trait ?? "")
            if !resultObject.isHeriditySelected {
                let breedName: String = resultObject.breedName ?? ""
                let result = breedArray.contains(breedName)
                if !result {
                    UserDefaults.standard.set(breedArray[0], forKey: keyValue.breedName.rawValue)
                    UserDefaults.standard.set(breedIdArray[0], forKey: keyValue.resultBreedID.rawValue)
                    delegate?.breedInfoUpdate(index: 0)
                    breedIndexPath = 0
                }
                else {
                    UserDefaults.standard.set(resultObject.breedName, forKey: keyValue.breedName.rawValue)
                    UserDefaults.standard.set(resultObject.breedID, forKey: keyValue.resultBreedID.rawValue)
                }
            } else {
                UserDefaults.standard.set(resultObject.breedName, forKey: keyValue.breedName.rawValue)
                UserDefaults.standard.set(resultObject.breedID, forKey: keyValue.resultBreedID.rawValue)
            }
        } else {
            headerisselected = false
            traitisselected = false
            trailsindexbutton.setTitle(ButtonTitles.selectIndexText, for: .normal)
        }
        breedCollectionvIEW.reloadData()
    }
    
    func cleardataWithAvailableinDB (){
        let resultFIlterDataSave =  fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID))
        isHerditySelected = false
        genderRetain = "F"
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.white, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
        
        if resultFIlterDataSave.count > 0 {
            let resultObject = resultFIlterDataSave.object(at: 0) as! ResultFIlterDataSave
            let proiderIndex = resultObject.productIndex
            let selectedIndexPath = IndexPath(row: Int(proiderIndex), section: 0)
            providerCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .right)
            self.collectionView(self.providerCollectionView, didSelectItemAt: IndexPath(item: Int(proiderIndex), section: 0))
            self.collectionView(self.providerCollectionView, didDeselectItemAt: IndexPath(item: 1, section: 0))
            providerCollectionView.allowsMultipleSelection = false
            UserDefaults.standard.set(resultObject.breedName, forKey: keyValue.breedName.rawValue)
            UserDefaults.standard.set(resultObject.breedIndex, forKey: keyValue.resultBreedID.rawValue)
            breedCollectionvIEW.reloadData()
            breedCollectionvIEW.allowsMultipleSelection = false
            providerIndexPath = 0
            breedIndexPath = 0
            UserDefaults.standard.setValue("", forKey: keyValue.todate.rawValue)
            UserDefaults.standard.setValue("", forKey: keyValue.fromdate.rawValue)
            let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
            
            let dateToNw = dateToBttn.titleLabel?.text ?? ""
            
            var dateFormatter = DateFormatter()
            dateFormatter = DateFormatter()
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            dateToBttn.setTitle(dateFormatter.string(from: Date()), for: .normal)
            let previousMonth = Calendar.current.date(byAdding: .month, value: -15, to: Date())
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
            let breedindex = UserDefaults.standard.integer(forKey: keyValue.breedIndex.rawValue)
            UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
            let headerstring =  ""
            trailsindexbutton.setTitle(ButtonTitles.selectIndexText, for: .normal)
            traitisselected = false
            let traitstring = trailsindexbutton.titleLabel?.text ?? ""
            UserDefaults.standard.setValue(true, forKey: keyValue.sortOrder.rawValue)
            ascending.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            descending.layer.backgroundColor = UIColor.white.cgColor
            ascending.setTitleColor(.white, for: .normal)
            descending.setTitleColor(.black, for: .normal)
            OnfarmIDbuttonoutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            OfflicalIDbuttonoutlet.layer.backgroundColor = UIColor.white.cgColor
            OnfarmIDbuttonoutlet.setTitleColor(.white, for: .normal)
            OfflicalIDbuttonoutlet.setTitleColor(.black, for: .normal)
            delegate?.genderInfoUpdate(sex: genderRetain, providerIndexPath: providerIndexPath, breedIndexPath: breedindex, fromdatevalue: dateFromNw ,todatevalue: dateToNw,header: headerstring ,trait: traitstring )
            traitisselected = false
        }
    }
}

