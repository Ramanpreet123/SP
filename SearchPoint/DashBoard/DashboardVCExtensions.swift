//
//  DashboardVCExtensions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 09/02/24.
//

import Foundation
import Alamofire
import FirebaseFirestore
import FirebaseStorage

// MARK: - UICOLLECTIONVIEW DATASOURCES AND DELEGATES

extension DashboardVC :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UIDevice().userInterfaceIdiom == .pad {
            return self.dashboardImagesIpad.count
        } else {
            return self.dashboardItemsImageArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if UIDevice().userInterfaceIdiom == .pad {
            let cell : DashboardCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCardCell", for: indexPath as IndexPath) as! DashboardCardCell
          //  cell.imgVw.image = UIImage(named: self.dashboardItemsImageArray[indexPath.row] as! String)
            cell.mainTitleLabel.text = self.iPadTitleArray[indexPath.row]
            
            cell.imgVw.image = self.dashboardImagesIpad[indexPath.row] as? UIImage
            cell.descriptionLabel.text = self.descriptionTextArray[indexPath.row]
            cell.layer.cornerRadius = 18
            cell.contentView.layer.cornerRadius = 18
            cell.contentView.clipsToBounds = true
            cell.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 1)
            cell.layer.shadowOpacity = 0.7
            cell.layer.shadowRadius = 6
            cell.layer.masksToBounds = false
            
            switch UIScreen.main.bounds.height {
            case 768:
                cell.mainTitleLabel.font = cell.mainTitleLabel.font.withSize(22)
                cell.descriptionLabel.font = cell.mainTitleLabel.font.withSize(15)
                
            case 810:
                cell.mainTitleLabel.font = cell.mainTitleLabel.font.withSize(22)
                cell.descriptionLabel.font = cell.mainTitleLabel.font.withSize(15)
                
            case 820:
                cell.mainTitleLabel.font = cell.mainTitleLabel.font.withSize(22)
                cell.descriptionLabel.font = cell.mainTitleLabel.font.withSize(15)
                
            case 834:
                cell.mainTitleLabel.font = cell.mainTitleLabel.font.withSize(22)
                cell.descriptionLabel.font = cell.mainTitleLabel.font.withSize(15)
                
            case 1024:
                cell.mainTitleLabel.font = cell.mainTitleLabel.font.withSize(25)
                cell.descriptionLabel.font = cell.mainTitleLabel.font.withSize(21)
                
            case 1032:
                cell.mainTitleLabel.font = cell.mainTitleLabel.font.withSize(25)
                cell.descriptionLabel.font = cell.mainTitleLabel.font.withSize(21)
                
            default:
                cell.mainTitleLabel.font = cell.mainTitleLabel.font.withSize(22)
                cell.descriptionLabel.font = cell.mainTitleLabel.font.withSize(15)
            }
            
            return cell
        }
        else {
            let cell : DashboardCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! DashboardCollectionCell
            cell.imgView.image = UIImage(named: self.dashboardItemsImageArray[indexPath.row] as! String)
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _ =  scrollView.contentOffset.y
    }
    public func calculatePercentage(value:Double,percentageVal:Double)->Int{
        let val = (value - percentageVal) / value
        
        _ = 1.0 - val
        
        return Int(val)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.saveResulyByPageViewModel?.timer.invalidate()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let custId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)

        let fetchSettingData = fetchAllOrderSetting(entityName: Entities.orderSettingsTblEntity, customerId: custId,userId:userId)
        if indexPath.item == 0 {
            
         //   if UIDevice().userInterfaceIdiom == .phone {
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                let marketId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as! String
                if marketId == MarketID.USMarketId  && pvid == 13 && UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
                    self.saveResulyByPageViewModel?.timer.invalidate()
                    self.workItem?.cancel()
                    checkworkitem = true
                    self.checkpercentage = true
                    self.orderingBtnClick()
                    
                } else {
                    UserDefaults.standard.set(keyValue.placeOrder.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
                    self.saveResulyByPageViewModel?.timer.invalidate()
                    self.workItem?.cancel()
                    checkworkitem = true
                    self.checkpercentage = true
                    self.orderingBtnClick()
                }
              
        //    }
//            else {
//                CommonClass.showAlertMessage(self, titleStr: "Alert!", messageStr: "In progress")
//            }
            

            
        }
        
        else if indexPath.item == 1 {
            
            if UIDevice().userInterfaceIdiom == .pad {
               // CommonClass.showAlertMessage(self, titleStr: "Alert!", messageStr: "In progress")
                let marketId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as! String
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                
                if marketId == MarketID.USMarketId  && pvid == 13 && UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.inheritEnrollmentText, comment: ""))
                }else {
                    UserDefaults.standard.set(ScreenNames.dataEntry.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
                    self.saveResulyByPageViewModel?.timer.invalidate()
                    self.workItem?.cancel()
                    checkworkitem = true
                    self.checkpercentage = true
                    self.dataEnterModeAction()
               }
            }
            else {
                let marketId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as! String
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                
                if marketId == MarketID.USMarketId  && pvid == 13 && UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.inheritEnrollmentText, comment: ""))
                }else {
                    UserDefaults.standard.set(ScreenNames.dataEntry.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
                    self.saveResulyByPageViewModel?.timer.invalidate()
                    self.workItem?.cancel()
                    checkworkitem = true
                    self.checkpercentage = true
                    self.dataEnterModeAction()
                }
                
            }
            
        } else if indexPath.item == 2 {
            
            let fetchObj = fetchResultFilterData(entityName: Entities.resultFilterDataTblEntity,customerId:  UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
            if fetchObj.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noResultString, comment: "") )
                self.view.isUserInteractionEnabled = true
                return
            } else {
                
                if UIDevice().userInterfaceIdiom == .pad {
                    let storyboard = UIStoryboard(name: "Results", bundle: Bundle.main)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ResultTypeSelectionVCiPad") as! ResultTypeSelectionVCiPad
                    vc.delegate = self
                    vc.modalPresentationStyle = .overFullScreen
                    self.navigationController?.present(vc, animated: false, completion: nil)
                } else {
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.resultTypeSelectionViewController) as! ResultTypeSelectionViewController
                    vc.delegate = self
                    vc.modalPresentationStyle = .overFullScreen
                    self.navigationController?.present(vc, animated: false, completion: nil)
                }
            }
        }
        
        else if indexPath.item == 3 {
            if UIDevice().userInterfaceIdiom == .pad {
              //  CommonClass.showAlertMessage(self, titleStr: "Alert!", messageStr: "In progress")
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                checkworkitem = true
                self.checkpercentage = true
                self.saveResulyByPageViewModel?.timer.invalidate()
                self.customerOrderSetting.saveCustomerSetting()
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "ResolveIssuesiPadVC")), animated: true)
            }
            else {
                checkworkitem = true
                self.checkpercentage = true
                self.saveResulyByPageViewModel?.timer.invalidate()
                self.customerOrderSetting.saveCustomerSetting()
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.resolveIssuesVC)), animated: true)
            }
        } else if indexPath.item == 4 {
            if UIDevice().userInterfaceIdiom == .pad {
                checkworkitem = true
                self.checkpercentage = true
                self.saveResulyByPageViewModel?.timer.invalidate()
                self.customerOrderSetting.saveCustomerSetting()
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "SampleTrackingVCIpad")), animated: true)
            }
            else {
                checkworkitem = true
                self.checkpercentage = true
                self.saveResulyByPageViewModel?.timer.invalidate()
                self.customerOrderSetting.saveCustomerSetting()
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.sampleTrackingVC)), animated: true)
            }
            
        } else if indexPath.item == 5 {
            checkworkitem = true
            self.checkpercentage = true
            self.saveResulyByPageViewModel?.timer.invalidate()
            self.customerOrderSetting.saveCustomerSetting()
            if UIDevice().userInterfaceIdiom == .phone {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.contactSupportVC)), animated: true)
            } else {
              
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.contactSupportVC)), animated: true)
            }
          
            
        }
    }
    
    
    func addAnimalInGroup(groupId:String,gobj:ResultAnimalServer,animalIds: String, completionHandler: @escaping CompletionHandler){
        let _: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: (accessToken ?? ""),LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.addAnimalGroup.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.groupId.rawValue: gobj.groupId as Any,"animalIds":gobj.animalIds]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch _ {
            
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case let .success(value):
                    let groupid = value as? NSDictionary
                    _ = groupid?.value(forKey: keyValue.groupId.rawValue)
                    self.hideIndicator()
                    Date().saveCurrentDate()
                    
                    return completionHandler(true)
                    
                case .failure(_):
                    print("")
                }
                
            } else {
                self.hideIndicator()
            }
        }
        return
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.bounds.height {
            case 768:
                let totalSpacing = 9 * 3
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 3
                return CGSize(width: Int(itemWidth) - totalSpacing, height: 220)
                
            case 810:
                let totalSpacing = 9 * 3
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 3
                return CGSize(width: Int(itemWidth) - totalSpacing, height: 240)
                
            case 820:
                let totalSpacing = 9 * 3
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 3
                return CGSize(width: Int(itemWidth) - totalSpacing, height: 240)
                
            case 834:
                let totalSpacing = 9 * 3
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 3
                return CGSize(width: Int(itemWidth) - totalSpacing, height: 250)
                
            case 1024:
                let totalSpacing = 9 * 3
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 3
                return CGSize(width: Int(itemWidth) - totalSpacing, height: 300)
                
            case 1032:
                let totalSpacing = 9 * 3
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 3
                return CGSize(width: Int(itemWidth) - totalSpacing, height: 300)
                
            default:
                let totalSpacing = 9 * 3
                let screenWidth = UIScreen.main.bounds.width
                let itemWidth = screenWidth / 3
                return CGSize(width: Int(itemWidth) - totalSpacing, height: 240)
            }
              
            
            //for portrait
         //   } else {
