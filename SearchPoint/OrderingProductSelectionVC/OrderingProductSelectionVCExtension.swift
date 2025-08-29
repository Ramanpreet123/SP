//
//  OrderingProductSelectionVCEXTENSION.swift
//  SearchPoint
//
//  Created by Mobile Programming on 04/03/24.
//

import Foundation
import UIKit
import Alamofire

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension OrderingProductSelectionVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SIDE MENU UI EXTENSION
extension OrderingProductSelectionVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: COLLECTION VIEW DATASOURCE AND DELEGATES
extension OrderingProductSelectionVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView.tag == 1{
            return arr.count
            
        }
        else {
            return productArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2) - 15, height: self.view.frame.height / 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.orderProductSelectionCollectionCell, for: indexPath) as! OrdingProductSelectionCollectionViewCell
            item.layer.masksToBounds = true
            item.Lbl.layer.cornerRadius =  item.Lbl.frame.size.height/2
            item.Lbl.layoutIfNeeded()
            item.Lbl.layer.masksToBounds = true
            let data = arr[indexPath.item] as! GetProductTbl
            
            if data.productDescription != "" {
                item.infoBtnOutlet.isHidden = false
            }
            else {
                item.infoBtnOutlet.isHidden = true
            }
            
            if data.status == "true"{
                item.Lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                item.Lbl.textColor = UIColor.white
            }
            else {
                item.Lbl.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
                item.Lbl.textColor = UIColor.black
            }
            
            item.Lbl.text = data.productName
         
            item.completionHandler = { [weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.clarifideTransparentView.isHidden = false
                weakSelf.clariifdeView.isHidden = false
                weakSelf.clarifideTransparentView.frame = weakSelf.view.frame
                self?.lable2TopConstraint.constant = 8
                
                if data.addOnStatus{
                    let helloAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)]
                    let worldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .regular)]
                    
                    let helloString = NSAttributedString(string: " \(data.addOnNames ?? "")", attributes: helloAttributes)
                    let worldString = NSMutableAttributedString(string: LocalizedStrings.followingProdBundled.localized, attributes: worldAttributes)
                    worldString.append(helloString)
                    self!.clarifideLbl1.attributedText = worldString
                    weakSelf.clarifideLbl3.isHidden = true
                    weakSelf.clarifideLbl2.isHidden = true
                }
                
                if data.providerId ==  2{
                    if data.productName == LocalizedStrings.providerClarifidePlusUpgrade {
                        self!.clarifideLbl1.text = NSLocalizedString(LocalizedStrings.cdcbSupportedBreeds, comment: "")
                        self!.clarifideLbl2.text = NSLocalizedString(LocalizedStrings.zoetisSupportedBreedsWithoutSpace, comment: "")
                        weakSelf.clarifideLbl3.isHidden = true
                        if data.addOnStatus{
                            let helloAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)]
                            let worldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .regular)]
                            let helloString = NSAttributedString(string: " \(data.addOnNames ?? "")", attributes: helloAttributes)
                            let worldString = NSMutableAttributedString(string: LocalizedStrings.followingProdBundled.localized, attributes: worldAttributes)
                            worldString.append(helloString)
                            self!.clarifideLbl3.attributedText = worldString
                            weakSelf.clarifideLbl1.isHidden = false
                            weakSelf.clarifideLbl2.isHidden = false
                            weakSelf.clarifideLbl3.isHidden = false
                        }
                        
                    }
                    else {
                        self!.clarifideLbl1.text = NSLocalizedString(LocalizedStrings.ahdbSupportedBreeds, comment: "")
                        let worldAttributes1: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .regular)]
                        
                        let worldString1 = NSMutableAttributedString(string: LocalizedStrings.cdcbSupportedBreeds.localized, attributes: worldAttributes1)
                        self!.clarifideLbl2.attributedText = worldString1
                        
                        if data.addOnStatus{
                            let helloAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)]
                            let worldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .regular)]
                            let helloString = NSAttributedString(string: " \(data.addOnNames ?? "")", attributes: helloAttributes)
                            let worldString = NSMutableAttributedString(string: LocalizedStrings.followingProdBundled.localized, attributes: worldAttributes)
                            worldString.append(helloString)
                            self!.clarifideLbl3.attributedText = worldString
                        }
                        weakSelf.clarifideLbl1.isHidden = false
                        weakSelf.clarifideLbl2.isHidden = false
                        weakSelf.clarifideLbl3.isHidden = false
                    }
                }
            }
            return item
        }
        else {
            let item = collView2.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.orderProdCellId, for: indexPath) as! OrderProductCell
            item.layer.masksToBounds = true
            item.Lbl.layer.cornerRadius = 27
            item.Lbl.layoutIfNeeded()
            item.Lbl.layer.masksToBounds = true
            if productArr.count>0{
                let data = productArr[indexPath.item] as! GetAdonTbl
                if data.status == "true"{
                    item.Lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                    item.Lbl.textColor = UIColor.white
                }
                else {
                    item.Lbl.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
                    item.Lbl.textColor = UIColor.black
                }
                
                if langId == 1 {
                    if data.textValueEnglish == "" {
                        item.infoBtnOutlet.isHidden = true
                    } else {
                        item.infoBtnOutlet.isHidden = false
                    }
                    
                } else if langId == 2 {
                    if data.textValuePortugese == "" {
                        item.infoBtnOutlet.isHidden = true
                    } else {
                        item.infoBtnOutlet.isHidden = false
                    }
                    
                }
                else if langId == 3 {
                    if data.textValueItalian == "" {
                        item.infoBtnOutlet.isHidden = true
                    } else {
                        item.infoBtnOutlet.isHidden = false
                    }
                }
                item.Lbl.text = data.adonName
                item.infoBtnOutlet.tag = indexPath.item
                item.infoBtnOutlet.addTarget(self, action: #selector(openPopUp(_:)), for: .touchUpInside)
            }
            return item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        if collectionView.tag == 1{
            reloadAddOns(collectionView: collectionView, indexPath: indexPath)
        }
        else {
            let prod = productArr[indexPath.item] as! GetAdonTbl
            let item = collectionView.cellForItem(at: indexPath) as! OrderProductCell
            item.Lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
            item.Lbl.textColor = UIColor.white
            let producrId = prod.productId
            let adonId = prod.adonName
            if adonId == LocalizedStrings.bvdvAddOnId{
                sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: Entities.animalAddTblEntity, sampleType1: ButtonTitles.caisleyTSUText, sampleType2: ButtonTitles.allflexTSUText,sampleType3: ButtonTitles.allflexTSTText,orderId: orderId, pvid: self.pvid).mutableCopy() as! NSMutableArray
                
                if sampTypeArr.count > 0 {
                    self.transparentView.isHidden = false
                    parentView.isHidden = false
                    crossBtnOutlet.isHidden = false
                    tbblView.reloadData()
                }
                else {
                    UserDefaults.standard.set(producrId, forKey: keyValue.bvdvValidation.rawValue)
                    for i in 0 ..< data1.count {
                        let animaldata = data1[i] as! AnimaladdTbl
                        let data =   fetchSubProductDataStatusUpdateDairy(productId:Int(prod.adonId), animalTag: Int(animaldata.animalId), status: "true",orderId: orderId ,userId: userId)
                        if data.count > 0{
                            UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
                            updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(prod.adonId), status: "false", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                            updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(prod.adonId), status: "false",productId: Int(prod.productId))
                            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                productArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(prod.productId),isCdcbProduct:false)
                            } else {
                                productArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(prod.productId))
                            }
                        }
                        else{
                            UserDefaults.standard.set(true, forKey: keyValue.bvdvSelected.rawValue)
                            updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(prod.adonId), status: "true", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                            updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(prod.adonId), status: "true",productId: Int(prod.productId))
                            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                
                                productArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(prod.productId),isCdcbProduct:false)
                                
                            } else {
                                productArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(prod.productId))
                            }
                        }
                    }
                    collView2.reloadData()
                }
            }
            else {
                for i in 0 ..< data1.count{
                    let animaldata = data1[i] as! AnimaladdTbl
                    let data =   fetchSubProductDataStatusUpdateDairy(productId:Int(prod.adonId), animalTag: Int(animaldata.animalId), status: "true",orderId: orderId ,userId: userId)
                    
                    if data.count > 0{
                        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                        if providerName == keyValue.auDairyProducts.rawValue{
                            
                            if adonId == LocalizedStrings.clarifideCDCB || adonId == LocalizedStrings.clarifidePlusCDCBAddOnId{
                                let clarifide =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifideCDCB, animalId: Int(animaldata.animalId), status: "false" ,orderId :orderId, userId: userId)
                                
                                let clarifidPlus =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifidePlusCDCBAddOnId, animalId: Int(animaldata.animalId), status: "false" ,orderId :orderId, userId: userId)
                                if clarifidPlus.count > 0 {
                                    updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifideCDCB, status: "false", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                                    updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifideCDCB, status: "false",productId: Int(prod.productId))
                                }
                                
                                if clarifide.count > 0 {
                                    updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                                    updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false",productId: Int(prod.productId))
                                }
                            }
                        }
                        
                        updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(prod.adonId), status: "false", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                        updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(prod.adonId), status: "false",productId: Int(prod.productId))
                        
                        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            productArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(prod.productId),isCdcbProduct:false)
                        } else {
                            productArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(prod.productId))
                        }
                    }
                    else{
                        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                        if providerName == keyValue.auDairyProducts.rawValue{
                            if adonId == LocalizedStrings.clarifideCDCB || adonId == LocalizedStrings.clarifidePlusCDCBAddOnId{
                                let clarifide =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifideCDCB, animalId: Int(animaldata.animalId), status: "false" ,orderId :orderId, userId: userId)
                                
                                let clarifidPlus =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifidePlusCDCBAddOnId, animalId: Int(animaldata.animalId), status: "false" ,orderId :orderId, userId: userId)
                                if clarifidPlus.count > 0 {
                                    updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifideCDCB, status: "false", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                                    updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifideCDCB, status: "false",productId: Int(prod.productId))
                                }
                                
                                if clarifide.count > 0 {
                                    updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                                    updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false",productId: Int(prod.productId))
                                }
                            }
                        }
                        updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(prod.adonId), status: "true", animaltag: Int(animaldata.animalId) ,orderId :orderId, userId: userId)
                        updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(prod.adonId), status: "true",productId: Int(prod.productId))
                        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            productArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(prod.productId),isCdcbProduct:false)
                        }
                        else {
                            productArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(prod.productId))
                        }
                    }
                }
            }
            collView2.reloadData()
        }
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension OrderingProductSelectionVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbblView {
            if section == 0 {
                if sampTypeArr.count == 0 {
                    return 0
                }
                else {
                    return sampTypeArr.count
                }
            }
        }
        return farmAddr.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        if tableView == tbblView {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if tableView == tbblView {
            return 100
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tbblView {
            if section == 0 {
                if sampTypeArr.count == 0{
                    return 0
                }
            }
            return 100.0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
        var label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label = UILabel(frame: CGRect(x: 10, y: 1, width: 320, height: 100))
        label.numberOfLines = 3
        headerView.addSubview(label)
        
        if tableView == tbblView {
            
            if section == 0 {
                if sampTypeArr.count == 0 {
                    label.numberOfLines = 0
                    self.tbblView.estimatedRowHeight = 0
                    self.tbblView.rowHeight = UITableView.automaticDimension
                    tbblView.sectionHeaderHeight = UITableView.automaticDimension
                    tbblView.estimatedSectionHeaderHeight = 0
                }
                else {
                    if sampTypeArr.count == 1 {
                        label.text = NSLocalizedString(LocalizedStrings.sampleTypeDifferences.localized(with: sampTypeArr.count), comment: "")
                    }
                    else  {
                        label.text = NSLocalizedString(LocalizedStrings.sampleTypeDifferences.localized(with: sampTypeArr.count), comment: "")
                    }
                }
            }
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tbblView {
            if section == 0 {
                if sampTypeArr.count == 0 {
                    return ""
                } else {
                    if sampTypeArr.count == 1 {
                        return NSLocalizedString(LocalizedStrings.sampleTypeDifferences.localized(with: sampTypeArr.count), comment: "")
                    }
                    else {
                        return NSLocalizedString(LocalizedStrings.sampleTypeDifferences.localized(with: sampTypeArr.count), comment: "")
                    }
                }
            }
        }
        else if section == 1 {
            if bothCom.count == 0 {
                return ""
            } else {
                if bothCom.count == 1 {
                    return NSLocalizedString(ButtonTitles.differentSampleTypeAndAge.localized(with: bothCom.count), comment: "")
                    
                } else {
                    return NSLocalizedString(ButtonTitles.differentSampleTypeAndAge.localized(with: bothCom.count), comment: "")
                }
            }
        }
        else {
            if ageCom.count == 0 {
                return ""
            } else {
                if ageCom.count == 1 {
                    return NSLocalizedString(ButtonTitles.ageLess35Days.localized(with: ageCom.count), comment: "")
                } else  {
                    return NSLocalizedString(ButtonTitles.ageLess35Days.localized(with: ageCom.count), comment: "")
                }
            }
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tbblView {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbblView {
            let cell1: ListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.listingTblViewCellId) as! ListingTableViewCell
            let datavale  = sampTypeArr[indexPath.row] as! AnimaladdTbl
            cell1.firstAnimalTag?.text = datavale.farmId
            cell1.firstBarcode?.text = datavale.animalTag
            cell1.onFarmIdLbl?.text = datavale.animalbarCodeTag
            cell1.onFarmTitleLbl.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell1.officalIdTitleLbl.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell1.barcodeTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            return cell1
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.billingTableViewCell, for: indexPath) as? BillingTableViewCell
            cell?.selectionStyle = .none
            let filterArr = farmAddr.filter({$0.isDefault })
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tbblView {
            let animalVal  =  sampTypeArr[indexPath.row] as! AnimaladdTbl
            self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
            UserDefaults.standard.set(Int(animalVal.animalId), forKey: keyValue.animalIdSelectionCart.rawValue)
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC) as! OrderingAnimalVC
            navigationController?.pushViewController(vc,animated: false)
        }
        else {
            let filterArr = farmAddr.filter({$0.isDefault })
            if filterArr.count > 0{
                updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
                
            }
            
            UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: keyValue.farmValue.rawValue)
            UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: keyValue.billToCustomerId.rawValue)
            updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: self.custmerId) as! [GetBillingContact]
            let attributeString = NSMutableAttributedString(string: farmAddr[indexPath.row].contactName ?? "", attributes: self.attrs)
            billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            transparentView.isHidden = true
            billingView.isHidden = true
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete".localized
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        if tableView == tbblView {
            let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalFromOrder, comment: ""), preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
                
                if editingStyle == .delete {
                    if indexPath.section == 0 {
                        let animalVal  =  self.sampTypeArr[indexPath.row] as! AnimaladdTbl
                        deleteDataWithProduct(Int(animalVal.animalId))
                        deleteDataWithSubProduct(Int(animalVal.animalId))
                        deleteDataWithAnimal(Int(animalVal.animalId))
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                        self.notificationLblCount.text = String(animalCount.count)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.removedAnimalSuccessfully, comment: ""), duration: 1, position: .bottom)
                    }
                    
                    self.sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: Entities.animalAddTblEntity, sampleType1: ButtonTitles.caisleyTSUText, sampleType2: ButtonTitles.allflexTSUText,sampleType3: ButtonTitles.allflexTSTText,orderId: orderId,pvid: self.pvid).mutableCopy() as! NSMutableArray
                    if self.sampTypeArr.count == 0{
                        self.parentView.isHidden = true
                        self.transparentView.isHidden = true
                        self.crossBtnOutlet.isHidden = true
                    }
                    
                    self.tbblView.reloadData()
                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                    if animalCount.count == 0 {
                        UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    }
                }
            }))
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                print(LocalizedStrings.cancelPressed)
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
}

//MARK: OFFLINE CUSTOM VIEW UI EXTENSION
extension OrderingProductSelectionVC : offlineCustomView1 {
    func crossBtn() {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
}
