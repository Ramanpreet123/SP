//
//  ADHFilterVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 10/06/22.
//

import UIKit
import DropDown

//MARK: ADH FILTER VC
class ADHFilterVC: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var clearFilterBtnOutlet: customButton!
    @IBOutlet weak var doneBtnFilterScreenOutlet: customButton!
    @IBOutlet weak var lblDaterangeTitle: UILabel!
    @IBOutlet weak var lblStartDateTitle: UILabel!
    @IBOutlet weak var lblEndDateTitle: UILabel!
    @IBOutlet weak var cancleBtnFilterScreenOutlet: customButton!
    @IBOutlet weak var lblGenderTitle: UILabel!
    @IBOutlet weak var lblBreedTitle: UILabel!
    @IBOutlet weak var maleBtnOutlet: customButton!
    @IBOutlet weak var femaleBtnOutlet: customButton!
    @IBOutlet weak var allBtnOutlet: customButton!
    @IBOutlet weak var btnCancelFilter: UIButton!
    @IBOutlet weak var btnClearFilter: UIButton!
    @IBOutlet weak var btnDoneFilter: UIButton!
    @IBOutlet weak var filterBackroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var innerview: UIView!
    @IBOutlet weak var scroolingview: UIScrollView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var dateToBttn: UIButton!
    @IBOutlet weak var dateFromBttn: UIButton!
    @IBOutlet weak var breedCollectionvIEW: UICollectionView!
    
    //MARK: VARIABLES AND CONSTANTS
    var value = 0
    var buttonbg = UIButton()
    var selectedBreed = String()
    var datefromstring = String()
    let tofromstring = String()
    var  newfromDaten = Date()
    var newToDaten = Date()
    var myHerdArray1 = [ResultMyHerdData]()
    var group = DispatchGroup()
    weak var delegate: filterInfoUpdate?
    var adhFilterDelegate: ADHFilterProtocol?
    var breedIndexPath = 0
    var providerIndexPath = 0
    var genderRetain = String()
    var breedID = String()
    var displayModelArray = [DisplayModel]()
    var headerisselected : Bool? = false
    var traitisselected : Bool? = false
    var dropDown = DropDown()
    var dropDown1 = DropDown()
    var fromDate = Date()
    var toDateClass = Date()
    var fromDaten = Date()
    var toDaten = Date()
    var tempArray = Bool()
    var nav = String()
    var customeridsave = Int64()
    let buttonbg2 = UIButton ()
    let buttonbgAutoSuggestion = UIButton ()
    let labletbale = UILabel()
    var droperTableView  = UITableView ()
    var productArray = [String]()
    var breedArray = [String]()
    var breedIDArray = [String]()
    var bttnTagClass = Int()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var dateFrom = String()
    var dateTo = String()
    let dateFormatter3 = DateFormatter()
    var custmerID = Int64()
    var  selectedDatefrom = String()
    var  selectedDateto = String()
    var resultMasterGet = [ResultMasterTemplate]()
    var userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
    var selectedtabTitles = String()
    var fromDateDateFormat: Date = Date()
    var toDateDateFormat: Date = Date()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        byDefaultValueSet()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //MARK: IB ACTIONS
    @IBAction func maleBtnAction(_ sender: Any){
        genderRetain = "M"
        UserDefaults.standard.setValue("M", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
        femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.white, for: .normal)
        femaleBtnOutlet.setTitleColor(.black, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func femaleBtnAction(_ sender: Any) {
        genderRetain = "F"
        UserDefaults.standard.setValue("F", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.white, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func allBtnACTION(_ sender: Any) {
        genderRetain = "A"
        UserDefaults.standard.setValue("A", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        allBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.black, for: .normal)
        allBtnOutlet.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func clearFilterBtnAction(_ sender: Any) {
        removeAppliedFilters()
    }
    
    @IBAction func cancleBtnFilterScreenAction(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnFilterScreenAction(_ sender: Any) {
        let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
        UserDefaults.standard.setValue(dateFromNw, forKey: keyValue.from_date_adh.rawValue)
        let dateToNw = dateToBttn.titleLabel?.text ?? ""
        UserDefaults.standard.setValue(dateToNw, forKey: keyValue.to_date_adh.rawValue)
        let dateToVariable = dateToBttn.titleLabel?.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  NSLocale(localeIdentifier: "nl_NL" ) as Locale
        UserDefaults.standard.set(breedIndexPath, forKey: keyValue.breedindexADH.rawValue)
        UserDefaults.standard.setValue(dateFromNw, forKey: keyValue.from_date_adh.rawValue)
        UserDefaults.standard.setValue(dateToVariable, forKey: keyValue.to_date_adh.rawValue)
        UserDefaults.standard.setValue(genderRetain, forKey: keyValue.savesex.rawValue)
        UserDefaults.standard.synchronize()
        let filterBreedID = breedIDArray[UserDefaults.standard.integer(forKey: keyValue.breedindexADH.rawValue)]
        self.dismiss(animated: true) {
            self.adhFilterDelegate?.applyFilterData(fromDate: dateFromNw, toDate: dateToVariable, gender: self.genderRetain, breed: filterBreedID)
        }
        UserDefaults.standard.set(true, forKey: keyValue.ADHFilterApplied.rawValue)
    }
    
    @IBAction func fromDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calendarViewBkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        bttnTagClass =  0
        doFromDatePicker()
    }
    
    @IBAction func toDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calendarViewBkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        bttnTagClass =  1
        doFromDatePicker()
    }
    
    //MARK: METHODS AND FUNCTIONS
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
    
    func getToDateFromDate() {
        if UserDefaults.standard.value(forKey: keyValue.from_date_adh.rawValue) as? String == "" {
            var dateFormatter = DateFormatter()
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
            toDateClass = dateFormatter.date(from: currentDates)!
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
    
    func removeAppliedFilters() {
        genderRetain = "F"
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.white, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
        
        if breedArray.count > 0 {
            breedID = UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String ?? ""
            let index = breedIDArray.indexes(of: breedID)
            let selectIndexBreedCollection = IndexPath(row: index.first ?? 0, section: 0)
            breedCollectionvIEW.selectItem(at: selectIndexBreedCollection, animated: true, scrollPosition: .right)
            self.collectionView(self.breedCollectionvIEW, didSelectItemAt: IndexPath(item: index.first ?? 0, section: 0))
            self.collectionView(self.breedCollectionvIEW, didDeselectItemAt: IndexPath(item: 1, section: 0))
        }
        
        breedCollectionvIEW.allowsMultipleSelection = false
        providerIndexPath = 0
        var dateFormatter = DateFormatter()
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
        toDateClass = dateFormatter.date(from: currentDates)!
        UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
        traitisselected = false
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
    
    func callfromAPIfliters() {
        self.filterBackroundView.isHidden = true
        self.filterView.isHidden = true
        self.innerview.isHidden = true
        self.scroolingview.isHidden = true
        self.dismiss(animated: false) {
            self.delegate?.reloaddata()
        }
    }
    
    func doFromDatePicker() {
        // 1. Locale setup
        configureDatePickerLocale()

        // 2. Case: No fromDate set
        if let fromDateStr = UserDefaults.standard.string(forKey: keyValue.fromdate.rawValue),
           fromDateStr.isEmpty {
            setupDatePicker(defaultDate: bttnTagClass == 0 ? fromDate : toDateClass)
        }
        
        // 3. Case: CheckDate == newKey
        else if UserDefaults.standard.string(forKey: keyValue.checkDate.rawValue) == keyValue.newKey.rawValue {
            setupDatePicker(defaultDate: bttnTagClass == 0 ? fromDate : toDateClass)
        }
        
        // 4. Case: Fallback – fetch saved filter data
        else {
            let defaultDate = resolveSavedFilterDates()
            setupDatePicker(defaultDate: bttnTagClass == 0 ? defaultDate.from : defaultDate.to)
        }
    }
    
    private func configureDatePickerLocale() {
        let langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
        switch langId {
        case 2: self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        case 3: self.datePicker?.locale = Locale(identifier: Languages.italian)
        default: self.datePicker?.locale = Locale(identifier: Languages.eng)
        }
    }

    private func setupDatePicker(defaultDate: Date) {
        self.datePicker = UIDatePicker(
            frame: CGRect(x: 20, y: 40, width: calenderView.frame.size.width, height: 260)
        )
        self.datePicker?.backgroundColor = .white
        self.datePicker?.datePickerMode = .date
        self.datePicker?.setDate(defaultDate, animated: true)
        if #available(iOS 14, *) {
            self.datePicker?.preferredDatePickerStyle = .wheels
        }
        self.datePicker?.maximumDate = Date()
        
        setupToolbar()
        
        calenderView.backgroundColor = .white
        calenderView.addSubview(self.datePicker!)
        calenderView.addSubview(toolBar)
        toolBar.isHidden = false
    }

    private func setupToolbar() {
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: LocalizedStrings.doneStr.localized,
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized,
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelClick))
        cancelButton.tintColor = .black
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: calenderView.frame.size.width, height: 40)
    }

    private func resolveSavedFilterDates() -> (from: Date, to: Date) {
        var fromDate = Date()
        var toDate = Date()
        
        // Safely cast NSArray to [ResultFIlterDataSave]
        if let resultFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,
                                                        customerId: Int(custmerID)) as? [ResultFIlterDataSave],
           let resultObject = resultFilterData.first {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
            dateFormatter.timeZone = .current
            dateFormatter.locale = .current
            
            if let fromStr = resultObject.datefrom, !fromStr.isEmpty {
                fromDate = dateFormatter.date(from: fromStr) ?? fromDate
            }
            if let toStr = resultObject.dateto, !toStr.isEmpty {
                toDate = dateFormatter.date(from: toStr) ?? toDate
            }
            
            let fmt = DateFormatter()
            fmt.dateFormat = DateFormatters.MMddyyyyFormat
            let fromCheck = fmt.string(from: fromDate)
            let toCheck = fmt.string(from: toDate)
            
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM" {
                dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
            } else {
                dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
            }
            
            fromDate = dateFormatter.date(from: fromCheck) ?? fromDate
            toDate = dateFormatter.date(from: toCheck) ?? toDate
        }
        
        return (fromDate, toDate)
    }
    
    func byDefaultValueSet(){
        if !UserDefaults.standard.bool(forKey: keyValue.ADHFilterApplied.rawValue){
            removeAppliedFilters()
        } else {
            maleBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.maleText, comment: ""), for: .normal)
            femaleBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.femaleText, comment: ""), for: .normal)
            allBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.allText, comment: ""), for: .normal)
            genderRetain = UserDefaults.standard.value(forKey: keyValue.savesex.rawValue) as? String ?? "F"
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
            
            if let fromDate = UserDefaults.standard.value(forKey: keyValue.from_date_adh.rawValue) as? String {
                self.dateFromBttn.setTitle(fromDate, for: .normal)
            }
            
            if let toDate = UserDefaults.standard.value(forKey: keyValue.to_date_adh.rawValue) as? String {
                self.dateToBttn.setTitle(toDate, for: .normal)
            }
        }
    }
}