//                let totalSpacing = 20 * 2
//                let screenWidth = UIScreen.main.bounds.width
//                let itemWidth = screenWidth / 2
//                return CGSize(width: Int(itemWidth) - totalSpacing, height: 270)
         //   }
           
        } else {
            let collectionViewSizeHeight = collectionView.frame.size.height
            let cellWidth = (UIScreen.main.bounds.width - 100) / 2
            return CGSize(width: cellWidth, height: (collectionViewSizeHeight) / 3)
        }
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return 20
            
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - RESULT TYPE SELECTION DELEGATE

extension DashboardVC : ResultTypeSelectionDelegate {
    
    func checkResultByAnimal(){
        let animalArray = fetchAllSearchByAnimal(entityName: Entities.resultByAnimalTblEntity, customerId: UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0)
        if animalArray.count  == 0 {
            saveResultbysearchAnimalData(customerID: UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0, searchbyEarTag: true)
        }
    }
    
    func selectedIndex(index: Int) {
        if index == 1 {
            UserDefaults.standard.set(false, forKey: keyValue.searchByAnimal.rawValue)
            self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            let fetchObj = fetchResultFilterData(entityName: Entities.resultFilterDataTblEntity,customerId:  UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
            
            if fetchObj.count == 0
            {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noResultString, comment: "") )
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
                return
            } else {
                self.resultSelection()
            }
        } else {
            checkResultByAnimal()
            if UIDevice().userInterfaceIdiom == .pad {
                let storyboard = UIStoryboard(name: "Results", bundle: Bundle.main)
                UserDefaults.standard.set(true, forKey: keyValue.searchByAnimal.rawValue)
                
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "MyHerdResultByAnimalVCiPad")), animated: true)
            } else {
                UserDefaults.standard.set(true, forKey: keyValue.searchByAnimal.rawValue)
                checkResultByAnimal()
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.myHerdResultsByAnimalViewController)), animated: true)
            }
          
        }
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATE

