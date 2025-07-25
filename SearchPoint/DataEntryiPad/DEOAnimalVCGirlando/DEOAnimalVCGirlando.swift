//
//  DEOAnimalVCGirlando.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 19/03/25.
//

import Foundation
import UIKit
import Toast_Swift
import DropDown
import CoreBluetooth
import Vision
import VisionKit

//MARK: CLASS

class DEOAnimalVCGirlando: UIViewController,VNDocumentCameraViewControllerDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var animalNameHeaderView: UIView!
    @IBOutlet weak var breedRegHeaderView: UIView!
    @IBOutlet weak var associationTypeHeaderView: UIView!
    @IBOutlet weak var damIdStackView: UIStackView!
    @IBOutlet weak var animalNameAndSireRegStackView: UIStackView!
    @IBOutlet weak var breedRegAndAssociationTypeStackView: UIStackView!
    @IBOutlet weak var genderHeaderView: UIView!
    @IBOutlet weak var bornTypeView: UIView!
    @IBOutlet weak var sampleTypeHeaderView: UIView!
    @IBOutlet weak var sampleBreedHeaderView: UIView!
    @IBOutlet weak var breedAndDateStackView: UIStackView!
    @IBOutlet weak var sampleTypeAndGenderStackView: UIStackView!
    @IBOutlet weak var dobHeaderView: UIView!
    @IBOutlet weak var damIDHeaderView: UIView!
    @IBOutlet weak var sireIDHeaderView: UIView!
    @IBOutlet weak var bornTypeHeaderView: UIView!
    @IBOutlet weak var clearFormBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var addAAnimalStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var innerScrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var breedTypeView: UIView!
    @IBOutlet weak var sampleTypeView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var breedRegView: UIView!
    @IBOutlet weak var associationTypeView: UIView!
    @IBOutlet weak var animalNameView: UIView!
    @IBOutlet weak var sireRegView: UIView!
    @IBOutlet weak var damRegView: UIView!
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var scanBarocodeOutlet: UIButton!
    @IBOutlet weak var invrementalBrocodeOutlet: UIButton!
    @IBOutlet weak var incrementalLbl: UILabel!
    @IBOutlet weak var bckToListNavigateOutlet: customButton!
    @IBOutlet weak var expandFormOutlet: UIButton!
    @IBOutlet weak var damTextFieldHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var damTextFieldTopConstaint: NSLayoutConstraint!
    @IBOutlet weak var sireRegTextFieldHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var sireRegTextFieldTopConstaint: NSLayoutConstraint!
    @IBOutlet weak var animalNameHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var animalNameTopHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var breedAssociationHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var breedAssociationTopHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var tissureDropDown:UIImageView!
    @IBOutlet weak var breedRegHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var breedRegTopHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var breedBtnHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var dobViewHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var maleFemaleHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var singleStackViewHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var tissueHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var breedDropIcon: UIImageView!
    @IBOutlet weak var breedAssociationIcon: UIImageView!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var orderingTitleLbl: UILabel!
    @IBOutlet weak var barcodeBtn: UIButton!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var scanEarTagTextField: UITextField!
    @IBOutlet weak var continueBttn: UIButton!
    @IBOutlet weak var addbttn: UIButton!
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var notificationLblCount: UILabel!
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
    @IBOutlet weak var breedRegLbl: UILabel!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var dateBtnView: UIView!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var breedRegBttn: UIButton!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var animalNameTextfield: UITextField!
    @IBOutlet weak var sireRegTextfield: UITextField!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var damRegTextfield: UITextField!
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    @IBOutlet weak var multipleBirthBttn: UIButton!
    @IBOutlet weak var singleBttn: UIButton!
    @IBOutlet weak var etBttn: UIButton!
    @IBOutlet weak var clearFormOutlet: UIButton!

    //MARK: VARIABLES AND CONSTANTS
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    var gestureEnabled: Bool = true
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var genderArray = ["Female","Male"]
    var viewsArray = [UIView]()
    var validateDateFlag = true
    let tapRec = UITapGestureRecognizer()
    var etBtn = String()
    var selectedBornTypeId = 1
    var addedd = Bool()
    var barcodeEnable = Bool()
    var barAutoPopu = false
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var timeStampString = String()
    var lblTimeStamp = String()
    var barcodeflag = Bool()
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
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
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
    var checkBarcode = Bool()
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
    let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
    var listIdGet = Int()
    var listName = String()
    var heartBeatViewModel:HeartBeatViewModel?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var methReturn = String()

    //MARK: VIEW LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUIOnDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.defaultIncrementalBarCodeSetting()
        removeObserver()
    }
    
    //MARK: SIDE MENU UI METHODS
    func setSideMenu(){
        if UIDevice.current.orientation.isLandscape {
            self.sideMenuRevealWidth = 300
        }
        else {
            self.sideMenuRevealWidth = 260
            
        }
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
//        tapGestureRecognizer.numberOfTapsRequired = 1
//        tapGestureRecognizer.delegate = self
        
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
    
    func sideMenuRevealSettingsViewController() -> DEOAnimalVCGirlando? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is DEOAnimalVCGirlando {
            return viewController! as? DEOAnimalVCGirlando
        }
        while (!(viewController is DEOAnimalVCGirlando) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is DEOAnimalVCGirlando {
            return viewController as? DEOAnimalVCGirlando
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }

    
    //MARK: METHODS AND FUNCTIONS
    func defaultIncrementalBarCodeSetting() {
        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabel.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
 
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
  
    
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var animalFetch = NSArray()
        
        if animalIdBool == true {
            textFieldBackroungWhite()
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId: animalId, customerID: custmerId!)
            let data = animalFetch.object(at: 0) as! DataEntryAnimaladdTbl
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            dateBttnOutlet.titleLabel!.text = ""
            
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            self.isBarcodeAutoIncrementedEnabled = false
            
            if data.date != "" {
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != ""{
                    dobLbl.text = ""
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!) ?? Date()
                }
                
                let isGreater = Date().isSmaller(than: selectedDate)
                print(isGreater)
                
                if isGreater == true {
                    dateBttnOutlet.setTitle("", for: .normal)
                    dateTextField.text = ""
                }
            }
            
            scanBarcodeTextfield.text = data.animalbarCodeTag
            barcodeflag = false
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            scanEarTagTextField.text = data.earTag
            breedRegTextfield.text = data.breedRegNumber
            breedRegBttn.setTitle(data.breedAssocation, for: .normal)
            animalNameTextfield.text = data.animalName
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName?.localized, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
            breedId = data.breedId!
            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
            
            if data.gender == ButtonTitles.maleText.localized || data.gender == "M" || data.gender == "m"{
                
                male_femaleBttnOutlet.setTitle("Male", for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                UserDefaults.standard.set("M", forKey: "DEGirlandoGender")
            } else {
//                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//                genderToggleFlag = 0
//                genderString = ButtonTitles.femaleText.localized
                male_femaleBttnOutlet.setTitle("Female", for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Female", comment: "")
                UserDefaults.standard.set("F", forKey: "DEGirlandoGender")
                
            }
            
            let inheritBreed = fetchAllDataProductGirlandoBreedID(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:4)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
            }
            
            let et = data.eT
            etBtn = et!
//            etBttn.layer.borderWidth = 0.5
//            singleBttn.layer.borderWidth = 0.5
//            multipleBirthBttn.layer.borderWidth = 0.5
            
            if et == "Et" || et == "ET"{
                etBttn.layer.borderColor = UIColor.clear.cgColor
               // etBttn.layer.borderWidth = 2
                singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                selectedBornTypeId = 3
                etBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                etBttn.setTitleColor(UIColor.white, for: .normal)
                
            } else if et == LocalizedStrings.singlesText{
                
//                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                singleBttn.layer.borderWidth = 2
//                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
//                etBttn.layer.borderColor = UIColor.gray.cgColor
//                selectedBornTypeId = 1
                singleBttn.layer.borderColor = UIColor.clear.cgColor
               // etBttn.layer.borderWidth = 2
                etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                selectedBornTypeId = 1
                singleBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                singleBttn.setTitleColor(UIColor.white, for: .normal)
            }else if et == LocalizedStrings.multipleBirthStr{
                //
//                multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                multipleBirthBttn.layer.borderWidth = 2
//                singleBttn.layer.borderColor = UIColor.gray.cgColor
//                etBttn.layer.borderColor = UIColor.gray.cgColor
//                selectedBornTypeId = 2
                selectedBornTypeId = 2
                multipleBirthBttn.layer.borderColor = UIColor.clear.cgColor
               // etBttn.layer.borderWidth = 2
                etBttn.layer.borderColor = UIColor(red:57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                multipleBirthBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                multipleBirthBttn.setTitleColor(UIColor.white, for: .normal)
            }
            else {
                selectedBornTypeId = 1
                singleBttn.layer.borderColor = UIColor.clear.cgColor
               // etBttn.layer.borderWidth = 2
                etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                singleBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                singleBttn.setTitleColor(UIColor.white, for: .normal)
                
            }
            
            tissuId = Int(data.tissuId)
            dateBttnOutlet.setTitleColor(.black, for: .normal)
            let adata = fetchAllDataOrderStatusMasterGirlando(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId, farmId: data.farmId!, earTag: data.earTag!, barcodeTag: data.animalbarCodeTag!)
            animalIdBool = false
            
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! AnimalMaster
                idAnimal = Int(animal.animalId)
            }
            breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.girolandoAssociationStr, comment:  "") , for: .normal)
            
        } else {
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
            if animalFetch.count > 0 {
                let data = animalFetch.object(at: 0) as! AnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                if data.date != "" {
                    
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    dobLbl.text = ""
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                    
                }
                
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                breedId = data.breedId!
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                scanEarTagTextField.text = data.earTag
                breedRegTextfield.text = data.breedRegNumber
                breedRegBttn.setTitle(data.breedAssocation, for: .normal)
                animalNameTextfield.text = data.animalName
                
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M" || data.gender == "m"{
                    
                    
                  //  self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    male_femaleBttnOutlet.setTitle("Male", for: .normal)
                    genderToggleFlag = 1
                    genderString = ButtonTitles.maleText.localized
                    UserDefaults.standard.set("M", forKey: "DEGirlandoGender")
                    
                } else {
                    
                   // self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    male_femaleBttnOutlet.setTitle("Female", for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                    UserDefaults.standard.set("F", forKey: "DEGirlandoGender")
                    
                }
                
                let et = data.eT
                etBtn = et!
//                etBttn.layer.borderWidth = 0.5
//                singleBttn.layer.borderWidth = 0.5
//                multipleBirthBttn.layer.borderWidth = 0.5
                
//                if et == "Et" || et == "ET"{
//                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    etBttn.layer.borderWidth = 2
//                    singleBttn.layer.borderColor = UIColor.gray.cgColor
//                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
//                    selectedBornTypeId = 3
//                    
//                } else if et == LocalizedStrings.singlesText{
//                    
//                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    singleBttn.layer.borderWidth = 2
//                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
//                    etBttn.layer.borderColor = UIColor.gray.cgColor
//                    
//                    selectedBornTypeId = 1
//                    
//                }else if et == LocalizedStrings.multipleBirthStr{
//                    multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    multipleBirthBttn.layer.borderWidth = 2
//                    singleBttn.layer.borderColor = UIColor.gray.cgColor
//                    etBttn.layer.borderColor = UIColor.gray.cgColor
//                    selectedBornTypeId = 2
//                }
//                else {
//                    
//                    
//                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    singleBttn.layer.borderWidth = 2
//                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
//                    etBttn.layer.borderColor = UIColor.gray.cgColor
//                    
//                    selectedBornTypeId = 1
//                }
                
                if et == "Et"{
                    etBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    selectedBornTypeId = 3
                    etBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                    etBttn.setTitleColor(UIColor.white, for: .normal)
                }
                else if et == LocalizedStrings.singlesText{
    //                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
    //                singleBttn.layer.borderWidth = 2
    //                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
    //                etBttn.layer.borderColor = UIColor.gray.cgColor
    //                selectedBornTypeId = 1
                    singleBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    selectedBornTypeId = 1
                    singleBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                    singleBttn.setTitleColor(UIColor.white, for: .normal)
                    
                }
                else if et == LocalizedStrings.multipleBirthStr{
    //                multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
    //                multipleBirthBttn.layer.borderWidth = 2
    //                singleBttn.layer.borderColor = UIColor.gray.cgColor
    //                etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 2
                    multipleBirthBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    multipleBirthBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                    multipleBirthBttn.setTitleColor(UIColor.white, for: .normal)
                }
                else {
    //                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
    //                singleBttn.layer.borderWidth = 2
    //                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
    //                etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                    singleBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    singleBttn.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1)
                    singleBttn.setTitleColor(UIColor.white, for: .normal)
                }
                
                tissuId = Int(data.tissuId)
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                
                let adata = fetchAllDataOrderStatusMasterGirlando(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId, farmId: data.farmId!, earTag: data.earTag!, barcodeTag: data.animalbarCodeTag!)
                
                animalIdBool = false
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! AnimalMaster
                    idAnimal = Int(animal.animalId)
                    statusOrder = true
                }
            }
            breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.girolandoAssociationStr, comment:  "") , for: .normal)
            
        }
    }
    
    func byDefaultSetting(){
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
            dateTextField.placeholder = DateFormatters.MMDDYYYYFormat
        } else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
            dateTextField.placeholder = DateFormatters.DDMMYYYYFormat
            
        }
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        barAutoPopu = false
        self.isautoPopulated = false
        dateBttnOutlet.setTitle( "", for: .normal)
        dateTextField.text = ""
        dobLbl.textColor = UIColor.gray
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
            dobLbl.isHidden = true
        } else {
            dateTextField.isHidden = true
            dobLbl.isHidden = false
        }
