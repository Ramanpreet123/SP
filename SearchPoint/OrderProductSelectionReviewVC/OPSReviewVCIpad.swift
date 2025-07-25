//
//  OPSReviewVCIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 23/02/25.
//

import Foundation
import UIKit
import DropDown
import MBProgressHUD

class OPSReviewVCIpad: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BillingDelegate ,offlineCustomView1,UITextViewDelegate,objectPickfromConfilict, DismissConflictPopUp{
    func updateDismissUI() {
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pviduser)
        notificationLblCount.text = String(animalCount.count)
                 NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
                 
         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
         
         self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
         
         self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
  
        tableViewBilling.delegate = billingdelegateVC
        tableViewBilling.dataSource = billingdelegateVC
        tableViewBilling.reloadData()
        billingdelegateVC.delegate = self
         let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
         
         for item in animalCount  {
             
             let data = item as! AnimaladdTbl
             let screen  = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
             
             if screen == keyValue.farmId.rawValue {
                 
                 let marketName = UserDefaults.standard.value(forKey: "marketName") as? String
                           
                           if marketName == "BR" {
                               if pviduser == 1 {
                                 if data.date == "" {
                                     UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                     UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                                     break
                                 } else {
                                 
                                   UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                                   UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                                 }
                                 
                               }
                           }
                 if pviduser == 1 ||  pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {

                if pviduser == 3 {
                 if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                     
                     if data.date == "" {
                         UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                          UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                         break
                     } else {
                     
                 UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                 UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                     }
                
                 }
                 }
                     if data.animalTag == "" || data.farmId == "" || data.date == ""{
                     
                     UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                     UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                     break
                 } else {
                     // 3 value hai
                     UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                     UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                 }
             }
         }
                 