extension DashboardVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == customerTblView {
            return filteredData.count
        }
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == customerTblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OpenSheetTableViewCell", for: indexPath) as! OpenSheetTableViewCell
            cell.lblTitle?.text = filteredData[indexPath.row].customerName
            return cell
            //return customerList.count
        } else {
            let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.beefProductTVCIdentifier, for: indexPath) as! BeefProductsTableViewCell
            let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
            if product.productName == keyValue.genoTypeOnly.rawValue
            {
                let langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
                if langId == 2{
                    cell.productName.text = keyValue.genotipagem.rawValue
                }
                else
                {
                    cell.productName.text = product.productName
                }
            }
            else
            {
                cell.productName.text = product.productName
            }
            cell.radioBttn.isUserInteractionEnabled = false
            cell.iBttn.isHidden = true
            //for Global
            if pvid == 5 {
                tblviewHeightConstaint.constant = 140
                
                if product.productId == 20 {
                    cell.iBttn.isHidden = false
                    self.inheritInfoButtonFrame = cell.iBttn.center.x - cell.iBttn.frame.size.width / 2
                    cell.iBttn.addTarget(self, action: #selector(self.marketTipPopClick), for: .touchUpInside)
                }
                if product.isAdded == "true" {
                    cell.radioBttn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                } else{
                    cell.radioBttn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                }
                cell.isUserInteractionEnabled = true
                cell.radioBttn.alpha = 1
                cell.alpha = 1
                cell.productName.alpha = 1
                
            }
            
            //for brazil
            if pvid == 6 {
                if UIDevice().userInterfaceIdiom == .phone {
                    tblviewHeightConstaint.constant = 188

                } else {
                    tblviewHeightConstaint.constant = 379

                }
                
                if product.isAdded == "true" {
                    cell.radioBttn.setImage(UIImage(named: "incrementalCheckIpad"), for: .normal)
                } else{
                    cell.radioBttn.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                }
                cell.isUserInteractionEnabled = true
                cell.radioBttn.alpha = 1
                cell.alpha = 1
                cell.productName.alpha = 1
            }
            
            //for Newzealand
            if pvid == 7 {
                if product.isAdded == "true" {
                    cell.radioBttn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                } else{
                    cell.radioBttn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                }
            }
            
            return cell
        }
     
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == customerTblView {
            self.selectedCustomer = filteredData[indexPath.row]
            self.didSelectCustomer(filteredData[indexPath.row].customerName ?? "", selectedCustomer: self.selectedCustomer!)
//            dismiss(animated: true, completion: nil)
//            self.searchTextField.endEditing(true)
//            self.searchTextField.resignFirstResponder()
//            self.tblViewSeperator.isHidden = true
//            self.customerTblView.isHidden = true
//            self.containerViewHeight.constant = 50.0
//            self.customerTblBottomConstraint.constant = 0
//            self.calendarViewBkg.isHidden = true
        }
        else {
            let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
            if pvid == 13{
                //for global
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                    }
                    products[indexPath.row].isAdded = "true"
                }
                UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                productTblView.reloadData()
            }
            
            if pvid == 5{
                //for global
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                    }
                    products[indexPath.row].isAdded = "true"
                }
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                productTblView.reloadData()
            }
            
            if pvid == 6 {
                //for brazil
                if let  products = productArr as? [GetProductTbl] {
                    if products[indexPath.row].isAdded == "true" {
                        products[indexPath.row].isAdded = "false"
                    } else {
                        products[indexPath.row].isAdded = "true"
                    }
                }
                brazilProduct.append(product.productName!)
                
                UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                UserDefaults.standard.set(brazilProduct, forKey: keyValue.brazilProduct.rawValue)
                
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                productTblView.reloadData()
            }
            
            if pvid == 7 {
                //for Newzealand
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                    }
                    UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                    products[indexPath.row].isAdded = "true"
                }
                
                productTblView.reloadData()
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == customerTblView {
////            if indexPath.row == filteredData.count{
////                if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
////                    return UITableView.automaticDimension
////                }else{
////                    return UITableView.automaticDimension
////                }
////            }
//            return 60
//            
//        }
//            return 70
//    }
}