//        tissueBttnOutlet.layer.borderWidth = 0.5
//        breedBtnOutlet.layer.borderWidth = 0.5
//        breedRegBttn.layer.borderWidth = 0.5
        dateBtnView.layer.borderColor = UIColor.gray.cgColor
    //    breedRegBttn.layer.borderColor = UIColor.gray.cgColor
        damRegTextfield.layer.borderColor = UIColor.gray.cgColor
        sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
        breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
        animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        breedBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        earTagView.layer.borderColor = UIColor.gray.cgColor
        scanEarTagTextField.text?.removeAll()
        scanBarcodeTextfield.text?.removeAll()
        damRegTextfield.text?.removeAll()
        sireRegTextfield.text?.removeAll()
        breedRegTextfield.text?.removeAll()
        animalNameTextfield.text?.removeAll()
        self.selectedDate = Date()
//        etBttn.layer.borderColor = UIColor.gray.cgColor
//        singleBttn.layer.borderColor = UIColor.gray.cgColor
//        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
//        etBttn.layer.borderWidth = 0.5
//        singleBttn.layer.borderWidth = 0.5
//        multipleBirthBttn.layer.borderWidth = 0.5
        etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        etBttn.isEnabled = false
        singleBttn.isEnabled = false
        multipleBirthBttn.isEnabled = false
        breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.girolandoAssociationStr, comment:  "") , for: .normal)
       // self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        
        if UserDefaults.standard.value(forKey: "DEGirlandoGender") as? String == "F" || UserDefaults.standard.value(forKey: "DEGirlandoGender") as? String == nil {
            male_femaleBttnOutlet.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            UserDefaults.standard.set("F", forKey: "DEGirlandoGender")
        } else {
            UserDefaults.standard.set("M", forKey: "DEGirlandoGender")
            male_femaleBttnOutlet.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = ButtonTitles.maleText.localized
        }
        
       
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        self.scrolView.contentOffset.y = 0.0
        if UserDefaults.standard.string(forKey: keyValue.dataEntryGirlandoSampleType.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntryGirlandoSampleType.rawValue) == ""{
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
            for items in self.tissueArr
            {
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if checkdefault == true
                {
                    self.tissueBttnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                    self.tissuId =  Int(tissue?.sampleId ?? 4)
                }
            }
        }
        else{
            tissueBttnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.dataEntryGirlandoSampleType.rawValue)?.localized, for: .normal)
        }
        
        if breedId  == "" {
            breedBtnOutlet.setTitle(ButtonTitles.girolandoText, for: .normal)
            let inheritBreed = fetchAllDataProductBeefIdNz(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 4)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
            }
        } else {
            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
            let inheritBreed = fetchAllDataProductGirlandoBreedID(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:4)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
            }
            
        }
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        dateTextField.text = ""
        dateBttnOutlet.titleLabel?.text = ""
        self.scanBarcodeTextfield.becomeFirstResponder()
        self.scanBarcodeTextfield.backgroundColor = .white
    }
    
    func anOptionalMethod(check :Bool){
        if check == true{
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            msgUpatedd = false
        }}
    
    
    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = DateFormatters.yyyyMMddFormat
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
    
   
    func statusOrderTrue() -> Bool{
        
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        } else {
            return false
        }
        
    }
    
    func validateBreed(completionHandler: CompletionHandler) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let data1 = fetchAllDataOrderStatusWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false", orderId:orderId,userId:userId)
        var bredidd123 = String ()
        if data1.count > 0 {
            let breeid1 = data1.object(at: 0) as! DataEntryAnimaladdTbl
            bredidd123 = breeid1.breedName ?? ""
        }
        
        if data1.count == 1 {
            UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
        }
        else {
            for i in 0 ..< data1.count{
                let breeid1 = data1.object(at: i) as! DataEntryAnimaladdTbl
                if bredidd123 == breeid1.breedName {
                    UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
                }
                else{
                    UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    return   completionHandler(true)
                    
                }
                bredidd123 = breeid1.breedName ?? ""
            }
        }
        return   completionHandler(true)
    }
    
    func timeStamp()-> String{
        let time1 = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatters.MMddyyyyHHmmssFormat
        let timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let string = lblTimeStamp as String
        let charset = CharacterSet(charactersIn: "i")
        if string.rangeOfCharacter(from: charset) != nil {
        }
        let udid = UserDefaults.standard.value(forKey: keyValue.applicationIdentifier.rawValue)! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    
    func doDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2
        {
            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        }
        else if langId == 3
        {
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else
        {
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
        let doneButton = UIBarButtonItem(title:  NSLocalizedString(LocalizedStrings.doneStr, comment: ""), style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title:  NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    
  
  
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
            
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
        
        if barcodeEnable == true {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
            if orederStatus.count > 0 {
                
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId!)
                    self.autoPop(animalData: animalFetch)
                    self.barcodeEnable = false
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                statusOrder = false
                self.scrolView.contentOffset.y = 0.0
                return
            }
        }
        else {
        }
        
        
        if scanEarTagTextField.text == ""  {
            self.validation()
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            completionHandler(false)
            return
        } else {
            addBtnCondtion(completionHandler: { (success) -> Void in
                if success == true{
                    completionHandler(true)
                }
            })
        }
        
        if notificationLblCount.text != "0"{
            countLbl.isHidden = false
            notificationLblCount.isHidden = false
            self.cartView.isHidden = false
        }
    }
    
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        if UserDefaults.standard.value(forKey: "DEGirlandoGender") as? String == "F" || UserDefaults.standard.value(forKey: "DEGirlandoGender") as? String == nil {
            male_femaleBttnOutlet.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            UserDefaults.standard.set("F", forKey: "DEGirlandoGender")
        } else {
            UserDefaults.standard.set("M", forKey: "DEGirlandoGender")
            male_femaleBttnOutlet.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = ButtonTitles.maleText.localized
        }
     if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            
            dateVale = dateTextField.text ?? ""
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBttnOutlet.titleLabel?.text ?? ""
                }
                else {
                    
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        } else {
            
            dateVale = dateBttnOutlet.titleLabel?.text ?? ""
            
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBttnOutlet.titleLabel?.text ?? ""
                }
                else {
                    
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
            
        }
        
        let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:(self.tissueBttnOutlet.titleLabel!.text!))
        let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
        
        if naabFetch1!.count != 0 {
            let breedIdGet = naabFetch1![0] as? Int
            self.tissuId = breedIdGet!
        }
        if dateTextField.text?.count == 0 {
            
            
        }
        else {
            if dateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: dateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr {
//                    dateBtnView.layer.borderColor = UIColor.gray.cgColor
//                    dateBtnView.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBtnView.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    if validate == LocalizedStrings.greaterThenDateStr {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                        return
                    }
                    return
                }
            }
            else {
                dateBtnView.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
            }
        }
  
        if  msgUpatedd == false {
            if barcodeflag == true &&  scanBarcodeTextfield.text != ""{
                let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.dataEntryAnimalAddTbl, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                if barCode.count > 0 {
                    barcodeView.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                    return
                }
            }
        }
        let animalData = fetchAnimaldataValidateAnimalTagGirlandoDataEntry(entityName: Entities.dataEntryAnimalAddTbl, earTag: scanEarTagTextField.text ?? "",listId: listIdGet, userId: userId,custmerId:custmerId ?? 0)
        
        if scanBarcodeTextfield.text != "" {
            let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.dataEntryAnimalAddTbl, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),IsDataEmail: false)
            if animaBarcOde.count > 0 {
                barcodeView.layer.borderColor = UIColor.red.cgColor
                
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                return
            }
        }
        
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        
        if animalData.count > 0  {
            isUpdate = true
            
            updateOrderStatusISyncAnimalMasterGirlando(entity: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text!, date: dateVale, damId: damRegTextfield.text ?? "", sireId: sireRegTextfield.text ?? "" , gender: genderString, update: "false", breedRegNumber: breedRegTextfield.text ?? "", tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: "", orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalId1, breedAssocation: breedRegBttn.titleLabel?.text ?? "",girlandoID: "")
            
            updateOrderStatusISyncAnimalMasterGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text!, date: dateVale, damId: damRegTextfield.text ?? "", sireId: sireRegTextfield.text ?? "" , gender: genderString, update: "true", breedRegNumber: breedRegTextfield.text ?? "", tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: "", orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalId1, breedAssocation: breedRegBttn.titleLabel?.text ?? "",girlandoID: "")
            
            updateOrderStatusISyncProductGirlando(entity: Entities.productAdonAnimalTblEntity,earTag: scanEarTagTextField.text ?? "",barCodetag:  scanBarcodeTextfield.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId:animalId1)
            
            updateOrderStatusISyncSubProductGirlando(entity: Entities.subProductTblEntity,earTag: scanEarTagTextField.text ?? "",barCodetag:  scanBarcodeTextfield.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId: animalId1)
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
           
            let fetchDataUpdate = fetchAnimalDataAccEarTagGirlando(entityName: Entities.animalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid)
            let fetchDataUpdate1 = fetchAnimalDataAccEarTagGirlando(entityName: Entities.dataEntryAnimalAddTbl,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid)
            
            
            if fetchDataUpdate.count != 0 {
                updateOrderInfoGirlando(entity: Entities.dataEntryAnimalAddTbl,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel?.text ?? "",custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                
                updateOrderInfoGirlando(entity: Entities.animalAddTblEntity,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "", date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel?.text ?? "",custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                
                updateOrderInfoGirlando(entity: Entities.animalMasterTblEntity,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel?.text ?? "",custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                
            }
            if fetchDataUpdate1.count != 0 {
                updateOrderInfoGirlando(entity: Entities.dataEntryAnimalAddTbl,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel?.text ?? "",custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                
                updateOrderInfoGirlando(entity: Entities.animalMasterTblEntity,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel?.text ?? "",custmerId:Int64(custmerId ?? 0),editFlagSave:true)
            }
            
            let adata = fetchAllDataOrderStatusMasterGirlando(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: farmIdText,earTag:scanEarTagTextField.text ?? "",barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                byDefaultSetting()
                
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                    
                    UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
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
                let data1 = fetchAllDataOrderStatusWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            
        } else if isUpdate == true {
            
            animalId1 = editAid
            updateOrderStatusISyncAnimalMasterGirlando(entity: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text!, date: dateVale, damId: damRegTextfield.text ?? "", sireId: sireRegTextfield.text ?? "" , gender: genderString, update: "false", breedRegNumber: breedRegTextfield.text ?? "", tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: "", orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalId1, breedAssocation: breedRegBttn.titleLabel?.text ?? "",girlandoID: "")
            
            updateOrderStatusISyncAnimalMasterGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text!, date: dateVale, damId: damRegTextfield.text ?? "", sireId: sireRegTextfield.text ?? "" , gender: genderString, update: "true", breedRegNumber: breedRegTextfield.text ?? "", tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: "", orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalId1, breedAssocation: breedRegBttn.titleLabel!.text!,girlandoID: "")
            
            updateOrderStatusISyncProductGirlando(entity: Entities.productAdonAnimalTblEntity,earTag: scanEarTagTextField.text ?? "",barCodetag:  scanBarcodeTextfield.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId:animalId1)
            
            updateOrderStatusISyncSubProductGirlando(entity: Entities.subProductTblEntity,earTag: scanEarTagTextField.text ?? "",barCodetag:  scanBarcodeTextfield.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId: animalId1)
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatusWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMasterGirlando(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId, farmId: "",earTag:scanEarTagTextField.text ?? "",barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                byDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                    
                    UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                    byDefaultSetting()
                }
                else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    byDefaultSetting()
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else {
            isUpdate = false
            let breedName =   breedBtnOutlet.titleLabel?.text
            let breedID =  fetchAllDataBreediDd(entityName: Entities.getProductTblEntity, breedName:breedName ?? ButtonTitles.girolandoText)
            if breedID.count > 0{
                
                let ob = breedID.object(at: 0) as! GetProductTbl
                breedId = ob.breedId!
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
            }
            breedId = UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String ?? keyValue.girlandoNewBreedId.rawValue
            let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
            
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                
                updateOrderStatusISyncAnimalMasterAnimalIdGirlando(entity: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text!, date: dateVale, damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "", gender: genderString, update: "false", breedRegNumber: breedRegTextfield.text ?? "", tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: farmIdText, orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalId1, animalidNew: animalID1, breedAssocation: breedRegBttn.titleLabel!.text!,girlandoID: "")
  
                let fetchDataUpdate = fetchAnimalDataAccEarTagGirlando(entityName: Entities.animalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid)
                let fetchDataUpdate1 = fetchAnimalDataAccEarTagGirlando(entityName: Entities.dataEntryAnimalAddTbl,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid)
                
                
                if fetchDataUpdate.count != 0 {
                    updateOrderInfoGirlando(entity: Entities.dataEntryAnimalAddTbl,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel!.text!,custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                    
                    updateOrderInfoGirlando(entity: Entities.animalAddTblEntity,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel!.text!,custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                    
                    updateOrderInfoGirlando(entity: Entities.animalMasterTblEntity,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel!.text!,custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                    
                }
                if fetchDataUpdate1.count != 0 {
                    updateOrderInfoGirlando(entity: Entities.dataEntryAnimalAddTbl,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel!.text!,custmerId:Int64(custmerId ?? 0),editFlagSave:true)
                    
                    updateOrderInfoGirlando(entity: Entities.animalMasterTblEntity,earTag: scanEarTagTextField.text ?? "", barCode: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,breedRegNumber: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text!,breedName: breedBtnOutlet.titleLabel!.text!,et: etBtn,farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:"",animalName:animalNameTextfield.text ?? "",userId:userId,udid: timeStampString,breedAssocation:breedRegBttn.titleLabel!.text!,custmerId:Int64(custmerId ?? 0),editFlagSave:true)
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
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalIdGirlando(entity: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text!, date: dateVale, damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "", gender: genderString, update: "false", breedRegNumber: breedRegTextfield.text ?? "", tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: farmIdText, orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalId1, animalidNew: animalID1, breedAssocation: breedRegBttn.titleLabel!.text!,girlandoID: "")
                }
                else {
                    saveAnimaldataGirlando(entity: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text ?? "", date: dateVale, damId: damRegTextfield.text ?? "", sireId: sireRegTextfield.text ?? "" , gender: genderString, update: "true", breedRegNumber: breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: "", orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId, breedAssocation: breedRegBttn.titleLabel!.text!,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "",girlandoID: "")
                }
            }
            
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId ?? 0)
            if data12333.count > 0{
                if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText || tissuId == 1 || tissuId == 18 {
                    saveAnimaldataGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text ?? "", date: dateVale, damId: damRegTextfield.text ?? "", sireId: sireRegTextfield.text ?? "" , gender: genderString, update: "false", breedRegNumber: breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: "", orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId, breedAssocation: breedRegBttn.titleLabel!.text!,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "",girlandoID: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                }
                else{
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.byDefaultSetting()
                        
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            else {
                saveAnimaldataGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: scanEarTagTextField.text ?? "", barCodetag: scanBarcodeTextfield.text ?? "", date: dateVale, damId: damRegTextfield.text ?? "", sireId: sireRegTextfield.text ?? "" , gender: genderString, update: "false", breedRegNumber: breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId: "", orderId: autoD, orderSataus: "false", breedId: breedId, isSync: "false", providerId: pvid, tissuId: tissuId, sireIDAU: "", animalName: animalNameTextfield.text ?? "", userId: userId, udid: timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId, breedAssocation: breedRegBttn.titleLabel!.text!,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "",girlandoID: "")
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            }
            
            statusOrder = false
            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
            self.animalSucInOrder = ""
            if self.msgAnimalSucess == false {
                if self.addContiuneBtn == 1 {
                    if self.msgcheckk == true {
                        self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .top)
                    }
                    else {
                        if self.isautoPopulated == true {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .top)
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .top)
                        }
                    }
                }
                else if self.addContiuneBtn == 2{
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
                else {
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
            }
            else {
                if self.msgcheckk == true {
                    self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .top)
                }
                else{
                    if self.isautoPopulated == true {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .top)
                    }else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                }
            }
            
            UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            
            UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.selectAnimalId.rawValue)
            barAutoPopu = false
         //   self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
           // male_femaleBttnOutlet.setTitle("Female", for: .normal)
            byDefaultSetting()
          //  genderToggleFlag = 0
          //  genderString = ButtonTitles.femaleText.localized
            etBtn.removeAll()
//            etBttn.layer.borderWidth = 0.5
//            singleBttn.layer.borderWidth = 0.5
//            multipleBirthBttn.layer.borderWidth = 0.5
            scanBarcodeTextfield.text = ""
            
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            let animalCount =  fetchAllDataAnimalDatarderIdGirlando(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false", listId: listIdGet, pvid: pvid)
            notificationLblCount.text = String(animalCount.count)
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if dateStr == "MM"{
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            dateBttnOutlet.setTitle("", for: .normal)
            dateBttnOutlet.setTitle(nil, for: .normal)
            dateVale = ""
            dateTextField.text = ""
            completionHandler(true)
        }
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                
                if scanBarcodeTextfield.text?.isEmpty == false {
                    textFieldBackroungWhite()
                }
            }
        }
    }
    
    func validation(){
        if scanEarTagTextField.text == ""{
            earTagView.layer.borderColor = UIColor.red.cgColor
        } else {
            earTagView.layer.borderColor = UIColor.gray.cgColor
        }
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
                    print("No candidate")
                    continue
                }
                textStr += "\n\(topCandidate.string)"
                DispatchQueue.main.async {
                    let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                    let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{/".contains($0)})
                    self.methReturn = self.ukTagReutn(animalId: test.uppercased())
                    
                    if self.methReturn == LocalizedStrings.againClick {
                        
                        self.scanEarTagTextField.text = ""
                        var mesageShow = String()
                        mesageShow = LocalizedStrings.unableToReadValue.localized(with: test)
                        
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title:NSLocalizedString("Retry", comment: "") , style: UIAlertAction.Style.default, handler: {
                            (_)in
                            //                            self.setUpGallary()
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
                            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                            vc?.delegate = self
                            self.navigationController?.pushViewController(vc!, animated: true)
                        })
                        let cancelAction = UIAlertAction(title:NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
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
            let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{/".contains($0)})
            
            let dropTwelveElement = test.suffix(12).uppercased()
            let totalString =  dropTwelveElement
            return totalString
            
        } else {
            let stringResultUS = idAnimal.contains("US")
            let stringResult840 = idAnimal.contains(LocalizedStrings.eightFortyCountryCode)
            
            if stringResultUS == true && stringResult840 == true {
                let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
                let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{/".contains($0)})
                if test.count < 15 {
                    return LocalizedStrings.againClick
                }
                else {
                    guard let range: Range<String.Index> = test.range(of: LocalizedStrings.eightFortyCountryCode) else {
                        return LocalizedStrings.againClick
                    }
                    
                    let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
                    print(index)
                    let countt = index + 14
                    if test.count < countt {
                        return LocalizedStrings.againClick
                    }
                    else {
                        let indexGet = test.subString(from: index, to: index + 14)
                        print(indexGet)
                        return indexGet
                    }
                }
            } else {
                return LocalizedStrings.againClick
            }
        }
        return LocalizedStrings.againClick
    }
}