             else {
                 if pviduser == 1 ||  pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {

                     if data.farmId == "" || data.animalTag == "" || data.date == ""{
                     
                     UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                     UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                     break
                 } else {
                     
                     UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                     UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                     
                     }}
             }
             if pviduser == 4 {
                 
                 if data.animalName == "" ||  data.date == ""{
                     UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                     UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                     break
                 } else {
                     UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                     UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                 }
             }
           
         }
         
         
         if  UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == ""{
             
             UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
             
             self.clickOnDropDown = NSLocalizedString("On-Farm ID", comment: "")
             
           //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
             self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
             self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
             self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
             fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
             
             
             if pviduser == 4 {
                 
                 UserDefaults.standard.set("Ear Tag", forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                 
                 self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
                 self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                 self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
              //   self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                 
                 fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                 
             }
             
         }
         
         if pviduser == 4 {
             
             self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
             self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
             self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
           //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
             
             fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
             
         }else{
             
             self.clickOnDropDown = NSLocalizedString("On-Farm ID", comment: "")
             
           //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
             self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
             self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
             self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
             fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
             
         }
         
         if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
             
             self.clickOnDropDown = NSLocalizedString("On-Farm ID", comment: "")
             
            // self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
             self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
             self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
             self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
             fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
             
             if pviduser == 4 {
                 
                 UserDefaults.standard.set("Ear Tag", forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                 
                 self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
                 self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                 self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
             //    self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                 
                 fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                 
                 
                 
             }
             
         }
         
         if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
             
             self.clickOnDropDown = NSLocalizedString("Official ID", comment: "")
             self.sortByFarmImgView.image = UIImage(named: "radioBtn")
             self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
             self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
             
             self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
             
         }
         
         if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
             
             self.clickOnDropDown =  NSLocalizedString("Barcode", comment: "")
             self.sortByFarmImgView.image = UIImage(named: "radioBtn")
             self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
             self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
             self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
             
             if pviduser == 4 {
                 self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                 self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
             }
         }

         DispatchQueue.main.async {
   
                 if UserDefaults.standard.value(forKey: "name") as? String  == "Dairy"{
                     
                     self.submitOrderOutlet.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
                     if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true {
                         
                         self.infoBtnSelectionOutlet.isHidden = true
                         self.agreeInfoBtnOutelt.isHidden = true
                         self.infoBtnSelectionOutlet.isHidden = false
                         self.agreeLl.isHidden = true
                         self.agrreLblStackView.isHidden = true
                         self.agreeStackViewTopConstraint.constant = -70
                         
                     } else {
                         self.infoBtnSelectionOutlet.isHidden = false

                         self.submitOrderOutlet.isHidden = false
                         self.infoBtnSelectionOutlet.isHidden = false
                         self.agreeLl.isHidden = false
                         self.agreeStackViewTopConstraint.constant = 20
                         self.agrreLblStackView.isHidden = false
                     }
                     
                     
                     
                     
                     
                     if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
                         
                         self.nominatorLbl.isHidden = false
                         
                         self.nominatorTitle.isHidden = false
                         
                     }
                         
                     else{
                         
                         self.nominatorLbl.isHidden = true
                         
                         self.nominatorTitle.isHidden = true
                         
                     }
                 }
      
             self.customerNameLbl.text = UserDefaults.standard.value(forKey: "farmValue") as! String

         }
         
       
       if farmAddr.count > 0  {
         var abc = ""
         let filterArr = farmAddr.filter({$0.isDefault == true })
         if filterArr.count > 0{
           abc = filterArr[0].contactName ?? ""
         } else{
           
           let billArray =  farmAddr.filter({Int($0.billToCustId!) == self.custmerId})
           abc = billArray[0].contactName ?? ""
           UserDefaults.standard.set(billArray[0].billToCustId, forKey: "billToCustomerId")
         }
           customerNameLbl.text = abc

       }
         
         
         self.setSubmitOrderInitialUI()
        self.setTermsConditionUI()
        let dataval:  [ProductAdonAnimalTbl] =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimalTbl]
        fetchProductAdonAnimalTbl(fethData: fethData, completion: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                for i in 0..<dataval.count{
                  self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: Int(dataval[i].animalId) , index: i)
                  
//                    if let index = self.indexOfSelection[i], let collView = self.collViewOfselection[i]{
//                        self.fetchAdonData(indexPath: index, collectionView: collView)
//                    }
                }
            }
        })
    }
    
    
    func crossBtn() {
        
    }
    func firstLevel(check: Bool) {
       
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!

        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12{
            
          if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count != 0 {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfilictOrdersViewController") as! ConfilictOrdersViewController
        vc.delegateCustom1 = self
        vc.screenName = "productSelectionReview"
        self.present(vc, animated: true, completion: nil)
        }}
        
        if pviduser == 4 || pviduser == 6 || pviduser == 8{
            
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count != 0 {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfilictOrdersViewController") as! ConfilictOrdersViewController
        vc.delegateCustom1 = self
        vc.screenName = "productSelectionReview"
        self.present(vc, animated: true, completion: nil)
        }}
    }
    func selectionObject(check: Bool) {
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        if pviduser == 4 {
            
            if check == true{
                let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "OrderingAnimalVCGirlandoIpad") as! OrderingAnimalVCGirlandoIpad
                navigationController?.pushViewController(vc,animated: false)

            } else {
                let storyboard = UIStoryboard(name: "iPad", bundle: nil)
                let secondViewController = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
                self.navigationController!.pushViewController(secondViewController, animated: false)

            }
        }else {
        if check == true{
            let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OrderingAnimalipadVC") as! OrderingAnimalipadVC
            navigationController?.pushViewController(vc,animated: false)

        } else {
            let storyboard = UIStoryboard(name: "iPad", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
            self.navigationController!.pushViewController(secondViewController, animated: false)

        }}
    }
    func dataReload(check :Bool){
        if check == true{
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReviewOrderVC") as! ReviewOrderVC
            self.navigationController?.pushViewController(newViewController, animated: false)

        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OPSReviewVCIpad") as! OPSReviewVCIpad
            self.navigationController?.pushViewController(newViewController, animated: false)

   //     self.setSubmitOrderInitialUI()
        }
        
    }
    weak var dismissDelegate : DismissConflictPopUp?
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
    @IBOutlet weak var nominatorView: UIView!
    @IBOutlet weak var sortByBarcodeBtn: UIButton!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sortByAscendingBtn: UIButton!
    @IBOutlet weak var sortByAscendingImgView: UIImageView!
    @IBOutlet weak var sortByAscendingBrazilImgView: UIImageView!
    @IBOutlet weak var sortByDescendingBrazilImgView: UIImageView!
    @IBOutlet weak var sortByDescendingBtn: UIButton!
    @IBOutlet weak var sortByDescendingImgView: UIImageView!
    @IBOutlet weak var sortByBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByOfficialIDImgView: UIImageView!
    @IBOutlet weak var sortByOfficialIDBtn: UIButton!
    @IBOutlet weak var sortByFarmImgView: UIImageView!
    @IBOutlet weak var sortByFarmIDBtn: UIButton!
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var placeAnOrderImgView: UIImageView!
    @IBOutlet weak var placeAnOutlet: UIButton!
    @IBOutlet weak var infooBtnSubmitOutlet: UIButton!
    @IBOutlet weak var placeAnotrderTitle: UILabel!
    @IBOutlet weak var infoBtnEmailOutlet: UIButton!
    @IBOutlet weak var emailMeEnterTtitle: UILabel!
    @IBOutlet weak var emailBtnImgView: UIImageView!
    @IBOutlet weak var emailCheckOutlet: UIButton!
    @IBOutlet weak var agreeInfoBtnOutelt: UIButton!
    @IBOutlet weak var agreeStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var AgreeBtnImgView: UIImageView!
    @IBOutlet weak var agrreLblStackView: UIStackView!
    @IBOutlet weak var infoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var agreeLl: UILabel!
    @IBOutlet weak var submitOrderOutlet: UIButton!
    @IBOutlet weak var nominatorTitle: UILabel!
    @IBOutlet weak var nominatorLbl: UILabel!
    @IBOutlet weak var evaluationTitle: UILabel!
    @IBOutlet weak var clarifideLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var billingBtnOutlet: UIButton!
    @IBOutlet weak var billingContactLbl: UILabel!
    @IBOutlet weak var reviewOrderTitle: UILabel!
    @IBOutlet weak var sortByTitle: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var animalTitle: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var sortByBrazilView: UIView!
    @IBOutlet weak var sortByBrazilBarcodeBtn: UIButton!
    @IBOutlet weak var sortByBrazilBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByEarTagImgView: UIImageView!
    @IBOutlet weak var sortByEarTagBtn: UIButton!
    
    
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var pricingLinkC :String?
    
    var earTagID = Int()
    var ascendingFound = true
    @IBOutlet weak var farmIdHideLbl: UILabel!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var farmIdDisplyOutlet: UIButton!
    @IBOutlet weak var serchTextField: UITextField!
    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var tableViewBilling : UITableView!
    @IBOutlet weak var dropUpDownBtn: UIButton!
    @IBOutlet weak var networkStatusLbl: UILabel!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var OffLineBtn: UIButton!
    @IBOutlet weak var innerScrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var billingView: UIView!
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    let dropDown = DropDown()
    var arr1 = [Int:[ProductAdonAnimalTbl]]()
    var values = [Int]()
    var farmID = [String]()
    var earTag = [String]()
    var barCode = [String]()
    var animaltag = [String]()
    var selection = [[String:Any]]()
    var aTag:Int!
    var pid = Int()
    var fethData:NSArray!
    var farmId = Int()
    var barCodeId = Int()
    var animaId = Int()
    var clickOnDropDown = String()
    var isBillingContact = true
    // networkCheck
    var indexOfSelection:[IndexPath?] = [IndexPath]()
    var collViewOfselection:[UICollectionView?] = [UICollectionView]()
    var billingdelegateVC = BillingTableViewDelegate()
    //var farmAddr = fetchAllData(entityName: "GetBillingContact") as! [GetBillingContact]
    var userId = Int()
    var orderId = Int()
    var pviduser = Int()
  var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
  var farmAddr = [GetBillingContact]()
    
    
    
    
    override func viewDidLoad() {
        self.setSideMenu()
        serchTextField.setLeftPaddingPoints(20.0)
        dismissDelegate.self = self
      farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        languageConversion(languageId: langId!)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!

        let clariText = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        clarifideLbl.text = clariText ?? ""
//        if self.clarifideLbl.text!.count > 21 {
//            self.clarifideLbl.font = self.clarifideLbl.font.withSize(15)
//        } else {
//            self.clarifideLbl.font = self.clarifideLbl.font.withSize(22)
//        }
        evaluationTitle.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
        nominatorTitle.text = "Nominator".localized
        if UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String == nil || UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String == ""{
            nominatorLbl.text = "Zoetis"
        }
        else {
            let nomi = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
            nominatorLbl.text = nomi!.uppercased()
        }
        
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        transparentView.isHidden = true
        sortByView.isHidden = true
        billingView.isHidden = true
      
      let dataval:  [ProductAdonAnimalTbl] =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimalTbl]
      
        fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId: serchTextField.text!)
        fetchProductAdonAnimalTbl(fethData: fethData, completion: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                for i in 0..<dataval.count{
                  self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: Int(dataval[i].animalId) , index: i)
                  
//                    if let index = self.indexOfSelection[i], let collView = self.collViewOfselection[i]{
//                        self.fetchAdonData(indexPath: index, collectionView: collView)
//                    }
                }
            }
        })
        
        perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pviduser)
        notificationLblCount.text = String(animalCount.count)
        setTermsConditionUI()
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
    
    func sideMenuRevealSettingsViewController() -> OPSReviewVCIpad? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is OPSReviewVCIpad {
            return viewController! as? OPSReviewVCIpad
        }
        while (!(viewController is OPSReviewVCIpad) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is OPSReviewVCIpad {
            return viewController as? OPSReviewVCIpad
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    
    func setTermsConditionUI(){
        
        if ( UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  false ) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  nil ) {
         //   infoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            AgreeBtnImgView.image = UIImage(named: "Incremental_Check")
        } else {
         //   infoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            AgreeBtnImgView.image = UIImage(named: "incrementalCheckIpad")
        }
        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true{
            self.infoBtnSelectionOutlet.isHidden = true
        } else {
            self.infoBtnSelectionOutlet.isHidden = false
        }
    }
    
    @IBAction func checkBoxBtnAction(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == true {
            sender.isSelected = false
            AgreeBtnImgView.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
            
        } else {
            sender.isSelected = true
            AgreeBtnImgView.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
    }
    
  
    
    func setSubmitOrderInitialUI(){
        
        if UserDefaults.standard.value(forKey: "name") as? String  == "Dairy"{
            
            self.submitOrderOutlet.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
          
          let pviduser1 = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
          if pviduser1 == 4 {
            let checkCartAnimal =  fetchAllDataGirlandoAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalTag:"", pvid: pviduser1,dob: "", animalName: "")
            if checkCartAnimal.count != 0 {
              UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
              
            } else {
              UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
              
            }
          } else {
            let checkCartAnimal =  fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid:pviduser1, dob: "")
            if checkCartAnimal.count != 0 {
              UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
              
            } else {
              UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
              
            }
          }
          
            
            if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true {
            
                self.agreeInfoBtnOutelt.isHidden = true
                self.infoBtnSelectionOutlet.isHidden = true
                self.agreeLl.isHidden = false
              
                self.submitOrderOutlet.isHidden = false
                self.infooBtnSubmitOutlet.isHidden = false
                self.agrreLblStackView.isHidden = true
                agreeStackViewTopConstraint.constant = -70
            } else {
    
                self.submitOrderOutlet.isHidden = false
                self.infooBtnSubmitOutlet.isHidden = false
                self.infoBtnSelectionOutlet.isHidden = false
                self.agreeInfoBtnOutelt.isHidden = false
                self.agreeLl.isHidden = false
                self.agrreLblStackView.isHidden = false
                agreeStackViewTopConstraint.constant = 20
            }
            
            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true{
                self.placeAnOutlet.isSelected = true
            } else {
                self.placeAnOutlet.isSelected = false
            }
            
            
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
                self.nominatorLbl.isHidden = false
                self.nominatorTitle.isHidden = false
                self.nominatorView.isHidden = false
            }
            else{
                self.nominatorLbl.isHidden = true
                self.nominatorTitle.isHidden = true
                self.nominatorView.isHidden = true
            }
            
            
        }
       
        self.billingContactLbl.text = NSLocalizedString("Billing Contact:", comment: "")
        self.agreeLl.text = "I agree to the Acceptance and Authorization, Warranty and Indemnification and Data Usage Policies.".localized
            // cell.pricingTextView.text = "Para obter informações sobre preços de lista de produtos, visite a seguinte página da web.Preços"
            //     cell.billingContact.text = "Contato de cobrança"
        self.evaluationTitle.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
            
        self.nominatorTitle.text = "Nominator".localized
        self.placeAnotrderTitle.text = "Place an Order".localized
        self.emailMeEnterTtitle.text = "E-Mail Me Entered Data".localized

       
        
        if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "emailMe" || UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "" ||  UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == nil{
      
           // cell.emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            //cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
            UserDefaults.standard.setValue("email", forKey: "emailFlag")
            if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
            {
              //  cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
            }
            else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
            {
               // cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                emailBtnImgView.image = UIImage(named: "Incremental_Check")
            }
            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                
                 //   self.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                  //  .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.placeAnOutlet.isSelected == false
                {
                  //  self.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                   //     .normal)
                        placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                }
           // cell.placeAnotrderTitle.alpha = 0.6
           // cell.emailMeEnterTtitle.alpha = 0.6
            
            
      } else {
       // cell.placeAnOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
        //cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
        
        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
        {
           // cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
        }
        else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
        {
           // cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            emailBtnImgView.image = UIImage(named: "Incremental_Check")
        }
        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
            
                //self.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
           // .normal)
            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
            }
            else  if self.placeAnOutlet.isSelected == false
            {
               // self.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                  //  .normal)
                    placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
            }
        UserDefaults.standard.setValue("submit", forKey: "submitTypeSelection")
       // cell.emailMeEnterTtitle.alpha = 1
        self.emailMeEnterTtitle.alpha = 1

        
    }
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {

          if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                self.placeAnOutlet.alpha = 1
                self.emailMeEnterTtitle.alpha = 1
                if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String ==  "submit" {
                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                        
                       // self.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                      //  .normal)
                        placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.placeAnOutlet.isSelected == false
                        {
                           // self.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        //    .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        }
                    
                    if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                    {
                       // self.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    }
                    else  if self.emailCheckOutlet.isSelected == false
                    {
                       // self.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    }

                      //  cell.placeAnOutlet.alpha = 1

                    } else {
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                        {
                           // self.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.emailCheckOutlet.isSelected == false
                        {
                            //self.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                            
                         //   self.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                           // .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            }
                            else  if self.placeAnOutlet.isSelected == false
                            {
                                //self.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            //    .normal)
                                placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            }

                      
                          }
        } else {
         //   cell.placeAnOutlet.setImage(UIImage(named: "checkboxgray"), for: .normal)
            if pviduser == 3 {
                if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: "SubmitBtnFlagNew") == true{
                    self.placeAnOutlet.alpha = 1
                    self.emailMeEnterTtitle.alpha = 1

                }else {
                    self.placeAnOutlet.alpha = 0.6
                    self.emailMeEnterTtitle.alpha = 0.6

                }
                
            }else {
                if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: "SubmitBtnFlagNew") == true {
                    self.placeAnOutlet.alpha = 1
                    self.emailMeEnterTtitle.alpha = 1

                }else {
                    self.placeAnOutlet.alpha = 0.6
                    self.placeAnotrderTitle.alpha = 0.6
                }}
       
            
         }
        }
        if pviduser == 4 || pviduser == 6 || pviduser == 8 {
            
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                
                self.placeAnOutlet.alpha = 1

            if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String ==  "submit" {
                //cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
                {
                    
                 //   self.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                  //  .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                    }
                    else  if self.placeAnOutlet.isSelected == false
                    {
                       // self.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                       // .normal)
                        placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                    }
                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                {
                    self.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.emailCheckOutlet.isSelected == false
                {
                    self.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }

            }else {
              
//                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
//                    {
//
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.placeAnOutlet.isSelected == false
//                        {
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
                {
                    
                   // self.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                  //  .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                    }
                    else  if self.placeAnOutlet.isSelected == false
                    {
                     //   self.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                     //   .normal)
                        placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                    }
                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                {
                    self.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.emailCheckOutlet.isSelected == false
                {
                    self.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
               // cell.emailMeEnterTtitle.alpha = 1

            }
            

        } else {
           // cell.placeAnOutlet.setImage(UIImage(named: "checkboxgray"), for: .normal)
            //cell.placeAnOrderSelectionOutlet.alpha = 0.6
           // cell.emailCheckOutlet.alpha = 0.6
            self.emailMeEnterTtitle.alpha = 1
           // cell.placeAnOutlet.alpha = 1
            self.placeAnotrderTitle.alpha = 0.6

         }
            
        }
    }
    
    @IBAction func emailCheckBoxAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 1
            }
            else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 0.6
                placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
            }
        }
        else if pviduser == 4 || pviduser == 6 || pviduser == 8{
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 1
            }
            else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 0.6
            }
        }
    }
    
    @IBAction func placeAnAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
            sender.isSelected = false
           // placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: keyValue.placeOrderCheck.rawValue)
        }
        else {
            sender.isSelected = true
            //placeAnOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: keyValue.placeOrderCheck.rawValue)
        }
        
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3  || pviduser == 10 || pviduser == 11 || pviduser == 12{
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                if pviduser == 3 {
                    if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                        placeAnOutlet.alpha = 1
                    }
                    else {
                        self.selectionObjectCheck(check :true)
                    }
                }
                else {
                    if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                        placeAnotrderTitle.alpha = 1
                        emailMeEnterTtitle.alpha = 1
                        placeAnOutlet.alpha = 1
                    }else {
                        self.selectionObjectCheck(check :true)
                    }
                }
            }
        }
        else if pviduser == 4 || pviduser == 6 || pviduser == 8 {
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                self.selectionObjectCheck(check :true)
            }
        }
    }
    
    func selectionObjectCheck(check :Bool){
        if check == true{
            let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.confilictOrdersViewControllerVC) as! ConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.dismissDelegate = self
            vc.screenName = "OPSAnimalReview"
            self.present(vc, animated: true, completion: nil)
           // self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func sortAscendingAction(_ sender: UIButton) {
        if sender.tag == 100{
            ascendingFound = false
            self.sortByAscendingImgView.image = UIImage(named: "radioBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioSeletedBtn")
        } else if sender.tag == 500{
            ascendingFound = true
            self.sortByDescendingBrazilImgView.image = UIImage(named: "radioBtn")
            self.sortByAscendingBrazilImgView.image = UIImage(named: "radioSeletedBtn")
        } else if sender.tag == 600{
            ascendingFound = false
            self.sortByDescendingBrazilImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByAscendingBrazilImgView.image = UIImage(named: "radioBtn")
        }
        else {
            ascendingFound = true
            self.sortByAscendingImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioBtn")
        }
    }
    
    @IBAction func sortDoneAction(_ sender: Any) {
        if  UserDefaults.standard.object(forKey:  keyValue.fOSampleTrackingDetailVC.rawValue) as! String == ButtonTitles.earTagText{
            if self.earTagID == 0{
                self.earTagID = 1
                // self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : ascendingFound,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            }
            else{
                //    self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.earTagID = 0
                self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : ascendingFound,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            }
            
           
            self.sortByBrazilView.isHidden = true
            self.transparentView.isHidden = true
        } else if UserDefaults.standard.object(forKey:  keyValue.fOSampleTrackingDetailVC.rawValue) as! String == keyValue.farmId.rawValue{
            if self.farmId == 0{
                if pviduser == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:ascendingFound,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                }
                else {
//                    self.fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:ascendingFound,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                    self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:ascendingFound,status: "true", orderStatus: "false", orderId: self.orderId, userId: self.userId, farmId: serchTextField.text!)
                }
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                //  self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.farmId = 1
                
                
            }
            else{
                //    self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                if pviduser == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:ascendingFound,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                }
                else {
                    self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:ascendingFound,status: "true", orderStatus: "false", orderId: self.orderId, userId: self.userId, farmId: serchTextField.text!)
                }
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.farmId = 0
                
            }
            self.sortByView.isHidden = true
            self.transparentView.isHidden = true
        } else if UserDefaults.standard.object(forKey:  keyValue.fOSampleTrackingDetailVC.rawValue) as! String == keyValue.officialId.rawValue{
            if self.animaId == 0{
                //  self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                if pviduser == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    
                    self.fethData = fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity,asending : ascendingFound,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                    
                }else {
                    
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : ascendingFound,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                }
                
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.animaId = 1
            }
            else{
                //  self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                if pviduser == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    self.fethData =  fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity, asending: ascendingFound,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                }
                else {
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : ascendingFound,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                }
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.animaId = 0
                
            }
            
            self.sortByView.isHidden = true
            self.transparentView.isHidden = true
        } else if UserDefaults.standard.object(forKey:  keyValue.fOSampleTrackingDetailVC.rawValue) as! String == keyValue.barcode.rawValue{
            if self.barCodeId == 0{
                //      self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                if pviduser == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    self.fethData = fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: ascendingFound,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                }
                else {
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: ascendingFound,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                }
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.barCodeId = 1
            }
            else{
                //   self.dropUpDownBtn.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                if pviduser == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    self.fethData =  fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: ascendingFound,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                }
                else {
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: ascendingFound,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                }
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.barCodeId = 0
                
            }
            self.sortByView.isHidden = true
            self.transparentView.isHidden = true
            self.sortByBrazilView.isHidden = true
            self.transparentView.isHidden = true
        }
    }
    @IBAction func sortByBarcodeAction(_ sender: UIButton) {
        if sortByBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortByFarmImgView.image = UIImage(named: "radioBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        }
    }
    
    @IBAction func sortByBrazilBarcodeAction(_ sender: UIButton) {
        if sortByBrazilBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else{
            self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        }
      
    }
    @IBAction func sortByEarTagAction(_ sender: UIButton) {
        
        if sortByEarTagImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        }
    }
    @IBAction func sortByFarmIDAction(_ sender: UIButton) {
        
        if sortByFarmImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        }
    }
    
    @IBAction func sortByOfficialIDAction(_ sender: UIButton) {
        if sortByOfficialIDImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortByFarmImgView.image = UIImage(named: "radioBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
        }
    }
    
    @IBAction func farmIdDropDown(_ sender: UIButton) {
        if pviduser != 4 {
            self.sortByView.isHidden = false
            self.transparentView.isHidden = false
            self.sortByBrazilView.isHidden = true
        } else {
            self.sortByView.isHidden = true
            self.transparentView.isHidden = false
            self.sortByBrazilView.isHidden = false
        }
      
        
//          serchTextField.text = ""
//        serchTextField.resignFirstResponder()
//        dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
//        dropDown.anchorView = farmIdHideLbl
//        dropDown.direction = .bottom
//        dropDown.backgroundColor = UIColor.white
//        dropDown.separatorColor = UIColor.clear
//        dropDown.cornerRadius = 10
//        dropDown.textFont = UIFont.systemFont(ofSize: 13)
//        dropDown.cellHeight = 30
//        
//        dropDown.dataSource = [ NSLocalizedString("On-Farm ID", comment: ""),NSLocalizedString("Official ID", comment: ""), NSLocalizedString("Barcode", comment: "")]
//        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
//        
//        if pviduser == 4 {
//            dropDown.dataSource = [ NSLocalizedString("Ear Tag", comment: ""),NSLocalizedString("Barcode", comment: "")]
//            
//        }
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//           
//            
//            self.clickOnDropDown = item
//            
//            //self.farmIdDisplyOutlet.setTitle(item, for: .normal)
//       //     self.farmIdDisplyOutlet.layer.borderColor = UIColor.gray.cgColor
//            
//            
//            if self.clickOnDropDown == NSLocalizedString("On-Farm ID", comment: ""){
//                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
//                if self.farmId == 0{
//                    
//                    self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: self.orderId, userId: self.userId, farmId: self.serchTextField.text!)
//                    
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                    
//                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
//                    self.farmId = 1
//                    
//                }
//                else{
//                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
//                    
//                    self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:false,status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                    self.farmId = 0
//                }
//                
//            }
//                
//            else if self.clickOnDropDown == "Ear Tag" || self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: ""){
//                //write your code
//                UserDefaults.standard.set("Ear Tag", forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
//                if self.earTagID == 0{
//                    self.earTagID = 1
//                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
//                    
//                    self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                }
//                else{
//                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
//                    self.earTagID = 0
//                    self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                }
//            }
//            else if self.clickOnDropDown == NSLocalizedString("Official ID", comment: ""){
//                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
//                if self.animaId == 0{
//                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
//                    
//                    self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                    self.animaId = 1
//                }
//                else{
//                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
//                    
//                    self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                    self.animaId = 0
//                }
//                
//            }
//            else{
//                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
//                if self.barCodeId == 0{
//                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
//                    
//                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                    self.barCodeId = 1
//                }
//                else{
//                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
//                    
//                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
//                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
//                    self.barCodeId = 0
//                }
//                
//            }
//        }
//        dropDown.show()
    }
    
  func languageConversion(languageId :Int){
    sortByTitle.text =  NSLocalizedString("Sort By", comment: "")
    serchTextField.placeholder = NSLocalizedString("Search", comment: "")
  }
    
    @IBAction func productAction(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        //        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        //        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
     
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    
    private func fetchProductAdonAnimalTbl(fethData:NSArray,completion: @escaping ()->()){
        values.removeAll()
        barCode.removeAll()
        farmID.removeAll()
        earTag.removeAll()
        arr1.removeAll()
        animaltag.removeAll()
        for value in fethData{
            if let item = value as? ProductAdonAnimalTbl{
                
                if values.contains(Int(item.animalId)){
                    arr1[Int(item.animalId)]?.append(item)
                } else {
                    values.append(Int(item.animalId))
                    farmID.append(item.farmId ?? "")
                    earTag.append(item.earTag ?? "")
                    
                    barCode.append(item.animalbarCodeTag ?? "")
                    animaltag.append(item.animalTag ?? "")
                    arr1[Int(item.animalId)] = [ProductAdonAnimalTbl]()
                    arr1[Int(item.animalId)]?.append(item)
                }
            }
        }
        reloadTable()
        completion()
    }
  func fetchAdonData(pid:Int, animaltag:Int, index:Int) {
    
//            let data = fetchSubProductDataDairy(productId: Int(pid),animalTag: animaltag,orderId:orderId,userId:userId) as? [SubProductTbl]
    
        let data = fetchSubProductDataDairyreview(productId: Int(pid),animalTag: animaltag,orderId:orderId,userId:userId, status: "true") as? [SubProductTbl]
            var found = false
            
            for i in 0..<selection.count{
                if let value = (selection[i]["animalId"]) as? Int, value  == animaltag{
                    selection[i]["animalId"] = animaltag
                    selection[i]["addon"] = data
                    selection[i]["row"] = index
                    found = true
                    break
                }
            }
            if found ==  false && data!.count > 0{
                selection.append (["animalId":animaltag,"addon":data,"row":index])
            }
        
    
    reloadTable()
    
    
}
    func fetchAdonData(indexPath:IndexPath, collectionView:UICollectionView) {
        if  collectionView.tag < values.count {
            
            if arr1[values[collectionView.tag]]!.count > indexPath.row {
                
                pid = Int(arr1[values[collectionView.tag]]![indexPath.row].productId)
                aTag = Int(arr1[values[collectionView.tag]]![indexPath.row].animalId)
                let data = fetchSubProductDataDairyreview(productId: Int(pid),animalTag: aTag!,orderId:orderId,userId:userId, status: "true") as? [SubProductTbl]
                var found = false
                
                for i in 0..<selection.count{
                    if let value = (selection[i]["animalId"]) as? Int, value  == aTag{
                        selection[i]["animalId"] = aTag
                        selection[i]["addon"] = data
                        selection[i]["row"] = collectionView.tag
                        found = true
                        break
                    }
                }
                if found ==  false && data!.count > 0{
                    selection.append (["animalId":aTag,"addon":data,"row":collectionView.tag])
                }
            }
        }
        reloadTable()
        
        
    }
    @objc func reloadTable(){
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
    }
    
   
    @IBAction func billingClick(_ sender: UIButton) {
        transparentView.isHidden = false
        billingView.isHidden = false
        isBillingContact = false
        //billingViewHeightConst.constant = tableViewBilling.contentSize.height + 100
        tableViewBilling.reloadData()
        
    }
    var value = 0
    @objc func methodOfReceivedNotification(notification: Notification)
        {
           
            if value == 0
                       {
                       UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
                       let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                       let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
                       self.navigationController?.pushViewController(newViewController, animated: true)
                       self.hideIndicator()
                          value = value + 1
                      }
    //        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
          
        }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    override func viewWillAppear(_ animated: Bool) {
        tableViewBilling.delegate = billingdelegateVC
        tableViewBilling.dataSource = billingdelegateVC
        tableViewBilling.reloadData()
        billingdelegateVC.delegate = self
        switch UIScreen.main.bounds.height {
        case 768:
            self.innerScrollViewHeight.constant = 600
            
        case 810:
            self.innerScrollViewHeight.constant = 600
            
        case 820:
            self.innerScrollViewHeight.constant = 600
            

        case 834:
            self.innerScrollViewHeight.constant = 600

        case 1024:
            self.innerScrollViewHeight.constant = 750

        case 1032:
            self.innerScrollViewHeight.constant = 750
        default:
            break
        }
       
                NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
                
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
 
        
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pviduser)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        
        for item in animalCount  {
            
            let data = item as! AnimaladdTbl
            let screen  = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
            
            if screen == keyValue.farmId.rawValue {
                
                let marketName = UserDefaults.standard.value(forKey: "marketName") as? String
                          
                          if marketName == "BR" {
                              if pviduser == 1 {
                                if data.date == "" {
                                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                    UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                                    break
                                } else {
                                
                                  UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                                  UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                                }
                                
                              }
                          }
                if pviduser == 1 ||  pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {

               if pviduser == 3 {
                if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    
                    if data.date == "" {
                        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                         UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                        break
                    } else {
                    
                UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                    }
               
                }
                }
                    if data.animalTag == "" || data.farmId == "" || data.date == ""{
                    
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                    break
                } else {
                    // 3 value hai
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                }
            }
        }
                
            else {
                if pviduser == 1 ||  pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {

                    if data.farmId == "" || data.animalTag == "" || data.date == ""{
                    
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                    break
                } else {
                    
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                    
                    }}
            }
            if pviduser == 4 {
                
                if data.animalName == "" ||  data.date == ""{
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                    break
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                }
            }
          
        }
        
        
        if  UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == ""{
            
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
            
            self.clickOnDropDown = NSLocalizedString("On-Farm ID", comment: "")
            
          //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
            
            
            if pviduser == 4 {
                
                UserDefaults.standard.set("Ear Tag", forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                
                self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
             //   self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                
                fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                
            }
            
        }
        
        if pviduser == 4 {
            
            self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
          //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
            
        }else{
            
            self.clickOnDropDown = NSLocalizedString("On-Farm ID", comment: "")
            
          //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
            
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
            
            self.clickOnDropDown = NSLocalizedString("On-Farm ID", comment: "")
            
           // self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
            
            if pviduser == 4 {
                
                UserDefaults.standard.set("Ear Tag", forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                
                self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            //    self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                
                fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                
                
                
            }
            
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
            
            self.clickOnDropDown = NSLocalizedString("Official ID", comment: "")
            self.sortByFarmImgView.image = UIImage(named: "radioBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            
            self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
            
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
            
            self.clickOnDropDown =  NSLocalizedString("Barcode", comment: "")
            self.sortByFarmImgView.image = UIImage(named: "radioBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
            
            if pviduser == 4 {
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
            }
        }

        DispatchQueue.main.async {
  
                if UserDefaults.standard.value(forKey: "name") as? String  == "Dairy"{
                    
                    self.submitOrderOutlet.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
                    if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true {
                        
                        self.infoBtnSelectionOutlet.isHidden = true
                        self.agreeInfoBtnOutelt.isHidden = true
                        self.infoBtnSelectionOutlet.isHidden = false
                        self.agreeLl.isHidden = true
                        self.agrreLblStackView.isHidden = true
                        self.agreeStackViewTopConstraint.constant = -70
                        
                    } else {
                        self.infoBtnSelectionOutlet.isHidden = false

                        self.submitOrderOutlet.isHidden = false
                        self.infoBtnSelectionOutlet.isHidden = false
                        self.agreeLl.isHidden = false
                        self.agreeStackViewTopConstraint.constant = 20
                        self.agrreLblStackView.isHidden = false
                    }
                    
                    
                    
                    
                    
                    if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
                        
                        self.nominatorLbl.isHidden = false
                        
                        self.nominatorTitle.isHidden = false
                        
                    }
                        
                    else{
                        
                        self.nominatorLbl.isHidden = true
                        
                        self.nominatorTitle.isHidden = true
                        
                    }
                }
     
            self.customerNameLbl.text = UserDefaults.standard.value(forKey: "farmValue") as! String

        }
        
        self.setSubmitOrderInitialUI()
      
      if farmAddr.count > 0  {
        var abc = ""
        let filterArr = farmAddr.filter({$0.isDefault == true })
        if filterArr.count > 0{
          abc = filterArr[0].contactName ?? ""
        } else{
          
          let billArray =  farmAddr.filter({Int($0.billToCustId!) == self.custmerId})
          abc = billArray[0].contactName ?? ""
          UserDefaults.standard.set(billArray[0].billToCustId, forKey: "billToCustomerId")
        }
          customerNameLbl.text = abc

      }
        
        
        self.setSubmitOrderInitialUI()
    }
    
    @IBAction func crossClick(_ sender: UIButton) {
        
        transparentView.isHidden = true
        billingView.isHidden = true
    }
    
    @IBAction func sortByCrossBtn(_ sender: Any) {
        
        sortByView.isHidden = true
        transparentView.isHidden = true
    }
    
    @IBAction func sortByBrazilCrossBtn(_ sender: Any) {
        
        sortByBrazilView.isHidden = true
        transparentView.isHidden = true
    }
    
      @IBAction func helpAction(_ sender: UIButton) {
          
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized //
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
         
      }

    @IBAction func viewAnimalClick(_ sender: Any) {
      //  let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
        let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewAnimalsControlleriPadVC") as? ViewAnimalsControlleriPadVC
        vc!.screenBackSave = true
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewBilling {
            return farmAddr.count
        }
        if arr1.count == 0 {
            return 1
        }
        return arr1.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewBilling {
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.billingTableViewCell, for: indexPath) as? BillingTableViewCell
            cell?.selectionStyle = .none
            let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
                if farmAddr[indexPath.row].billToCustId! == filterArr[0].billToCustId{
                    cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                } else {
                    cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                }
            } else if Int(farmAddr[indexPath.row].billToCustId!) == self.custmerId{
                cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            }
            else {
                cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
            }
            cell?.AddrLbl.text = farmAddr[indexPath.row].contactName
            return cell!
        }
//        if indexPath.row == arr1.keys.count{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BillinghCell", for: indexPath) as! BillingCell
//           // UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
//            let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as! String), attributes: self.attrs)
//            cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
//            cell.delegateCustom = self
//            let marketId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as! String
//            let markeData = fetchdataFromMarketId(marketId: marketId)
//            if markeData.count > 0 {
//                
//                let marketnA = markeData.object(at: 0) as! GetMarketsTbl
//                let pricingLink = marketnA.pricingLinkUrl
//                pricingLinkC = pricingLink
//              
//              let attributedString = NSMutableAttributedString(string:  "For Information on list pricing of products, please visit the following web page. Pricing".localized)
//                    cell.pricingTextView.linkTextAttributes = [
//                        .foregroundColor: UIColor.blue,
//                        .underlineStyle: NSUnderlineStyle.single.rawValue
//                    ]
//                    attributedString.addAttribute(.link, value: "1", range: NSRange(location: 82, length: 7))
//                    cell.pricingTextView.attributedText = attributedString
//                    cell.pricingTextView.isHidden = true
//               
//                
//            } else  {
//                //   cell.pricingBtnOutlet.isHidden = true
//            }
//            
//            
//            if UserDefaults.standard.value(forKey: "name") as? String  == "Dairy"{
//                cell.emailOrderBtnOutlet.setTitle(NSLocalizedString("E-Mail Me Entered Data", comment: ""), for: .normal)
//                
//                cell.submitOrderOutlet.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
//              
//              let pviduser1 = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
//              if pviduser1 == 4 {
//                let checkCartAnimal =  fetchAllDataGirlandoAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalTag:"", pvid: pviduser1,dob: "", animalName: "")
//                if checkCartAnimal.count != 0 {
//                  UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
//                  
//                } else {
//                  UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
//                  
//                }
//              } else {
//                let checkCartAnimal =  fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid:pviduser1, dob: "")
//                if checkCartAnimal.count != 0 {
//                  UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
//                  
//                } else {
//                  UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
//                  
//                }
//              }
//              
//                
//                if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true {
//                  
//                    cell.pricingHEIGHTconstraint.constant = 0
//
//                  //  cell.submitBtnHeightConsraint.constant = 0
//                 //   cell.termsHeightConstraint.constant = 0
//                    
//               //     cell.emailOrderTopConstraint.constant = 0
//                 //   cell.termsBelowConstraint.constant = 0
//                    // cell.forInfoHeightConsraint.constant = 0
//                    cell.agreeTopConstraint.constant = 0
//                    // cell.agreeLblHeightConsraint.constant = 0
//                    cell.agreeInfoBtnOutelt.isHidden = true
//                    cell.infoBtnSelectionOutlet.isHidden = true
//                    cell.agreeLl.isHidden = false
//                    //cell.priceLinklbl.isHidden = true
//                    // cell.pricingBtnOutlet.isHidden = true
//                    cell.submitOrderOutlet.isHidden = false
//                    cell.infooBtnSubmitOutlet.isHidden = false
//                    cell.agreeLblHeightConsraint.constant = 0
//
//                } else {
//                    cell.agreeLblHeightConsraint.constant = 10
//
//                    cell.pricingHEIGHTconstraint.constant = 0
//
//                    cell.submitOrderOutlet.isHidden = false
//                    cell.infooBtnSubmitOutlet.isHidden = false
//                    cell.agreeTopConstraint.constant = 45
//                    cell.infoBtnSelectionOutlet.isHidden = false
//                    cell.agreeInfoBtnOutelt.isHidden = false
//                    cell.agreeLl.isHidden = false
//                }
//                
//                
//                if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
//                    cell.nominatorLbl.isHidden = false
//                    cell.nominatorTitle.isHidden = false
//                }
//                else{
//                    cell.nominatorLbl.isHidden = true
//                    cell.nominatorTitle.isHidden = true
//                }
//                
//                
//            }
//           
//                cell.billingContactLbl.text = NSLocalizedString("Billing Contact", comment: "")
//                cell.agreeLl.text = "I agree to the Acceptance and Authorization, Warranty and Indemnification and Data Usage Policies.".localized
//                // cell.pricingTextView.text = "Para obter informações sobre preços de lista de produtos, visite a seguinte página da web.Preços"
//              cell.orderDefaultTtile.text = "Order Defaults".localized
//                //     cell.billingContact.text = "Contato de cobrança"
//                cell.evaluationTitle.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
//                cell.editBtnOutlet.setTitle("Edit".localized, for: .normal)
//                
//                cell.nominatorTitle.text = "Nominator".localized
//                cell.placeAnotrderTitle.text = "Place an Order".localized
//              cell.emailMeEnterTtitle.text = "E-Mail Me Entered Data".localized
//
//           
//            
//            if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "emailMe" || UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "" ||  UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == nil{
//          
//               // cell.emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
//                //cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
//                UserDefaults.standard.setValue("email", forKey: "emailFlag")
//                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
//                {
//                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                }
//                else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
//                {
//                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                }
//                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                    
//                      //  cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                    }
//                    else  if cell.placeAnOutlet.isSelected == false
//                    {
//                        cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                    }
//               // cell.placeAnotrderTitle.alpha = 0.6
//               // cell.emailMeEnterTtitle.alpha = 0.6
//                
//                
//          } else {
//           // cell.placeAnOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
//            //cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//            
//            if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
//            {
//                cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//            }
//            else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
//            {
//                cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//            }
//            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                
//                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                }
//                else  if cell.placeAnOutlet.isSelected == false
//                {
//                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                }
//            UserDefaults.standard.setValue("submit", forKey: "submitTypeSelection")
//           // cell.emailMeEnterTtitle.alpha = 1
//            cell.emailMeEnterTtitle.alpha = 1
//
//            
//        }
//            if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
//
//              if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
//                    cell.placeAnOutlet.alpha = 1
//                    cell.emailMeEnterTtitle.alpha = 1
//                    if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String ==  "submit" {
//                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                            
//                                cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                            }
//                            else  if cell.placeAnOutlet.isSelected == false
//                            {
//                                cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                            }
//                        
//                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
//                        {
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.emailCheckOutlet.isSelected == false
//                        {
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//
//                          //  cell.placeAnOutlet.alpha = 1
//
//                        } else {
//                            if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
//                            {
//                                cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                            }
//                            else  if cell.emailCheckOutlet.isSelected == false
//                            {
//                                cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                            }
//                            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                                
//                                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                                }
//                                else  if cell.placeAnOutlet.isSelected == false
//                                {
//                                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                                }
//
//                          
//                              }
//            } else {
//             //   cell.placeAnOutlet.setImage(UIImage(named: "checkboxgray"), for: .normal)
//                if pviduser == 3 {
//                    if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: "SubmitBtnFlagNew") == true{
//                        cell.placeAnOutlet.alpha = 1
//                        cell.emailMeEnterTtitle.alpha = 1
//
//                    }else {
//                        cell.placeAnOutlet.alpha = 0.6
//                        cell.emailMeEnterTtitle.alpha = 0.6
//
//                    }
//                    
//                }else {
//                    if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: "SubmitBtnFlagNew") == true {
//                        cell.placeAnOutlet.alpha = 1
//                        cell.emailMeEnterTtitle.alpha = 1
//
//                    }else {
//                    cell.placeAnOutlet.alpha = 0.6
//                        cell.placeAnotrderTitle.alpha = 0.6
//                    }}
//           
//                
//             }
//            }
//            if pviduser == 4 || pviduser == 6 || pviduser == 8 {
//                
//                if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
//                    
//                cell.placeAnOutlet.alpha = 1
//
//                if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String ==  "submit" {
//                    //cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
//                    {
//                        
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.placeAnOutlet.isSelected == false
//                        {
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                    if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
//                    {
//                        cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                    }
//                    else  if cell.emailCheckOutlet.isSelected == false
//                    {
//                        cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                    }
//
//                }else {
//                  
////                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
////                    {
////
////                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
////                        }
////                        else  if cell.placeAnOutlet.isSelected == false
////                        {
////                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
////                        }
//                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
//                    {
//                        
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.placeAnOutlet.isSelected == false
//                        {
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                    if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
//                    {
//                        cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                    }
//                    else  if cell.emailCheckOutlet.isSelected == false
//                    {
//                        cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                    }
//                   // cell.emailMeEnterTtitle.alpha = 1
//
//                }
//                
//
//            } else {
//               // cell.placeAnOutlet.setImage(UIImage(named: "checkboxgray"), for: .normal)
//                //cell.placeAnOrderSelectionOutlet.alpha = 0.6
//               // cell.emailCheckOutlet.alpha = 0.6
//                cell.emailMeEnterTtitle.alpha = 1
//               // cell.placeAnOutlet.alpha = 1
//              cell.placeAnotrderTitle.alpha = 0.6
//
//             }
//                
//            }
//            
//            return cell
//        }
        if arr1.count == 0 {
            let cell = UITableViewCell()
            let label = UILabel(frame: CGRect(x: tableView.frame.width/2 - 100, y: 80, width: 200, height: 21))
            label.textAlignment = .center
            label.text = "No Records Found"
            label.font = UIFont(name: "TrebuchetMS", size: 22)
            cell.contentView.addSubview(label)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OPSTableViewCell", for: indexPath) as! OPSTableViewCell
            if String(animaltag[indexPath.row]) != ""{
                cell.OfficialId.text = animaltag[indexPath.row]
            } else {
                cell.OfficialId.text = "N/A" // Or any default placeholder
            }
            if String(farmID[indexPath.row]) != ""{
                cell.OnFarmId.text = farmID[indexPath.row]
            } else {
                cell.OnFarmId.text = "N/A" // Or any default placeholder
            }
            //        cell.OfficialId.text =  String(animaltag[indexPath.row])
            //        cell.OnFarmId.text =  String(farmID[indexPath.row])
            cell.Barcode.text = String(barCode[indexPath.row])
            if selection.count > 0 {
                cell.vollView.isHidden = false
            } else {
                cell.vollView.isHidden = true
            }
            cell.vollView.tag = indexPath.row
            cell.productTitle.text = arr1[values[indexPath.row]]?[0].productName ?? ""
            cell.vollView.reloadData()
            
            cell.onFarmIDTitle.text = NSLocalizedString("On-Farm ID", comment: "")
            cell.officalIdTitle.text = NSLocalizedString("Official ID", comment: "")
            cell.barcodeTitleleft.text  = NSLocalizedString("Barcode", comment: "")
            
            let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
            
            if pviduser == 4 {
                cell.Barcode.text = String(barCode[indexPath.row])
                cell.OfficialId.isHidden = true
                cell.officalIdTitle.isHidden = true
                cell.OnFarmId.text =  String(earTag[indexPath.row])
                cell.onFarmIDTitle.text = NSLocalizedString("Ear Tag", comment: "")
                // cell.officalIdTitle.text = NSLocalizedString("Barcode", comment: "")
                
            }else{
                cell.Barcode.isHidden = false
                cell.barcodeTitleleft.isHidden = false
                
            }
            
            return cell
        }
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "1"{
          
            let url =  NSURL(string: pricingLinkC ?? "") as! URL
            UIApplication.shared.open(url) { (Bool) in
                
            }
        }
        return true
    }
    @objc func deleteButton(_ sender : UIButton){
        //        let animalId = (String(values[sender.tag]))
        //        deleteDataWithProduct(animalId)
        //        deleteDataWithSubProduct(animalId)
        //        arr1.removeAll()
        //
        //        fetchProductAdonAnimalTbl(fethData: fethData, completion: {})
        //        // collectionView.reloadData()
        //        tblView.reloadData()
        
    }
    @objc func pricingBtnClick(_ sender:UIButton) {
        
        guard let url = URL(string: pricingLinkC! ??  "https://www.zoetisus.com") else { return }
        UIApplication.shared.open(url)
        
    }
    @IBAction func dropAction(_ sender: UIButton) {
        
        if self.clickOnDropDown == NSLocalizedString("On-Farm ID", comment: ""){
            if self.farmId == 0{
                
                self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
                
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                
                dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                self.farmId = 1
                
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:false,status: "true", orderStatus: "false", orderId: orderId,userId:userId, farmId: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.farmId = 0
            }
            
        }
        else if self.clickOnDropDown == NSLocalizedString("Official ID", comment: ""){
            if self.animaId == 0{
                dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.animaId = 1
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.animaId = 0
            }
            
        }
            
        else if self.clickOnDropDown == "Ear Tag" || self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: ""){
            //write your code
            
            if self.earTagID == 0{
                self.earTagID = 1
                self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            }
            else{
                self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                self.earTagID = 0
                self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            }
        }
        else{
            if self.barCodeId == 0{
                dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.barCodeId = 1
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.barCodeId = 0
            }
            
        }
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = serchTextField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        tblView.isHidden = false
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString("On-Farm ID", comment: "") {
                let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                
                let fetchcustRep = fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId: orderId,userId:userId, farmId: newString as String) as NSArray
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    // tblView.isHidden = true
                    arr1.removeAll()
                    reloadTable()
                    self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString("Official ID", comment: ""){
                let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                
                let fetchcustRep = fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",animalTag: newString as String).filtered(using: bPredicate) as NSArray
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    // tblView.isHidden = true
                    arr1.removeAll()
                    reloadTable()
                    self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString("Barcode", comment: "")  {
                let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                
                let fetchcustRep = fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false", barcode: newString as String).filtered(using: bPredicate) as NSArray
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    // tblView.isHidden = true
                    arr1.removeAll()
                    reloadTable()
                    self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                }
            }
            if clickOnDropDown == "Ear Tag"{
                let fetchcustRep =    fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity, asending: true, orderId: orderId, userId: userId, animalTag:  newString as String)
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    //  tblView.isHidden = true
                    arr1.removeAll()
                    reloadTable()
                    
                    self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                }
            }
        }else{
         //   self.dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
            fethData = fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId: orderId,userId:userId, farmId: newString as String)
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {})
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    if textField.text?.count == 1{
                        
                        
                    }
                }
            }
            
            reloadTable()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false")
        //        fetchProductAdonAnimalTbl(fethData: fethData, completion: {})
        textField.resignFirstResponder()
        
        return true
    }
    var tblHeghtFrame  = CGFloat()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == arr1.keys.count{
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
                if arr1.count == 0 {
                    return 200
                }
                return 660
                
            } else{
                if arr1.count == 0 {
                    return 200
                }
                return 650
            }
        }
        
        
        
        var addon = 0
        var data = [String:Any]()
        for value in selection{
            if value["animalId"] as? Int == values[indexPath.row]{
                data = value
            }
        }
        if let item = data["animalId"] as? Int{
            if values[indexPath.row] == item{
                let data = data["addon"] as? [SubProductTbl]
                
                var quo = data!.count/2
                var rem = data!.count % 2
                var val = quo * 40 * rem
                if quo == 0 && rem == 1{
                    quo = 1
                }
                
               
                if data!.count > 0 {
                    addon = 110
                    
                }else{
                    addon = -40
                }
            }else{
                addon = -40
            }
        }else{
            addon = -40
        }
        let count = (arr1[values[indexPath.row]]!.count)/2 + 1
        
        print(40 * CGFloat(count) + 30 + CGFloat(count*20) + CGFloat(addon + 100))
        tblHeghtFrame = (40 * CGFloat(count) + 130 + CGFloat(count*20) + CGFloat(addon + 100))
        return 40 * CGFloat(count) + 90 + CGFloat(count*20) + CGFloat(addon + 100)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if section == 0{
            var data = [String:Any]()
            for value in selection{
                if (value["animalId"] as? Int) == values[collectionView.tag]{
                    data = value
                }
            }
            if let item  = data["animalId"] as? Int{
                if values[collectionView.tag] == item{
                    return (data["addon"] as! NSArray).count
                }else{
                    return 0
                }
            }
            else{
                return 0
            }
     //   }
//        else{
//            return arr1[values[section]]!.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      //  if indexPath.section == 0{
//            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
//          item.layer.masksToBounds = true
//          item.layoutIfNeeded()
//          item.lbl.layoutIfNeeded()
//          item.lbl.layer.masksToBounds = true
//          item.lbl.text = arr1[values[collectionView.tag]]?[indexPath.row].productName ?? ""
//            
//            item.lbl.layer.borderColor = UIColor.lightGray.cgColor
//            if arr1[values[collectionView.tag]]![indexPath.row].status! == "true"{
//                collViewOfselection.append(collectionView)
//                indexOfSelection.append(indexPath)
//                item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
//                item.lbl.textColor = UIColor.white
//            }else{
//                item.lbl.backgroundColor = UIColor.white
//                item.lbl.textColor = UIColor.black
//            }
//            return item
            
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
          item.layer.masksToBounds = true
          item.layoutIfNeeded()
          item.lbl.layoutIfNeeded()
          item.lbl.layer.masksToBounds = true
            var data = [String:Any]()
            for value in selection{
                if (value["animalId"] as? Int) == values[collectionView.tag]{
                    data = value
                }
            }
            item.lbl.layer.borderColor = UIColor.lightGray.cgColor
            
            if ((data["addon"] as! NSArray).object(at: indexPath.row) as! SubProductTbl).status! == "true"{
                item.lbl.backgroundColor = UIColor(red: 191/255, green: 202/255, blue: 205/255, alpha: 1)
                item.lbl.textColor = UIColor.black
            }else{
                item.lbl.backgroundColor = UIColor.white
                item.lbl.textColor = UIColor.black
            }
            
            
            item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row) as! SubProductTbl).adonName!
            
            return item
      //  }