// MARK: - RESPONSE LOGOUT API

extension DashboardVC : ResponseLogoutApi {
    func logoutSuccess(){
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
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
        logoutSuccess()
    }
}

// MARK: - OFFLINE CUSTOM VIEW DELEGATE

extension DashboardVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - CUSTOMER SELECTION  IPAD DELEGATE

extension DashboardVC{
    func didSelectCustomer(_ customer: String, selectedCustomer : GetCustomer?) {
        self.searchTextField.text = customer
        self.pageapi = 0
        UserDefaults.standard.setValue(0, forKey: keyValue.totalAnimalsCount.rawValue)
        UserDefaults.standard.set(selectedCustomer?.customerId, forKey: keyValue.currentActiveCustomerId.rawValue)
        UserDefaults.standard.set(selectedCustomer?.billToCustomerId,forKey: keyValue.billToCustomerId.rawValue)
        UserDefaults.standard.set(selectedCustomer?.marketCode,forKey: keyValue.marketName.rawValue)
        UserDefaults.standard.set(selectedCustomer?.marketId,forKey: keyValue.marketNameID.rawValue)
        UserDefaults.standard.set(selectedCustomer?.country,forKey: keyValue.country.rawValue)
        let curentCustId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        let email = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
        let customerSetting =  fetchAllCustomerSettingData(entityName: Entities.customerSettingSaveEntity,emailId:email.lowercased())
        
        if customerSetting.count == 0 {
            savecustomerSettingData(customerID: curentCustId!,emailId: email.lowercased())
            
        } else {
            UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
            updateCustomerSettingData(entity: Entities.customerSettingSaveEntity,emailId: email.lowercased(),customerId:curentCustId!)
            
        }
        
        if self.getMarketsForCurrentCustomer() == nil {
            self.madeLogoutIfCustomerHasNoMarkets()
            return
        }
        
        if UserDefaults.standard.value(forKey: "name") as? String == "Dairy" ||  UserDefaults.standard.value(forKey: "name") as? String == nil  {
            self.provideCountCheckDairy = fetchdataOfProvider(specisId: "074dc82b-2b82-4ee6-99c6-f9691937394d") as! [GetProviderTbl]
            getListProvider = providerEvaliuater(arr: provideCountCheckDairy) as! [GetProviderTbl]
            // getListProvider
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated evaluation provider found for this customer in the app.", comment: ""))
                self.customerTblView.isHidden = false
                self.searchTextField.text = ""
                UserDefaults.standard.removeObject(forKey: keyValue.currentActiveCustomerId.rawValue)
                return
              
            } else {
                dismiss(animated: true, completion: nil)
                self.searchTextField.endEditing(true)
                self.searchTextField.resignFirstResponder()
                self.tblViewSeperator.isHidden = true
                self.customerTblView.isHidden = true
                self.containerViewHeight.constant = 50.0
                self.customerTblBottomConstraint.constant = 0
                self.calendarViewBkg.isHidden = true
            }
        }
        
