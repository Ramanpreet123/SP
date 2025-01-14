//
//  DashboardVC+ControllerExtensions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 09/02/24.
//

import Foundation

// MARK: - CUSTOMER LIST CONTROLLER DELEGATE

extension DashboardVC: CustomersListControllerDelegate {
    
    func setupCurrentSelectedCustomer() {
        self.updateCustomerButton.isHidden = true
        
        if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int {
            if let currentCustomer = fetchCurrentActiveCustomer(entityName: Entities.getCustomerTblEntity, customerId: currentCustomerId) as? [GetCustomer] {
                guard currentCustomer.count > 0 else {
                    return
                }
                
                self.selectedCustomerLabel.text = currentCustomer[0].customerName ?? ""
                if UIDevice().userInterfaceIdiom == .phone {
                    self.customertitleLbll.text = NSLocalizedString(LocalizedStrings.customerTextStr, comment: "")
                    self.selectedCustomerLabel.text = ""

                }
                if fetchAllData(entityName: Entities.getCustomerTblEntity).count > 1 {
                    self.updateCustomerButton.isUserInteractionEnabled = true
                    if UIDevice().userInterfaceIdiom == .phone {
                       // self.updateCustomerButton.isHidden = false
                        self.customertitleLbll.text = NSLocalizedString(LocalizedStrings.customerTextStr, comment: "")

                    }
//                    else {
//                        self.updateCustomerButton.isHidden = true
//                    }
                }
                else{
                    self.updateCustomerButton.isHidden = true
                    
                }
                // manish userwise comment
                if self.customerOrderSetting.isCustomerAlreadySettingExist() == false {
                    UserDefaults.standard.set(false, forKey: keyValue.settingDefault.rawValue)
                    UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.name.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.settingDefault.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
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
                }
                
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
                
                var customerName = String()
                var customerId = Int()
                
                if currentCustomer[0].billToCustomerName == "" {
                    customerName = currentCustomer[0].customerName!
                }else {
                    customerName = currentCustomer[0].billToCustomerName!
                }
                if currentCustomer[0].billToCustomerId == 0 {
                    customerId = Int(currentCustomer[0].customerId)
                } else {
                    customerId = Int(currentCustomer[0].billToCustomerId)
                }
                let _ : [String:Any] = ["custId":currentCustomer[0].customerId ,
                                                 "billToCustId": "\(customerId)",
                                        "contactName": customerName ]
                
                UserDefaults.standard.set("", forKey: keyValue.farmValue.rawValue)
            }
        }
    }
    
