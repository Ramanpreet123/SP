
//""
//  BeefAnimalGlobalHD50KVC.swift
//  SearchPoint
//
//  Created by "" on 06/03/20.
//

import UIKit
import Toast_Swift
import Vision
import VisionKit
import CoreBluetooth

// MARK: - BEEF ANIMAL GLOBAL HD 50 KVC CLASS
class BeefAnimalGlobalHD50KVC : UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate,VNDocumentCameraViewControllerDelegate {
  
  // MARK: - IB OUTLETS
  @IBOutlet weak var keyBoardOptionsView: UIView!
  @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var closeImage1: UIImageView!
  @IBOutlet weak var closeImage2: UIImageView!
  @IBOutlet weak var importListMainView: UIView!
  @IBOutlet weak var importBackroundView: UIView!
  @IBOutlet weak var importTblView: UITableView!
  @IBOutlet weak var selectListLbl: UILabel!
  @IBOutlet weak var inheritDateTextField: UITextField!
  @IBOutlet weak var globalDateTextField: UITextField!
  @IBOutlet weak var ocrBtnOutlet: UIButton!
  @IBOutlet weak var globalOcrBtnOutlet: UIButton!
  @IBOutlet weak var appStatusLbl: UILabel!
  @IBOutlet weak var orderingTitleLbl: UILabel!
  @IBOutlet weak var inheritbarcodeBttn: UIButton!
  @IBOutlet weak var barcodeBtn: UIButton!
  @IBOutlet weak var inheritDobLbl: UILabel!
  @IBOutlet weak var dobLbl: UILabel!
  @IBOutlet weak var scanEarTagTextField: UITextField!
  @IBOutlet weak var continueBttn: UIButton!
  @IBOutlet weak var inheritAddBttn: UIButton!
  @IBOutlet weak var inheritContinueBttn: UIButton!
  @IBOutlet weak var addbttn: UIButton!
  @IBOutlet weak var scanBarcodeTextfield: UITextField!
  @IBOutlet weak var scrolView: UIScrollView!
  @IBOutlet weak var countLbl: UIButton!
  @IBOutlet weak var notificationLblCount: UILabel!
  @IBOutlet weak var inheritTissueHideLbl: UILabel!
  @IBOutlet weak var calenderView: UIView!
  @IBOutlet weak var calenderbkg: UIView!
  @IBOutlet weak var damRegLbl: UILabel!
  @IBOutlet weak var sireRegLbl: UILabel!
  @IBOutlet weak var breedLbl: UILabel!
  @IBOutlet weak var earTagView: UIView!
  @IBOutlet weak var innerView: UIView!
  @IBOutlet weak var breedRegTextfield: UITextField!
  @IBOutlet weak var dateBttnOutlet: UIButton!
  @IBOutlet weak var breedBtnOutlet: customButton!
  @IBOutlet weak var male_femaleBttnOutlet: UIButton!
  @IBOutlet weak var tissueBttnOutlet: customButton!
  @IBOutlet weak var tissueLbl: UILabel!
  @IBOutlet weak var inheritScrollView: UIScrollView!
  @IBOutlet weak var inheritRegistrationLbl: UILabel!
  @IBOutlet weak var breedRegLbl: UILabel!
  @IBOutlet weak var NetworkStatusLbl: UILabel!
  @IBOutlet weak var offLineBtn: UIButton!
  @IBOutlet weak var networkStatusImg: UIImageView!
  @IBOutlet weak var breedRegBttn: UIButton!
  @IBOutlet weak var inheritBreedLbl: UILabel!
  @IBOutlet weak var scrollInnerView: UIView!
  @IBOutlet weak var animalNameTextfield: UITextField!
  @IBOutlet weak var sireRegDropdownOutlet: customButton!
  @IBOutlet weak var damRegDropdownOutlet: customButton!
  @IBOutlet weak var sireRegTextfield: UITextField!
  @IBOutlet weak var barcodeView: UIView!
  @IBOutlet weak var damRegTextfield: UITextField!
  @IBOutlet weak var inheritEarTagView: UIView!
  @IBOutlet weak var inheritBarcodeView: UIView!
  @IBOutlet weak var inheritBarcodeTextfield: UITextField!
  @IBOutlet weak var inheritEarTagTextfield: UITextField!
  @IBOutlet weak var inheritTissueBttn: customButton!
  @IBOutlet weak var inheritEIDTextfield: UITextField!
  @IBOutlet weak var inheritSecondaryIdTextfield: UITextField!
  @IBOutlet weak var inheritBreedBttn: customButton!
  @IBOutlet weak var inheritDobBttn: UIButton!
  @IBOutlet weak var inheritMaleFemaleBttn: UIButton!
  @IBOutlet weak var inheritBreedRegTextfield: UITextField!
  @IBOutlet weak var inheritRegAssociationBttn: customButton!
  @IBOutlet weak var inheritDamYobBttn: UITextField!
  @IBOutlet weak var inheritDamIdTextfield: UITextField!
  @IBOutlet weak var inheritSireRegTextfield: UITextField!
  @IBOutlet weak var inheritSireYobBttn: UITextField!
  @IBOutlet weak var inheritAddBttnView: UIView!
  @IBOutlet weak var inheritDObView: UIView!
  @IBOutlet weak var incrementalBarcodeCheckBoxInherit: UIImageView!
  @IBOutlet weak var incrementalBarcodeTitleLabelInherit: UILabel!
  @IBOutlet weak var incrementalBarcodeButtonInherit: UIButton!
  @IBOutlet weak var incrementalBarcodeCheckBoxGlobal: UIImageView!
  @IBOutlet weak var incrementalBarcodeTitleLabelGlobal: UILabel!
  @IBOutlet weak var incrementalBarcodeButtonGlobal: UIButton!
  @IBOutlet weak var pairedTableView: UITableView!
  @IBOutlet weak var pairedDeviceView: UIView!
  @IBOutlet weak var pairedBackroundView: UIView!
  @IBOutlet weak var pairedDeviceTitle: UILabel!
  @IBOutlet weak var InheritmergeListBtnOulet: UIButton!
  @IBOutlet weak var globalMergeListBtnOulet: UIButton!
  @IBOutlet weak var inheritImportFromOutlet: UIButton!
  @IBOutlet weak var inheritCrossBtnOutlet: UIButton!
  @IBOutlet weak var globalImportFromOutlet: UIButton!
  @IBOutlet weak var globalCrossBtnOutlet: UIButton!
  @IBOutlet weak var inheritResetIconImage: UIImageView!
  @IBOutlet weak var inheriSireRedOutlet: customButton!
  @IBOutlet weak var inheritRegHideLbl: UILabel!
  @IBOutlet weak var globalClearFormOutlet: UIButton!
  @IBOutlet weak var inheritClearFormOutlet: UIButton!
  @IBOutlet weak var inheritEIDTagView: UIView!
  