        else if UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
            
            self.provideCountCheckDairy = fetchdataOfProvider(specisId: "151e2230-9a01-4828-a105-d87a92b5be2f") as! [GetProviderTbl]
            
            getListProvider = providerEvaliuater(arr: provideCountCheckDairy) as! [GetProviderTbl]
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated product found for this customer in the app.", comment: ""))
                self.customerTblView.isHidden = false
                self.searchTextField.text = ""
                UserDefaults.standard.removeObject(forKey: keyValue.currentActiveCustomerId.rawValue)
              return
            } else {
                dismiss(animated: true, completion: nil)
                self.searchTextField.endEditing(true)
                self.searchTextField.resignFirstResponder()
                self.tblViewSeperator.isHidden = true
                self.customerTblView.isHidden = true
                self.containerViewHeight.constant = 50.0
                self.customerTblBottomConstraint.constant = 0
                self.calendarViewBkg.isHidden = true
            }
        }

        
        guard UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) != nil || UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int != 0 else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:NSLocalizedString(LocalizedStrings.pleaseSelectCustomer, comment: "") )
            return
        }
        UserDefaults.standard.removeObject(forKey: keyValue.capsBrazil.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.dataEntryTsu.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.beefProduct.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.breedNameClear.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.capsBreedName.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.foReviewOrderVC.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedName.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedId.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.beefBreed.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        self.selectedCustomer(selectedCustomer: selectedCustomer, isForSingleUser: false)
        self.collectionView.reloadData()
    }
    
    func providerEvaliuater(arr:[GetProviderTbl]) -> [GetProviderTbl] {
        getListProvider.removeAll()
        for provider in arr {
            
            var providersForCustomerMarkets = [Int]()
            for markets in customerMarkets {
                
                let evaluationMarkets = fetchEvaluationMarkets(entityName: "EvaluationMarkets", marketId: markets.marketId ?? "", speciesId: provider.speciesId ?? "")
                
                for market in evaluationMarkets as? [EvaluationMarkets] ?? [] {
                    
                    let providers = fetchEvaluationProvider(entityName: "GetProviderTbl", providerId: Int(market.providerID))
                    
                    for provider in providers as? [GetProviderTbl] ?? [] {
                        providersForCustomerMarkets.append(Int(provider.providerId))
                    }
                }
            }
            
            if providersForCustomerMarkets.contains(Int(provider.providerId)) {
                getListProvider.append(provider)
            }
        }
        return getListProvider
    }
}

// MARK: - SIDE MENU UI DELEGATE

extension DashboardVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - FIREBASE APP HELP IMAGES

