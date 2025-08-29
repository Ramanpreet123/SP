//
//  SideMenuVC.swift
//  SearchPoint
//
//  Created by "" on 01/10/2019.
//  ""
//

import UIKit
import AKSideMenu
import Gigya
import GigyaTfa
import GigyaAuth

//MARK: SIDE MENU CLASS
class SideMenuVC: UIViewController {
    
    //MARK: IB OUTLETS
    
    @IBOutlet weak var searchpointImage: UIImageView!
    @IBOutlet weak var versionNoLbl: UILabel!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var helloLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: VARIABLES AND CONSTANTS
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    var arr = [String]()
    var img = ["dashboard","settings","Group 1367","Sideconatct_support","help","full_site","data_refresh","logout"]
    var imgForiPad = ["dashboardiPad","settingsiPad","warningSigniPad","contactSupportiPadSideMenu","helpSideMenuiPad","fullSiteiPad","dataRefreshiPad","logoutiPad"]
    var group = DispatchGroup()
    var orderDetailNinetyDays:OrderDetailByPastDaysVM?
    var actionRequiredNinetyDays:ActionRequiredVM?
    var naabCodeVM:GetNaabCodeVM?
    var providerVM: GetProviderViewModel?
    var breedVM: GetBreedViewModel?
    var sampleM : SampleTypeViewModel?
    var speciesVM: GetSpeciesViewModel?
    var marketVM :GetMarketsViewModel?
    var productVM :GetProductsViewModel?
    var nominatorsVM :GetNominatorsViewModel?
    var addonVM:GetAddonsViewModel?
    var breedCodeVM:GetBreedCodeVM?
    var countryCodeVM:GetCountryCodeVM?
    var heartBeatViewModel:HeartBeatViewModel?
    var sampleStatusViewModel: SampleStatusViewModel?
    var animalByCustomerViewModel: AnimalByCustomerViewModel?
    var customerVM:GetCustomerViewModel?
    var contactVM:ContactSupportViewModel?
    var PriorityBreedNameVM :GetPriorityBreedNameVM?
    var bornTypesViewModel: ProviderBornTypesViewModel?
    var ausNaabCodeVM:AusNaabBullVM?
    var breedSoceitesVM:GetBreedSocietiesVM?
    var resultFilterViewModel: ResultFilterViewModel?
    var saveListCustomerViewModel: GetListForCustomerViewModel?
    var customerOrderSetting = CustomerOrderSetting()
    var dataViewModel:LogoutViewModel!
    
