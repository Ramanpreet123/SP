//
//  MyHerdResultByAnimalVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 08/05/25.
//

import Foundation
import UIKit
import Vision
import VisionKit
import CoreBluetooth
import Alamofire
import MBProgressHUD
import CoreData
import Toast_Swift
import IQKeyboardManagerSwift

//MARK: CLASS
class MyHerdResultByAnimalVCiPad: UIViewController,swipeCell,VNDocumentCameraViewControllerDelegate{
    
    //MARK: OUTLETS
    @IBOutlet weak var bleImgView: UIImageView!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var officialIDImgView: UIImageView!
    @IBOutlet weak var earTagImgView: UIImageView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var totalAnimalCount: UILabel!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var screenTitleLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var headerstackview: UIStackView!
    @IBOutlet weak var pairedBackroundView: UIView!
    @IBOutlet weak var pairedDeviceTitle: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var officalIdLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var blebttn1: UIButton!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var searchByEartagLabel: UILabel!
    @IBOutlet weak var searchByOfficialIdLabel: UILabel!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var pairedTableView: UITableView!
    @IBOutlet weak var pairedDeviceView: UIView!
    @IBOutlet weak var breedFilterBtnOutlet: customButton!
    @IBOutlet weak var dateFilterBtnOutlet: customButton!
    @IBOutlet weak var sexFilterBtnOutlet: customButton!
    @IBOutlet weak var rfidBtnOutlet: customButton!
    @IBOutlet weak var deleteAnimalStackView: UIStackView!
    @IBOutlet weak var deletAnimalHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectAllBtnOutlet: UIButton!
    @IBOutlet weak var DeleteAnimalBtnOutlet: UIButton!
  @IBOutlet weak var autoSuggestTableView: UITableView!
    