extension DashboardVC  {
    func getDownloadURl() {
        
        let langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
        var storageReference = ref.child("")
        
        if langId == 1 {
            storageReference = ref.child("Ios/en")
            
        }
        else if langId == 2 {
            storageReference = ref.child("Ios/pt")
            
        }
        else {
            storageReference = ref.child("Ios/it")
            
        }
        storageReference.listAll { (result, error) in
            if let error = error {
                print(error)
            }
            let savedImgArr = fetchImgDetailsFromDB() as [NSDictionary]
            if savedImgArr.count == result?.items.count  {
                return
            }
            
            if result?.items.count ?? 0 > 0 {
                
                for item in result!.items {
                    //List storage reference
                    deleteAllData(Entities.imageTblEntity)
                    let storageLocation = String(describing: item)
                    let gsReference = Storage.storage().reference(forURL: storageLocation)
                    let dictDat = NSMutableDictionary()
                    UserDefaults.standard.setValue(result?.items.count, forKey: keyValue.imageCount.rawValue)
                    
                    gsReference.getData(maxSize: (1 * 1024 * 1024), completion: { (data, error) -> Void in
                        if (error != nil) {
                            print(error as Any)
                        } else {
                            let myImage : UIImage! = UIImage(data: data!)
                            
                            self.counter = self.counter + 1
                            let percent = (self.counter*100)/(result?.items.count ?? 0)
                            print(percent)
                            DispatchQueue.main.async {
                                if UIDevice().userInterfaceIdiom == .phone {
                                    self.appHelpView.isHidden = false
                                    self.appHelpPercentLbl.text = "\(percent)" + "%"
                                }
                              
                            }
                            let imageData:NSData = myImage!.pngData()! as NSData
                            
                            let urlStr = item.fullPath
                            if let url = URL(string: urlStr) {
                                let withoutExt = url.deletingPathExtension()
                                let name = withoutExt.lastPathComponent
                                //  let result = name.substring(from: name.index(name.startIndex, offsetBy: 3))
                                _ = String(name.prefix(3))
                                let scanner = Scanner(string: name)
                                var element : NSString?
                                var ordinal = 0
                                if scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: &element),
                                   scanner.scanInt(&ordinal) {
                                    _ = "\(element!):\(ordinal)"
                                }
                                dictDat.setValue(url, forKey: "url")
                                dictDat.setValue("\(element!)", forKey: "name")
                                dictDat.setValue(ordinal, forKey: "number")
                                dictDat.setValue(imageData, forKey: "imageData")
                                saveImageDetailsInDB(entity: Entities.imageTblEntity, dict: dictDat)
                                if self.counter == result?.items.count {
                                    DispatchQueue.main.async {
                                        if UIDevice().userInterfaceIdiom == .phone {
                                            self.appHelpView.isHidden = true
                                        }
                                    }
                                }
                            }
                        }
                    })
                    
                }
            }
        }
    }
    
    func getFolderList(){
        var storageReference = ref.child("")
        storageReference = ref.child("Ios")
        storageReference.listAll { (result, error) in
            if let error = error {
                print(error)
            }
            let items = result?.items ?? []
            for item in items {
                //print(item)
                let storageLocation = String(describing: item)
                let gsReference = Storage.storage().reference(forURL: storageLocation)
                _ = NSMutableDictionary ()
                
                // Fepoch the download URL
                gsReference.downloadURL { url, error in
                  guard let url = url, error == nil else {
                    print (error)
                    return
                  }
                    let data = NSData(contentsOf: url)
                        let versionTxt = NSString(data: data! as Data, encoding:NSUTF8StringEncoding)! as String
                        if let valueText = UserDefaults.standard.value(forKey: keyValue.versionTxt.rawValue) as? String {
                            
                            if valueText != "" {
                                if versionTxt != valueText {
                                    UserDefaults.standard.set(versionTxt, forKey: keyValue.versionTxt.rawValue)
                                    deleteAllData(Entities.imageTblEntity)
                                    self.getDownloadURl()
                                } else {
                                    if let value = UserDefaults.standard.value(forKey: keyValue.languageChanged.rawValue) as? Bool {
                                        if value == true{
                                            deleteAllData(Entities.imageTblEntity)
                                            UserDefaults.standard.set(false, forKey: keyValue.languageChanged.rawValue)
                                            UserDefaults.standard.removeObject(forKey: keyValue.imageCount.rawValue)
                                            self.getDownloadURl()
                                            
                                        } else {
                                            self.getDownloadURl()
                                            
                                        }
                                    }
                                }
                            } else {
                                UserDefaults.standard.set(versionTxt, forKey: keyValue.versionTxt.rawValue)
                                
                            }
                        }
                        else {
                            UserDefaults.standard.set(versionTxt, forKey: keyValue.versionTxt.rawValue)
                            self.getDownloadURl()
                            
                        }
                        
                    }
                    
                }
            }
        }
    }


