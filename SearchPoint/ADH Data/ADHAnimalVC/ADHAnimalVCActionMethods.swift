//
//  ADHAnimalVCActionMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 07/03/24.
//

import Foundation
import UIKit
import CoreBluetooth

//MARK: IB ACTION METHODS
extension ADHAnimalVC {
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        navigateToADHFilterControler()
    }
    
    @IBAction func dashBoardBackBtnClick(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: keyValue.ADHFilterApplied.rawValue)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func backBtnClick(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: keyValue.ADHFilterApplied.rawValue)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func myGroupBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.myManagementGroupControllerVC) as? MyManagementGroupController
        vc!.screenBackSave = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func crossPairedAction(_ sender: Any) {
        pairedBackroundView.isHidden = true
    }
    
    @IBAction func providerFilterBtnClick(_ sender: UIButton) {
        UserDefaults.standard.setValue("true", forKey: keyValue.checkFilter.rawValue)
        navigateToADHFilterControler()
    }
    
    @IBAction func breedFilterBtnClick(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: keyValue.checkFilter.rawValue)
        navigateToADHFilterControler()
    }
    
    @IBAction func dateFilterBtnClick(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: keyValue.checkFilter.rawValue)
        navigateToADHFilterControler()
    }
    
    @IBAction func sexFilterBtnClick(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: keyValue.checkFilter.rawValue)
        navigateToADHFilterControler()
    }
    
    @IBAction func rfidBtnClick(_ sender: Any) {
        view.endEditing(true)
        
        if isOCRScannerSelected() {
            navigateToOCRScanner()
            return
        }
        
        if isBluetoothOff() {
            presentBluetoothOffAlert()
            return
        }
        
        handleBluetoothState()
    }
    
    @IBAction func sortByAction(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        dropDown.anchorView = sortByDownlbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 30
        dropDown.dataSource = [ NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""),NSLocalizedString(LocalizedStrings.officialIDText, comment: "")]
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.clickOnDropDown = item
            weakSelf.sortByButtonOutlet.setTitle(item, for: .normal)
            weakSelf.sortByButtonOutlet.layer.borderColor = UIColor.gray.cgColor
            
            if weakSelf.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                let sortedArray : [AnimalMaster] = (self?.viewModel.adhAnimalData.sorted(by: {$0.farmId ?? "" < $1.farmId ?? ""}))!
                self?.viewModel.adhAnimalData = sortedArray
                self?.viewModel.filterAdhAnimalData = sortedArray
                self?.tblView.reloadData()
            }
            else if weakSelf.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                let sortedArray: [AnimalMaster] = (self?.viewModel.adhAnimalData.sorted(by: {$0.animalTag ?? "" < $1.animalTag ?? ""}))!
                self?.viewModel.adhAnimalData = sortedArray
                self?.viewModel.filterAdhAnimalData = sortedArray
                self?.tblView.reloadData()
            }
        }
        dropDown.show()
        
    }
    
    @IBAction func sortByDropDownAction(_ sender: UIButton) {
        if (self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")) {
            if (sortByDropDownOutlet.currentImage == UIImage(named: ImageNames.sortingDescImg)) {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                let sortedArray : [AnimalMaster] = (self.viewModel.adhAnimalData.sorted(by: {($0.farmId ?? "").localizedStandardCompare($1.farmId ?? "") == .orderedAscending }))
                self.viewModel.sortingType = "farmIdAscending"
                self.viewModel.adhAnimalData = sortedArray
                self.viewModel.filterAdhAnimalData = sortedArray
                self.tblView.reloadData()
            }
            else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                let sortedArray : [AnimalMaster] =  (self.viewModel.adhAnimalData.sorted(by: {($0.farmId ?? "").localizedStandardCompare($1.farmId ?? "") == .orderedDescending }))
                self.viewModel.sortingType = "farmIdDescending"
                self.viewModel.adhAnimalData = sortedArray
                self.viewModel.filterAdhAnimalData = sortedArray
                self.tblView.reloadData()
            }
        } else  {
            if sortByDropDownOutlet.currentImage == UIImage(named: ImageNames.sortingDescImg) {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                let sortedArray : [AnimalMaster] = (self.viewModel.adhAnimalData.sorted(by: {($0.animalTag ?? "").localizedStandardCompare($1.animalTag ?? "") == .orderedAscending }))
                self.viewModel.sortingType = "officialIdAscending"
                self.viewModel.adhAnimalData = sortedArray
                self.viewModel.filterAdhAnimalData = sortedArray
                self.tblView.reloadData()
                
            } else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                let sortedArray : [AnimalMaster] = (self.viewModel.adhAnimalData.sorted(by: {($0.animalTag ?? "").localizedStandardCompare($1.animalTag ?? "") == .orderedDescending }))
                self.viewModel.sortingType = "officialIdDescending"
                self.viewModel.adhAnimalData = sortedArray
                self.viewModel.filterAdhAnimalData = sortedArray
                self.tblView.reloadData()
            }
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
    
    @IBAction func menuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func acnSubmitAnimal(_ sender: UIButton) {
        let filterArray = viewModel.adhAnimalData.filter({ $0.isADHSelected })
        if(filterArray.count>0){
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            let auto = UserDefaults.standard.bool(forKey: keyValue.autoId.rawValue)
            if !auto {
                autoIncrementidtable()
                autoD = fetchFromAutoIncrement()
                timeStampString = timeStamp()
                UserDefaults.standard.set(timeStampString, forKey: keyValue.timeStamp.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.autoId.rawValue)
                UserDefaults.standard.set(autoD, forKey: keyValue.orderId.rawValue)
            }
            autoD = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
            
            for dataGet in filterArray {
                if dataGet.animalbarCodeTag != "" && dataGet.isADHSelected {
                    let defaltscreen =  UserDefaults.standard.string(forKey: keyValue.screen.rawValue) ?? ""
                    if defaltscreen == keyValue.farmId.rawValue || defaltscreen == ""{
                        let farmIDArray = fetchAnimaldataValidateFamID(entityName: Entities.animalAddTblEntity,farmId:dataGet.farmId ?? "",custmerId: customerId , userId: userId, animalId: Int64(Int(dataGet.animalId )))
                        if farmIDArray.count != 0 {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAddedWithSameFarmId, comment: ""))
                            return
                        }
                    } else {
                        let animalTagArray =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:dataGet.animalTag ?? "",orderId: orderId, userId: userId, custmerId: customerId )
                        if animalTagArray.count != 0 {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAddedWithSameOfficialTag, comment: ""))
                            return
                        }
                    }
                    
                    updateOrderStatusISyncAnimalMaster(entity: Entities.animalMasterTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "",update: "false", permanentId:dataGet.offPermanentId ?? "", tissuName: ButtonTitles.allflexTSUText, breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: 1,sireIDAU:(dataGet.sireIDAU ?? ""), nationHerdAU:dataGet.nationHerdAU ?? "", userId: Int(userId),udid:timeStampString,animalId: Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),isSyncServer:false, adhDataServer: true, editFlagSave: true, territoryGeno: "")
                    
                    updateAdhAnimalDataforCart(entity: Entities.animalMasterTblEntity, officialID: dataGet.animalTag ?? "", barCode: dataGet.animalbarCodeTag ?? "", isADHCart: true)
                    
                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: ButtonTitles.allflexTSUText,breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: orderId,orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: 1,sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: (dataGet.udid ?? ""),animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType ?? ""  ,earTag:"",isSyncServer:dataGet.isSyncServer, adhDataServer: true,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                    createDataList()
                    saveAnimaltoCart(dataGet, orderID: orderId)
                }
            }
            UserDefaults.standard.removeObject(forKey: keyValue.ADHFilterApplied.rawValue)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func acnClearList(_ sender: UIButton) {
        self.viewModel.updateADHListToClearAnimals()
        if isADHFilterApplied ?? false {
            self.viewModel.fetchFilteredADHAnimalList(userId: self.userId!, customerID: Int(self.customerId), fromDate: self.filterFromDate ?? "", toDate: self.filterToDate ?? "", gender: self.filterGender ?? "", breedID: filterBreedId ?? "")
        } else {
            fetchADHAnimalData()
        }
        showTotalCount()
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        barcodeScreen = false
        selectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func alertAction(_ sender: UIButton) {
        view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
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
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                // Intentionally left empty.
                                  // Nothing additional required after opening Settings.
                                  // Could be used in the future for logging, analytics, or error handling.
                                print("Settings opened successfully")
                            })
                            
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
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
                if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
                    BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
            }
        }
    }
}

