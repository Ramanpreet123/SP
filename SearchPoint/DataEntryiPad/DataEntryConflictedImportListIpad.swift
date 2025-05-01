//
//  DataEntryConflictedImportListIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 09/04/25.
//

import Foundation
class DataEntryConflictedImportListIpad: UIViewController {
  
    //MARK: OUTLETS
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var listTitleName: UILabel!
    @IBOutlet weak var appStatusTitle: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var bckBtnOutlet: UIButton!
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var listId = Int()
    var listingArray = NSArray()
    
    //MARK: VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
    }
    
    //MARK: UI METHODS AND FUNCTIONS
    
    func setInitialUI(){
        initialNetworkCheck()
        let screenPerference = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
        self.navigationController?.navigationBar.isHidden = true
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        listTitleName.text = NSLocalizedString("List", comment: "")
        
        if screenPerference == keyValue.officialId.rawValue {
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                listingArray = fetchAllDataAnimalFarmiIdCheckBothMandatory(entityName: Entities.dataEntryAnimalAddTbl,farmId:"",animalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :UserDefaults.standard.integer(forKey: keyValue.userId.rawValue), listId: Int64(listId))
                print(listingArray)
            } else {
                listingArray = fetchAllDataAnimalAnimalTagCheck(entityName: Entities.dataEntryAnimalAddTbl,anmalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), userID: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue), listId: Int64(listId))
            }
            
        }
        else {
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                listingArray = fetchAllDataAnimalFarmiIdCheckBothMandatory(entityName: Entities.dataEntryAnimalAddTbl,farmId:"",animalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :UserDefaults.standard.integer(forKey: keyValue.userId.rawValue), listId: Int64(listId))
                print(listingArray)
            } else {
                listingArray = fetchAllDataAnimalFarmiIdCheck(entityName: Entities.dataEntryAnimalAddTbl,anmalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), userID: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue), listId: Int64(listId))
            }
        }
        
        if listingArray.count == 0 {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC) as! OrderingAnimalVC
            navigationController?.pushViewController(vc,animated: false)
        }
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appStatusLbl?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    
    //MARK: OBJC SELECTORS
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appStatusLbl?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    //MARK: IB ACTIONS
    @IBAction func bckBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    
    @IBAction func offlineBtnAction(_ sender: Any) {
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
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OrderingAnimalipadVC")), animated: true)
        
    }
    
}

//MARK: TABLEVIEW DATASOURCES AND DELEGATES
extension DataEntryConflictedImportListIpad :UITableViewDelegate,UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ConflicedImportListCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! ConflicedImportListCell
        print(listingArray[indexPath.row])
        let fff = listingArray[indexPath.row] as! DataEntryAnimaladdTbl
        cell.farmIdLbl.text = fff.farmId
        cell.officialIdLbl.text = fff.animalTag
        cell.barcodeLbl.text = fff.animalbarCodeTag
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalVal = listingArray[indexPath.row] as! DataEntryAnimaladdTbl
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: ClassIdentifiers.dataEntryAnimalIdSelectionCartVC)
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVC) as! DataEntryOrderingAnimalVC
        vc.dataEntryConflicedBack = true
        navigationController?.pushViewController(vc,animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listingArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ViewAnimalCelliPad = self.listCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ViewAnimalCelliPad
        let animalVal =  listingArray[indexPath.row] as! DataEntryAnimaladdTbl
        
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.barcodeLbl.isHidden = false
            cell.barcodeLbl.isHidden = false
            cell.barcodeTtileLbl.isHidden = false
            cell.onFarmIdTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodeTtileLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let animalVal = listingArray[indexPath.row] as! DataEntryAnimaladdTbl
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: ClassIdentifiers.dataEntryAnimalIdSelectionCartVC)
        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DataEntryOrderingAnimalVCIpad") as! DataEntryOrderingAnimalVCIpad
        vc.dataEntryConflicedBack = true
        navigationController?.pushViewController(vc,animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 186)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return 15
            
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
//MARK: OFFLINE CUSTOM VIEW EXTENSION

extension DataEntryConflictedImportListIpad : offlineCustomView{
    func crossBtnCall() {
        
    }
}
