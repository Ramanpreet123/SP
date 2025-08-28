//
//  OrderSubmittedVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 24/02/25.
//

import Foundation
import UIKit
import MBProgressHUD
import Toast_Swift
import Alamofire
import CoreData

//MARK: ORDER SUBMITTED VC
class OrderSubmittedVCiPad: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var submitTiile: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var appHelpBtn: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    var fetchDataEntry : [DataEntryList] = []
    let orderingDatalistVM = OrderingDataListViewModel()
    var listName = String()
    var modalObject:LoginModel?
    var emailOrder =  Bool()
    var submitEmailFlag = Bool()
    var userId = Int()
    var orderId = Int()
    var objApiSync = ApiSync()
    var orderIdBeef = Int()
    var heartBeatViewModel:HeartBeatViewModel?
    var value = 0
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        heartBeatViewModel?.callGetHearBeatData()
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
            if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.submitOrder, comment: ""), and: "")
            }
            else {
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.dataSyncProgress, comment: ""), and: "")
            }
            
        }
        else {
            if UserDefaults.standard.bool(forKey: keyValue.emailBeef.rawValue) {
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.submitOrder, comment: ""), and: "")
            }
            else {
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.dataSyncProgress, comment: ""), and: "")
            }
            
        }
        objApiSync.delegeteSyncApi = self
        if Connectivity.isConnectedToInternet() {
            self.view.isUserInteractionEnabled = false
            if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
                if  UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 13  {
                    objApiSync.saveBeefUSAnimalData()
                } else {
                    
                    objApiSync.saveAnimaldataBEEF()
                }
            }
            else{
                objApiSync.saveAnimaldata(submitEmailFlag: submitEmailFlag)
            }
        }
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
            if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
                let arrayString = [NSLocalizedString(LocalizedStrings.receiveDataInEmail, comment: "")]
                infoLbl.attributedText = add(stringList: arrayString, font: infoLbl.font!, bullet: "")
            }
            else {
                let arrayString = [NSLocalizedString(LocalizedStrings.contactCustomerSupport, comment: ""),NSLocalizedString(LocalizedStrings.customerSupportWillContact, comment: ""),NSLocalizedString(LocalizedStrings.orderConfirmationEmail, comment: "")]
                infoLbl.attributedText = add(stringList: arrayString, font: infoLbl.font!, bullet: "•")
            }
        }
        else {
            if UserDefaults.standard.bool(forKey: keyValue.emailBeef.rawValue) {
                let arrayString = [NSLocalizedString(LocalizedStrings.receiveDataInEmail, comment: "")]
                infoLbl.attributedText = add(stringList: arrayString, font: infoLbl.font!, bullet: "")
            } else {
                let arrayString = [NSLocalizedString(LocalizedStrings.contactCustomerSupport, comment: ""),NSLocalizedString(LocalizedStrings.customerSupportWillContact, comment: ""),NSLocalizedString(LocalizedStrings.orderConfirmationEmail, comment: "")]
                infoLbl.attributedText = add(stringList: arrayString, font: infoLbl.font!, bullet: "•")
            }
        }
    }
    
    //MARK: API CALLS AND DATA SAVING
    private func Login(){
        let Network = NetworkManager()
        Network.delegate = self
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"BEARER" + " " + "ea4369e9-d4a9-4322-856b-5323e21ff351"]
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParams(), Url: Configuration.Dev(packet: ApiKeys.login.rawValue).getUrl()))
        
    }
    
    private func getParams()->[String:Any]{
        let userNameOld = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
        let passwordOld = UserDefaults.standard.value(forKey: keyValue.password.rawValue) as? String  ?? ""
        return ["appId":"\(appID)",
                "email":userNameOld,
                "password":passwordOld ,"deviceId": UserDefaults.standard.value(forKey: keyValue.deviceId.rawValue) as! String]
    }
    
    func saveLoginDat(dataModel:LoginModel){
        let accessToken =  dataModel.authorizationToken
        UserDefaults.standard.set(accessToken, forKey: keyValue.accessToken.rawValue)
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
            if  UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 13  {
                objApiSync.saveBeefUSAnimalData()
            } else {
                
                objApiSync.saveAnimaldataBEEF()
            }
        }
        else{
            objApiSync.saveAnimaldata(submitEmailFlag: submitEmailFlag)
        }
    }
    
    func add(stringList: [String],font: UIFont, bullet: String = "\u{2022}",indentation: CGFloat = 20,lineSpacing: CGFloat = 2,            paragraphSpacing: CGFloat = 12, textColor: UIColor = .black, bulletColor: UIColor = .black) -> NSAttributedString {
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        let bulletList = NSMutableAttributedString()
        
        for string in stringList {
            let formattedString = "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        return bulletList
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    
    //MARK: IB ACTIONS
    @IBAction func menuBtnAction(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func acknowledgeAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsTextBeef.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}

//MARK: SIDE MENU UI EXTENSION
extension OrderSubmittedVCiPad : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: GET, CREATE AND DELETE LIST
extension OrderSubmittedVCiPad {
    func getListName()  {
        var pvid = 0
        if let speciesType = UserDefaults.standard.object(forKey: keyValue.name.rawValue) {
            if speciesType as! String == marketNameType.Beef.rawValue {
                pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            }
            else {
                pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            }
            listName = orderingDatalistVM.makeListName(custmerId: custmerId ?? 0, providerID: pvid)
            fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:speciesType as! String) as! [DataEntryList]
        }
    }
    
    func createListNameAndCheckifExist(){
        self.getListName()
        if fetchDataEntry.count > 0 {
            let list_Id = fetchDataEntry[0].listId
            deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(list_Id), customerId: Int(custmerId ?? 0 ),userId:1 )
            if let speciesType = UserDefaults.standard.object(forKey: keyValue.name.rawValue) {
                if speciesType as! String == marketNameType.Beef.rawValue {
                    deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(list_Id), customerId: Int(custmerId ?? 0),userId:1 )
                    deleteList(listName:listName ,customerId:Int64(Int(custmerId ?? 0)), listID: Int(list_Id ))
                    let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryBeefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(list_Id ))
                    if animalData1.count > 0 {
                        deleteDataWithListIdDatEntry(entityString: Entities.dataEntryBeefAnimalAddTblEntity, listId: Int(list_Id ), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:1)
                    }
                } else {
                    let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryAnimalAddTbl, customerId: Int(custmerId ?? 0 ), listId: Int64(list_Id ))
                    if animalData1.count > 0 {
                        deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(list_Id ), customerId: Int(custmerId ?? 0 ),userId:userId)
                    }
                }
                self.view.isUserInteractionEnabled = false
            }
        }
    }
    
    func deleteList(listName: String, customerId: Int64, listID: Int) {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.listName.rawValue:listName]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                self.view.isUserInteractionEnabled = true
                self.hideIndicator()
            } else {
                self.view.isUserInteractionEnabled = true
                self.hideIndicator()
            }
        }
    }
}

