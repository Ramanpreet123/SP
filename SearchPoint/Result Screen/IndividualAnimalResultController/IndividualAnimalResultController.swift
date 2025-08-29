//
//  IndividualAnimalResultController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 15/03/21.
//

import UIKit
import Swift_PageMenu
import Alamofire

//MARK: CLASS
class IndividualAnimalResultController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var managedGroupoutlet: UIButton!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var onFarmIdTitle: UILabel!
    @IBOutlet weak var officialTagTitle: UILabel!
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var evaluationDateTitle: UILabel!
    @IBOutlet weak var sexTitle: UILabel!
    @IBOutlet weak var dobTitle: UILabel!
    @IBOutlet weak var resultTypeTitle: UILabel!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var onFarmIdLbl: UILabel!
    @IBOutlet weak var officialTagLbl: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var evaluationDateLbl: UILabel!
    @IBOutlet weak var sexLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var donebutton: UIButton!
    @IBOutlet weak var donebuttonlb: UILabel!
    @IBOutlet weak var resultTypeLbl: UILabel!
    @IBOutlet weak var subVieww: UIView!
    @IBOutlet weak var replaceBtnOutlet: UIButton!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var notesBackroundView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesView: customView!
    @IBOutlet weak var notesDoneBtnOutlet: UIButton!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageBackroundView: UIView!
    @IBOutlet weak var replaceLbl: UILabel!
    @IBOutlet weak var deleteLbl: UILabel!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var providerChnageOutlet: customButton!
    @IBOutlet weak var notedBtnOutlet: customButton!
    @IBOutlet weak var photoBtnOutlet: customButton!
    @IBOutlet weak var deleteBtnOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var proModel : ChildViewController?
    var backScreenClickIndex = Int()
    var newbackscreenindex = Int()
    var navigateFromGroupDetailScreen = false
    var groupNameExist = String()
    var productName = String()
    var checkCOntroller = ""
    var gronformid = String()
    var getMyHerdArray = [ResultMyHerdData]()
    var groupanimalarray = [ResultGroupsAnimals]()
    var boolcheck = Bool.self
    var itemsArray = [[String]]()
    var tabTitles = [String]()
    let arrayother = MyHerdResultsViewController()
    var titleNameArray = ["ID","NMS", "TPI", "JPI","BPI","Sire_Naab", "PTI/CPI", "NMS","BPI","FM$","Group"]
    var titleLabelArray  = ["1231232","123", "321", "231","343","232", "434", "455","Group"]
    var searchbyAnimal = Bool()
    var note = String()
    var photo = String()
    var animalID: String?
    var fetchMyHerdData = [ResultMyHerdData]()
    var custmerID = Int64()
    var selectedProuductName = ""
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var value = 0
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOndidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    func setUIOndidLoad(){
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        initialNetworkCheck()
        if navigateFromGroupDetailScreen  {
            let myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: groupNameExist,customerId:custmerID) as! [ResultGroupsAnimals]
            let myHerdValueWithIndex = myHerdArray[backScreenClickIndex]
            animalID = myHerdValueWithIndex.animalID
            if searchbyAnimal {
                fetchMyHerdData   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID ,searchFound: true) as! [ResultMyHerdData]
            } else {
                fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID) as! [ResultMyHerdData]
            }
            
            var currentIndex = 0
            for name in fetchMyHerdData {
                if name.animalID == animalID {
                    UserDefaults.standard.set(currentIndex, forKey: keyValue.myHerdListSelectIndex.rawValue)
                    backScreenClickIndex = currentIndex
                    break
                }
                currentIndex += 1
            }
        }
        else {
            UserDefaults.standard.set(backScreenClickIndex, forKey: keyValue.myHerdListSelectIndex.rawValue)
            
        }
        
        if searchbyAnimal {
            fetchMyHerdData   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID ,searchFound: true) as! [ResultMyHerdData]
            selectedProuductName = productName
            UserDefaults.standard.set(productName, forKey: keyValue.selectedProviderName.rawValue)
        }
        else {
            fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID) as! [ResultMyHerdData]
            UserDefaults.standard.set(productName, forKey: keyValue.selectedProviderName.rawValue)
            if productName == keyValue.auDairyProducts.rawValue{
                selectedProuductName = LocalizedStrings.clarifideDataGene
            }
            else{
                if UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue)
                {
                    selectedProuductName = LocalizedStrings.herdity
                } else {
                    selectedProuductName = LocalizedStrings.clarifideCDCB
                }
            }
        }
        
        if searchbyAnimal {
            let traitHeader = fetchResultHeaderAllDataForSearchAnimal(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName :[String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabTitles = hName.removeDuplicates()
        }
        else {
            let traitHeader = fetchResultHeaderAllData(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName :[String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabTitles = hName.removeDuplicates()
        }
        var titleArray = [String]()
        for title in tabTitles {
            titleArray.append(title)
        }
        for _ in tabTitles {
            itemsArray.append(titleArray)
        }
        notesView.isHidden = true
        notesBackroundView.isHidden = true
        notesTextView.layer.borderWidth = 0.4
        notesTextView.layer.borderColor = UIColor.gray.cgColor
        profileImgView.alpha = 0
        imageBackroundView.isHidden = true
        deleteLbl.isHidden = true
        replaceLbl.isHidden = true
        donebutton.isHidden = true
        donebuttonlb.isHidden = true
        replaceBtnOutlet.isHidden = true
        deleteBtnOutlet.isHidden = true
        let pageViewController = StoryboardPageTabMenuViewController(items: itemsArray, titles: tabTitles, options: UnderlinePagerOption())
        pageViewController.navigationItem.title = "Title"
        addChild(pageViewController)
        pageViewController.productName = productName
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width  - 80 , height: subVieww.frame.size.height )
        pageViewController.searchbyAnimal = searchbyAnimal
        subVieww.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        self.populateAletalInformation()
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        profileImgView.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: nil)
        proModel?.delegateUpadte = self
        proModel?.productName = productName
        if Connectivity.isConnectedToInternet(){
            self.getNote()
        }
    }
    
    //MARK: OBJC SELECTORS
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
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
    @objc func notificationRecevied(notification: Notification) {
        let data = notification.object
        let groupValue = data as! String != "" ? data as! String : "N/A"
        groupTitleLbl.text = groupValue
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    //MARK: METHODS AND FUNCTIONS
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
    
    func populateAletalInformation(){
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: nil)
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let officialID = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue) as? String
            let fetchnote = fetchResultnote(entityName: Entities.resultMyherdDataTblEntity ,onFarmID: onformid ?? "", customerId: custmerID, officialID: officialID ?? "") as! [ResultMyHerdData]
            if fetchnote.count > 0{
                let note = fetchnote[0]
                onFarmIdLbl.text = note.onFarmID != "" ? note.onFarmID : "N/A"
                officialTagLbl.text = note.officialID != "" ? note.officialID : "N/A"
                breedLbl.text = note.breed != "" ? note.breed : "N/A"
                
                if note.sex == "F"{
                    sexLbl.text = ButtonTitles.femaleText.localized
                }
                else if note.sex  == "M"{
                    sexLbl.text = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                
                let dob = note.dob ?? ""
                let dateonly = dob.components(separatedBy: " ")
                dobLbl.text = dateonly[0]
                providerChnageOutlet.titleLabel?.lineBreakMode = .byWordWrapping
                providerChnageOutlet.titleLabel?.textAlignment = .center
                
                if searchbyAnimal{
                    providerChnageOutlet.setTitle(selectedProuductName, for: .normal)
                } else {
                    if selectedProuductName == LocalizedStrings.herdity || selectedProuductName == LocalizedStrings.clarifideCDCB{
                        providerChnageOutlet.setTitle(keyValue.USDairyProducts.rawValue, for: .normal)
                    } else{
                        providerChnageOutlet.setTitle(selectedProuductName, for: .normal)
                    }
                }
                
                let resultValue = note.resultType != "" ? note.resultType : "N/A"
                resultTypeLbl.text = resultValue
                let datetext = note.orderDate ?? "N/A"
                if datetext != ""{
                    evaluationDateLbl.text = datetext
                }
                else{
                    evaluationDateLbl.text = "N/A"
                }
                
                notesTextView.text = note.notes
                if note.photos != nil {
                    self.profileImgView.image = UIImage(data: note.photos!)
                }
            }
            profileImgView.isHidden = true
            groupTitleLbl.text = groupNameExist
        }
        else{
            if getMyHerdArray.count != 0{
                animalID = getMyHerdArray[backScreenClickIndex].animalID
                onFarmIdLbl.text = getMyHerdArray[backScreenClickIndex].onFarmID != "" ? getMyHerdArray[backScreenClickIndex].onFarmID : "N/A"
                officialTagLbl.text = getMyHerdArray[backScreenClickIndex].officialID != "" ?  getMyHerdArray[backScreenClickIndex].officialID : "N/A"
                breedLbl.text = getMyHerdArray[backScreenClickIndex].breed != "" ?  getMyHerdArray[backScreenClickIndex].breed : "N/A"
                
                let datatext = getMyHerdArray[backScreenClickIndex].orderDate != "" ?  getMyHerdArray[backScreenClickIndex].orderDate : "N/A"
                if datatext != ""{
                    evaluationDateLbl.text = datatext
                }
                else{
                    evaluationDateLbl.text = "N/A"
                    
                }
                if getMyHerdArray[backScreenClickIndex].sex == "F"{
                    sexLbl.text = ButtonTitles.femaleText.localized
                }
                else if getMyHerdArray[backScreenClickIndex].sex == "M"{
                    sexLbl.text = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else{
                    sexLbl.text = ButtonTitles.allText.localized
                }
                
                let dob = getMyHerdArray[backScreenClickIndex].dob ?? ""
                let dateonly = dob.components(separatedBy: " ")
                dobLbl.text = dateonly[0]
                providerChnageOutlet.titleLabel?.lineBreakMode = .byWordWrapping
                providerChnageOutlet.titleLabel?.textAlignment = .center
                providerChnageOutlet.setTitle(productName, for: .normal)
                if productName == "" {
                    providerChnageOutlet.isHidden = true
                } else {
                    providerChnageOutlet.isHidden = false
                }
                
                let resultValue = getMyHerdArray[backScreenClickIndex].resultType != "" ? getMyHerdArray[backScreenClickIndex].resultType : "N/A"
                resultTypeLbl.text = resultValue
                notesTextView.text = getMyHerdArray[backScreenClickIndex].notes
                profileImgView.isHidden = true
                if UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) == nil {
                    groupTitleLbl.text = "N/A"
                }
                else {
                    let groupValue = UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String != "NA" ? UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String : "N/A"
                    
                    if groupValue == LocalizedStrings.inactiveStatus{
                        groupTitleLbl.text = "N/A"
                    }
                    
                    else{
                        groupTitleLbl.text = groupValue
                    }
                }
                if getMyHerdArray[backScreenClickIndex].photos != nil {
                    self.profileImgView.image = UIImage(data: getMyHerdArray[backScreenClickIndex].photos!)
                }
            }
        }
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: "2015-04-01T11:42:00")
    }
    
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    //MARK: IB ACTIONS
    @IBAction func imageBckounBtnClick(_ sender: Any) {
        imageBackroundView.isHidden = true
        deleteLbl.isHidden = true
        donebutton.isHidden = true
        donebuttonlb.isHidden = true
        replaceLbl.isHidden = true
        replaceBtnOutlet.isHidden = true
        deleteBtnOutlet.isHidden = true
        profileImgView.isHidden = true
    }
    
    @IBAction func doneBckounBtnClick(_ sender: Any) {
        imageBackroundView.isHidden = true
        deleteLbl.isHidden = true
        replaceLbl.isHidden = true
        donebutton.isHidden = true
        donebuttonlb.isHidden = true
        replaceBtnOutlet.isHidden = true
        deleteBtnOutlet.isHidden = true
        profileImgView.isHidden = true
    }
    
    @IBAction func noteBckounBtnClick(_ sender: Any) {
        notesBackroundView.isHidden = true
        notesView.isHidden = true
        
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.resultsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func bckBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notesDoneBtnAction(_ sender: Any) {
        view.endEditing(true)
        notesView.isHidden = true
        notesBackroundView.isHidden = true
        
        if Connectivity.isConnectedToInternet() {
            noteupdateinapi(animalId: animalID ?? "", notes: notesTextView.text ?? "", completionHandler: { (success) -> Void in
                if success {
                    updateNotesAgainstgroupscren(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID) ,onFarmID: self.onFarmIdLbl.text ?? "" ,officialID: self.officialTagLbl.text ?? "",notes: self.notesTextView.text ?? "")
                    
                    updateNotesAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID) ,onFarmID: self.onFarmIdLbl.text ?? "" ,officialID: self.officialTagLbl.text ?? "",notes: self.notesTextView.text ?? "")
                }
            })
        }
        else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.notConnectedToInternet, comment: ""))
            return
        }
    }
    
    @IBAction func managedGroupAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.myManagementGroupControllerVC) as? MyManagementGroupController
        vc?.searchByAnimal = searchbyAnimal
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func menuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func notesBtnClick(_ sender: Any) {
        let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
        let officialID = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue) as? String
        let fetchnote = fetchResultnote(entityName: Entities.resultMyherdDataTblEntity ,onFarmID: onformid ?? "", customerId: custmerID, officialID: officialID ?? "") as! [ResultMyHerdData]
        if fetchnote.count > 0{
            let note = fetchnote[0]
            notesTextView.text = note.notes
        }
        notesView.isHidden = false
        notesBackroundView.isHidden = false
    }
    
    @IBAction func photoBtnClick(_ sender: Any) {
        profileImgView.alpha = 1
        if profileImgView.image == nil {
            self.showAlert()
        } else {
            self.imageBackroundView.isHidden = false
            self.imageBackroundView.isHidden = false
            self.donebutton.isHidden = false
            self.donebuttonlb.isHidden = false
            self.deleteLbl.isHidden = false
            self.replaceLbl.isHidden = false
            self.replaceBtnOutlet.isHidden = false
            self.deleteBtnOutlet.isHidden = false
            profileImgView.isHidden = false
        }
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
    
    @IBAction func dashBoardBackBtnClick(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func deleteBtnClick(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.deletePhoto, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            print(LocalizedStrings.cancelPressed)
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            if Connectivity.isConnectedToInternet() {
                self.profileImgView.isHidden = true
                self.imageBackroundView.isHidden = true
                self.donebutton.isHidden = true
                self.donebuttonlb.isHidden = true
                self.deleteLbl.isHidden = true
                self.replaceLbl.isHidden = true
                self.replaceBtnOutlet.isHidden = true
                self.deleteBtnOutlet.isHidden = true
                self.profileImgView.image = nil
                self.deletePhoto(animalId: self.animalID ?? "", customerId: Int64(Int(self.custmerID)))
                if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                    updategroupPhotoNil(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID),onFarmID: self.onFarmIdLbl.text ?? "",officialID: self.officialTagLbl.text ?? "")
                }
                else{
                    updatePhotoNil(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID),onFarmID: self.onFarmIdLbl.text ?? "",officialID: self.officialTagLbl.text ?? "")
                }
            }
            else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.photoCantBeDeleted, comment: ""))
                return
            }
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func replaceBtnClick(_ sender: Any) {
        self.showAlert()
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension IndividualAnimalResultController:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: UPDATE VIEW EXTENSION
extension IndividualAnimalResultController:UpdateView{
    func responseRecievedStatus(value: String) {
        groupTitleLbl.text = value
    }
}