    //MARK: INITIALIZATION
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        guard Bundle.main.infoDictionary?["CFBundleShortVersionString"] is String else { return }
        self.versionNoLbl.text = Constants.appVersion
        self.tblView.delegate = self
        self.tblView.dataSource = self
        hideIndicator()
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arr = [NSLocalizedString(LocalizedStrings.dashboardText, comment: ""),NSLocalizedString(LocalizedStrings.settingsText, comment: ""),NSLocalizedString(ButtonTitles.offlineRestrictionText, comment: ""),NSLocalizedString(LocalizedStrings.contactSupportText, comment: ""),NSLocalizedString(LocalizedStrings.appHelpText, comment: ""),NSLocalizedString(ButtonTitles.fullSiteText, comment: ""),NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""),NSLocalizedString(ButtonTitles.logOutText, comment: "")]
        helloLbl.text = NSLocalizedString(ButtonTitles.hellotext, comment: "")
        let firstname = UserDefaults.standard.value(forKey: keyValue.firstName.rawValue) as? String
        if firstname != nil{
            firstNameLbl.text = " " + (firstname?.firstUppercased ?? "")
        }
        tblView.reloadData()
    }
    
    //MARK: NAVIGATION METHODS
    func navigateToAnotherVc143(){
        self.view.isUserInteractionEnabled = true
    }
    
    func navigateToAnotherVcAnimal(){
        self.view.isUserInteractionEnabled = false
        hideIndicator()
        hideIndicator()
        group.enter()
        showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
        let count = UserDefaults.standard.integer(forKey: keyValue.countAnimal.rawValue)
        animalByCustomerViewModel = AnimalByCustomerViewModel(callBack: navigateToAnotherVcAnimalCunt)
        animalByCustomerViewModel?.callServer(start: 1, count: count)
    }
    func navigateToAnotherVcAnimalCunt(){
        group.leave()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        let currentCustomer = fetchCurrentActiveCustomer(entityName: Entities.getCustomerTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)) as? [GetCustomer]
        self.setDefaultSettingsForCustomer(selectedCustomer: currentCustomer?[0])
        self.customerOrderSetting.saveCustomerSetting()
        self.view.isUserInteractionEnabled = true
        let count = UserDefaults.standard.integer(forKey: keyValue.countAnimal.rawValue)
        let custId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        saveCustomerDataCount(customerId: Int64(custId!), dataCount: Int64(count))
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        } else {
            
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        }
        
        self.sideMenuViewController!.hideMenuViewController()
        
    }
    
    //MARK: GET AND SET MARKETS
    func ssologoutMethod()
    {
        gigya.logout() { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    func getMarketsForCurrentCustomer() -> String? {
        if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int {
            let customerMarkets = fetchAllDataWithCustomerID(entityName: Entities.customerMarketsTblEntity, customerId: currentCustomerId)
            guard customerMarkets.count > 0 else {
                return nil
            }
            for market in customerMarkets as? [CustomerMarkets] ?? [] {
                return market.marketId
            }
        } else {
            return nil
        }
        return nil
    }
    
    func setDefaultSettingsForCustomer(selectedCustomer: GetCustomer?) {
        if let currentCustomer = selectedCustomer {
            UserDefaults.standard.set(currentCustomer.customerId, forKey: keyValue.currentActiveCustomerId.rawValue)
            UserDefaults.standard.set(currentCustomer.marketId, forKey: keyValue.currentActiveMarketId.rawValue)
            UserDefaults.standard.set(currentCustomer.billToCustomerId, forKey: keyValue.billToCustomerId.rawValue)
            
            guard let marketId = getMarketsForCurrentCustomer() else {
                return
            }
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == "" || UserDefaults.standard.value(forKey: keyValue.name.rawValue) == nil {
                self.setMarketNameType(marketId : marketId)
            }
            
            let ab = fetchAllDetailWithMarketSpeciesId(entityName: Entities.evaluationMarketsTblEntity,marketId:marketId,species:(UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String) ?? "")
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                UserDefaults.standard.set("", forKey: keyValue.providerNameUS.rawValue)
                self.setDataForBeefMarketType(marketId: marketId)
                
            } else if UserDefaults.standard.value(forKey: "name") as? String == marketNameType.Dairy.rawValue {
                UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                UserDefaults.standard.set("", forKey: keyValue.providerNameUS.rawValue)
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey:keyValue.screen.rawValue)
                self.setDataForDairyMarketType(marketId: marketId, ab: ab)
                
            }
        }
    }
    
    func setMarketNameType(marketId : String){
        switch marketId {
            
        case MarketID.USMarketId: //US
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            
        case MarketID.BRMarketId: //BR
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            
        case MarketID.NZMarketId: //NZ
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            
        case MarketID.AusMarketId: //AU
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            
        case MarketID.UKMarketId: //UK
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            
        case MarketID.ItaMarketId: //ITA
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
            
        case MarketID.NetherlandMarketId: //Netherland
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
        case MarketID.CanadaMarketId: //Canada
            UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
            UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
        default:
            break
        }
    }
    
    func setDataForBeefMarketType(marketId : String){
        switch marketId {
            
        case MarketID.USMarketId: //US
            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set(keyValue.gLobal.rawValue, forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
            break
            
        case MarketID.BRMarketId: //BR
            
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(6, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set(keyValue.brazil.rawValue, forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
            
        case MarketID.NZMarketId: //NZ
            
            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set(keyValue.gLobal.rawValue, forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
            break
            
        case MarketID.AusMarketId: //AU
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(keyValue.gLobal.rawValue, forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            
        case MarketID.UKMarketId: //UK
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(2, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set(keyValue.clarifideAHDBUK.rawValue, forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            
        case MarketID.ARMarketId: //AR
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set("Ar", forKey: keyValue.providerName.rawValue)
            break
        case MarketID.CanadaMarketId: //CA
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set("CA", forKey: keyValue.providerName.rawValue)
            break
        case MarketID.CHMarketId: //CH
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set("CH", forKey: keyValue.providerName.rawValue)
            break
        default:
            break
        }
    }
    
    func hideActivityIndicator(){
        hideIndicator()
    }
    
    func setDataForDairyMarketType(marketId: String, ab:NSArray){
        switch marketId {
        case MarketID.USMarketId: //US
            for ob in ab{
                let checkObj = ob as? EvaluationMarkets
                let newMarket = fetchAllDetailWithMarketSpeciesIdnEW(entityName: Entities.newMarketNameTblEntity,marketId:marketId , providerId: Int(checkObj!.providerID))
                if checkObj?.isDefault == true && checkObj?.providerID == 1 {
                    UserDefaults.standard.set(1, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
                } else if checkObj?.isDefault == false && checkObj?.providerID == 1 {
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                }
                
                if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                    UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                } else {
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                }
                
                if checkObj?.providerID == 5 {
                    UserDefaults.standard.set(1, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    
                    for item in newMarket {
                        let fetch1 = item as? NewMarketName
                        if fetch1?.productId == 19 {
                            UserDefaults.standard.set(0, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                            
                        } else if fetch1?.productId == 20{
                            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        }
                    }
                }
            }
            
        case MarketID.ItaMarketId: //  ITALY
            for ob in ab{
                let checkObj = ob as? EvaluationMarkets
                if checkObj?.isDefault == true && checkObj?.providerID == 10 {
                    UserDefaults.standard.set(10, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBIT.rawValue, forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
                    UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
                } else if checkObj?.isDefault == false && checkObj?.providerID == 10 {
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                }
                
                if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                    UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                }
                else {
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                }
            }
            
        case MarketID.CanadaMarketId: // Canada
            for ob in ab{
                let checkObj = ob as? EvaluationMarkets
                if checkObj?.isDefault == true && checkObj?.providerID == 12 {
                    
                    UserDefaults.standard.set(12, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBCan.rawValue, forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                    UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
                } else if checkObj?.isDefault == false && checkObj?.providerID == 12 {
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                }
            }
            
        case MarketID.NetherlandMarketId: // NETHERLAND
            for ob in ab{
                let checkObj = ob as? EvaluationMarkets
                if checkObj?.isDefault == true && checkObj?.providerID == 11 {
                    
                    UserDefaults.standard.set(11, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBBenelux.rawValue, forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
                    UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
                } else if checkObj?.isDefault == false && checkObj?.providerID == 11 {
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                }
                
                if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                    UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                } else {
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                }
            }
            
        case MarketID.BRMarketId: //BR
            for ob in ab{
                let checkObj = ob as? EvaluationMarkets
                let newMarket = fetchAllDetailWithMarketSpeciesIdnEW(entityName: Entities.newMarketNameTblEntity,marketId:marketId , providerId: Int(checkObj!.providerID))
                if checkObj?.species == marketNameType.Dairy.rawValue {
                    if checkObj?.isDefault == true && checkObj?.providerID == 1 {
                        UserDefaults.standard.set(1, forKey: keyValue.providerID.rawValue)
                        UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerName.rawValue)
                        UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                        UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
                    } else if checkObj?.isDefault == true && checkObj?.providerID == 4 {
                        UserDefaults.standard.set(4, forKey: keyValue.providerID.rawValue)
                        UserDefaults.standard.set(keyValue.clarifideGirolandoBR.rawValue, forKey: keyValue.providerName.rawValue)
                        UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                        UserDefaults.standard.set(keyValue.clarifideGirolandoBR.rawValue, forKey: keyValue.providerNameUS.rawValue)
                        
                    }else  if checkObj?.isDefault == true && checkObj?.providerID == 8  {
                        UserDefaults.standard.set(8, forKey: keyValue.providerID.rawValue)
                        UserDefaults.standard.set(keyValue.clarifideCDCBBR.rawValue, forKey: keyValue.providerName.rawValue)
                        UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                        UserDefaults.standard.set(keyValue.clarifideCDCBBR.rawValue, forKey: keyValue.providerNameUS.rawValue)
                    }
                    else {
                        UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                        UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    }}
                
                if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                    UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                    
                } else if checkObj?.species == marketNameType.Beef.rawValue {
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                }
                if checkObj?.providerID == 5 {
                    UserDefaults.standard.set(1, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    for item in newMarket {
                        let fetch1 = item as? NewMarketName
                        if fetch1?.productId == 19 {
                            UserDefaults.standard.set(0, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                        } else if fetch1?.productId == 20{
                            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        }
                    }
                }
            }
            
        case MarketID.NZMarketId: //NZ
            for ob in ab {
                let checkObj = ob as? EvaluationMarkets
                let newMarket = fetchAllDetailWithMarketSpeciesIdnEW(entityName: Entities.newMarketNameTblEntity,marketId:marketId , providerId: Int(checkObj!.providerID))
                if checkObj?.isDefault == true && checkObj?.providerID == 1 {
                    UserDefaults.standard.set(1, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
                } else if checkObj?.isDefault == false && checkObj?.providerID == 1 {
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                }
                
                if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                    UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                } else {
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                }
                
                if checkObj?.providerID == 5 {
                    UserDefaults.standard.set(1, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    
                    for item in newMarket {
                        let fetch1 = item as? NewMarketName
                        if fetch1?.productId == 19 {
                            UserDefaults.standard.set(0, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                            
                        } else if fetch1?.productId == 20{
                            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        }
                    }
                }
            }
            
        case MarketID.AusMarketId: //AU
            for ob in ab{
                let checkObj = ob as? EvaluationMarkets
                let newMarket = fetchAllDetailWithMarketSpeciesIdnEW(entityName: Entities.newMarketNameTblEntity,marketId:marketId , providerId: Int(checkObj!.providerID))
                
                if checkObj?.isDefault == true && checkObj?.providerID == 3 {
                    UserDefaults.standard.set(3, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.clickAuProvider.rawValue)
                    UserDefaults.standard.set("False", forKey: keyValue.isAuSelected.rawValue)
                    UserDefaults.standard.set(keyValue.auDairyProducts.rawValue, forKey: keyValue.providerName.rawValue)
                    
                } else if checkObj?.isDefault == false && checkObj?.providerID == 3 {
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.clickAuProvider.rawValue)
                }
                if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                    UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                } else {
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                }
                if checkObj?.providerID == 5 {
                    UserDefaults.standard.set(1, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    
                    for item in newMarket {
                        let fetch1 = item as? NewMarketName
                        if fetch1?.productId == 19 {
                            UserDefaults.standard.set(0, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                            
                        } else if fetch1?.productId == 20{
                            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        }
                    }
                    
                }
            }
            
        case MarketID.UKMarketId: //UK
            for ob in ab{
                let checkObj = ob as? EvaluationMarkets
                let newMarket = fetchAllDetailWithMarketSpeciesIdnEW(entityName: Entities.newMarketNameTblEntity,marketId:marketId , providerId: Int(checkObj!.providerID))
                if checkObj?.isDefault == true && checkObj?.providerID == 2 {
                    UserDefaults.standard.set(2, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(keyValue.clarifideAHDBUK.rawValue, forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                } else if checkObj?.isDefault == false && checkObj?.providerID == 2 {
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                }
                if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                    UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                    
                } else {
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                }
                
                if checkObj?.providerID == 5 {
                    UserDefaults.standard.set(1, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    
                    for item in newMarket {
                        let fetch1 = item as? NewMarketName
                        if fetch1?.productId == 19 {
                            UserDefaults.standard.set(0, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                        } else if fetch1?.productId == 20{
                            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        }
                    }
                }
            }
            
        case MarketID.ARMarketId: //AR
            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(marketNameType.Beef.rawValue, forKey: "name")
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set("AR", forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
            break
            
        case MarketID.CanadaMarketId: //CA
            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(marketNameType.Beef.rawValue, forKey: "name")
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set("CA", forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
            break
            
        case MarketID.CHMarketId: //CH
            UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(marketNameType.Beef.rawValue, forKey: "name")
            UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set("CH", forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
            
        default:
            break
        }
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension SideMenuVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        cell.nameLbl.text = arr[indexPath.row]
        
        if UIDevice().userInterfaceIdiom == .phone {
            cell.img.image = UIImage(named: img[indexPath.row])
        } else {
            cell.img.image = UIImage(named: imgForiPad[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.customerOrderSetting.saveCustomerSetting()
            if UIDevice().userInterfaceIdiom == .phone {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            } else {
                
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            }
            
            self.sideMenuViewController!.hideMenuViewController()
            
        case 1:
            if UIDevice().userInterfaceIdiom == .phone {
                UserDefaults.standard.set(1, forKey: keyValue.orderSlideTag.rawValue)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC)), animated: true)
                self.sideMenuViewController!.hideMenuViewController()
            }  else {
                UserDefaults.standard.set(1, forKey: keyValue.orderSlideTag.rawValue)
                
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SettingsVC")), animated: true)
                self.sideMenuViewController!.hideMenuViewController()
            }
            
        case 2:
            self.customerOrderSetting.saveCustomerSetting()
            if UIDevice().userInterfaceIdiom == .phone {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.offLineRestrictionVC)), animated: true)
            } else {
                
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.offLineRestrictionVC)), animated: true)
            }
            
            self.sideMenuViewController!.hideMenuViewController()
            
            
        case 3:
            self.customerOrderSetting.saveCustomerSetting()
            if UIDevice().userInterfaceIdiom == .phone {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.contactSupportVC)), animated: true)
            } else {
                
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.contactSupportVC)), animated: true)
            }
            
            self.sideMenuViewController!.hideMenuViewController()
            
        case 4:
            if UIDevice().userInterfaceIdiom == .phone {
                
                self.customerOrderSetting.saveCustomerSetting()
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpListVC)), animated: true)
                self.sideMenuViewController!.hideMenuViewController()
            }
            else {
                CommonClass.showAlertMessage(self, titleStr:AlertMessagesStrings.alertString.localized + "!", messageStr: "In progress")
            }
            
        case 5:
            self.customerOrderSetting.saveCustomerSetting()
            guard let url = URL(string: "https://mysearchpoint.com") else { return }
            UIApplication.shared.open(url)
            self.sideMenuViewController!.hideMenuViewController()
            
        case 6:
            if Connectivity.isConnectedToInternet() {
                let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue),orderId:UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                let beefDAta =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue),orderId:UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue),orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                if viewAnimalArray.count > 0 || beefDAta.count > 0 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(NSLocalizedString(AlertMessagesStrings.completeOrderStr, comment: ""), comment: ""))
                    return
                }
                
                let offSuync = UserDefaults.standard.bool(forKey: keyValue.syncOff.rawValue)
                if offSuync == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(NSLocalizedString(AlertMessagesStrings.syncOfflineOrders, comment: ""), comment: ""))
                    return
                }
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:NSLocalizedString(AlertMessagesStrings.forceFullyRefreshData, comment: ""), preferredStyle: .alert)
                let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    print(LocalizedStrings.cancelPressed)
                })
                alert.addAction(cancel)
                let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        UserDefaults.standard.set(false, forKey: keyValue.settingDefault.rawValue)
                        UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.name.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.settingDefault.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.settingDone.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.nominatorSave.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.beefProductAdded.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.providerName.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.screen.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.providerNameUS.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.speciesId.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.foReviewOrderVC.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.keyboardSelection.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.scannerSelection.rawValue)
                        UserDefaults.standard.set(nil, forKey: keyValue.beefScannerSelection.rawValue)
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
                        deleteRecordFromDatabase(entityName: Entities.getDataBaseCountTbl)
                        deleteDataWithUserId(entity: Entities.animalMasterTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteDataWithUserId(entity: Entities.animalAddTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteDataWithUserId(entity: Entities.beefAnimalMasterTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteDataWithUserId(entity: Entities.beefAnimalAddTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteRecordFromDatabase(entityName: Entities.resultFIlterDataSaveTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.resultFilterDataTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.resultGroupAnimalsTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.resultMasterPageNumberTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.resultMyherdDataTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.resultPageByTraitTblEntity)
                        deleteRecordFromDatabase(entityName: Entities.resultGroupCreateTblEntity)
                        UserDefaults.standard.set(0, forKey: keyValue.groupId.rawValue)
                        deleteDataWithUserId(entity: Entities.orderSettingsTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteDataWithUserId(entity: Entities.productAdonAnimalTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteDataWithUserId(entity: Entities.subProductTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteDataWithUserId(entity: Entities.productAdonAnimlBeefTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        deleteDataWithUserId(entity: Entities.subProductBeefTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue))
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.ausNaabCodeVM = AusNaabBullVM(callBack: self.hideActivityIndicator)
                        self.ausNaabCodeVM?.callAusNaabBull()
                        
                        self.view.isUserInteractionEnabled = false
                        self.customerVM = GetCustomerViewModel(callBack: self.hideActivityIndicator)
                        self.customerVM?.callGetCustomerCode()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.breedVM = GetBreedViewModel(callBack: self.hideActivityIndicator)
                        self.breedVM?.callGetBreeds()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.productVM = GetProductsViewModel(callBack: self.hideActivityIndicator)
                        self.productVM?.callGetProducts()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.providerVM = GetProviderViewModel(callBack: self.hideActivityIndicator)
                        self.providerVM?.callGetProvider()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.sampleM = SampleTypeViewModel(callBack: self.hideActivityIndicator)
                        self.sampleM?.callsampleType()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.nominatorsVM = GetNominatorsViewModel( callBack: self.hideActivityIndicator)
                        self.nominatorsVM?.callGetNominators()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.marketVM = GetMarketsViewModel(callBack: self.hideActivityIndicator)
                        self.marketVM?.callGetMarkets()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.breedSoceitesVM = GetBreedSocietiesVM(callBack: self.hideActivityIndicator)
                        self.breedSoceitesVM?.callGetSocietiesCode()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.PriorityBreedNameVM = GetPriorityBreedNameVM(callBack: self.hideActivityIndicator)
                        self.PriorityBreedNameVM?.callGetPriorityCode()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.countryCodeVM = GetCountryCodeVM(callBack: self.hideActivityIndicator)
                        self.countryCodeVM?.callGetCountryCode()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.bornTypesViewModel = ProviderBornTypesViewModel(callBack: self.hideActivityIndicator)
                        self.bornTypesViewModel?.serverCall()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.sampleStatusViewModel = SampleStatusViewModel(callBack: self.hideActivityIndicator)
                        self.sampleStatusViewModel?.callSampleStatuses()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.orderDetailNinetyDays?.callOrderDetailByPastApi(days: String(91))
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.actionRequiredNinetyDays?.callNineteyDaysApi(days: Int(91))
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.naabCodeVM = GetNaabCodeVM(callBack: self.hideActivityIndicator)
                        self.naabCodeVM?.callGetNaabCode()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.resultFilterViewModel = ResultFilterViewModel(callBack: self.hideActivityIndicator)
                        self.resultFilterViewModel?.callSaveListApi()
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.animalByCustomerViewModel = AnimalByCustomerViewModel(callBack: self.navigateToAnotherVcAnimal)
                        self.animalByCustomerViewModel?.callServer(start: 1, count: 0)
                        
                        self.view.isUserInteractionEnabled = false
                        self.showIndicator(self.view, withTitle: NSLocalizedString(ButtonTitles.dataRefreshText, comment: ""), and: "")
                        self.contactVM = ContactSupportViewModel( callBack: self.hideActivityIndicator)
                        self.contactVM?.callContactSupport()
                        
                        self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                        self.saveListCustomerViewModel = GetListForCustomerViewModel(callBack: self.navigateToAnotherVc143)
                        self.saveListCustomerViewModel?.callListForCustomer()
                    })
                })
                alert.addAction(ok)
                
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
                
            } else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noInternetConnection, comment: ""))
                return
            }
            
        case 7:
            self.customerOrderSetting.saveCustomerSetting()
            
            if Connectivity.isConnectedToInternet() {
                let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue),orderId:UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                let beefDAta =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: UserDefaults.standard.integer(forKey: keyValue.userId.rawValue),orderId:UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue),orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                if viewAnimalArray.count > 0 || beefDAta.count > 0 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.completeBeforeLoggingOut, comment: ""))
                }
                
                let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.logoutFromTheApp, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                    self.sideMenuViewController?.hideMenuViewController()
                }))
                refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                    
                    self.showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
                    self.dataViewModel =  LogoutViewModel(ref: self, callBack: self.logoutSuccess)
                    self.dataViewModel.delegate = self
                    self.dataViewModel.logout()
                    self.ssologoutMethod()
                    UserDefaults.standard.set(false, forKey: keyValue.settingDefault.rawValue)
                    UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.name.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.settingDefault.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.settingDone.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.nominatorSave.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefProductAdded.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.screen.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerNameUS.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.speciesId.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.keyboardSelection.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.scannerSelection.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefScannerSelection.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.removeObserver(self)
                let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.logoutFromTheApp, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                    self.sideMenuViewController?.hideMenuViewController()
                }))
                refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                    self.sideMenuViewController?.hideMenuViewController()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.onlineToLogout, comment: ""))
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: RESPONSE LOGOUT API
extension SideMenuVC : ResponseLogoutApi {
    func logoutSuccess(){
        self.hideIndicator()
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
        } else {
            
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
        }
        
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func responseRecievedStstus(status:Bool) {
        self.hideIndicator()
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
        } else {
            
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
        }
        
        self.sideMenuViewController!.hideMenuViewController()
    }
}


extension UIViewController {
    public var sideMenuViewController: AKSideMenu? {
        guard var iterator = self.parent else { return nil }
        guard let strClass = String(describing: type(of: iterator)).components(separatedBy: ".").last else { return nil }
        
        while strClass != nibName {
            if iterator is AKSideMenu {
                return iterator as? AKSideMenu
            } else if iterator.parent != nil && iterator.parent != iterator {
                iterator = iterator.parent!
            }
        }
        return nil
    }
    
    // MARK: - Public
    // MARK: - IBAction Helper methods
    
    @IBAction public func presentLeftMenuViewController(_ sender: AnyObject) {
        self.sideMenuViewController?.presentLeftMenuViewController()
    }
    
    @IBAction public func presentRightMenuViewController(_ sender: UIButton) {
        self.sideMenuViewController?.presentRightMenuViewController()
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
