//
//  OrderProductSelectionSecondVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 04/03/24.
//

import Foundation
import UIKit
import Alamofire

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension OrderProductSelectionSecondVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SIDE MENU UI EXTENSION
extension OrderProductSelectionSecondVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: GET, CREATE AND DELETE ANIMAL LIST
private typealias DeleteAnimalListHelper = OrderProductSelectionSecondVC
extension DeleteAnimalListHelper {
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custmerId , providerID: pvid)
        fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        
    }
    
    func deleteSigalAnimalFromList(animalTagStr:String) {
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ), providerId: pvid) as! [DataEntryAnimaladdTbl]
            if fetchAllDatalistAnimals.count > 0{
                let filterdatalistAnimal = fetchAllDatalistAnimals.filter{$0.animalTag == animalTagStr}
                if filterdatalistAnimal.count > 0 {
                    let animalVal = filterdatalistAnimal[0]
                    deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
                    if Connectivity.isConnectedToInternet() {
                        self.objApiSync.postListDataDelete(listId: fetchDataEntry[0].listId, custmerId: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                    }
                }
            }
        }
    }
    
    func createListNameAndCheckifExist(){
        if fetchDataEntry.count > 0 {
            self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(fetchDataEntry[0].listId), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
            deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(Int(fetchDataEntry[0].listId)), customerId: custmerId,userId:userId )
            deleteList(listName: listName, customerId: Int64(custmerId ),listID: Int(fetchDataEntry[0].listId))
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
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension OrderProductSelectionSecondVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tbblView {
            return 100
        }
        if indexPath.row == arr1.keys.count{
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
                return UITableView.automaticDimension
            }else{
                return UITableView.automaticDimension
            }
        }
        var addon = 0
        var data = [String:Any]()
        for value in selection{
            if (value[keyValue.animalId.rawValue] as! Int) == values[indexPath.row]{
                data = value
            }
        }
        if let item = data[keyValue.animalId.rawValue] as? Int{
            if values[indexPath.row] == item{
                let data = data["addon"] as? [SubProductTbl]
                if data!.count > 0 {
                    if data!.count % 2 == 0{
                        addon = Int(40 * CGFloat(data!.count/2 )  + CGFloat(data!.count*10))
                    }else{
                        addon = Int(40 * CGFloat(data!.count/2 + 1)  + CGFloat(data!.count*10))
                    }
                }
            }
        }
        var height:CGFloat
        let bCount = (arr1[values[indexPath.row]]!.count)
        if bCount % 2 == 0{
            height = 40 * CGFloat(bCount/2) + 50 + CGFloat((bCount/2)*20) + CGFloat(addon + 70)
        }
        else {
            height = 40 * CGFloat((bCount/2)+1) + 50 + CGFloat(((bCount/2)+1)*20) + CGFloat(addon + 70)
        }
        return height
    }
    
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
        return arr1.keys.count + 1
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
                        label.text = NSLocalizedString("\(sampTypeArr.count) Animal in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)", comment: "")
                    }
                    else {
                        label.text = NSLocalizedString("\(sampTypeArr.count) Animals in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)", comment: "")
                    }
                }
            }
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tbblView {
            if sampTypeArr.count == 0 {
                return ""
            } else {
                return NSLocalizedString("\(sampTypeArr.count) Animal in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)", comment: "")
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
            if indexPath.row == arr1.keys.count{
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.billingCellId, for: indexPath) as! BillingCell
                cell.billingContactLbl.text = NSLocalizedString(LocalizedStrings.billingContact, comment: "")
                cell.orderDefaultTtile.text = ButtonTitles.orderDefaultsText.localized
                cell.editBtnOutlet.setTitle(ButtonTitles.editText.localized, for: .normal)
                cell.reviewOrderBtnTtile.setTitle(NSLocalizedString(ButtonTitles.reviewOrderText, comment: ""), for: .normal)
                cell.evaluationTitle.text = NSLocalizedString(LocalizedStrings.providerMarkets, comment: "")
                cell.nominatorTitle.text = ButtonTitles.nominatorText.localized
                
                if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
                    cell.nominatorTitle.isHidden = true
                    cell.nominatorLbl.isHidden = true
                }else{
                    cell.nominatorTitle.isHidden = false
                    cell.nominatorLbl.isHidden = false
                }
                updateUIForButtonTitle()
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.opsTableViewCell, for: indexPath) as! OPSTableViewCell
            cell.OfficialId.text =  String(animaltag[indexPath.row])
            cell.OnFarmId.text =  String(farmID[indexPath.row])
            cell.Barcode.text = String(barCode[indexPath.row])
            cell.vollView.tag = indexPath.row
            cell.deleteBttn.tag = indexPath.row
            cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
            cell.onFarmIDTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodeTitleleft.text  = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
            
            if pviduser == 4 {
                cell.OfficialId.text =  String(barCode[indexPath.row])
                cell.OnFarmId.text = String(eartag[indexPath.row])
                cell.barcodeTitleleft.isHidden = true
                cell.Barcode.isHidden = true
                cell.thirdColonLbl.isHidden = true
                cell.onFarmIDTitle.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                cell.officalIdTitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            }
            else {
                cell.barcodeTitleleft.isHidden = false
                cell.Barcode.isHidden = false
                cell.thirdColonLbl.isHidden = false
            }
            cell.vollView.reloadData()
            return cell
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
    }
}

