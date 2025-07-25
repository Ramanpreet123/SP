//
//  ADHFilteriPadVC.swift
//  SearchPoint
//
//  Created by Rajni on 08/04/25.
//

import Foundation
import UIKit


class ADHFilteriPadVC: UIViewController{
    
    //MARK: IB OUTLETS
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var clearFilterBtnOutlet: customButton!
    @IBOutlet weak var doneBtnFilterScreenOutlet: customButton!
    @IBOutlet weak var lblDaterangeTitle: UILabel!
    //@IBOutlet weak var lblStartDateTitle: UILabel!
   // @IBOutlet weak var lblEndDateTitle: UILabel!
    @IBOutlet weak var CancleBtnFilterScreenOutlet: customButton!
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
    var breedArray = [String]()
    var breedIDArray = [String]()
    var BttnTag = Int()
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
            let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
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
        maleBtnOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
        allBtnOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
        maleBtnOutlet.backgroundColor = UIColor.white
        femaleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        femaleBtnOutlet.layer.borderWidth = 0.0
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.white, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
        maleBtnOutlet.layer.borderWidth = 2.0
        allBtnOutlet.layer.borderWidth = 2.0
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
        let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
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
        UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
        traitisselected = false
    }
    
    
    func navigateTosaveanimal(){
        self.filterBackroundView.isHidden = true
        self.filterView.isHidden = true
        self.innerview.isHidden = true
       // self.scroolingview.isHidden = true
        self.view.isUserInteractionEnabled = true
        self.dismiss(animated: false) {
            self.delegate?.Reloaddata()
        }
    }
    
    func callfromAPIfliters() {
        self.filterBackroundView.isHidden = true
        self.filterView.isHidden = true
        self.innerview.isHidden = true
       // self.scroolingview.isHidden = true
        self.dismiss(animated: false) {
            self.delegate?.Reloaddata()
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
            else if langId == 3{
                self.datePicker?.locale = Locale(identifier: Languages.italian)
            }
            else{
                self.datePicker?.locale = Locale(identifier: Languages.eng)
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
        else  if UserDefaults.standard.value(forKey: keyValue.checkDate.rawValue) as! String == keyValue.newKey.rawValue{
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
                fmt.dateFormat = DateFormatters.MMddyyyyFormat
                let fromdatecheck = fmt.string(from: fromDaten)
                let todatecheck = fmt.string(from: ToDaten)
                
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
                }
                else {
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
    }
    
    func byDefaultValueSet(){
        if UserDefaults.standard.bool(forKey: keyValue.ADHFilterApplied.rawValue)  == false{
            removeAppliedFilters()
        } else {
            maleBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.maleText, comment: ""), for: .normal)
            femaleBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.femaleText, comment: ""), for: .normal)
            allBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.allText, comment: ""), for: .normal)
            genderRetain = UserDefaults.standard.value(forKey: keyValue.savesex.rawValue) as? String ?? "F"
            let malevale = UserDefaults.standard.value(forKey: keyValue.savesex.rawValue) as? String
            
            if malevale  == "M"{
                maleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
                maleBtnOutlet.layer.borderWidth = 0.0
                femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
                allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
                maleBtnOutlet.setTitleColor(.white, for: .normal)
                femaleBtnOutlet.setTitleColor(.black, for: .normal)
                allBtnOutlet.setTitleColor(.black, for: .normal)
            }
            else if malevale == "A"{
                maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
                femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
                allBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
                allBtnOutlet.layer.borderWidth = 0.0
                maleBtnOutlet.setTitleColor(.black, for: .normal)
                femaleBtnOutlet.setTitleColor(.black, for: .normal)
                allBtnOutlet.setTitleColor(.white, for: .normal)
            }
            else{
                UserDefaults.standard.setValue("F", forKey: keyValue.savesex.rawValue)
                maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
                femaleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
                femaleBtnOutlet.layer.borderWidth = 0.0
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
    
    //MARK: IB ACTIONS
    @IBAction func maleBtnAction(_ sender: Any){
        genderRetain = "M"
        UserDefaults.standard.setValue("M", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        maleBtnOutlet.layer.borderWidth = 0.0
        femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.layer.borderWidth = 2.0
        allBtnOutlet.layer.borderWidth = 2.0
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.white, for: .normal)
        femaleBtnOutlet.setTitleColor(.black, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func femaleBtnAction(_ sender: Any) {
        genderRetain = "F"
        UserDefaults.standard.setValue("F", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        femaleBtnOutlet.layer.borderWidth = 0.0
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        maleBtnOutlet.layer.borderWidth = 2.0
        allBtnOutlet.layer.borderWidth = 2.0
        femaleBtnOutlet.setTitleColor(.white, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func allBtnACTION(_ sender: Any) {
        genderRetain = "A"
        UserDefaults.standard.setValue("A", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        allBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        allBtnOutlet.layer.borderWidth = 0.0
        femaleBtnOutlet.layer.borderWidth = 2.0
        maleBtnOutlet.layer.borderWidth = 2.0
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.black, for: .normal)
        allBtnOutlet.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func clearFilterBtnAction(_ sender: Any) {
        removeAppliedFilters()
    }
    
    @IBAction func CancleBtnFilterScreenAction(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnFilterScreenAction(_ sender: Any) {
        let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
        UserDefaults.standard.setValue(dateFromNw, forKey: keyValue.from_date_adh.rawValue)
        let dateToNw = dateToBttn.titleLabel?.text ?? ""
        UserDefaults.standard.setValue(dateToNw, forKey: keyValue.to_date_adh.rawValue)
        let dateTo = dateToBttn.titleLabel?.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  NSLocale(localeIdentifier: "nl_NL" ) as Locale
        UserDefaults.standard.set(breedIndexPath, forKey: keyValue.breedindexADH.rawValue)
        UserDefaults.standard.setValue(dateFromNw, forKey: keyValue.from_date_adh.rawValue)
        UserDefaults.standard.setValue(dateTo, forKey: keyValue.to_date_adh.rawValue)
        UserDefaults.standard.setValue(genderRetain, forKey: keyValue.savesex.rawValue)
        UserDefaults.standard.synchronize()
        let filterBreedID = breedIDArray[UserDefaults.standard.integer(forKey: keyValue.breedindexADH.rawValue)]
        self.dismiss(animated: true) {
            self.adhFilterDelegate?.applyFilterData(fromDate: dateFromNw, toDate: dateTo, gender: self.genderRetain, breed: filterBreedID)
        }
        UserDefaults.standard.set(true, forKey: keyValue.ADHFilterApplied.rawValue)
    }
    
    @IBAction func fromDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calendarViewBkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        BttnTag =  0
        doFromDatePicker()
    }
    
    @IBAction func toDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calendarViewBkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        BttnTag =  1
        doFromDatePicker()
    }
}