// MARK: - OFFLINE CUSTOM VIEW

extension DashboardVC : offlineCustomView1 {
    func crossBtn() {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
}

extension DashboardVC : syncApiOffline {
    func failWithErrorOffline(statusCode: Int) {
        self.view.isUserInteractionEnabled = true
        self.hideIndicator()
    }
    
    
    func failWithErrorInternalOffline() {
        hideIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
    func didFinishApiOffline(response: String) {
        print("Got Response")
        let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue {
            UserDefaults.standard.set(false, forKey: keyValue.syncOff.rawValue)
            deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.beefAnimalAddTblEntity, isSync: "false",ordestatus: "false", status: "true", orderId: orderId,userId: userId)
            for i in 0..<animaltbl.count{
                let animadata = animaltbl[i] as! BeefAnimaladdTbl
                updateOrderStatusISyncAnimal(entity: Entities.beefAnimalAddTblEntity, isSync: "false", status: "true", orderstatus: "false",orderId:orderId,userId:userId)
                updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, isSync: "false", status: "false", orderstatus: "false",orderId:orderId,userId:userId,animalId:Int(animadata.animalId))
                
                updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity, isSync: "false",animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId)
                updateOrderStatusISyncProduct(entity: Entities.subProductBeefTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId)
            }
            UserDefaults.standard.set(false, forKey: keyValue.autoIdBeef.rawValue)
            updateProductTablStatus(entity: Entities.getProductBeefTblEntity)
            updateProductTablStatus(entity: Entities.getAdonTblEntity)
            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.pdId.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.productName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.emailBeef.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.beefBreed.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefTSU.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreed.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTSU.rawValue)
            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
            deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
            deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
            deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
            deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
            self.view.isUserInteractionEnabled = true
            self.hideIndicator()
            
            let  orderIdDataOff  = fetchAllData(entityName: Entities.offlineOrderTblEntity)
            if orderIdDataOff.count > 0 {
                UserDefaults.standard.set(true, forKey: keyValue.syncOff.rawValue)
                UserDefaults.standard.set(marketNameType.Dairy.rawValue, forKey: keyValue.name.rawValue)
                if Connectivity.isConnectedToInternet() {
                    
                    let offSuync = UserDefaults.standard.bool(forKey: keyValue.syncOff.rawValue)
                    if offSuync == true {
                        self.view.isUserInteractionEnabled = false
                        
                        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
                            
                            if UserDefaults.standard.bool(forKey: keyValue.dairySubmitBtnFlag.rawValue) == true {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.submitOrder, comment: ""), and: "")
                                
                            } else {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.dataSyncProgress, comment: ""), and: "")
                                
                            }
                        } else {
                            if UserDefaults.standard.bool(forKey:  keyValue.emailBeef.rawValue) == true {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.submitOrder, comment: ""), and: "")
                                
                            } else {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.dataSyncProgress, comment: ""), and: "")
                            }}
                        self.objApiSyncOffline.saveAnimaldata()
                    }
                }
            }
            else{
                self.view.isUserInteractionEnabled = true
                self.hideIndicator()
                UserDefaults.standard.set(false, forKey: keyValue.syncOff.rawValue)
            }
        }
        else {
            deleteRecordFromDatabase(entityName: Entities.offlineOrderTblEntity)
            
            UserDefaults.standard.set(false, forKey: keyValue.syncOff.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            
            let animaltbl = fetchAllDataOrderStatusIsSyncOfflineAnimal(entityName: Entities.animalAddTblEntity, isSync: "false", orderId: orderId,userId: userId,status:"true")
            for i in 0..<animaltbl.count{
                let animadata = animaltbl[i] as! AnimaladdTbl
                updateOrderStatusISyncAnimalOffline(entity: Entities.animalAddTblEntity, isSync: "false", status: "true",orderId:orderId,userId:userId)
                updateOrderStatusISyncProductOFFline(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), status: "true",orderId: orderId,userId: userId)
                updateOrderStatusISyncProductOFFline(entity: Entities.subProductTblEntity, isSync: "false", animalTag:Int(animadata.animalId), status: "true",orderId: orderId,userId: userId)
            }
            
            UserDefaults.standard.set(false, forKey: keyValue.autoId.rawValue)
            updateProductTablStatus(entity: Entities.getProductTblEntity)
            updateProductTablStatus(entity: Entities.getAdonTblEntity)
            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.pdId.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.productName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
            self.view.isUserInteractionEnabled = true
            self.hideIndicator()
            
            let  orderIdDataOff  = fetchAllData(entityName: Entities.offlineOrderBeefTblEntity)
            if orderIdDataOff.count > 0 {
                UserDefaults.standard.set(true, forKey: keyValue.syncOff.rawValue)
                UserDefaults.standard.set(marketNameType.Beef.rawValue, forKey: keyValue.name.rawValue)
                if Connectivity.isConnectedToInternet() {
                    
                    let offSuync = UserDefaults.standard.bool(forKey: keyValue.syncOff.rawValue)
                    if offSuync == true {
                        self.view.isUserInteractionEnabled = false
                        
                        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
                            if UserDefaults.standard.bool(forKey: keyValue.dairySubmitBtnFlag.rawValue) == true {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.submitOrder, comment: ""), and: "")
                                
                            } else {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.dataSyncProgress, comment: ""), and: "")
                            }
                            
                        } else {
                            if UserDefaults.standard.bool(forKey:  keyValue.emailBeef.rawValue) == true {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.submitOrder, comment: ""), and: "")
                                
                            } else {
                                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.dataSyncProgress, comment: ""), and: "")
                            }}
                        self.objApiSyncOffline.saveAnimaldata()
                    }
                }
            }
            else{
                self.view.isUserInteractionEnabled = true
                self.hideIndicator()
                UserDefaults.standard.set(false, forKey: keyValue.syncOff.rawValue)
            }
        }
    }
    
    func failWithInternetConnectionOffline() {
        self.view.isUserInteractionEnabled = true
        self.hideIndicator()
    }
}