    //MARK: VARIABLES AND CONSTANTS
    var group = DispatchGroup()
    var copyarray = NSArray()
    var rankid = String()
    var rankidnms = String()
    var yourarray = [String : Any]()
    var myFilterController : MyHerdFilterController?
    var saveResulyByPageViewModel: ResulyByPageViewModel?
    var dasboard :  DashboardVC?
    var fromDaten = Date()
    var ToDaten = Date()
    let searchTypebyearTagStr = "EAR_TAG"
    let searchTypeByOfficialIDStr = "OFFICIAL_ID"
    var sexname : String!
    var tempArray = Bool()
    var searchType  =  String()
    var productArray = [String]()
    var providerarray = [Int]()
    var breedArray = [String]()
    var breedIDArray = [String]()
    var breedName = String()
    var breedID = String()
    var productName = String()
    var providerID = Int()
    var checkid = String()
    var scannedString = String()
    var BttnTag = Int()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var dateFrom = String()
    var dateTo = String()
    var fromdatecheck = String()
    var currentdate = String()
    var  todatecheck = String()
    let dateFormatter3 = DateFormatter()
    var searchByEarTag =  Bool()
    var bckRetain = Bool()
    var resultMasterGet = [ResultMasterTemplate]()
    let error_officialID_countCheck = "Please enter a valid 17 character Official ID".localized
    let error_eartag_countCheck = "Please enter at least 3 characters.".localized
    let error_blankfield = "This field cannot be empty.".localized
    var selectedbreedID = String()
    var saveAnimalGroupUpdatedViewModel: AnimalGroupsForCustomerUpdateVM?
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var myTableView: UITableView!
    var datasource = [callSwipeStruct]()
    var myHerdArray = [ResultMyHerdData]()
    var selectedMyHerdArray = ResultMyHerdData()
    var searchHerdArray = [ResultMyHerdData]()
    var tableCellSelected = Bool()
    var selectedIndex = Int()
    var customerId:Int64?
    var userId : Int?
    var langId : Int?
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    private let textRecognitionWorkQueue = DispatchQueue(label: "MyVisionScannerQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    var fetchFilterData = NSArray()
    var fetchTempObj1new = NSArray()
    let ACCEPTABLE_CHARACTERS = LocalizedStrings.alphaNumericFormat
    var value = 0
    var ranktitle : String?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var selectAllSelected =  Bool()
    var doneBtnClicked =  Bool()
   var AutoSuggestionTableView  = UITableView ()
   lazy var viewModel: AutoAnimalViewModel  = {
     let obj = AutoAnimalViewModel.init()
      return obj
     }()
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            pairedTableView?.reloadData()
        }
    }
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                searchTextField.text = qrData?.codeString
                
            }else {
                
            }
        } willSet {
        }
    }
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUIOnDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUIOnWillAppear()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setUIOnDidAppear()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.scannedString = ""
        UserDefaults.standard.setValue(searchByEarTag, forKey: keyValue.searchByEarTagAnimal.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.fromManagement.rawValue)
        updateResultSearchByAnimal(entity: Entities.resultByAnimalTblEntity, customerID: customerId ?? 0, searchbyEarTag: searchByEarTag)
        
    }
    
    //MARK: INITIAL UI METHODS
    func setInitialUIOnDidLoad(){
        datasource.removeAll()
        UserDefaults.standard.set(0, forKey: keyValue.breedIndex.rawValue)
        langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
        self.customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        self.userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        self.navigationController?.navigationBar.isHidden = true
        self.calenderView.isHidden = true
        self.calendarViewBkg.isHidden = true
        pairedDeviceView.isHidden = true
        pairedBackroundView.isHidden = true
        initialNetworkCheck()
        searchTextField.autocorrectionType = .yes
        searchTextField.enablesReturnKeyAutomatically = false
        setlanguage()
        setLongPressGestureforTableCell()
        deletAnimalHeightConstraint.constant = 0
        
    }
    
    func setUIOnWillAppear(){
      viewModel.fetchAnimalList()
        let animalArray = fetchAllSearchByAnimal(entityName: Entities.resultByAnimalTblEntity, customerId: UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0) as! [ResultbyAnimal]
        if animalArray.count > 0{
            searchByEarTag = animalArray[0].searchbyEarTag
        }
        else {
            saveResultbysearchAnimalData(customerID: customerId ?? 0, searchbyEarTag: true)
            searchByEarTag = true
        }
        UserDefaults.standard.setValue(searchByEarTag, forKey: keyValue.searchByEarTagAnimal.rawValue)
        searchTextField.text =  self.scannedString
        searchTextField.iq.toolbar.doneBarButton.setTarget(self, action: #selector(searchButtonAction(_:)))
     //   searchTextField.leftViewMode = .always
    //    searchTextField.radiusOfCorner = 15
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchDidChange(sender:)), for: .editingChanged)
     //   searchTextField.layer.borderColor = UIColor.lightGray.cgColor
     //   searchTextField.layer.borderWidth = 0.5
        let view  = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 14, height: 14))
        let image = UIImage(named: ImageNames.searchIconImg)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
     //   searchTextField.leftView = view
        searchTextField.setLeftPaddingPoints(20.0)
      autoSuggestTableView.isHidden = true
        if searchByEarTag {
          //  toggleBtn.setImage(UIImage(named: ImageNames.toggleLeftImg), for: .normal)
           // self.setTextfield(textLabel: searchByEartagLabel, color: .black, textFont: UIFont.boldSystemFont(ofSize: 12))
        //    self.setTextfield(textLabel: searchByOfficialIdLabel, color: .lightGray, textFont: UIFont.systemFont(ofSize: 12))
          searchTextField.keyboardType = .default
            earTagImgView.image = UIImage(named: "resultsRadioSelectedImg")
            officialIDImgView.image = UIImage(named: "resultsRadioNonSelectedImg")
            tablereload()
        } else {
         //   toggleBtn.setImage(UIImage(named: ImageNames.toggleRightImg), for: .normal)
           // self.setTextfield(textLabel: searchByEartagLabel, color: .lightGray, textFont: UIFont.systemFont(ofSize: 12))
        //    self.setTextfield(textLabel: searchByOfficialIdLabel, color: .black, textFont: UIFont.boldSystemFont(ofSize: 12))
          searchTextField.keyboardType = .default
            earTagImgView.image = UIImage(named: "resultsRadioNonSelectedImg")
            officialIDImgView.image = UIImage(named: "resultsRadioSelectedImg")
            tablereload()
        }
    }
    
    func setUIOnDidAppear(){
        UserDefaults.standard.set("", forKey: keyValue.groupDetails.rawValue)
        hideIndicator()
        hideIndicator()
        myHerdArray  = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        myHerdArray =  myHerdArray.sorted(by: {$0.currentDateTime  > $1.currentDateTime })
        if myHerdArray.count == 0{
            hideIndicator()
            hideIndicator()
        } else {
            tablereload()
        }
        
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        if myHerdArray.count > 20 {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: 20)
        } else {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        }
        
        if myHerdArray.count == 0{
            message.isHidden = false
         //   tblView.isHidden = true
          //  headerview.isHidden = true
            resultCollectionView.isHidden = true
        }
        if myHerdArray.count != 0 {
            message.isHidden = true
//            tblView.isHidden = false
//            headerview.isHidden = false
            resultCollectionView.isHidden = false
            datasource.removeAll()
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        screenTitleLbl.text = ButtonTitles.myHerdResultText.localized
       // bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
       // officalIdLabel.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
     //   groupLabel.text = ButtonTitles.groupText.localized
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
        //    blebttn1.setBackgroundImage(UIImage(named: "resultsOCRImage"), for: .normal)
            bleImgView.image = UIImage(named: "resultsOCRImage")
        } else {
            if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
                bleImgView.image = UIImage(named: "resultRFIDicon")
             //   blebttn1.setBackgroundImage(UIImage(named: "resultRFIDicon"), for: .normal)
            } else {
                bleImgView.image = UIImage(named: "resultRFIDicon")
            //    blebttn1.setBackgroundImage(UIImage(named: "resultRFIDicon"), for: .normal)
            }
        }
        BluetoothCentre.shared.navController = self
        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        BluetoothCentre.shared.delegateRFID  = self
        BluetoothCentre.shared.nearByDeviceDelegate  = self
        
        datasource.removeAll()
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        if myHerdArray.count != 0 {
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
//        tblView.reloadData()
//        tblView.delegate = self
//        tblView.dataSource = self
        
        resultCollectionView.reloadData()
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
    }
    
    func setlanguage(){
        searchTextField.placeholder = ButtonTitles.searchText.localized
      //  searchByEartagLabel.text = ButtonTitles.searchByTag.localized
      //  searchByOfficialIdLabel.text = ButtonTitles.searchByOfficialId.localized
      //  breedFilterBtnOutlet.setTitle(ButtonTitles.recentlySearchedText.localized, for: .normal)
    }
    
    func setLongPressGestureforTableCell(){
      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
       //  tblView.addGestureRecognizer(longPress)
        self.resultCollectionView.addGestureRecognizer(longPress)
    }
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
      if sender.state == .began {
          let touchPoint = sender.location(in: resultCollectionView)
//          let indexpath = self.resultCollectionView.indexPathForItem(at: touchPoint)
//          let tblindex = self.tblView.index
          if let indexPath = self.resultCollectionView.indexPathForItem(at: touchPoint) {
              let cell = self.resultCollectionView.cellForItem(at: indexPath) as! MyHerdCollectionViewCelliPad
          let animal = myHerdArray[indexPath.row]
          if animal.selectedAnimal == false{
            updateAnimalSelectedDataResult(entity: "ResultMyHerdData", animalID: animal.animalID ?? "", customerId: Int(animal.customerId), searchbyanimal: true, selectedAnimal: true)
          //  cell.selectedBackroundView.isHidden = false
            //  cell.layer.borderColor = UIColor(red: 246/255, green: 92/255, blue: 6/255, alpha: 1.0).cgColor
//              cell.layer.cornerRadius = 15
//              cell.contentView.layer.cornerRadius = 15
//              cell.contentView.clipsToBounds = true
//              cell.layer.shadowColor = UIColor(red: 246/255, green: 92/255, blue: 6/255, alpha: 1.0).cgColor
//              cell.layer.shadowOffset = CGSize(width: 0, height: 1)
//              cell.layer.shadowOpacity = 0.7
//              cell.layer.shadowRadius = 6
//              cell.layer.masksToBounds = false
              cell.contentView.layer.borderWidth = 2.0
              cell.contentView.layer.borderColor = UIColor(red: 246/255, green: 92/255, blue: 0/255, alpha: 1.0).cgColor
            checkSelectedCell()
          }else {
            // if selected view count ==0 the hide the delete animal view
            updateAnimalSelectedDataResult(entity: "ResultMyHerdData", animalID: animal.animalID ?? "", customerId: Int(animal.customerId), searchbyanimal: true, selectedAnimal: false)
         //   cell.selectedBackroundView.isHidden = true
//              cell.layer.cornerRadius = 15
//              cell.contentView.layer.cornerRadius = 15
//              cell.contentView.clipsToBounds = true
//              cell.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
//              cell.layer.shadowOffset = CGSize(width: 0, height: 1)
//              cell.layer.shadowOpacity = 0.7
//              cell.layer.shadowRadius = 6
//              cell.layer.masksToBounds = false
              cell.contentView.layer.borderWidth = 0
              cell.contentView.layer.borderColor = UIColor.clear.cgColor
            myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
            let filterHerdanimal = myHerdArray.filter({$0.selectedAnimal == true })
            if filterHerdanimal.count == 0 {
              
              deleteAnimalStackView.isHidden = true
              deletAnimalHeightConstraint.constant = 0
                collectionViewTopConstraint.constant = 83
            } else {
              checkSelectedCell()
            }
            
            
          }
        }
      }
    }
    // MARK: show Delete view
    func checkSelectedCell(){
      myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
      let filterHerdanimal = myHerdArray.filter({$0.selectedAnimal == true })
      if filterHerdanimal.count>0 {
        if filterHerdanimal.count == myHerdArray.count{
          selectAllSelected = true
          selectAllBtnOutlet.setImage(UIImage.init(named: "incrementalCheckIpad"), for: .normal)
        } else{
          selectAllSelected = false
          selectAllBtnOutlet.setImage(UIImage.init(named: ImageNames.unCheckImg), for: .normal)
        }
        deleteAnimalStackView.isHidden = false
        deletAnimalHeightConstraint.constant = 60
          collectionViewTopConstraint.constant = 143
      } else {
        deleteAnimalStackView.isHidden = true
        deletAnimalHeightConstraint.constant = 0
          collectionViewTopConstraint.constant = 83
          self.resultCollectionView.reloadData()
      }
        
    }

    
    func callResultbyAnimalApi(){
        searchTextField.resignFirstResponder()
        showIndicator(self.view, withTitle: NSLocalizedString("Searching...", comment: ""), and: "")
        self.view.isUserInteractionEnabled = false
        saveResulyByPageViewModel = ResulyByPageViewModel(callBack: resultcallbackaction)
        saveResulyByPageViewModel?.delegate = self
        if searchByEarTag{
            for value in viewModel.filterAutoAnimalData {
                if value.earTag != searchTextField.text?.lowercased() {
                    viewModel.filterAutoAnimalData.removeAll()
                }
            }
            saveResulyByPageViewModel?.callResultByAnimalApi(searchText: searchTextField.text ?? "", searchType: searchTypebyearTagStr)
        } else {
            saveResulyByPageViewModel?.callResultByAnimalApi(searchText: searchTextField.text ?? "", searchType: searchTypeByOfficialIDStr)
        }
    }
    
    func resultcallbackaction(){
        self.view.isUserInteractionEnabled = true
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        hideIndicator()
        let dataArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        if searchByEarTag {
            searchHerdArray = dataArray.filter{$0.onFarmID == searchTextField.text}
        } else {
            searchHerdArray = dataArray.filter{$0.officialID == searchTextField.text}
        }
       
        if searchHerdArray.count > 1{
            selectedMyHerdArray = searchHerdArray.first!
            searchTextField.text = ""
            CommonClass.showAlertMessage(self, titleStr: AlertMessagesStrings.alertString, messageStr: AlertMessagesStrings.foundMultipleResultsForEarTag.localized)
            tablereload()
        }else if searchHerdArray.count != 0 {
            selectedMyHerdArray = searchHerdArray.first!
            let myArraynew = self.searchHerdArray[0]
            self.GetProviderName(animalID: myArraynew.animalID ?? "", onfarmID: myArraynew.onFarmID ?? "", officialID: myArraynew.officialID ?? "", customerId: myArraynew.customerId)
        }
    }
    
    func removeAnimalInGroup(groupId:String,animalIds: String, completionHandler: @escaping  CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        
        let urlString = Configuration.Dev(packet: ApiKeys.removeAnimalsGroup.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.groupId.rawValue: groupId,"animalIds":[animalIds]]
        
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case .success(_):
                    return completionHandler(true)
                    
                case let .failure(error):
                    print(error)
                }
                
            } else {
            }
        }
        return
    }
    
    
    func getToDateFromDate() {
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        
        let toDateBttn = dateFormatter.string(from: Date())
        let previousMonth = Calendar.current.date(byAdding: .month, value: -15, to: Date())
        let fromDateBttn = dateFormatter.string(from: previousMonth!)
        let showDate = fromDateBttn + " - " + toDateBttn
        dateFilterBtnOutlet.setTitle(showDate, for: .normal)
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
    }
    
    func breednameset(){
        customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        let fetchFilterData = fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0),isheridity: UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue), productID: providerID)
        for items in fetchFilterData{
            let newfetch = items as? ResultFIlterDataSave
            if (newfetch?.breedName?.components(separatedBy: ",").count ?? 0) > 1{
                breedFilterBtnOutlet.setTitle(ButtonTitles.recentlySearchedText.localized, for: .normal)
            }else{
                breedFilterBtnOutlet.setTitle(newfetch?.breedName, for: .normal)
            }
        }
    }
    
    func dissmissbackcall(){
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    func swipeLeft(index: Int) {
        let cell : MyHerdTblCell = self.tblView.cellForRow(at: IndexPath(row: index, section: 0)) as! MyHerdTblCell
        let dataObject = self.myHerdArray[index]
        let animalId = dataObject.animalID ?? ""
        let status = dataObject.status ?? ""
        let onfarmid = dataObject.onFarmID ?? ""
        let officialID = dataObject.officialID ?? ""
        
        let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: Int64(customerId ?? 0))
        if fetchActiveBarnExist.count == 0  {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
            return
        }
        else {
            let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
            let groupServerId = fetchObject.groupServerId ?? ""
            if status == LocalizedStrings.banStatus  {
                self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                removeAnimalInGroup(groupId: fetchObject.groupServerId ?? "", animalIds: animalId, completionHandler: { (result) in
                    if result == true{
                        _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:fetchObject.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: dataObject.onFarmID ?? "", officalId: dataObject.officialID ?? "")
                        
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                    }
                })
                self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
                self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
            }
            else {
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ?? 0), groupTypeId: 0 ,onFarmId:onfarmid, officialID: officialID)
                
                if data.count > 0
                {
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result == true{
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                
                let date:Date? = dateFormatter.date(from:dataObject.dob ?? "")
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject.onFarmID ?? "", officalId: dataObject.officialID ?? "", dob: dataObject.dob ?? "", sex: dataObject.sex ?? "", breedId: dataObject.breedID ?? "", breedName: dataObject.breed ?? "", name: dataObject.name ?? "", groupId: 0, customerId: dataObject.customerId,datedob:date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.banStatus)
                self.datasource[index].backgroundGroup = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                self.datasource[index].image = UIImage(named: ImageNames.barnActiveImg)!
                cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.barnActiveImg)!
            }
        }
        self.hideIndicator()
    }
    
    func swipeRight(index: Int) {
        let cell : MyHerdTblCell = self.tblView.cellForRow(at: IndexPath(row: index, section: 0)) as! MyHerdTblCell
        let dataObject = datasource[index].name
        let animalId = dataObject[0].animalID ?? ""
        let status = dataObject[0].status ?? ""
        let onfarmid = dataObject[0].onFarmID ?? ""
        let officialID = dataObject[0].officialID ?? ""
        let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 0, customerId: Int64(customerId ?? 0))
        
        if fetchActiveBarnExist.count == 0  {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noActiveDoller, comment: "") )
            return
        }
        else {
            let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
            let groupServerId = fetchObject.groupServerId ?? ""
            updateMyHerdData(entity: Entities.resultMyherdDataTblEntity, customerId : Int64(self.customerId ?? 0) ,animalID : animalId ,groupIDs : groupServerId)
            if status == LocalizedStrings.dollerStatus{
                self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                removeAnimalInGroup(groupId: fetchObject.groupServerId ?? "", animalIds: animalId, completionHandler: { (result) in
                    if result == true{
                        _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:fetchObject.groupName ?? "", customerId: dataObject[0].customerId, onFarmId: dataObject[0].onFarmID ?? "", officalId: dataObject[0].officialID ?? "")
                    }
                })
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
                self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
            }
            else {
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ?? 0), groupTypeId: 1,onFarmId:onfarmid, officialID: officialID)
                if data.count > 0{
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result == true{
                                
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                let date:Date? = dateFormatter.date(from:dataObject[0].dob ?? "")
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject[0].onFarmID ?? "", officalId: dataObject[0].officialID ?? "", dob: dataObject[0].dob ?? "", sex: dataObject[0].sex ?? "", breedId: dataObject[0].breedID ?? "", breedName: dataObject[0].breed ?? "", name: dataObject[0].name ?? "", groupId: 0, customerId: dataObject[0].customerId, datedob: date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.dollerStatus)
                self.datasource[index].backgroundGroup = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                self.datasource[index].image = UIImage(named: ImageNames.dollarActiveImg)!
                cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.dollarActiveImg)!
            }
        }
        self.hideIndicator()
    }
    
    func tablereload(){
        datasource.removeAll()
        myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        myHerdArray =  myHerdArray.sorted(by: {$0.currentDateTime  > $1.currentDateTime })
        if myHerdArray.count != 0 {
            
            for i in 0...myHerdArray.count - 1{
                
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        if myHerdArray.count > 20 {
            let animal = myHerdArray.last
            deleteDatafromMyHerdAnimal(animal?.animalID ?? "")
            myHerdArray = myHerdArray.dropLast()
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: 20)
        } else {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        }
        resultCollectionView.isHidden = true
        resultCollectionView.reloadData()
//        tblView.isHidden = true
//        tblView.reloadData()
        checkSelectedCell()
    }
    
    func setTextfield(textLabel:UILabel,color: UIColor,textFont:UIFont){
        textLabel.textColor = color
        textLabel.font = textFont
    }
    
    private func setUpGallary(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imgPhotoLib = UIImagePickerController()
            imgPhotoLib.delegate = self
            imgPhotoLib.allowsEditing = true
            imgPhotoLib.sourceType = .camera
            self.present(imgPhotoLib,animated: true,completion: nil)
        }
    }
    func setVisionTextRecognizeImage(image: UIImage){
        var textStr = ""
        
        request = VNRecognizeTextRequest(completionHandler: {(request,error)in
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Received invalid observation")
            }
            for observation in observations{
                guard let topCandidate = observation.topCandidates(1).first else{
                    
                    continue
                }
                textStr += "\n\(topCandidate.string)"
                DispatchQueue.main.async {
                    if self.searchTextField.tag == 0 {
                        
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                        
                        self.searchTextField.text = ""
                        self.imageView.isHidden = true
                        var mesageShow = String()
                        mesageShow = LocalizedStrings.unableToReadValue.localized(with: test)
                        
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                            vc?.delegate = self
                            self.navigationController?.pushViewController(vc!, animated: true)
                            
                            
                            //SAVE DEMO DATA HERE
                        })
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
                            (_)in
                        })
                        let thirdAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            
                            self.searchTextField.text = test
                            self.imageView.isHidden = true
                            
                            self.searchTextField.returnKeyType = UIReturnKeyType.done
                            self.searchTextField.delegate = self
                            self.searchTextField.tag = 1
                            self.textFieldDidEndEditing(textField: self.searchTextField)
                        })
                        
                        alert.addAction(OKAction)
                        alert.addAction(cancelAction)
                        alert.addAction(thirdAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    else {
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                        self.searchTextField.text = ""
                        var mesageShow = String()
                        mesageShow = LocalizedStrings.unableToReadValue.localized(with: test)
                        
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
                            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                            vc?.delegate = self
                            self.navigationController?.pushViewController(vc!, animated: true)
                            
                            
                            //SAVE DEMO DATA HERE
                        })
                        let cancelAction = UIAlertAction(title:NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
                            (_)in
                        })
                        let thirdAction = UIAlertAction(title: NSLocalizedString(NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            
                            self.searchTextField.text = test
                            self.imageView.isHidden = true
                            self.textFieldDidEndEditing(textField: self.searchTextField)
                            self.searchTextField.delegate = self
                            
                        })
                        
                        alert.addAction(OKAction)
                        alert.addAction(cancelAction)
                        alert.addAction(thirdAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    self.imageView.isHidden = true
                    self.searchTextField.becomeFirstResponder()
                }
            }
        })
        request.customWords = ["custOm"]
        request.minimumTextHeight = 0.03125
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en_US"]
        request.usesLanguageCorrection = true
        let requests = [request]
        DispatchQueue.global(qos: .userInitiated).async {
            guard let img1 = image.cgImage else{
                fatalError("Missing image to scan")
            }
            let handle = VNImageRequestHandler(cgImage: img1, options: [:])
            try?handle.perform(requests)
        }
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
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
    
    //MARK: IB ACTIONS
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.resultsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func menuBtnClick(_ sender: Any) {
        myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        for animal in myHerdArray{
          updateAnimalSelectedDataResult(entity: "ResultMyHerdData", animalID: animal.animalID ?? "", customerId: Int(animal.customerId), searchbyanimal: true, selectedAnimal: false)
        }
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
    
    @IBAction func myGroupBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Results", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyManagementGroupiPadVC") as? MyManagementGroupiPadVC
        vc?.searchByAnimal = true
        vc!.screenBackSave = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func crossPairedAction(_ sender: Any) {
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
    }
    
    @IBAction func backButtonAction(_ sender: UIButton){
        //1.10 merged
        myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        for animal in myHerdArray{
          updateAnimalSelectedDataResult(entity: "ResultMyHerdData", animalID: animal.animalID ?? "", customerId: Int(animal.customerId), searchbyanimal: true, selectedAnimal: false)
        }
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController:self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func AlertAction(_ sender: UIButton) {
        view.endEditing(true)
        
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else  {
            if BluetoothCentre.shared.manager.state == .poweredOff{
                let alertController = UIAlertController (title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: ""), preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.settingsText, comment: ""), style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                        }
                        else {
                            UIApplication.shared.openURL(settingsUrl)
                        }
                    }
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.disconnected || BluetoothCentre.shared.smartBowPeripheral == nil{
                    
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
                if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
                    BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
                    
                    for i in 0 ..< arrNearbyDevice.count{
                        let state = arrNearbyDevice[i].state
                        if state == .connecting {
                            
                        }
                    }
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        barcodeScreen = true
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        navigateToMyherfFilterControler()
    }
    
    @IBAction func dashBoardBackBtnClick(_ sender: Any) {
        myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        for animal in myHerdArray{
          updateAnimalSelectedDataResult(entity: "ResultMyHerdData", animalID: animal.animalID ?? "", customerId: Int(animal.customerId), searchbyanimal: true, selectedAnimal: false)
        }
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func breedFilterBtnClick(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: keyValue.checkFilter.rawValue)
    }
    
    @IBAction func toogleBtnClick(_ sender: UIButton) {
        searchTextField.text = ""
       autoSuggestTableView.isHidden = true
        if !searchByEarTag {
            searchTextField.resignFirstResponder()
         //   sender.setImage(UIImage(named: ImageNames.toggleRightImg), for: .normal)
            searchByEarTag.toggle()
           // self.setTextfield(textLabel: searchByEartagLabel, color: .lightGray, textFont: UIFont.systemFont(ofSize: 12))
          //  self.setTextfield(textLabel: searchByOfficialIdLabel, color: .black, textFont: UIFont.boldSystemFont(ofSize: 12))
          searchTextField.keyboardType = .default
            earTagImgView.image = UIImage(named: "resultsRadioSelectedImg")
            officialIDImgView.image = UIImage(named: "resultsRadioNonSelectedImg")
            tablereload()
        } else {
            searchTextField.resignFirstResponder()
        //    sender.setImage(UIImage(named: ImageNames.toggleLeftImg), for: .normal)
            searchByEarTag.toggle()
          //  self.setTextfield(textLabel: searchByEartagLabel, color: .black, textFont: UIFont.boldSystemFont(ofSize: 12))
        //    self.setTextfield(textLabel: searchByOfficialIdLabel, color: .lightGray, textFont: UIFont.systemFont(ofSize: 12))
            searchTextField.keyboardType = .default
            earTagImgView.image = UIImage(named: "resultsRadioNonSelectedImg")
            officialIDImgView.image = UIImage(named: "resultsRadioSelectedImg")
            tablereload()
        }
    }
    
    @IBAction func dateFilterBtnClick(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: keyValue.checkFilter.rawValue)
    }
    
    @IBAction func sexFilterBtnClick(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: keyValue.checkFilter.rawValue)
    }
    
    @IBAction func rfidBtnClick(_ sender: Any) {
        view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else  {
            if BluetoothCentre.shared.manager.state == .poweredOff{
                let alertController = UIAlertController (title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: ""), preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.settingsText, comment: ""), style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                            
                        } else {
                            UIApplication.shared.openURL(settingsUrl)
                            
                        }
                    }
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.disconnected || BluetoothCentre.shared.smartBowPeripheral == nil{
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
                if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
                    BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
                    for i in 0 ..< arrNearbyDevice.count{
                        let state = arrNearbyDevice[i].state
                        if state == .connecting {
                            
                        }
                    }
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
            }
        }
    }
}