//MARK: COLLECTIONVIEW DATASOURCE AND DELEGATE
extension OrderProductSelectionSecondVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            var data = [String:Any]()
            for value in selection{
                if (value[keyValue.animalId.rawValue] as? Int) == values[collectionView.tag]{
                    data = value
                }
            }
            if let item  = data[keyValue.animalId.rawValue] as? Int{
                if values[collectionView.tag] == item{
                    return (data["addon"] as! NSArray).count == 0 ? 0 :  (data["addon"] as! NSArray).count + 2
                }else{
                    return 0
                }
            }
            else{
                return 0
            }
        }else{
            return arr1[values[collectionView.tag]]!.count
        }
    }
    
    func collectionView4545555(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            var data = [String:Any]()
            for value in selection{
                if values.contains(value[keyValue.animalId.rawValue] as! Int){
                    data = value
                    break
                }
            }
            if let item  = data[keyValue.animalId.rawValue] as? Int{
                if values.contains(item){
                    return (data["addon"] as! NSArray).count == 0 ? 0 :  (data["addon"] as! NSArray).count + 2
                }else{
                    return 0
                }
            }
            else{
                return 0
            }
        }else{
            return arr1[values[collectionView.tag]]!.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.orderProductSelectionCollectionCell, for: indexPath)  as! OrdingProductSelectionCollectionViewCell
            item.layer.masksToBounds = true
            item.layoutIfNeeded()
            item.Lbl.layoutIfNeeded()
            item.Lbl.layer.masksToBounds = true
            item.Lbl.text = arr1[values[collectionView.tag]]![indexPath.row].productName!
            item.infoBtnOutlet.isHidden = true
            var data = GetProductTbl()
            var breedId =  ""
            let animalData = fetchAnimaldataBarcodeanimalId(entityName: Entities.animalAddTblEntity, animalbarCodeTag: arr1[values[collectionView.tag]]![indexPath.row].animalbarCodeTag ?? "",  animalId: Int(arr1[values[collectionView.tag]]![indexPath.row].animalId), orderStatus: "false", custId: custmerId) as! [AnimaladdTbl]
            if animalData.count > 0 {
                breedId = animalData[0].breedId ?? ""
            }
            let productArr = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId)
            if productArr.count > 0 {
                data = productArr[indexPath.item] as! GetProductTbl
            }
            
            item.Lbl.layer.borderColor = UIColor.lightGray.cgColor
            
            if UserDefaults.standard.bool(forKey: keyValue.bvdvSelected.rawValue){
                let data12333 =  fetchProductAdonDataBVDV(entityName: Entities.subProductTblEntity, adonId:LocalizedStrings.bvdvAddOnId,ordrId:orderId, productId: Int(arr1[values[collectionView.tag]]![indexPath.row].productId))
                
                if data12333.count == 0{
                    updateProductTablaid(entity: Entities.productAdonAnimalTblEntity, productId: Int(arr1[values[collectionView.tag]]![indexPath.row].productId), status: "false")
                }
            }
            if arr1[values[collectionView.tag]]![indexPath.row].status! == "true"{
                collViewOfselection.append(collectionView)
                item.Lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                item.Lbl.textColor = UIColor.white
            } else {
                
                item.Lbl.backgroundColor = UIColor.white
                item.Lbl.textColor = UIColor.black
            }
       
            if data.productDescription != "" {
                item.infoBtnOutlet.isHidden = false
            } else {
                item.infoBtnOutlet.isHidden = true
            }
            
            
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
            if indexPath.row == 0 {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.addOnWithTitle, for: indexPath)
                item.isUserInteractionEnabled = false
                return item
            } else if indexPath.row == 1 {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOn", for: indexPath)
                item.isUserInteractionEnabled = false
                return item
            } else {
                
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.opsCollectionViewCell, for: indexPath)  as! OPSCollectionViewCell
                item.layer.masksToBounds = true
                item.layoutIfNeeded()
                item.lbl.layoutIfNeeded()
                item.lbl.layer.masksToBounds = true
                item.infoBtnOutlet.isHidden = true
                var data = [String:Any]()
                for value in selection{
                    if (value[keyValue.animalId.rawValue] as? Int) == values[collectionView.tag]{
                        data = value
                    }
                    
                }
                item.lbl.layer.borderColor = UIColor.lightGray.cgColor
                
                if ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonName == LocalizedStrings.bvdvAddOnId  {
                    if UserDefaults.standard.bool(forKey: keyValue.bvdvSelected.rawValue) {
                        item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                        item.lbl.textColor = UIColor.white
                        
                        updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "true", animaltag: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).animalId), orderId: orderId, userId: userId)
                        updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "true",productId:Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).productId))
                    }
                    else {
                        item.lbl.backgroundColor = UIColor.white
                        item.lbl.textColor = UIColor.black
                        updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "false", animaltag: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).animalId), orderId: orderId, userId: userId)
                        updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "false",productId:Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).productId))
                    }
                } else {
                    if ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).status! == "true" {
                        item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                        item.lbl.textColor = UIColor.white
                    }
                    else{
                        item.lbl.backgroundColor = UIColor.white
                        item.lbl.textColor = UIColor.black
                    }
                }
                if langId == 1 {
                    let englishText = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).textValueEnglish!
                    if englishText == "" {
                        item.infoBtnOutlet.isHidden = true
                    } else {
                        item.infoBtnOutlet.isHidden = false
                    }
                    
                }
                else if langId == 2 {
                    let textValuePortugese = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).textValuePortugese!
                    if textValuePortugese == "" {
                        item.infoBtnOutlet.isHidden = true
                    } else {
                        item.infoBtnOutlet.isHidden = false
                    }
                }
                item.infoBtnOutlet.tag = indexPath.item
                item.infoBtnOutlet.addTarget(self, action: #selector(openPopUp(_:)), for:.touchUpInside)
                item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonName!
                return item
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2 ) - 10, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        if identyCheck == false || identyCheck == nil {
            let Data = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity, ordestatus: "false",orderId:self.orderId,userId:self.userId)
            if Data.count > 0 {
                UserDefaults.standard.set("off", forKey: keyValue.onKey.rawValue)
            }
        }
        else {
            let Data = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity, ordestatus: "false",orderId:self.orderId,userId:self.userId)
            if Data.count > 0 {
                UserDefaults.standard.set("off", forKey: keyValue.onKey.rawValue)
            }
        }
        
        if indexPath.section == 0 {
            pid =  Int(arr1[values[collectionView.tag]]![indexPath.row].productId)
            let PName =  arr1[values[collectionView.tag]]![indexPath.row].productName
            aTag = Int(arr1[values[collectionView.tag]]![indexPath.row].animalId)
            let productname = arr1[values[collectionView.tag]]![indexPath.row].animalTag
            
            let fethData1 =  fetchAllDataFarmIdStatusCheckdataDairy(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag, pId: pid)
            if fethData1.count > 0 {
                self.hideIndicator()
                return
            }
            
            UserDefaults.standard.set(aTag, forKey: "aTag")
            UserDefaults.standard.set(pid, forKey: keyValue.pdId.rawValue)
            UserDefaults.standard.set(productname, forKey: "aId")
            let fethData =  fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId)
            if fethData.count == 0{
                UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
            }
            let data12333 =  fetchProductAdonDataBVDV(entityName: Entities.subProductTblEntity, adonId:LocalizedStrings.bvdvAddOnId,ordrId:orderId, productId: pid)
            let BVDVfound = UserDefaults.standard.bool(forKey: keyValue.bvdvSelected.rawValue)
            
            if data12333.count == 0 && BVDVfound  {
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: AlertMessagesStrings.bvdvAlreadyAppliedToOrder.localized, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    print(LocalizedStrings.cancelPressed)
                }
                let okAction = UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    
                    if productname == "" {
                        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                        if providerName == keyValue.auDairyProducts.rawValue {
                            if PName == LocalizedStrings.providerClarifidePlusUpgrade  || PName == LocalizedStrings.providerClarifideDataGeneUpgrade ||  PName == LocalizedStrings.providerClarifideCDCBUpgrade {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideCDCB, comment: ""))
                                self.hideIndicator()
                            }
                        }
                        else if providerName == keyValue.clarifideAHDBUK.rawValue{
                            if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideCDCBUpgrade || PName == LocalizedStrings.providerClarifideAHDBUpgrade{
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideAHDB, comment: ""))
                                self.hideIndicator()
                            }
                        }
                        else {
                            if  PName == LocalizedStrings.providerClarifidePlusUpgrade {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifide, comment: ""))
                                self.hideIndicator()
                            }
                        }
                    }
                    else {
                        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                        if providerName == keyValue.auDairyProducts.rawValue {
                            if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideDataGeneUpgrade ||  PName == LocalizedStrings.providerClarifideCDCBUpgrade {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideCDCB, comment: ""))
                                self.hideIndicator()
                                
                            }
                        }
                        else if providerName == keyValue.clarifideAHDBUK.rawValue{
                            if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideCDCBUpgrade || PName == LocalizedStrings.providerClarifideAHDBUpgrade{
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideAHDB, comment: ""))
                                self.hideIndicator()
                                
                            }
                        }
                        else {
                            if  PName == LocalizedStrings.providerClarifidePlusUpgrade {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifide, comment: ""))
                                self.hideIndicator()
                                
                            }
                        }
                    }
                    updateAdoonTablBVDV(entity: Entities.subProductTblEntity, AdonId:LocalizedStrings.bvdvAddOnId, status: "false", orderId: orderId)
                    updateAdoonTablBVDVMaster(entity:Entities.getAdonTblEntity,AdonId:LocalizedStrings.bvdvAddOnId,status: "false")
                    let data = fetchSubProductDataDairy(productId: Int(self.pid),animalTag: self.aTag!, orderId: orderId,userId:userId) as? [SubProductTbl]
                    
                    var found = false
                    if data!.count > 0 && !BVDVfound{
                        for i in 0..<self.selection.count{
                            if let value = self.selection[i][keyValue.animalId.rawValue] as? Int, value  == self.aTag{
                                self.selection[i][keyValue.animalId.rawValue] = self.aTag
                                self.selection[i]["addon"] = data
                                self.selection[i]["row"] = collectionView.tag
                                found = true
                                break
                            }
                        }
                        if found ==  false{
                            self.selection.append ([keyValue.animalId.rawValue:self.aTag as Any,"addon":data as Any,"row":collectionView.tag])
                        }
                    }
                    else{
                        for i in 0..<self.selection.count{
                            if let value = self.selection[i][keyValue.animalId.rawValue] as? Int, value  == self.aTag{
                                self.selection.remove(at: i)
                                break
                            }
                        }
                    }
                    updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                    updateAnimalTblDataDairy(entity: Entities.productAdonAnimalTblEntity, status: "false", animalTag: self.aTag, orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                        
                        if success {
                            updateProducDataDairy(entity: Entities.productAdonAnimalTblEntity, productID: Int(self.pid), status: "false", animalTag: self.aTag!,orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                                if success {
                                    updateAnimalTblDataDairy(entity: Entities.animalAddTblEntity, status:"false", animalTag: self.aTag, orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                                        if success {
                                            updateProductTablaid(entity:Entities.getProductTblEntity,productId: Int(self.pid),status: "false")
                                        }
                                    })
                                }
                            })
                        }
                    })
                    
                    self.arr1.removeAll()
                    if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
                        self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                        self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                        if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                            
                        } else {
                            self.fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                        }
                    }
                    if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
                        self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
                        self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                        if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            
                            self.fethData =  fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                            
                        }else {
                            self.fethData =  fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                            
                        }
                    }
                    if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
                        self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
                        self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                        if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            self.fethData =  fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                            
                        }else {
                            self.fethData =  fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                            
                        }
                    }
                    self.fetchProductAdonAnimalTblForCollectionView(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    updateAnimalTblDataDairy(entity: Entities.subProductTblEntity, status: "false", animalTag: self.aTag,orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                        
                        if success {
                            if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                self.fethData = fetchAllDataOrderStatusIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
                            }
                            else {
                                self.fethData = fetchAllDataOrderStatus(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
                                
                            }
                            let dataval =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: self.serchTextField.text!)
                            self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if dataval.count > 0 {
                                        for i in 0..<self.indexOfSelection.count{
                                            if let index = self.indexOfSelection[i], let collView = self.collViewOfselection[i]{
                                                self.fetchAdonData(indexPath: index, collectionView: collView)
                                            }
                                        }
                                    }
                                }
                            })
                            self.perform(#selector(self.reloadTable), with: nil, afterDelay: 0.1)
                            collectionView.reloadData()
                        }
                    })
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            else {
                nonBVDVBaseProductFound = false
                if productname == "" {
                    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                    if providerName == keyValue.auDairyProducts.rawValue {
                        if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideDataGeneUpgrade ||  PName == LocalizedStrings.providerClarifideCDCBUpgrade {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideCDCB, comment: ""))
                            self.hideIndicator()
                        }
                    }
                    
                    else if providerName == keyValue.clarifideAHDBUK.rawValue{
                        if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideCDCBUpgrade || PName == LocalizedStrings.providerClarifideAHDBUpgrade{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideAHDB, comment: ""))
                            self.hideIndicator()
                        }
                    }
                    
                    else {
                        if  PName == LocalizedStrings.providerClarifidePlusUpgrade {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifide, comment: ""))
                            self.hideIndicator()
                        }
                    }
                }
                
                else {
                    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                    if providerName == keyValue.auDairyProducts.rawValue {
                        
                        if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideDataGeneUpgrade ||  PName == LocalizedStrings.providerClarifideCDCBUpgrade {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideCDCB, comment: ""))
                            self.hideIndicator()
                        }
                    }
                    
                    else if providerName == keyValue.clarifideAHDBUK.rawValue{
                        if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideCDCBUpgrade || PName == LocalizedStrings.providerClarifideAHDBUpgrade{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideAHDB, comment: ""))
                            self.hideIndicator()
                        }
                    }
                    else {
                        if PName == LocalizedStrings.providerClarifidePlusUpgrade {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifide, comment: ""))
                            self.hideIndicator()
                        }
                    }
                }
                
                let data = fetchSubProductDataDairy(productId: Int(self.pid),animalTag: self.self.aTag!, orderId: orderId,userId:userId) as? [SubProductTbl]
                
                var found = false
                if data!.count > 0{
                    for i in 0..<self.selection.count{
                        if let value = self.selection[i][keyValue.animalId.rawValue] as? Int, value  == self.aTag{
                            self.selection[i][keyValue.animalId.rawValue] = self.aTag
                            self.selection[i]["addon"] = data
                            self.selection[i]["row"] = collectionView.tag
                            found = true
                            break
                        }
                    }
                    if found ==  false{
                        self.selection.append ([keyValue.animalId.rawValue:self.aTag as Any,"addon":data as Any,"row":collectionView.tag])
                        
                    }
                }else{
                    for i in 0..<self.selection.count{
                        if let value = self.selection[i][keyValue.animalId.rawValue] as? Int, value  == self.aTag{
                            self.selection.remove(at: i)
                            break
                        }
                    }
                }
                
                updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                updateAnimalTblDataDairy(entity: Entities.productAdonAnimalTblEntity, status: "false", animalTag: self.aTag, orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                    
                    if success {
                        updateProducDataDairy(entity: Entities.productAdonAnimalTblEntity, productID: Int(self.pid), status: "true", animalTag: self.aTag!,orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                            if success {
                                updateAnimalTblDataDairy(entity: Entities.animalAddTblEntity, status:"true", animalTag: self.aTag, orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                                    
                                    if success {
                                        updateProductTablaid(entity:Entities.getProductTblEntity,productId: Int(self.pid),status: "true")
                                    }
                                })
                            }
                        })
                    }
                })
                
                self.arr1.removeAll()
                if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
                    self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                    self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                    if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                        self.fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                    }
                    else {
                        self.fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                    }
                }
                if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
                    self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
                    self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                    if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                        self.fethData =  fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                    }
                    else{
                        self.fethData =  fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                    }
                }
                if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
                    self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
                    self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                    if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                        self.fethData =  fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    }
                    else {
                        self.fethData =  fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    }
                }
                self.fetchProductAdonAnimalTblForCollectionView(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
                updateAnimalTblDataDairy(entity: Entities.subProductTblEntity, status: "false", animalTag: self.aTag,orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                    
                    if success {
                        if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            self.fethData = fetchAllDataOrderStatusIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
                        }
                        else {
                            self.fethData = fetchAllDataOrderStatus(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
                        }
                        let dataval =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if dataval.count > 0 {
                                    for i in 0..<self.indexOfSelection.count{
                                        if let index = self.indexOfSelection[i], let collView = self.collViewOfselection[i]{
                                            self.fetchAdonData(indexPath: index, collectionView: collView)
                                        }
                                    }
                                }
                            }
                        })
                        perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
                        collectionView.reloadData()
                    }
                })
            }
        } else {
            let sampleTypeFound = checkedSampletype(indexPath: indexPath, userId: userId, orderId: orderId, collectionViewTag: collectionView.tag)
            if !sampleTypeFound {
                isSelectedBaseProductCompatiablewithBVDV(indexPath: indexPath, userId: userId, orderId: orderId, collectionViewTag: collectionView.tag, collectionView)
            }
        }
    }
}