    func moveToCustomerListing() {
        let customers =  fetchAllData(entityName: Entities.getCustomerTblEntity) as! [GetCustomer]
        _ = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
        
        if customers.count == 0 {
            
            let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.contactCustomerService, comment: ""), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                
                UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
                self.hideIndicator()
                self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                self.sideMenuViewController?.hideMenuViewController()
                self.ssologoutMethod()
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        } else if customers.count == 1 {
            let customer = customers[0]
            
            self.selectedCustomer(selectedCustomer: customer, isForSingleUser: true)
            self.selectedCustomerLabel.text = customer.customerName ?? ""
            if UIDevice().userInterfaceIdiom == .phone {
                self.customertitleLbll.text = NSLocalizedString(LocalizedStrings.customerTextStr, comment: "")

            }
            UserDefaults.standard.set(customer.customerId, forKey: keyValue.currentActiveCustomerId.rawValue)
            UserDefaults.standard.set(customer.billToCustomerId,forKey: keyValue.billToCustomerId.rawValue)
            UserDefaults.standard.set(customer.marketCode,forKey: keyValue.marketName.rawValue)
            UserDefaults.standard.set(customer.marketId,forKey: keyValue.marketNameID.rawValue)
            
            self.updateCustomerButton.isHidden = true
        } else {
            self.updateCustomerButton.isHidden = true
            var storyBoard = UIStoryboard()
            if UIDevice().userInterfaceIdiom == .phone {
                 storyBoard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.customersListControllerVC) as! CustomersListController
                vc.delegate = self
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
            else {
                storyBoard = UIStoryboard(name: "iPad", bundle: nil)
                if let customerSelectionVC = storyBoard.instantiateViewController(withIdentifier: "OpenSheetViewController") as? OpenSheetViewController {
                    customerSelectionVC.modalPresentationStyle = .overFullScreen
                    customerSelectionVC.delegate = self
                    if let sheet = customerSelectionVC.sheetPresentationController {
                        customerSelectionVC.preferredContentSize = UIScreen.main.bounds.size
                    }
                    present(customerSelectionVC, animated: false, completion: nil)
                }
            }
        }
    }
    
    ///MARK:- Current active customer has no markets
    func madeLogoutIfCustomerHasNoMarkets() {
        let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.noAssociatedProduct, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            self.hideIndicator()
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
            self.sideMenuViewController!.hideMenuViewController()
            
        }))
        
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func selectedCustomer(selectedCustomer: GetCustomer?, isForSingleUser: Bool) {
        
        if let currentCustomer = selectedCustomer {
            
            if isForSingleUser == false {
                if UIDevice().userInterfaceIdiom == .phone {
                    self.updateCustomerButton.isHidden = false
                } else {
                    self.updateCustomerButton.isHidden = true
                }
                
            }
            
            self.selectedCustomerLabel.text = currentCustomer.customerName ?? ""
            if UIDevice().userInterfaceIdiom == .phone {
                self.customertitleLbll.text = NSLocalizedString(LocalizedStrings.customerTextStr, comment: "")

            }
            UserDefaults.standard.set(currentCustomer.customerId, forKey: keyValue.currentActiveCustomerId.rawValue)
            UserDefaults.standard.set(currentCustomer.marketId, forKey: keyValue.currentActiveMarketId.rawValue)
            UserDefaults.standard.set(currentCustomer.billToCustomerId, forKey: keyValue.billToCustomerId.rawValue)
            
            
            
            if self.customerOrderSetting.isCustomerAlreadySettingExist() == false {
                UserDefaults.standard.set(false, forKey: keyValue.settingDefault.rawValue)
                UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.name.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.settingDefault.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                UserDefaults.standard.set(nil, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                
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
                
                self.setDefaultSettingsForCustomer(selectedCustomer: selectedCustomer)
            }
            
            let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
            //needs discussion
//            var customerName = String()
//            var customerId = Int()
//
//            if currentCustomer.billToCustomerName == "" {
//                customerName = currentCustomer.customerName!
//            }else {
//                customerName = currentCustomer.billToCustomerName!
//            }
//            if currentCustomer.billToCustomerId == 0 {
//                customerId = Int(currentCustomer.customerId)
//            } else {
//                customerId = Int(currentCustomer.billToCustomerId)
//            }
            
            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
            UserDefaults.standard.set("", forKey: keyValue.farmValue.rawValue)
            if Connectivity.isConnectedToInternet()
            {
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                group.enter()
              animalautoVM = AnimalAutoPopViewModel(ref: self, callBack: navigateToAnotherVc)
              animalautoVM!.callGetAutoPopAnimal()
              self.hideIndicator()
              group.enter()
                animalByCustomerViewModel = AnimalByCustomerViewModel(ref: self, callBack: navigateToAnotherVcAnimal)
                animalByCustomerViewModel?.callServer(start: 1, count: 0)
                self.hideIndicator()
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                group.enter()
                saveListCustomerViewModel = GetListForCustomerViewModel(ref: self, callBack: navigateToAnotherVc143)
                saveListCustomerViewModel?.callListForCustomer()
                self.hideIndicator()
                DispatchQueue.global(qos: .background).sync {
                    self.view.isUserInteractionEnabled = false
                    self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                    group.enter()
                    self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM( callBack: self.leavegroupapi)
                    self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
                }
                
                UserDefaults.standard.removeObject(forKey: keyValue.checkFilter.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.headerValue.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.traitValue.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.traitName.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.sortOrder.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.idSelect.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.breedName.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.selectedProviderName.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.selectedProductName.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.breedIndexPath.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.breedIndex.rawValue)
                UserDefaults.standard.removeObject(forKey: keyValue.isHerditySelected.rawValue)
                
                
                UserDefaults.standard.synchronize()
                Singleton.shared.isfilter = true
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                group.enter()
                resultFilterViewModel = ResultFilterViewModel(ref: self, callBack: resultfliter)
                resultFilterViewModel?.callSaveListApi()
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                group.enter()
                resultTotalViewModel = ResulttotalanimalsViewModel(ref: self, callBack: totalanimalcountapicheck)
                resultTotalViewModel?.callTotalanimalsApi()
                self.collectionView.reloadData()
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
            } else {
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
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
            self.selectedCustomerLabel.text = currentCustomer.customerName ?? ""
            if UIDevice().userInterfaceIdiom == .phone {
                self.customertitleLbll.text = NSLocalizedString(LocalizedStrings.customerTextStr, comment: "")

            }
            
            UserDefaults.standard.set(currentCustomer.customerId, forKey: keyValue.currentActiveCustomerId.rawValue)
            UserDefaults.standard.set(currentCustomer.marketId, forKey: keyValue.currentActiveMarketId.rawValue)
            UserDefaults.standard.set(currentCustomer.billToCustomerId, forKey: keyValue.billToCustomerId.rawValue)
            
            
            guard let marketId = getMarketsForCurrentCustomer() else {
                return
            }
            
            if  UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == "" || UserDefaults.standard.value(forKey: keyValue.name.rawValue) == nil {
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
                    UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
                    
                case MarketID.ItaMarketId: //ITA
                    UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
                    UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
                    
                case MarketID.NetherlandMarketId: //BeNeLux
                    UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
                    UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
                case MarketID.CanadaMarketId : //Canada
                    UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
                    UserDefaults.standard.set("DD", forKey: keyValue.date.rawValue)
                default:
                    break
                }
            }
            
            
            let ab = fetchAllDetailWithMarketSpeciesId(entityName: Entities.evaluationMarketsTblEntity,marketId:marketId,species:(UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String) ?? "")
            
            if  UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                UserDefaults.standard.set("", forKey: keyValue.providerNameUS.rawValue)
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
                    
                case MarketID.AusMarketId: //AU
                    UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set(keyValue.auDairyProducts.rawValue, forKey: keyValue.providerName.rawValue)
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
                    
                case MarketID.CHMarketId: //CH
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set("CH", forKey: keyValue.providerName.rawValue)
                    break
                    
                default:
                    break
                }
                
            } else if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Dairy.rawValue {
                UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                UserDefaults.standard.set("", forKey: keyValue.providerNameUS.rawValue)
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey:keyValue.screen.rawValue)
                
                
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
                        
                        //1.10 merged
                        if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true && checkObj?.providerID == 5{
                            UserDefaults.standard.set(checkObj?.providerID ?? 0, forKey: keyValue.beefPvid.rawValue)
                            
                        } else if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true && checkObj?.providerID == 13{
                            UserDefaults.standard.set(13, forKey: keyValue.beefPvid.rawValue)
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
                case MarketID.ItaMarketId: //IT   ITALY
                    
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
                            
                        } else {
                            
                            UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                        }
                        
                    }
                    
                    
                case MarketID.NetherlandMarketId: // NETHERLAND
                    
                    for ob in ab{
                        let checkObj = ob as? EvaluationMarkets
                        if checkObj?.isDefault == true && checkObj?.providerID == 11 {
                            
                            UserDefaults.standard.set(11, forKey: keyValue.providerID.rawValue)
                            UserDefaults.standard.set(keyValue.clarifideCDCBBenelux.rawValue, forKey: keyValue.providerName.rawValue)
                            UserDefaults.standard.set(keyValue.clarifideCDCBUS.rawValue, forKey: keyValue.providerNameUS.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
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
                                
                            } else  if checkObj?.isDefault == true && checkObj?.providerID == 4  {
                                
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
                        UserDefaults.standard.set(keyValue.officialId.rawValue, forKey:keyValue.screen.rawValue)
                        let newMarket = fetchAllDetailWithMarketSpeciesIdnEW(entityName: Entities.newMarketNameTblEntity,marketId:marketId , providerId: Int(checkObj!.providerID))
                        if checkObj?.isDefault == true && checkObj?.providerID == 2 {
                            
                            UserDefaults.standard.set(2, forKey: keyValue.providerID.rawValue)
                            UserDefaults.standard.set(keyValue.clarifideAHDBUK.rawValue, forKey: keyValue.providerName.rawValue)
                            UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                            //UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
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
                    UserDefaults.standard.set(marketNameType.Beef.rawValue, forKey: keyValue.name.rawValue)
                    UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set("AR", forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
                    break
                    
                case "7bd58ad4-6fb3-4b9c-89a3-c498019cd69b": //CH
                    UserDefaults.standard.set(0, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    UserDefaults.standard.set(marketNameType.Beef.rawValue, forKey: keyValue.name.rawValue)
                    UserDefaults.standard.set(5, forKey: keyValue.beefPvid.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
                    UserDefaults.standard.set("CH", forKey: keyValue.providerName.rawValue)
                    UserDefaults.standard.set(1, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
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
                        
                        if checkObj?.species == marketNameType.Beef.rawValue && checkObj?.isDefault == true {
                            
                            UserDefaults.standard.set(checkObj?.providerID, forKey: keyValue.beefPvid.rawValue)
                            
                        } else {
                            
                            UserDefaults.standard.set(nil, forKey: keyValue.beefPvid.rawValue)
                        }
                        
                    }
                default:
                    break
                }
            }
        }
    }
    
}

// MARK: - INHERIT QUESTION CONTROLLER DELEGATE

extension DashboardVC: InheritQuestionaireControllerDelegate {
    func inheritQuestionaireControllerDismissed() {
        UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC) as! BeefAnimalGlobalHD50KVC
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
}