extension DashboardVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //  updateCustomerAction()
        if UserDefaults.standard.value(forKey: keyValue.oflinesave.rawValue) as? String == keyValue.checkOffline.rawValue
        {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.changeCustomerAlert, comment: ""))
        }
        else
        {
            checkworkitem = true
            checkpercentage = false
            UserDefaults.standard.setValue(0, forKey: keyValue.pageNumber.rawValue)
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            let  viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
            let beefDAta =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderIdBeef,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            if viewAnimalArray.count > 0 || beefDAta.count > 0 { //|| orderIdDataOff.count > 0 || orderIdDataOnn.count > 0{
                self.searchTextField.resignFirstResponder()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.completeClearOrder, comment: ""))
            }
            
            else
            {
                
                var storyBoard = UIStoryboard()
                storyBoard = UIStoryboard(name: "iPad", bundle: nil)
//                if let customerSelectionVC = storyBoard.instantiateViewController(withIdentifier: "OpenSheetViewController") as? OpenSheetViewController {
//                    customerSelectionVC.modalPresentationStyle = .overFullScreen
//                    customerSelectionVC.delegate = self
//                    if let sheet = customerSelectionVC.sheetPresentationController {
//                        customerSelectionVC.preferredContentSize = UIScreen.main.bounds.size
//                    }
//                    present(customerSelectionVC, animated: false, completion: nil)
//                }
                updateCustomerButton.setImage(UIImage(named: "searchIconiPad"), for: .normal)
                self.searchTextField.text = ""
              //  self.searchTextField.becomeFirstResponder()
                self.customerTblView.isHidden = false
                self.containerViewHeight.constant = 501.0
                self.customerTblBottomConstraint.constant = 50.0
                self.calendarViewBkg.isHidden = false
                self.tblViewSeperator.isHidden = false
                self.customerTblView.reloadData()
            }
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty
        {
            search = String(search.dropLast())
        }
        else
        {
            search=textField.text!+string
        }
        
        print(search)
        if search.count > 0 {
            filteredData  =  self.customerList.filter { ($0.customerName?.lowercased())!.contains( search.lowercased())}
         //   customerList = filteredData
        } else {
            filteredData = customerList
        }
        
//        let predicate=NSPredicate(format: "SELF.name CONTAINS[cd] %@", search)
//        let arr = (customerList as NSArray).filtered(using: predicate)
//        
//        if arr.count > 0
//        {
//            customerList.removeAll(keepingCapacity: true)
//            customerList = arr as! [GetCustomer]
//        }
//        else
//        {
//            customerList = arr as! [GetCustomer]
//        }
        customerTblView.reloadData()
        return true
    }
}
