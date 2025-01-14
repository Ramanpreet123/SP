////
////  OrderProductSelectionReviewVCExtension.swift
////  SearchPoint
////
////  Created by Mobile Programming on 02/03/24.
////
//
//import Foundation
//import UIKit
//
////MARK: OFFLINE CUSTOM VIEW EXTENSION
//extension OrderProductSelectionReviewVC:offlineCustomView{
//    func crossBtnCall() {
//        buttonbg.removeFromSuperview()
//        customPopView.removeFromSuperview()
//    }
//}
//
////MARK: SIDE MENU UI EXTENSION
//extension OrderProductSelectionReviewVC : SideMenuUI{
//    func changeCornerRadius(val: Int) {
//        self.view.makeCorner(withRadius: CGFloat(val))
//    }
//}
//
////MARK: COLLECTIONVIEW DATASOURCE AND DELEGATE
//extension OrderProductSelectionReviewVC : UICollectionViewDataSource, UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 1{
//            var data = [String:Any]()
//            for value in selection{
//                if (value[keyValue.animalId.rawValue] as? Int) == values[collectionView.tag]{
//                    data = value
//                }
//            }
//            if let item  = data[keyValue.animalId.rawValue] as? Int{
//                if values[collectionView.tag] == item{
//                    return (data["addon"] as! NSArray).count + 2
//                }else{
//                    return 0
//                }
//            }
//            else{
//                return 0
//            }
//        }else{
//            return arr1[values[section]]!.count
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0{
//            let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.opsCollectionViewCell, for: indexPath)  as! OPSCollectionViewCell
//            item.layer.masksToBounds = true
//            item.layoutIfNeeded()
//            item.lbl.layoutIfNeeded()
//            item.lbl.layer.masksToBounds = true
//            item.lbl.text = arr1[values[collectionView.tag]]![indexPath.row].productName!
//            item.lbl.layer.borderColor = UIColor.lightGray.cgColor
//            if arr1[values[collectionView.tag]]![indexPath.row].status! == "true"{
//                collViewOfselection.append(collectionView)
//                indexOfSelection.append(indexPath)
//                item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
//                item.lbl.textColor = UIColor.white
//            }
//            else{
//                item.lbl.backgroundColor = UIColor.white
//                item.lbl.textColor = UIColor.black
//            }
//            return item
//        }
//        else{
//            if indexPath.row == 0 {
//                let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.addOnWithTitle, for: indexPath)
//                return item
//            }else  if indexPath.row == 1 {
//                let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.addOn, for: indexPath)
//                return item
//            }else{
//                let item = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.opsCollectionViewCell, for: indexPath)  as! OPSCollectionViewCell
//                item.layer.masksToBounds = true
//                item.layoutIfNeeded()
//                item.lbl.layoutIfNeeded()
//                item.lbl.layer.masksToBounds = true
//                var data = [String:Any]()
//                for value in selection{
//                    if (value[keyValue.animalId.rawValue] as? Int) == values[collectionView.tag]{
//                        data = value
//                    }
//                }
//                item.lbl.layer.borderColor = UIColor.lightGray.cgColor
//                
//                if ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).status! == "true"{
//                    item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
//                    item.lbl.textColor = UIColor.white
//                }else{
//                    item.lbl.backgroundColor = UIColor.white
//                    item.lbl.textColor = UIColor.black
//                }
//                item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonName!
//                return item
//            }
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (collectionView.frame.size.width / 2 ) - 10, height: 40)
//    }
//}
//
////MARK: TABLEVIEW DATASOURCE AND DELEGATE
//extension OrderProductSelectionReviewVC : UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arr1.keys.count + 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == arr1.keys.count{
//            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.billingCellId, for: indexPath) as! BillingCell
//            let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as! String), attributes: self.attrs)
//            cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
//            cell.delegateCustom = self
//            let marketId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as! String
//            let markeData = fetchdataFromMarketId(marketId: marketId)
//            if markeData.count > 0 {
//                let marketnA = markeData.object(at: 0) as! GetMarketsTbl
//                let pricingLink = marketnA.pricingLinkUrl
//                pricingLinkC = pricingLink
//                let attributedString = NSMutableAttributedString(string:  LocalizedStrings.visitFollowingWebPage.localized)
//                cell.pricingTextView.linkTextAttributes = [
//                    .foregroundColor: UIColor.blue,
//                    .underlineStyle: NSUnderlineStyle.single.rawValue
//                ]
//                attributedString.addAttribute(.link, value: "1", range: NSRange(location: 82, length: 7))
//                cell.pricingTextView.attributedText = attributedString
//                cell.pricingTextView.isHidden = true
//            }
//            
//            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
//                cell.emailOrderBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.emailEnteredData, comment: ""), for: .normal)
//                cell.submitOrderOutlet.setTitle(NSLocalizedString(ButtonTitles.submitText, comment: ""), for: .normal)
//                if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true {
//                    cell.pricingHEIGHTconstraint.constant = 0
//                    cell.agreeTopConstraint.constant = 0
//                    cell.agreeInfoBtnOutelt.isHidden = true
//                    cell.infoBtnSelectionOutlet.isHidden = true
//                    cell.agreeLl.isHidden = false
//                    cell.submitOrderOutlet.isHidden = false
//                    cell.infooBtnSubmitOutlet.isHidden = false
//                    cell.agreeLblHeightConsraint.constant = 0
//                }
//                else {
//                    cell.agreeLblHeightConsraint.constant = 10
//                    cell.pricingHEIGHTconstraint.constant = 0
//                    cell.submitOrderOutlet.isHidden = false
//                    cell.infooBtnSubmitOutlet.isHidden = false
//                    cell.agreeTopConstraint.constant = 45
//                    cell.infoBtnSelectionOutlet.isHidden = false
//                    cell.agreeInfoBtnOutelt.isHidden = false
//                    cell.agreeLl.isHidden = false
//                }
//                
//                if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
//                    cell.nominatorLbl.isHidden = false
//                    cell.nominatorTitle.isHidden = false
//                }
//                else{
//                    cell.nominatorLbl.isHidden = true
//                    cell.nominatorTitle.isHidden = true
//                }
//            }
//            cell.billingContactLbl.text = NSLocalizedString(LocalizedStrings.billingContact, comment: "")
//            cell.agreeLl.text = ButtonTitles.agreeToAcceptance.localized
//            cell.orderDefaultTtile.text = ButtonTitles.orderDefaultsText.localized
//            cell.evaluationTitle.text = NSLocalizedString(LocalizedStrings.providerMarkets, comment: "")
//            cell.editBtnOutlet.setTitle(ButtonTitles.editText.localized, for: .normal)
//            cell.nominatorTitle.text = ButtonTitles.nominatorText.localized
//            cell.placeAnotrderTitle.text = ButtonTitles.placeAnOrderText.localized
//            cell.emailMeEnterTtitle.text = LocalizedStrings.emailEnteredData.localized
//            
//            if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == keyValue.emailMe.rawValue || UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == "" ||  UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == nil{
//                UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
//                UserDefaults.standard.setValue("email", forKey: keyValue.emailFlag.rawValue)
//                
//                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
//                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                }
//                else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false{
//                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                }
//                
//                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                }
//                else  if cell.placeAnOutlet.isSelected == false{
//                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                }
//            }
//            else {
//                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
//                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                }
//                else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false{
//                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                }
//                
//                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                }
//                else  if cell.placeAnOutlet.isSelected == false{
//                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                }
//                
//                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
//                cell.emailMeEnterTtitle.alpha = 1
//            }
//            
//            if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
//                if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
//                    cell.placeAnOutlet.alpha = 1
//                    cell.emailMeEnterTtitle.alpha = 1
//                    if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String ==  keyValue.submitKey.rawValue {
//                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.placeAnOutlet.isSelected == false{
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                        
//                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.emailCheckOutlet.isSelected == false{
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                    }
//                    else {
//                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.emailCheckOutlet.isSelected == false {
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                        
//                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.placeAnOutlet.isSelected == false{
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                    }
//                } else {
//                    if pviduser == 3 {
//                        if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true{
//                            cell.placeAnOutlet.alpha = 1
//                            cell.emailMeEnterTtitle.alpha = 1
//                            
//                        }else {
//                            cell.placeAnOutlet.alpha = 0.6
//                            cell.emailMeEnterTtitle.alpha = 0.6
//                        }
//                    }
//                    else {
//                        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
//                            cell.placeAnOutlet.alpha = 1
//                            cell.emailMeEnterTtitle.alpha = 1
//                            
//                        }else {
//                            cell.placeAnOutlet.alpha = 0.6
//                            cell.placeAnotrderTitle.alpha = 0.6
//                        }
//                    }
//                }
//            }
//            if pviduser == 4 {
//                if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
//                    cell.placeAnOutlet.alpha = 1
//                    
//                    if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String ==  keyValue.submitKey.rawValue {
//                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true{
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.placeAnOutlet.isSelected == false{
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.emailCheckOutlet.isSelected == false{
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                        
//                    }
//                    else {
//                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true{
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.placeAnOutlet.isSelected == false{
//                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                        }
//                        else  if cell.emailCheckOutlet.isSelected == false{
//                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
//                        }
//                    }
//                }
//                else {
//                    cell.emailMeEnterTtitle.alpha = 1
//                    cell.placeAnotrderTitle.alpha = 0.6
//                    
//                }
//            }
//            return cell
//        }
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.opsTableViewCell, for: indexPath) as! OPSTableViewCell
//        cell.OfficialId.text =  String(animaltag[indexPath.row])
//        cell.OnFarmId.text =  String(farmID[indexPath.row])
//        cell.Barcode.text = String(barCode[indexPath.row])
//        cell.vollView.tag = indexPath.row
//        cell.deleteBttn.tag = indexPath.row
//        cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
//        cell.vollView.reloadData()
//        cell.onFarmIDTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
//        cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
//        cell.barcodeTitleleft.text  = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
//        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
//        
//        if pviduser == 4 {
//            cell.OfficialId.text = String(barCode[indexPath.row])
//            cell.Barcode.isHidden = true
//            cell.barcodeTitleleft.isHidden = true
//            cell.thirdColonLbl.isHidden = true
//            cell.OnFarmId.text =  String(earTag[indexPath.row])
//            cell.onFarmIDTitle.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
//            cell.officalIdTitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
//        }
//        else{
//            cell.Barcode.isHidden = false
//            cell.barcodeTitleleft.isHidden = false
//            cell.thirdColonLbl.isHidden = false
//            
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == arr1.keys.count{
//            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
//                return 460
//                
//            } else{
//                
//                return 450
//            }
//        }
//        var addon = 0
//        var data = [String:Any]()
//        for value in selection{
//            if value[keyValue.animalId.rawValue] as? Int == values[indexPath.row]{
//                data = value
//            }
//        }
//        if let item = data[keyValue.animalId.rawValue] as? Int{
//            if values[indexPath.row] == item{
//                let data = data["addon"] as? [SubProductTbl]
//                
//                var quo = data!.count/2
//                var rem = data!.count % 2
//                var val = quo * 40 * rem
//                if quo == 0 && rem == 1{
//                    quo = 1
//                }
//                if data!.count > 0 {
//                    addon = Int(40 * CGFloat(quo) + 30) + val
//                    
//                }else{
//                    addon = -20
//                }
//            }else{
//                addon = -20
//            }
//        }else{
//            addon = -20
//        }
//        let count = (arr1[values[indexPath.row]]!.count)/2 + 1
//        
//        print(40 * CGFloat(count) + 30 + CGFloat(count*20) + CGFloat(addon + 100))
//        tblHeghtFrame = (40 * CGFloat(count) + 30 + CGFloat(count*20) + CGFloat(addon + 100))
//        return 40 * CGFloat(count) + 30 + CGFloat(count*20) + CGFloat(addon + 100)
//    }
//}
//
////MARK: TEXTFIELD AND TEXTVIEW DELEGATES
//extension OrderProductSelectionReviewVC : UITextFieldDelegate, UITextViewDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
//        let currentString: NSString = serchTextField.text! as NSString
//        let newString: NSString =
//        currentString.replacingCharacters(in: range, with: string) as NSString
//        tblView.isHidden = false
//        if newString != ""{
//            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
//                
//                let fetchcustRep = fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId: orderId,userId:userId, farmId: newString as String) as NSArray
//                if fetchcustRep.count > 0 {
//                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
//                }
//                else{
//                    arr1.removeAll()
//                    reloadTable()
//                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
//                }
//            }
//            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
//                let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
//                
//                let fetchcustRep = fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",animalTag: newString as String).filtered(using: bPredicate) as NSArray
//                if fetchcustRep.count > 0 {
//                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
//                }
//                else{
//                    arr1.removeAll()
//                    reloadTable()
//                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
//                }
//            }
//            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
//                let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
//                let fetchcustRep = fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false", barcode: newString as String).filtered(using: bPredicate) as NSArray
//                if fetchcustRep.count > 0 {
//                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
//                }
//                else{
//                    arr1.removeAll()
//                    reloadTable()
//                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
//                }
//            }
//            if clickOnDropDown == ButtonTitles.earTagText{
//                let fetchcustRep =    fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity, asending: true, orderId: orderId, userId: userId, animalTag:  newString as String)
//                if fetchcustRep.count > 0 {
//                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
//                }
//                else{
//                    arr1.removeAll()
//                    reloadTable()
//                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
//                }
//            }
//        }
//        else{
//            self.dropUpDownBtn.setImage(UIImage(named: ImageNames.imageImg), for: .normal)
//            fethData = fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId: orderId,userId:userId, farmId: newString as String)
//            fetchProductAdonAnimalTbl(fethData: fethData, completion: {})
//            if let char = string.cString(using: String.Encoding.utf8) {
//                let isBackSpace = strcmp(char, "\\b")
//            }
//            reloadTable()
//        }
//        return true
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        if URL.absoluteString == "1"{
//            let url =  NSURL(string: pricingLinkC ?? "")! as URL
//            UIApplication.shared.open(url) { (Bool) in
//                
//            }
//        }
//        return true
//    }
//}
//
////MARK: OBJECT PICK FROM CONFLICT
//extension OrderProductSelectionReviewVC:objectPickfromConfilict{
//    func firstLevel(check: Bool) {
//        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
//        
//        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12{
//            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count != 0 {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.confilictOrdersViewControllerVC) as! ConfilictOrdersViewController
//                vc.delegateCustom1 = self
//                vc.screenName = ScreenNames.productSelectionReview.rawValue
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
//        
//        if pviduser == 4 || pviduser == 6 || pviduser == 8{
//            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count != 0 {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.confilictOrdersViewControllerVC) as! ConfilictOrdersViewController
//                vc.delegateCustom1 = self
//                vc.screenName = ScreenNames.productSelectionReview.rawValue
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
//    }
//    
//    func selectionObject(check: Bool) {
//        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
//        if pviduser == 4 {
//            if check == true{
//                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVCGirlando) as! OrderingAnimalVCGirlando
//                navigationController?.pushViewController(vc,animated: false)
//            }
//            else {
//                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
//                self.navigationController!.pushViewController(secondViewController, animated: false)
//            }
//        }
//        else {
//            if check == true{
//                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC) as! OrderingAnimalVC
//                navigationController?.pushViewController(vc,animated: false)
//            }
//            else {
//                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
//                self.navigationController!.pushViewController(secondViewController, animated: false)
//            }
//        }
//    }
//    
//    func dataReload(check :Bool){
//        if check == true{
//            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.reviewOrderVC) as! ReviewOrderVC
//            self.navigationController?.pushViewController(newViewController, animated: false)
//        }
//        else {
//            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.orderProductSelectionReviewVC) as! OrderProductSelectionReviewVC
//            self.navigationController?.pushViewController(newViewController, animated: false)
//        }
//    }
//}
//
////MARK: OFFLINE CUSTOM VIEW1 DELEGATE
//extension OrderProductSelectionReviewVC:offlineCustomView1{
//    func crossBtn() {
//        
//    }
//}
//
////MARK: BILLING DELEGATE
//extension OrderProductSelectionReviewVC:BillingDelegate{
//    func UpdateUI(SelectedBillingCustomer: GetBillingContact) {
//        DispatchQueue.main.async {
//            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
//                let filterArr = self.farmAddr.filter({$0.isDefault == true })
//                if filterArr.count > 0{
//                    updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
//                    
//                }
//                UserDefaults.standard.set(SelectedBillingCustomer.contactName, forKey: keyValue.farmValue.rawValue)
//                UserDefaults.standard.set(SelectedBillingCustomer.billToCustId, forKey: keyValue.billToCustomerId.rawValue)
//                updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: SelectedBillingCustomer.billToCustId ?? "0", billcustomerName: SelectedBillingCustomer.contactName ?? "")
//                self.farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: self.custmerId) as! [GetBillingContact]
//                let attributeString = NSMutableAttributedString(string: SelectedBillingCustomer.contactName ?? "", attributes: self.attrs)
//                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
//            }
//            self.transparentView.isHidden = true
//            self.billingView.isHidden = true
//        }
//        
//    }
//    func updateUI() {
//        DispatchQueue.main.async {
//            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
//                let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String ?? ""),
//                                                                attributes: self.attrs)
//                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
//            }
//            self.transparentView.isHidden = true
//            self.billingView.isHidden = true
//        }
//    }
//}