//        else{
////            if indexPath.row == 0 {
////                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOnWithTitle", for: indexPath)
////                return item
////            }
////            
////            else  if indexPath.row == 1 {
////                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOn", for: indexPath)
////                return item
////            }else{
//                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
//              item.layer.masksToBounds = true
//              item.layoutIfNeeded()
//              item.lbl.layoutIfNeeded()
//              item.lbl.layer.masksToBounds = true
//                var data = [String:Any]()
//                for value in selection{
//                    if (value["animalId"] as? Int) == values[collectionView.tag]{
//                        data = value
//                    }
//                }
//                item.lbl.layer.borderColor = UIColor.lightGray.cgColor
//                
//                if ((data["addon"] as! NSArray).object(at: indexPath.row) as! SubProductTbl).status! == "true"{
//                    item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
//                    item.lbl.textColor = UIColor.white
//                }else{
//                    item.lbl.backgroundColor = UIColor.white
//                    item.lbl.textColor = UIColor.black
//                }
//                
//                
//                item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row) as! SubProductTbl).adonName!
//                
//                return item
//         //   }
//        }
    }
    
    
    
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: (collectionView.frame.size.width / 2 ) - 100, height: 80)
        return CGSize(width: 170, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 60.0,left: 30.0,bottom: 15.0,right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0
        
    }
    
    @IBAction func emailBtnInfo(_ sender: UIButton) {
        
        let p = sender.convert(sender.bounds,to: self.view)
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip1), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: 140,y: p.origin.y + 44   ,width: 250, height: 125)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        if langId == 1 {
        customPopView1.arrow_Top.frame = CGRect(x: 168 , y: -22, width: 26, height: 26)
        }else {
            customPopView1.arrow_Top.frame = CGRect(x: 228 , y: -22, width: 26, height: 26)

        }
        //        if UserDefaults.standard.bool(forKey: "SubmitBtnFlagNew") == true {
        //
        // customPopView1.textLabel1.text =  NSLocalizedString("Submit is only available if all fields are filled out for each animal submitted.", comment: "")
        //        } else {
        customPopView1.textLabel1.text =  NSLocalizedString("This will email me with the animals, samples and product information I have entered. I can finish the order on my computer and email to Zoetis Genetics.", comment: "")
        //    }
        
    }
    @IBAction func conflictOrderAction(_ sender: Any) {
      if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
            
            
        } else {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfilictOrdersViewController") as! ConfilictOrdersViewController
        vc.delegateCustom1 = self
        vc.screenName = "productSelectionReview"
        self.present(vc, animated: true, completion: nil)

        }}
    
    @objc func buttonbgPressedTip1 (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    @IBAction func edirOrderBtnAction(_ sender: UIButton) {
        //        if (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == false) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == nil) {
        //            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please accept the order terms to proceed.", comment: ""))
        //            return
        //        }
        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false {
            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                
                return
            }
            // Create the actions
            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                if Connectivity.isConnectedToInternet() {
                    self.showIndicator(self.view, withTitle: "", and: "")
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
        
            alertController.addAction(cancelAction)
            // Add the actions
            alertController.addAction(okAction)
           
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            return
        }
        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: "", and: "")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    @IBAction func termsBtnInfo(_ sender: UIButton) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ProductWiseTermsController") as! ProductWiseTermsController
        self.navigationController?.present(vc, animated: false, completion: nil)
        return
        
    }
    
    
    @IBAction func infoIconAction(_ sender: UIButton) {
        
        let p = sender.convert(sender.bounds,to: self.view)
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: p.origin.x - 150,y: p.origin.y + 42   ,width: 200, height: 100)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)

        if langId == 1 {
        customPopView1.arrow_Top.frame = CGRect(x: 121 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 133 , y: -22, width: 26, height: 26)

        }
        //        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true {
        //
        //            customPopView1.textLabel1.text =  NSLocalizedString("This will email me with the animals, samples and product information I have entered. I can finish the order on my computer and email to Zoetis Genetics.", comment: "")
        //
        //        } else {
        
        customPopView1.textLabel1.text =  NSLocalizedString("Submit is only available if all fields are filled out for each animal submitted.", comment: "")
        //}
        
        
    }
    
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    @IBAction func reviewOrder(_ sender: UIButton) {
        
        

        
            
            DispatchQueue.main.async
            {
               // if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell
            //    {
                if self.customerNameLbl.text == "N/A"
                    {
                        self.transparentView.isHidden = false
                        self.billingView.isHidden = false
                        self.isBillingContact = false
                    }
                    else
                    {
                        
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true &&
                              UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                          {
                            updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: false)
                             updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: false)
                              if (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == false) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == nil)
                              {
                                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please accept the order terms to proceed.", comment: ""))
                                  return
                              }
                              
                              if Connectivity.isConnectedToInternet()
                              {
                                  
                              UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                                 // UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                self.showIndicator(self.view, withTitle: "", and: "")
                              
                              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                                newViewController.emailOrder=true
                              self.navigationController?.pushViewController(newViewController, animated: true)
                                 
                          }
                          else
                          {
                              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                              self.navigationController?.pushViewController(newViewController, animated: true)
                          }
                              
                    }
                              
                  else if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true &&
                              UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
                          {
                      updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: false)
                       updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: false)
                              if (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == false) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == nil)
                              {
                                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please accept the order terms to proceed.", comment: ""))
                                  return
                              }
                              
                              if Connectivity.isConnectedToInternet()
                              {
                                  
                              UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                                 // UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                self.showIndicator(self.view, withTitle: "", and: "")
                              
                              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                                newViewController.emailOrder=false
                              self.navigationController?.pushViewController(newViewController, animated: true)
                                 
                          }
                          else
                          {
                              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                              self.navigationController?.pushViewController(newViewController, animated: true)
                          }
                              
                          }
                  else if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == false &&
                              UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                               
                          {
                      updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: true)
                       updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: true)
                    if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false
                    {
                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
                       
                        let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                            
                            return
                        }
                        // Create the actions
                        let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                            if Connectivity.isConnectedToInternet() {
                                self.showIndicator(self.view, withTitle: "", and: "")
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                                newViewController.emailOrder=true
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            } else {
                                let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                        }
           
                        alertController.addAction(cancelAction)
                        // Add the actions
                        alertController.addAction(okAction)
                       
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                    else
                    {
                              
                              if Connectivity.isConnectedToInternet()
                              {
                                  
                             // UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                               UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                self.showIndicator(self.view, withTitle: "", and: "")
                              
                              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                             newViewController.emailOrder=true
                              self.navigationController?.pushViewController(newViewController, animated: true)
                                 
                          }
                          else
                          {
                              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                              self.navigationController?.pushViewController(newViewController, animated: true)
                          }
                              
                          }
                  }
                        else
                          {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Please select at least one checkbox to submit.", comment: ""))
                    return
                         }
                      }
                     
                    
               // }
            }
        

      
        
    }
    
    @IBAction func pricingLinkAction(_ sender: Any) {
        
        guard let url = URL(string: "https://mysearchpoint.com") else { return }
        UIApplication.shared.open(url)
        
    }
    
    @IBAction func toggleBtnAction(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReviewOrderVCIpad") as! ReviewOrderVCIpad
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
    
    // network check
    
    @objc  func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized
        {
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
        
    }
    
    func initialNetworkCheck()
    {
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized
        {
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    
    
    
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderProductSelectionSecondVC.buttonbgPressed), for: .touchUpInside)
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
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    func UpdateUI(SelectedBillingCustomer: GetBillingContact) {
        DispatchQueue.main.async {
      //    if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
            let filterArr = self.farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
              updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
              
            }
              UserDefaults.standard.set(SelectedBillingCustomer.contactName, forKey: "farmValue")
              UserDefaults.standard.set(SelectedBillingCustomer.billToCustId, forKey: "billToCustomerId")
            
            updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: SelectedBillingCustomer.billToCustId ?? "0", billcustomerName: SelectedBillingCustomer.contactName ?? "")
            
            self.farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
            
              let attributeString = NSMutableAttributedString(string: SelectedBillingCustomer.contactName ?? "", attributes: self.attrs)
             // cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
              
       //   }
            self.customerNameLbl.text = SelectedBillingCustomer.contactName ?? ""
//            if self.customerNameLbl.text!.count > 28 {
//                self.customerNameLbl.font = self.customerNameLbl.font.withSize(14)
//            } else {
//                self.customerNameLbl.font = self.customerNameLbl.font.withSize(22)
//            }
          self.transparentView.isHidden = true
          self.billingView.isHidden = true
      }
        
    }
  func updateUI() {
    DispatchQueue.main.async {
      if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
        let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as? String ?? ""),
                                                        attributes: self.attrs)
        cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
      }
        self.customerNameLbl.text = UserDefaults.standard.value(forKey: "farmValue") as? String ?? ""
//        if self.customerNameLbl.text!.count > 28 {
//            self.customerNameLbl.font = self.customerNameLbl.font.withSize(14)
//        } else {
//            self.customerNameLbl.font = self.customerNameLbl.font.withSize(22)
//        }
      self.transparentView.isHidden = true
      self.billingView.isHidden = true
    }
  }
    @IBAction func editBtnActon(_ sender: Any) {
        //  UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
        UserDefaults.standard.set(1, forKey: keyValue.orderSlideTag.rawValue)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingDefaultsVC")), animated: true)
        
    }
    
}
extension OPSReviewVCIpad:offlineCustomView{
    func crossBtnCall() {
        
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}

extension OPSReviewVCIpad : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