  // MARK: - VARIABLES AND CONSTANTS
  var alreadyOrderPlacedAnimal = BeefAnimaladdTbl()
  var autoPopulateAnimalData: BeefAnimaladdTbl?
  let tapRec = UITapGestureRecognizer()
  var listNameString = String()
  var isAnimalComingFromCart = Bool()
  var value = 0
  var listId = Int()
  var conflictArr = [DataEntryBeefAnimaladdTbl]()
  var request = VNRecognizeTextRequest(completionHandler: nil)
  var validateDateFlag = true
  var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.init(red: 29/225, green: 131/225, blue: 174/225, alpha: 1.0),.underlineStyle: NSUnderlineStyle.single.rawValue]
  var checkBarcode = Bool()
  var barAutoPopu =  false
  var timeStampString = String()
  var lblTimeStamp = String()
  var scanAnimalText = String()
  var farmIdText = String()
  let buttonbg1 = UIButton ()
  var customPopView1 :TipPopUp!
  var animalTag = true
  var sireIdBool = true
  var offPmidBool = true
  var barCodeIdBool = true
  var damIdBool = true
  var farmIdTagBool = true
  var idAnimal = Int()
  var isUpdate = Bool()
  var msgUpatedd = Bool()
  var animalSucInOrder = String()
  var animalIdBool = Bool()
  let buttonbg2 = UIButton ()
  var breedArr = NSArray()
  var breedRegArr = NSArray()
  var breedId = String()
  var tissuId = Int()
  var animalId1 = Int()
  var pid : GetProductTblBeef?
  var tissueArr = NSArray()
  var btnTag = Int()
  var identify = Bool()
  var identify1 = Bool()
  var msgcheckk  = Bool()
  var isautoPopulated = false
  var statusOrder = Bool()
  var updateOrder = Bool()
  var editIngText = Bool()
  var autoD = Int()
  var editAid = Int()
  var messageCheck = Bool()
  var msgAnimalSucess = Bool()
  var yearPublic = Calendar.current.component(.year, from: Date())
  var barcodeflag = Bool()
  var defaltscreen = String()
  var datePicker : UIDatePicker!
  var selectedDate = Date()
  var InheritSelectedDate = Date()
  var InheritSireSelectedDate = Date()
  var InheritDamSelectedDate = Date()
  let toolBar = UIToolbar()
  var droperTableView  = UITableView ()
  var genderString = String()
  var inheritGenderString = String()
  var genderToggleFlag : Int = 0
  var inheritGenderToggleFlag : Int = 0
  var sireRegArr = NSArray()
  var damRegArr = NSArray()
  var inheritBreedArr = NSArray()
  var inheritTissueArr = NSArray()
  var inheritRegArr = NSArray()
  var addContiuneBtn = Int()
  var userId = Int()
  var orderId = Int()
  var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
  var custmerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
  var pvid = Int()
  let orderingDataListViewModel = OrderingDataListViewModel()
  var importListArray = [DataEntryList]()
  var tempimportListArray = [DataEntryList]()
  var incrementalBarCode = ""
  var isBarcodeAutoIncrementedEnabled = false
  let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
  var heartBeatViewModel:HeartBeatViewModel?
  let buttonbg = UIButton ()
  var customPopView :OfflinePopUp!
  var barcodeEnable = Bool()
  var methReturn = String()
  var arrNearbyDevice : [CBPeripheral] = [] {
    didSet{
      pairedTableView?.reloadData()
    }
  }
  
  // MARK: - VIEW LIFE CYCLE
  override func viewDidLoad() {
    self.setUIOnDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.setUIOnWillAppear()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    removeObserver()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    self.defaultIncrementalBarCodeSetting_Inherit()
    self.defaultIncrementalBarCodeSetting_Global()
  }
  
  override func viewDidLayoutSubviews() {
    inheritScrollView.contentSize.height = 1100
  }
  
  // MARK: - NAVIGATE TO ORDER SCREEN
  func NavigateToBeefOrderingScreen() {
    let viewAnimalArray =  beefFetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid) as! [BeefAnimaladdTbl]
    let dataListAnimals : [BeefAnimaladdTbl] = viewAnimalArray as! [BeefAnimaladdTbl]
    let animals = dataListAnimals.filter({ $0.animalTag == "" || $0.animalbarCodeTag == nil })
    let barcodeAnimals = dataListAnimals.filter({ $0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil })
    if animals.count > 0 {
      let alert = UIAlertController(title: NSLocalizedString("Alert",comment: ""), message: "Animal(s) in the cart do not have the Ear Tag, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
      let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
        // vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
      })
      alert.addAction(ok)
      DispatchQueue.main.async(execute: {
        self.present(alert, animated: true)
      })
    }
    else if barcodeAnimals.count > 0 {
      
      if barcodeAnimals.count > 0 {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(AlertMessagesStrings.reviewTheCartToUpdate.localized(with: barcodeAnimals.count), comment: ""), preferredStyle: .alert)
        
        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
          let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.beefViewAnimalVC) as? BeefViewAnimalVC
          vc!.screenBackSave = false
          vc!.productBackSave = false
          self.navigationController?.pushViewController(vc!, animated: true)
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
          self.present(alert, animated: true)
        })
      }
    }
    else {
      self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefOrderingProductSelectionVC)), animated: true)
        return
    }
  }
    
    // MARK: - METHODS AND FUNCTIONS
    func showAlertforwithoutBarcodeAnimal(importListAnimal: [DataEntryBeefAnimaladdTbl]) {
      let animals = importListAnimal.filter({$0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil})
      if animals.count > 0 {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(AlertMessagesStrings.reviewTheCartToUpdate.localized(with: animals.count), comment: ""), preferredStyle: .alert)
        
        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
          let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.beefViewAnimalVC) as? BeefViewAnimalVC
          vc!.screenBackSave = false
          vc!.productBackSave = false
          self.navigationController?.pushViewController(vc!, animated: true)
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
          self.present(alert, animated: true)
        })
      }
    }
    
    func defaultIncrementalBarCodeSetting_Inherit() {
      UserDefaults.standard.set(nil, forKey: keyValue.barcodeIncremental.rawValue)
      incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
      UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
      incrementalBarcodeTitleLabelInherit.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
    
    func defaultIncrementalBarCodeSetting_Global() {
      UserDefaults.standard.set(nil, forKey: keyValue.barcodeIncremental.rawValue)
      incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
      UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
      incrementalBarcodeTitleLabelGlobal.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
    
    func updateCartCount(){
      let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
      
      if animalCount.count == 0{
        notificationLblCount.isHidden = true
        countLbl.isHidden = true
      } else {
        notificationLblCount.text = String(animalCount.count)
        notificationLblCount.isHidden = false
        countLbl.isHidden = false
      }
    }
    
    func dataPopulateInScreen(animalId:Int){
      isautoPopulated = true
      barAutoPopu = true
      var animalFetch = NSArray()
      if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
        if animalIdBool == true {
          animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
          let data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
          let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
          animalId1 = Int(data.animalId)
          let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
          
          if dataFetch.count == 0 {
            scanBarcodeTextfield.text = ""
            incrementalBarcodeTitleLabelGlobal.textColor = .black
            incrementalBarcodeTitleLabelGlobal.alpha = 1
            incrementalBarcodeCheckBoxGlobal.alpha = 1
            self.isBarcodeAutoIncrementedEnabled = false
            incrementalBarcodeButtonGlobal.isEnabled = true
            incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
          } else {
            if data.orderstatus == "true"{
              checkBarcode = false
              incrementalBarcodeTitleLabelGlobal.textColor = .black
              incrementalBarcodeButtonGlobal.isEnabled = true
              incrementalBarcodeTitleLabelGlobal.alpha = 1
              incrementalBarcodeCheckBoxGlobal.alpha = 1
            }else{
              scanBarcodeTextfield.text = data.animalbarCodeTag
              UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
              UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
              self.isBarcodeAutoIncrementedEnabled = false
              incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
              incrementalBarcodeButtonGlobal.isEnabled = false
              incrementalBarcodeTitleLabelGlobal.textColor = .gray
              checkBarcode = false
              incrementalBarcodeTitleLabelGlobal.alpha = 0.6
              incrementalBarcodeCheckBoxGlobal.alpha = 0.6
            }
          }
          
          earTagView.layer.borderColor = UIColor.gray.cgColor
          barcodeView.layer.borderColor = UIColor.gray.cgColor
          damRegTextfield.layer.borderColor = UIColor.gray.cgColor
          breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
          animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
          sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
          dateBttnOutlet.titleLabel?.text = ""
          
          let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
          let formatter = DateFormatter()
          if data.date != "" {
            if dateStr == "MM"{
              var dateVale = ""
              let values = data.date!.components(separatedBy: "/")
              if values.count > 1{
                let date = values[0]
                let month = values[1]
                let year = values[2]
                dateVale = month + "/" + date + "/" + year
                yearPublic = Int(year)!
              }
              if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                globalDateTextField.text = dateVale
              } else {
                dateBttnOutlet.setTitle(dateVale, for: .normal)
              }
              formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
              var dateVale = ""
              
              let values = data.date!.components(separatedBy: "/")
              if values.count > 1{
                let date = values[0]
                let month = values[1]
                let year = values[2]
                dateVale = date + "/" + month + "/" + year
                yearPublic = Int(year)!
                
              }
              if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                globalDateTextField.text = dateVale
              } else {
                dateBttnOutlet.setTitle(dateVale, for: .normal)
              }
              formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            }
            else {
              if dateBttnOutlet.titleLabel!.text != nil {
                self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                
              }
            }
          }
          
          scanEarTagTextField.text = data.animalTag
          scanBarcodeTextfield.text = data.animalbarCodeTag
          breedRegTextfield.text = data.offPermanentId
          sireRegTextfield.text = data.offsireId
          damRegTextfield.text = data.offDamId
          animalNameTextfield.text  = data.eT
          if data.breedName == LocalizedStrings.breedNameX{
            breedBtnOutlet.setTitle("XX", for: .normal)
          } else {
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
          }
          tissueBttnOutlet.setTitleColor(.black, for: .normal)
          breedBtnOutlet.setTitleColor(.black, for: .normal)
          tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
          UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefTSU.rawValue)
          breedRegBttn.setTitle(data.farmId, for: .normal)
          breedRegBttn.setTitleColor(.black, for: .normal)
          sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
          damRegDropdownOutlet.setTitleColor(.black, for: .normal)
          breedRegBttn.backgroundColor = .white
          sireRegDropdownOutlet.backgroundColor = .white
          damRegDropdownOutlet.backgroundColor = .white
          breedId = data.breedId!
          
          if data.sireIDAU != ""{
            sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
            sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
          } else {
            sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
          }
          if data.nationHerdAU != ""{
            damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
            damRegDropdownOutlet.setTitleColor(.black, for: .normal)
          }else {
            damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""), for: .normal)
          }
          UserDefaults.standard.set(data.breedName, forKey: keyValue.beefBreed.rawValue)
          
          if data.gender == "Male".localized || data.gender == "M"{
            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 1
            inheritGenderString = NSLocalizedString("Male", comment: "")
          } else {
            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 0
            inheritGenderString = NSLocalizedString("Female", comment: "")
          }
          
          tissuId = Int(data.tissuId)
          
          dateBttnOutlet.setTitleColor(.black, for: .normal)
          let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
          animalIdBool = false
          
          if adata.count > 0{
            let animal  = adata.object(at: 0) as! BeefAnimalMaster
            idAnimal = Int(animal.animalId)
          }
          
        } else {
          animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
          if animalFetch.count > 0 {
            let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            earTagView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            damRegTextfield.layer.borderColor = UIColor.gray.cgColor
            breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
            sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
            dateBttnOutlet.titleLabel?.text = ""
            
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if data.date != "" {
              if dateStr == "MM"{
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                if values.count > 1{
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = month + "/" + date + "/" + year
                  yearPublic = Int(year)!
                }
                if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                  globalDateTextField.text = dateVale
                } else {
                  dateBttnOutlet.setTitle(dateVale, for: .normal)
                }
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
              }
              else {
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                if values.count > 1{
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = date + "/" + month + "/" + year
                  yearPublic = Int(year)!
                  
                }
                if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                  globalDateTextField.text = dateVale
                } else {
                  dateBttnOutlet.setTitle(dateVale, for: .normal)
                }
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
              }
              if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
              }
              else {
                if dateBttnOutlet.titleLabel!.text != nil {
                  self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                }
              }
            }
            
            scanEarTagTextField.text = data.animalTag
            scanBarcodeTextfield.text = data.animalbarCodeTag
            breedRegTextfield.text = data.offPermanentId
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            if data.breedName == LocalizedStrings.breedNameX{
              breedBtnOutlet.setTitle("XX", for: .normal)
            } else {
              breedBtnOutlet.setTitle(data.breedName, for: .normal)
            }
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefTSU.rawValue)
            breedRegBttn.setTitle(data.farmId, for: .normal)
            breedRegBttn.setTitleColor(.black, for: .normal)
            sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            breedRegBttn.backgroundColor = .white
            sireRegDropdownOutlet.backgroundColor = .white
            damRegDropdownOutlet.backgroundColor = .white
            breedId = data.breedId!
            if data.sireIDAU != ""{
              sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
              sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            }
            else {
              sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
            }
            
            if data.nationHerdAU != ""{
              damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
              damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            }
            else {
              damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""), for: .normal)
              
            }
            UserDefaults.standard.set(data.breedName, forKey: keyValue.beefBreed.rawValue)
            
            if data.gender == "Male".localized || data.gender == "M"{
              self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
              genderToggleFlag = 1
              genderString = NSLocalizedString("Male", comment: "")
            }
            else {
              self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
              genderToggleFlag = 0
              genderString = "Female".localized
            }
            tissuId = Int(data.tissuId)
            dateBttnOutlet.setTitleColor(.black, for: .normal)
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            animalIdBool = false
            
            if adata.count > 0{
              let animal  = adata.object(at: 0) as! BeefAnimalMaster
              idAnimal = Int(animal.animalId)
              statusOrder = true
            }
          }
        }
      }
      else{
        inherittextFieldBackroungWhite()
        if animalIdBool == true {
          animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
          if animalFetch.count > 0 {
            let data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
            inheritEIDTagView.layer.borderColor = UIColor.gray.cgColor
            inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
            inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
            inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if data.date != "" {
              if dateStr == "MM"{
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                if values.count > 1{
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = month + "/" + date + "/" + year
                  yearPublic = Int(year)!
                }
                if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                  inheritDateTextField.text = dateVale
                } else {
                  inheritDobBttn.setTitle(dateVale, for: .normal)
                }
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
              }
              else {
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                if values.count > 1{
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = date + "/" + month + "/" + year
                  yearPublic = Int(year)!
                  
                }
                if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                  inheritDateTextField.text = dateVale
                } else {
                  inheritDobBttn.setTitle(dateVale, for: .normal)
                }
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
              }
              
              if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
              } else {
                if inheritDobBttn.titleLabel!.text == nil {
                  self.InheritSelectedDate = Date()
                }
                else{
                  self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                }
              }
            }
            inheritEIDTextfield.text = data.sireIDAU
            inheritSecondaryIdTextfield.text = data.nationHerdAU
            inheritEarTagTextfield.text = data.animalTag
            inheritBarcodeTextfield.text = data.animalbarCodeTag
            inheritBreedRegTextfield.text = data.offPermanentId
            inheritSireRegTextfield.text = data.offsireId
            inheritDamIdTextfield.text = data.offDamId
            inheritSireYobBttn.text = data.sireYOB
            inheritDamYobBttn.text = data.damYOB
            inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
            
            if data.breedName == LocalizedStrings.breedNameX{
              self.inheritBreedBttn.setTitle("XX", for: .normal)
            } else {
              inheritBreedBttn.setTitle(data.breedName, for: .normal)
            }
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefInheritTSU.rawValue)
            
            let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
            if dataFetch.count == 0 {
              inheritBarcodeTextfield.text = ""
              incrementalBarcodeTitleLabelInherit.textColor = .black
              incrementalBarcodeTitleLabelInherit.alpha = 1
              incrementalBarcodeCheckBoxInherit.alpha = 1
              self.isBarcodeAutoIncrementedEnabled = false
              incrementalBarcodeButtonInherit.isEnabled = true
              incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
            } else {
              if data.orderstatus == "true"{
                checkBarcode = false
                incrementalBarcodeTitleLabelInherit.textColor = .black
                incrementalBarcodeButtonInherit.isEnabled = true
                incrementalBarcodeTitleLabelInherit.alpha = 1
                incrementalBarcodeCheckBoxInherit.alpha = 1
              }else {
                inheritBarcodeTextfield.text = data.animalbarCodeTag
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                incrementalBarcodeButtonInherit.isEnabled = false
                incrementalBarcodeTitleLabelInherit.textColor = .gray
                checkBarcode = false
                incrementalBarcodeTitleLabelInherit.alpha = 0.6
                incrementalBarcodeCheckBoxInherit.alpha = 0.6
              }}
            
            inheritRegAssociationBttn.setTitle(data.eT?.localized, for: .normal)
            breedId = data.breedId!
            UserDefaults.standard.set(data.breedName, forKey: keyValue.inheritBeefbreed.rawValue)
            
            if data.gender == "Male".localized || data.gender == "M"{
              self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
              inheritGenderToggleFlag = 1
              inheritGenderString = NSLocalizedString("Male", comment: "")
              
            } else {
              self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
              inheritGenderToggleFlag = 0
              inheritGenderString = "Female".localized
            }
            tissuId = Int(data.tissuId)
            inheritDobBttn.setTitleColor(.black, for: .normal)
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            animalIdBool = false
            
            if adata.count > 0{
              let animal  = adata.object(at: 0) as! BeefAnimalMaster
              idAnimal = Int(animal.animalId)
            }
            if data.eT == "" || data.eT == nil {
              inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
            }
            if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
              inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
            }
          }
        } else {
          animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
          if animalFetch.count > 0 {
            let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
            inheritEIDTagView.layer.borderColor = UIColor.gray.cgColor
            inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
            inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
            inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if data.date != "" {
              if dateStr == "MM"{
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                if values.count > 1{
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = month + "/" + date + "/" + year
                  yearPublic = Int(year)!
                }
                if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                  inheritDateTextField.text = dateVale
                } else {
                  inheritDobBttn.setTitle(dateVale, for: .normal)
                }
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
              }
              else {
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                if values.count > 1{
                  let date = values[0]
                  let month = values[1]
                  let year = values[2]
                  dateVale = date + "/" + month + "/" + year
                  yearPublic = Int(year)!
                  
                }
                if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                  inheritDateTextField.text = dateVale
                } else {
                  inheritDobBttn.setTitle(dateVale, for: .normal)
                }
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
              }
              if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
              }else {
                if inheritDobBttn.titleLabel!.text == nil {
                  self.InheritSelectedDate = Date()
                }
                else{
                  self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                }
              }
            }
            inheritEIDTextfield.text = data.sireIDAU
            inheritSecondaryIdTextfield.text = data.nationHerdAU
            inheritEarTagTextfield.text = data.animalTag
            inheritBarcodeTextfield.text = data.animalbarCodeTag
            inheritBreedRegTextfield.text = data.offPermanentId
            inheritSireRegTextfield.text = data.offsireId
            inheritDamIdTextfield.text = data.offDamId
            inheritSireYobBttn.text = data.sireYOB
            inheritDamYobBttn.text = data.damYOB
            inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
            
            
            if data.breedName == LocalizedStrings.breedNameX{
              self.inheritBreedBttn.setTitle("XX", for: .normal)
            } else {
              inheritBreedBttn.setTitle(data.breedName, for: .normal)
            }
            
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritBreedBttn.setTitleColor(.black, for: .normal)
            inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefInheritTSU.rawValue)
            
            breedId = data.breedId!
            UserDefaults.standard.set(data.breedName, forKey: keyValue.inheritBeefbreed.rawValue)
            inheritRegAssociationBttn.setTitle(data.eT?.localized, for: .normal)
            if data.gender == "Male".localized || data.gender == "M"{
              self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
              inheritGenderToggleFlag = 1
              inheritGenderString = NSLocalizedString("Male", comment: "")
              
            } else {
              self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
              inheritGenderToggleFlag = 0
              inheritGenderString = "Female".localized
              
            }
            if data.eT == "" || data.eT == nil {
              inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
            }
            if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
              inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
            }
            tissuId = Int(data.tissuId)
            
            inheritDobBttn.setTitleColor(.black, for: .normal)
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            animalIdBool = false
            
            
            if adata.count > 0{
              let animal  = adata.object(at: 0) as! BeefAnimalMaster
              idAnimal = Int(animal.animalId)
              statusOrder = true
            }
          }
        }
      }
    }
    
    func isValidDate(dateString: String) -> String {
      let dateFormatterGet = DateFormatter()
      let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
      if dateStr == "MM"{
        dateFormatterGet.dateFormat = DateFormatters.MMddyyyyFormat
      }
      else {
        dateFormatterGet.dateFormat = DateFormatters.ddMMyyyyFormat
      }
      if let dateGet = dateFormatterGet.date(from: dateString) {
        let smallDate = dateGet.isSmallerThan(Date())
        if smallDate == false {
          return LocalizedStrings.greaterThenDateStr
        }
        return LocalizedStrings.correctFormatStr
      } else {
        return  LocalizedStrings.invalidFormatStr
      }
    }
    
    func doDatePicker(){
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
      self.datePicker.setDate(selectedDate, animated: true)
      
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
      let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.doneClick))
      let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.cancelClick))
      cancelButton.tintColor = UIColor.black
      toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
      toolBar.isUserInteractionEnabled = true
      toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
      self.calenderView.addSubview(toolBar)
      self.toolBar.isHidden = false
    }
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
      // merged 1st May
      //        if barcodeEnable == true {
      //            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
      //            if orederStatus.count > 0 {
      //                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
      //
      //                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
      //                    UIAlertAction in
      //                    let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
      //                    self.autoPop(animalData: animalFetch)
      //                    self.barcodeEnable = false
      //                }
      //                alertController.addAction(okAction)
      //                self.present(alertController, animated: true, completion: nil)
      //                statusOrder = false
      //                self.scrolView.contentOffset.y = 0.0
      //                return
      //            }
      //        }
      let selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
      
      if selctionAuProvider == true {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
          if scanEarTagTextField.text == "" || (breedRegTextfield.text != "" && breedRegBttn.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectBreedAssc, comment:  "")) || (sireRegTextfield.text != "" && sireRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectSireReg, comment: "")) || (damRegTextfield.text != "" && damRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""))   {
            self.validation()
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            completionHandler(false)
            return
          } else {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
              addBtnCondtion(completionHandler: { (success) -> Void in
                
                completionHandler(true)
              })
            }
          }
        }
        else{
          if inheritEarTagTextfield.text == "" || inheritBarcodeTextfield.text == "" {
            self.inheritValidation()
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            completionHandler(false)
            return
          }
          else {
            if inheritSireRegTextfield.text == "" {
            }
            else{
              if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectSireReg, comment: "") {
                inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
              } else {
                inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                return
              }
            }
            
            if inheritSireYobBttn.text?.count ?? 0 > 0 {
              let inheritSireYob = Int(inheritSireYobBttn.text ?? "") ?? 0
              
              if inheritSireYobBttn.text!.count < 4 || inheritSireYobBttn.text != "0" {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                return
              }
              if inheritSireYob > yearPublic {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.SireYOBSmallerThanYOB, comment: ""))
                inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                return
              }else {
                inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
              }
            }
            
            if inheritDamYobBttn.text?.count ?? 0 > 0 {
              let inheritDamYob:Int = Int(inheritDamYobBttn.text ?? "") ?? 0
              
              if inheritDamYobBttn.text!.count < 4 || inheritSireYobBttn.text != "0" {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                return
              }
              
              if inheritDamYob > yearPublic {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.DamYOBSmallerThanYOB, comment: ""))
                inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                
                return
              }else {
                inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
              }
            }
            inheritAddBtnCondtion(completionHandler: { (success) -> Void in
              completionHandler(true)
            })
          }
        }
      }
      else {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
          if scanEarTagTextField.text == "" ||  (breedRegTextfield.text != "" && breedRegBttn.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectBreedAssc, comment:  "")) || (sireRegTextfield.text != "" && sireRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectSireReg, comment: "")) || (damRegTextfield.text != "" && damRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectDamReg, comment: "")){
            self.validation()
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            completionHandler(false)
            return
          } else {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
              addBtnCondtion(completionHandler: { (success) -> Void in
                if success == true{
                  
                  completionHandler(true)
                }
              })
            }
          }
        }
        else{
          if inheritEarTagTextfield.text == "" || inheritBarcodeTextfield.text == "" {
            self.inheritValidation()
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            completionHandler(false)
            return
          } else {
            if inheritSireRegTextfield.text == "" {
            }
            else{
              if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectSireReg, comment: "") {
                inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
              } else {
                inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                return
              }
            }
            
            if inheritSireYobBttn.text?.count ?? 0 > 0 {
              let inheritSireYob = Int(inheritSireYobBttn.text ?? "") ?? 0
              
              if inheritSireYobBttn.text!.count < 4 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                return
              }
              if inheritSireYob > yearPublic {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.SireYOBSmallerThanYOB, comment: ""))
                inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                return
              }else {
                inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
              }
            }
            
            if inheritDamYobBttn.text?.count ?? 0 > 0 {
              let inheritDamYob:Int = Int(inheritDamYobBttn.text ?? "") ?? 0
              
              if inheritDamYobBttn.text!.count < 4 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                return
              }
              if inheritDamYob > yearPublic {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.DamYOBSmallerThanYOB, comment: ""))
                inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                return
              } else {
                inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
              }
            }
            
            inheritAddBtnCondtion(completionHandler: { (success) -> Void in
              if success == true{
                inheritDobBttn.setTitle("", for: .normal)
                inheritDobBttn.titleLabel?.text = ""
                inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
                inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
                completionHandler(true)
              }
            })
          }
        }
      }
      
      if notificationLblCount.text != "0"{
        countLbl.isHidden = false
        notificationLblCount.isHidden = false
      }
    }
    
    func addBtnCondtion(completionHandler: CompletionHandler){
      if checkBarcode == true {
        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
        return
      }
      let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
      
      if barcodeflag == true {
        let barCode =  fetchAnimaldataCheckAnimalBarcodeExist(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
        let earTag =  fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: scanEarTagTextField.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId)
        if earTag.count > 0 {
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalDataCantLoad, comment: ""))
          return
        }
        
        if barCode.count > 0 {
          barcodeView.layer.borderColor = UIColor.red.cgColor
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
          return
        }
      }
      
      let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (self.breedBtnOutlet.titleLabel?.text!)!, productId: 19)
      if inheritBreed.count != 0 {
        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
        self.breedId = medbreedRegArr1!.breedId ?? ""
      }
      
      let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity, provId: pvid, tissueName: (tissueBttnOutlet.titleLabel?.text)!)
      
      let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
      if naabFetch1!.count != 0 {
        let tissuId = naabFetch1![0] as? Int
        self.tissuId = tissuId!
      }
      
      let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.beefAnimalMasterTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),IsDataEmail: false)
      if animaBarcOde.count > 0 {
        barcodeView.layer.borderColor = UIColor.red.cgColor
        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
        return
      }
      
      var breedReg = ""
      if breedRegBttn.titleLabel?.text == nil {
        breedReg = ""
      }
      else{
        breedReg = breedRegBttn.titleLabel!.text!
      }
      var sireReg = ""
      if sireRegDropdownOutlet.titleLabel?.text == nil {
        sireReg = ""
      }
      else{
        sireReg = sireRegDropdownOutlet.titleLabel!.text!
      }
      var damReg = ""
      if damRegDropdownOutlet.titleLabel?.text == nil {
        damReg = ""
      }
      else{
        damReg = damRegDropdownOutlet.titleLabel!.text!
      }
      var dateVale = ""
      let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
      
      if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
        dateVale = globalDateTextField.text ?? ""
        if dateStr == "DD"{
          dateVale = globalDateTextField.text ?? ""
        }
        else {
          if dateVale != ""{
            let values = dateVale.components(separatedBy: "/")
            let date = values[0]
            let month = values[1]
            let year = values[2]
            dateVale = month + "/" + date + "/" + year
          }
        }
      } else {
        dateVale = dateBttnOutlet.titleLabel?.text ?? ""
        if dateStr == "DD"{
          dateVale = dateBttnOutlet.titleLabel?.text ?? ""
        }
        else {
          if dateVale != ""{
            let values = dateVale.components(separatedBy: "/")
            let date = values[0]
            let month = values[1]
            let year = values[2]
            dateVale = month + "/" + date + "/" + year
          }
        }
      }
      
      if globalDateTextField.text?.count == 0 {
      }
      else {
        if globalDateTextField.text?.count == 10 {
          let validate = isValidDate(dateString: globalDateTextField.text ?? "")
          if validate == LocalizedStrings.correctFormatStr {
            dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
            dateBttnOutlet.layer.borderWidth = 0.5
            validateDateFlag = true
          } else {
            dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
            validateDateFlag = false
            if validate == LocalizedStrings.greaterThenDateStr {
              
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
              return
            } else {
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
              return
            }
          }
        } else {
          dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
          validateDateFlag = false
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
          return
        }
      }
      
      let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
      let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
      incrementalBarCode = scanBarcodeTextfield.text ?? ""
      let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanEarTagTextField.text!, orderId: orderId, userId: userId, animalId: animalId1)
      
      if animalData.count > 0  {
        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
        if data12333.count > 0 && tissueBttnOutlet.titleLabel!.text! != ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! != ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! != ButtonTitles.caisleyTSUText {
          let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
          
          let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.byDefaultSetting()
            
          }
          let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.byDefaultSetting()
            return
          }
          alertController.addAction(cancelAction)
          alertController.addAction(okAction)
          self.present(alertController, animated: true, completion: nil)
        }
        else {
          isUpdate = true
          updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text ?? "", date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
          
          updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text ?? "", date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
          
          updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: scanEarTagTextField.text!,barCodetag:  scanBarcodeTextfield.text ?? "",farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
          updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: scanEarTagTextField.text!,barCodetag:  scanBarcodeTextfield.text ?? "",farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
          
          let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:19)
          
          if fetchDataUpdate.count != 0 {
            updateOrderInfoBeefGlobal(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ),editFlagSave: true)
          }
          
          let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanEarTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
          let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
          
          if adata.count > 0{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
            byDefaultSetting()
          }
          
          else if animalDataMaster.count > 0 {
            if  msgUpatedd == true{
              self.NavigateToBeefOrderingScreen()
              UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: keyValue.beefbreedClear.rawValue)
              UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.beeftsuClear.rawValue)
              UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.beefTSU.rawValue)
              UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.beefBreed.rawValue)
              byDefaultSetting()
            }
            else{
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
              byDefaultSetting()
            }
          }
          
          editAid = animalId1
          animalId1 = 0
          
          if identify1 == true {
            let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
            if data1.count > 0 {
              completionHandler(true)
              return
            }
          }
          completionHandler(true)
          scrolView.contentOffset.y = 0.0
        }
      }
      
      else if isUpdate == true {
        animalId1 = editAid
        updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
        
        updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
        
        if identify1 == true {
          let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
          if data1.count > 0 {
            completionHandler(true)
            return
          }
        }
        isautoPopulated = false
        let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanEarTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        
        if adata.count > 0{
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
          byDefaultSetting()
        }
        
        else if animalDataMaster.count > 0 {
          if msgUpatedd == true{
            self.NavigateToBeefOrderingScreen()
            UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: keyValue.beefbreedClear.rawValue)
            UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.beeftsuClear.rawValue)
            UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.beefTSU.rawValue)
            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.beefBreed.rawValue)
            byDefaultSetting()
          }
          else{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
            byDefaultSetting()
          }
        }
        completionHandler(true)
        scrolView.contentOffset.y = 0.0
      }
      else {
        isUpdate = false
        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        let pid = product[0] as! GetProductTblBeef
        var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0{
          if animalID1 == 0 {
            animalID1 = animalID1 + 1
            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
          }
          else {
            animalID1 = animalID1 + 1
            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
          }
          
          updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
          
          let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:19)
          
          if fetchDataUpdate.count != 0 {
            updateOrderInfoBeefGlobal(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
          }
        }
        else{
          if animalID1 == 0 {
            animalID1 = animalID1 + 1
            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
            
          }
          else {
            animalID1 = animalID1 + 1
            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
          }
          
          let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
          
          if animalDataMaster.count > 0{
            updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
          }
          else {
            
            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "", tertiaryGeno: "")
            createDataList()
          }
        }
        
        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
        if data12333.count > 0{
          if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "", tertiaryGeno: "")
            createDataList()
          }
          else{
            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
              self.byDefaultSetting()
              
            }
            let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
              deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
              deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
              deleteDataWithProductwithEntity(animalID1, entity: Entities.beefAnimalAddTblEntity)
              let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
              self.notificationLblCount.text = String(animalCount.count)
              self.byDefaultSetting()
              return
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
          }
        }
        else {
          saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "", tertiaryGeno: "")
          createDataList()
        }
        
        let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanEarTagTextField.text!,orderId:orderId,userId:userId)
        
        for k in 0 ..< animalData.count{
          let animalId = animalData[k] as! BeefAnimaladdTbl
          for i in 0 ..< product.count {
            let data = product[i] as! GetProductTblBeef
            saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
            
            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
            for j in 0 ..< addonArr.count {
              let addonDat = addonArr[j] as! GetAdonTbl
              if data12333.count > 0 {
                if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                  saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                  updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                }
                else {
                  saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                }
              }
              else {
                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
              }
              
              statusOrder = false
              UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
              self.animalSucInOrder = ""
              if self.msgAnimalSucess == false {
                if self.addContiuneBtn == 1 {
                  if self.msgcheckk == true {
                    self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .bottom)
                  }
                  else {
                    if self.isautoPopulated == true {
                      self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .bottom)
                    } else {
                      self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .bottom)
                    }
                  }
                } else if self.addContiuneBtn == 2{
                  if self.msgcheckk == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                  }
                  else{
                    if self.isautoPopulated == true {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                    } else {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                  }
                }else {
                  if self.msgcheckk == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                  }
                  else{
                    if self.isautoPopulated == true {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                      
                    } else {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                  }
                }
                self.msgAnimalSucess = false
              } else {
                if self.msgcheckk == true {
                  self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .bottom)
                }
                else{
                  if self.isautoPopulated == true {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .bottom)
                  }
                  else {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .bottom)
                  }
                }
              }
            }
          }
        }
        UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: keyValue.beefbreedClear.rawValue)
        UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.beeftsuClear.rawValue)
        UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.beefTSU.rawValue)
        UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.beefBreed.rawValue)
        
        if isBarcodeAutoIncrementedEnabled == true {
          UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
          UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
          
        } else {
          UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
          UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
          
        }
        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        byDefaultSetting()
        textFieldBackroungGrey()
        genderToggleFlag = 0
        genderString = "Female".localized
        barAutoPopu = false
        dateVale = ""
        scanEarTagTextField.text = ""
        scanBarcodeTextfield.text = ""
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
        notificationLblCount.text = String(animalCount.count)
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        let formatter = DateFormatter()
        
        if dateStr == "MM"{
          formatter.dateFormat = DateFormatters.MMddyyyyFormat
        }
        else {
          formatter.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        
        inheritDobBttn.setTitle(nil, for: .normal)
        dateBttnOutlet.setTitle(nil, for: .normal)
        dateVale = ""
        dateBttnOutlet.titleLabel?.text = ""
        completionHandler(true)
      }
      
      if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
        UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
      }
      incrementalBarCode = ""
      
    }
    
    func validation() {
      if scanEarTagTextField.text == ""{
        
        earTagView.layer.borderColor = UIColor.red.cgColor
      }
      else {
        earTagView.layer.borderColor = UIColor.gray.cgColor
      }
      if scanBarcodeTextfield.text == ""{
        barcodeView.layer.borderColor = UIColor.red.cgColor
      }
      else {
        barcodeView.layer.borderColor = UIColor.gray.cgColor
      }
      if breedRegTextfield.text == ""{
        breedRegBttn.layer.borderColor = UIColor.gray.cgColor
      }
      else{
        if breedRegBttn.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectBreedAssc, comment:  "") {
          breedRegBttn.layer.borderColor = UIColor.gray.cgColor
        }else{
          breedRegBttn.layer.borderColor = UIColor.red.cgColor
        }
      }
      if sireRegTextfield.text == ""{
        sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
      }
      else{
        if sireRegDropdownOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectSireReg, comment: "") {
          sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        }else{
          sireRegDropdownOutlet.layer.borderColor = UIColor.red.cgColor
        }
      }
      if damRegTextfield.text == ""{
        damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
      }
      else{
        if damRegDropdownOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectDamReg, comment: "") {
          damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        }else{
          damRegDropdownOutlet.layer.borderColor = UIColor.red.cgColor
        }
      }
    }
    
    func statusOrderTrue() -> Bool{
      let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
      if animalFetch.count > 0{
        statusOrder = true
        return true
      }else{
        return false
      }
    }
    
    private func setVisionTextRecognizeImage(image: UIImage){
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
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
              let trimmed = (textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
              let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{/".contains($0)})
              self.methReturn = self.ukTagReutn(animalId: test.uppercased())
              if self.methReturn == LocalizedStrings.againClick {
                
                self.scanEarTagTextField.text = ""
                var mesageShow = String()
                mesageShow = LocalizedStrings.unableToReadValue.localized(with: test)
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                  (_)in
                  
                  let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                  self.navigationController?.pushViewController(vc!, animated: true)
                  vc?.delegate = self
                  
                  
                })
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
                  (_)in
                })
                let thirdAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), style: UIAlertAction.Style.default, handler: {
                  (_)in
                  
                  self.scanEarTagTextField.text = test
                  self.dataPopulateInFocusChange()
                  self.textFieldBackroungWhite()
                })
                
                alert.addAction(OKAction)
                alert.addAction(cancelAction)
                alert.addAction(thirdAction)
                self.present(alert, animated: true, completion: nil)
                return
              }
              self.scanEarTagTextField.text = self.methReturn
              self.dataPopulateInFocusChange()
              self.textFieldBackroungWhite()
              
            } else {
              let trimmed = (textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
              let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
              self.methReturn = self.ukTagReutn(animalId: test.uppercased())
              if self.methReturn == LocalizedStrings.againClick {
                
                self.inheritEarTagTextfield.text = ""
                
                var mesageShow = String()
                mesageShow = LocalizedStrings.unableToReadValue.localized(with: test)
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                  (_)in
                  
                  let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                  vc?.delegate = self
                  self.navigationController?.pushViewController(vc!, animated: true)
                  
                  
                })
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
                  (_)in
                })
                let thirdAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), style: UIAlertAction.Style.default, handler: {
                  (_)in
                  
                  self.inheritEarTagTextfield.text = test
                  self.inherittextFieldBackroungWhite()
                  self.dataPopulateInFocusChange()
                })
                
                alert.addAction(OKAction)
                alert.addAction(cancelAction)
                alert.addAction(thirdAction)
                self.present(alert, animated: true, completion: nil)
                
                return
              }
              self.inheritEarTagTextfield.text = self.methReturn
              self.inherittextFieldBackroungWhite()
              self.dataPopulateInFocusChange()
            }
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
    
    func ukTagReutn(animalId:String)-> String{
      let idAnimal = animalId.uppercased()
      let stringResult = idAnimal.contains("UK")
      if stringResult == true {
        let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
        let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
        let dropTwelveElement = test.suffix(12).uppercased()
        let totalString =  dropTwelveElement
        return totalString
        
      } else {
        let stringResultUS = idAnimal.contains("US")
        let stringResult840 = idAnimal.contains("840")
        
        if stringResultUS == true && stringResult840 == true {
          let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
          let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
          if test.count < 15 {
            return LocalizedStrings.againClick
          }
          else {
            guard let range: Range<String.Index> = test.range(of: "840") else {
              return LocalizedStrings.againClick
            }
            let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
            
            let countt = index + 14
            if test.count < countt {
              return LocalizedStrings.againClick
            }
            else {
              let indexGet = test.subString(from: index, to: index + 14)
              return indexGet
            }
          }
        } else {
          return LocalizedStrings.againClick
        }
      }
      
      return LocalizedStrings.againClick
    }
    
    // MARK: - IMAGE PICKER CONTROLLER DELEGATE
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
      picker.dismiss(animated: true, completion: nil)
      
      if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
        self.scanEarTagTextField.text = ""
      } else {
        self.inheritEarTagTextfield.text = ""
      }
      
      guard let image = info[.editedImage] as? UIImage else {
        return
      }
      setVisionTextRecognizeImage(image: image)
    }
  }