//MARK: RESPONSE DELEGATE
extension OrderSubmittedVCiPad : ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if status {
            let decoder = JSONDecoder()
            modalObject = try? decoder.decode(LoginModel.self, from: data!)
            if modalObject != nil {
                saveLoginDat(dataModel: modalObject!)
            }
        }
        else {
            let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.authFailed, comment: ""), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
                self.hideIndicator()
                let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                self.sideMenuViewController?.hideMenuViewController()
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
}

//MARK: SYNC API DELEGATE
extension OrderSubmittedVCiPad : syncApi {
    func failWithError(statusCode: Int) {
        hideIndicator()
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
    }
    
    func failWithErrorInternal() {
        hideIndicator()
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
    }
    
    func didFinishApi(response: String) {
        orderIdLbl.text =  NSLocalizedString(LocalizedStrings.orderIdStr, comment: "") + " : " + "\(response)"
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
            if response.count != 0 {
                CommonClass.showAlertMessage(self, titleStr: AlertMessagesStrings.alertString.localized, messageStr: response.localized)
            }
            
            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
            let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.beefAnimalAddTblEntity, isSync: "false",ordestatus: "false", status: "true", orderId: orderIdBeef,userId: userId)
            
            for i in 0..<animaltbl.count{
                let animadata = animaltbl[i] as! BeefAnimaladdTbl
                updateOrderStatusISyncAnimal(entity: Entities.beefAnimalAddTblEntity, isSync: "false", status: "true", orderstatus: "false",orderId:orderIdBeef,userId:userId)
                updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, isSync: "false", status: "false", orderstatus: "false",orderId:orderIdBeef,userId:userId,animalId:Int(animadata.animalId))
                
                updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity, isSync: "false",animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderIdBeef,userId: userId)
                updateOrderStatusISyncProduct(entity: Entities.subProductBeefTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderIdBeef,userId: userId)
            }
            createListNameAndCheckifExist()
            UserDefaults.standard.set(false, forKey: keyValue.autoIdBeef.rawValue)
            updateProductTablStatus(entity: Entities.getProductBeefTblEntity)
            updateProductTablStatus(entity: Entities.getAdonTblEntity)
            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.pdId.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.productName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.beefBreed.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefTSU.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreed.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTSU.rawValue)
            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
            UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
            deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
            deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
            UserDefaults.standard.set(nil, forKey: keyValue.beefbreedClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreedClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTsuClear.rawValue)
            UserDefaults.standard.setValue(nil, forKey: keyValue.beefbreedClear.rawValue)
            UserDefaults.standard.setValue(nil, forKey: keyValue.beeftsuClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.nzBeeftsuClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.tissueBttnClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.genotypeTissueBttnClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.emailFlag.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.submitFlag.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.primaryGenoType.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.secondaryGenoType.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.tertirayGenoType.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataListPrimaryGenoType.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataListSecondaryGenoType.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataListTertirayGenoType.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataBeefBreedID.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataBeefBreedName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.beefBreedID.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.beefBreedName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.GenoBeefBreedName.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
        }
        else{
            let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.animalAddTblEntity, isSync: "false",ordestatus: "false", status: "true", orderId: orderId,userId: userId)
            for i in 0..<animaltbl.count{
                let animadata = animaltbl[i] as! AnimaladdTbl
                updateOrderStatusISyncAnimal(entity: Entities.animalAddTblEntity, isSync: "false", status: "true", orderstatus: "false",orderId:orderId,userId:userId)
                updateOrderStatusISyncAnimalMaster(entity: Entities.animalMasterTblEntity, isSync: "false", status: "false", orderstatus: "false",orderId:orderId,userId:userId,animalId:Int(animadata.animalId))
                let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                if providerName == keyValue.auDairyProducts.rawValue{
                    updateOrderStatusISyncProductclarifdeAU(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId,productName:LocalizedStrings.clarifideDataGene, productName1: LocalizedStrings.clarifideCDCB, productName2: LocalizedStrings.providerClarifidePlus, status: "true")
                }
                else if providerName == keyValue.clarifideAHDBUK.rawValue {
                    updateOrderStatusISyncProductclarifdeUK(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId,productName:LocalizedStrings.clarifideAHDB, productName1: LocalizedStrings.clarifideCDCB, productName2: LocalizedStrings.providerClarifidePlus, status: "true")
                }
                else {
                    updateOrderStatusISyncProductclarifde(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId,productName:LocalizedStrings.providerClarifide,status: "true")
                }
                updateOrderStatusISyncProduct(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId)
                updateOrderStatusISyncProduct(entity: Entities.subProductTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId)
            }
            createListNameAndCheckifExist()
            UserDefaults.standard.set("False", forKey: keyValue.isAuSelected.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.autoId.rawValue)
            updateProductTablStatus(entity: Entities.getProductTblEntity)
            updateProductTablStatus(entity: Entities.getAdonTblEntity)
            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.pdId.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.productName.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.tsuKey.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.bvdvValidation.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.tsuClear.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.girlandoSampleTypeClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.breedNameClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.emailFlag.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.submitFlag.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
        }
        UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
        self.view.isUserInteractionEnabled = true
        self.hideIndicator()
    }
    
    func failWithInternetConnection() {
        hideIndicator()
    }
}
