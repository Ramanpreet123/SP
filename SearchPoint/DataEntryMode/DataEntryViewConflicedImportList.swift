//
//  DataEntryViewConflicedImportList.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/12/20.
//

import UIKit

//MARK: CLASS

class DataEntryViewConflicedImportList: UIViewController {
    
    //MARK: OUTLETS
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
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
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
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC)), animated: true)
        
    }
    
}

//MARK: TABLEVIEW DATASOURCES AND DELEGATES
extension DataEntryViewConflicedImportList :UITableViewDelegate,UITableViewDataSource {
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
}
//MARK: OFFLINE CUSTOM VIEW EXTENSION

extension DataEntryViewConflicedImportList : offlineCustomView{
    func crossBtnCall() {
        
    }
}
