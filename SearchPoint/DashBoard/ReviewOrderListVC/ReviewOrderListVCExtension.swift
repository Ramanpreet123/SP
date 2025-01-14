//
//  ReviewOrderListVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 01/03/24.
//

import Foundation
import UIKit

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension ReviewOrderListVc : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return set.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == set.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "lastcell") as! ReviewOrderCell
            cell.bilingBtnOutlet.tag = indexPath.section
            cell.pricingTextView.delegate = self
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  != marketNameType.Dairy.rawValue{
                cell.addDealerCodeTxtField.delegate = cell
                cell.addDealerCodeLbl.sizeToFit()
                cell.addDealerCodeTxtField.layer.borderWidth = 1.0
                cell.addDealerCodeTxtField.layer.borderColor = UIColor.lightGray.cgColor
                cell.addDealerCodeTxtField.layer.cornerRadius = 20.0
                cell.addDealerCodeTxtField.setLeftPaddingPoints(10.0)
                cell.dealerCodeLabel.textColor = .black
                cell.dealerCodeLabel.font = cell.dealerCodeLabel.font.withSize(10)
                cell.dealerCodeLabel.textAlignment = .left
                cell.dealerCodeLabel.text = "12345678901234567890"
                cell.dealerCodeLabel.numberOfLines = 0
                cell.dealerCodeLabel.sizeToFit()
                cell.dealerCodeLabel.lineBreakMode = .byCharWrapping
                cell.dealerCodeView.addSubview(cell.dealerCodeLabel)
                cell.dealerCodeView.isHidden = true
                cell.dealerCodeView.layer.cornerRadius = 15.0
                cell.dealerCodeView.backgroundColor = UIColor(displayP3Red: 255/255, green: 224/255, blue: 203/255, alpha: 1.0)
                cell.button.frame = CGRect(x: 157, y: 5, width: 18, height: 18)
                cell.button.setImage(cell.image, for: .normal)
                cell.dealerCodeView.addSubview(cell.button)
                let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
                let addDealerCodeCheck = UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool
                if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true
                {
                    if addDealerCodeCheck == false {
                        cell.addDealerCodeOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                      if dealerCode == "" || dealerCode == nil{
                        cell.dealerCodeView.isHidden = true
                        cell.addDealerCodeTxtField.isHidden = false
                        cell.addDealerCodeTxtField.layer.borderWidth = 1.0
                        cell.addDealerCodeTxtField.layer.borderColor = UIColor.lightGray.cgColor
                        cell.addDealerCodeTxtField.layer.cornerRadius = 20.0
                        cell.addDealerCodeTxtField.setLeftPaddingPoints(10.0) }
                      else {
                        
                            cell.dealerCodeView.isHidden = false
                            cell.dealerCodeLabel.text = dealerCode
                            cell.dealerCodeView.alpha = 1
                            cell.dealerCodeView.isUserInteractionEnabled = true
                            cell.addDealerCodeTxtField.isHidden = true
                        }
                    }
                    else {
                        cell.addDealerCodeOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        cell.addDealerCodeTxtField.isHidden = true
                      if dealerCode == "" || dealerCode == nil{
                        cell.dealerCodeView.isHidden = true
                      } else {
                        cell.dealerCodeView.isHidden = false
                        cell.dealerCodeLabel.text = dealerCode
                        cell.dealerCodeView.alpha = 0.6
                        cell.dealerCodeView.isUserInteractionEnabled = false
                        cell.addDealerCodeTxtField.isHidden = true
                      }
                    }
                } else{
                    cell.addDealerCodeOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    cell.addDealerCodeTxtField.isHidden = true
                  if dealerCode == "" || dealerCode == nil{
                    cell.dealerCodeView.isHidden = true
                  } else {
                    cell.dealerCodeView.isHidden = false
                    cell.dealerCodeLabel.text = dealerCode
                    cell.dealerCodeView.alpha = 0.6
                    cell.dealerCodeView.isUserInteractionEnabled = false
                    cell.addDealerCodeTxtField.isHidden = true
                  }
                }
            }
            
            let marketId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as? String
            let markeData = fetchdataFromMarketId(marketId: marketId!)
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            
            if markeData.count > 0 {
                let marketnA = markeData.object(at: 0) as! GetMarketsTbl
                let pricingLink = marketnA.pricingLinkUrl
                pricingLinkc = pricingLink
                let attributedString = NSMutableAttributedString(string: LocalizedStrings.visitFollowingWebPage.localized)
                cell.pricingTextView.linkTextAttributes = [
                    .foregroundColor: UIColor.blue,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                attributedString.addAttribute(.link, value: "1", range: NSRange(location: 82, length: 7))
                cell.pricingTextView.attributedText = attributedString
                cell.pricingTextView.isHidden = true
                cell.pricingTextView.backgroundColor = .red
            }
            let farmValue = UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String ?? ""
            if farmValue == "" {
                UserDefaults.standard.setValue(Constants.farmValue, forKey: keyValue.farmValue.rawValue)
            }
            else {
                Constants.farmValue = farmValue
            }
            let attributeString = NSMutableAttributedString(string: Constants.farmValue ?? "",attributes: self.attrs)
            cell.bilingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
                cell.emailOrderBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.emailEnteredData, comment: ""), for: .normal)
                cell.submitOrderOutlet.setTitle(NSLocalizedString(ButtonTitles.submitText, comment: ""), for: .normal)
                cell.pricingTextView.delegate = self
                let clariText = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                let ab  = "    " + clariText!
                cell.providerLbl.setTitle(ab, for: .normal)
                cell.delegateCustom = self
              let pviduser1 = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
              if pviduser1 == 4 {
                let checkCartAnimal =  fetchAllDataGirlandoAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalTag:"", pvid: pviduser1,dob: "", animalName: "")
                if checkCartAnimal.count != 0 {
                  UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
                  
                } else {
                  UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
                  
                }
              } else {
                let checkCartAnimal =  fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid:pviduser1, dob: "")
                if checkCartAnimal.count != 0 {
                  UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
                  
                } else {
                  UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
                  
                }
              }
             
              if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true{
                    cell.agreeLblHeightConstraint.constant = 0
                    cell.pricingTextHeightConstraint.constant = 0
                    cell.infoButton1.isHidden = true
                    cell.infoBtnSelectionOutlet.isHidden = true
                    cell.submitOrderOutlet.isHidden = false
                    cell.infoButton3.isHidden = false
                    cell.emailCheckBoxTopContraint.constant = 0
                } else {
                    cell.emailCheckBoxTopContraint.constant = 14
                    cell.agreeTopConstraint.constant = 12
                    cell.agrreBelowContsint.constant = 5
                    cell.pricingTextHeightConstraint.constant = 0
                    cell.agreeLblHeightConstraint.constant = 43
                    cell.submitOrderOutlet.isHidden = false
                    cell.infoButton3.isHidden = false
                    cell.agrreLbl.isHidden = false
                    cell.infoButton1.isHidden = false
                    cell.infoBtnSelectionOutlet.isHidden = false
                    cell.pricingTextView.isHidden = true
                }
                
                let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
                if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == keyValue.emailMe.rawValue || UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == "" ||  UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == nil{
                    UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    UserDefaults.standard.setValue(keyValue.email.rawValue, forKey: keyValue.emailFlag.rawValue)
                    if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                        cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    }
                    else  if cell.emailMeSelectionOutlet.isSelected == false{
                        cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    }
                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                        cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    }
                    else  if cell.placeAnOrderSelectionOutlet.isSelected == false{
                        cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    }
                    cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    cell.placeAnotrderTitle.alpha = 1.0
                }
                else {
                    if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                        cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    }
                    else  if cell.emailMeSelectionOutlet.isSelected == false{
                        cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    }
                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                        cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    }
                    else  if cell.placeAnOrderSelectionOutlet.isSelected == false{
                        cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    }
                    UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    cell.placeAnotrderTitle.alpha = 1
                }
                
                if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
                    if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"",pvid: pviduser).count == 0 {
                        cell.placeAnOrderSelectionOutlet.alpha = 1
                        cell.placeAnotrderTitle.alpha = 1
                        if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String ==  keyValue.submitKey.rawValue{
                            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.placeAnOrderSelectionOutlet.isSelected == false{
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            
                            if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.emailMeSelectionOutlet.isSelected == false{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                        }
                        else {
                            if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.emailMeSelectionOutlet.isSelected == false{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.placeAnOrderSelectionOutlet.isSelected == false{
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                        }
                    }
                    else {
                        if pviduser == 3 {
                            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false{
                                cell.placeAnOrderSelectionOutlet.alpha = 1
                                cell.placeAnotrderTitle.alpha = 1
                            }
                            else {
                                cell.placeAnOrderSelectionOutlet.alpha = 0.6
                                cell.placeAnotrderTitle.alpha = 0.6
                            }
                        }
                        else {
                            if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
                                cell.placeAnOrderSelectionOutlet.alpha = 1
                                cell.placeAnotrderTitle.alpha = 1
                            }
                            else {
                                cell.placeAnOrderSelectionOutlet.alpha = 0.6
                                cell.placeAnotrderTitle.alpha = 0.6
                            }
                        }
                    }
                }
                
                if pviduser == 4 || pviduser == 6 || pviduser == 8  {
                    if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString:"").count == 0 {
                        cell.placeAnOrderSelectionOutlet.alpha = 1
                        
                        if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String ==  keyValue.submitKey.rawValue {
                            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.placeAnOrderSelectionOutlet.isSelected == false{
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.emailMeSelectionOutlet.isSelected == false{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                        }
                        else {
                            if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.emailMeSelectionOutlet.isSelected == false{
                                cell.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.placeAnOrderSelectionOutlet.isSelected == false{
                                cell.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            cell.emailMeEnterTtitle.alpha = 1
                            cell.placeAnotrderTitle.alpha = 1
                        }
                    } else {
                        cell.placeAnOrderSelectionOutlet.alpha = 0.6
                        cell.placeAnotrderTitle.alpha = 0.6
                    }
                }
            }
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
                cell.beefsubmitInfoBtn.isHidden = false
                cell.beefEmailMeInfoBtn.isHidden = false
                cell.delegateCustom = self
                let pviduser = (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue))
                let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
                if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == keyValue.emailMe.rawValue || UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == "" ||  UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == nil{
                    UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    
                    if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    }
                    else  if cell.beefEmailSelectionOutlet.isSelected == false{
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    }
                    
                    if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        cell.addDealerCodeLbl.alpha = 1
                        cell.addDealerCodeOutlet.alpha = 1
                    }
                    else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        cell.addDealerCodeLbl.alpha = 0.6
                        cell.addDealerCodeOutlet.alpha = 0.6
                    }
                }
                else {
                    UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    }
                    else  if cell.beefEmailSelectionOutlet.isSelected == false{
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    }
                    
                    if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        cell.addDealerCodeLbl.alpha = 1
                        cell.addDealerCodeOutlet.alpha = 1
                    }
                    else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        cell.addDealerCodeLbl.alpha = 0.6
                        cell.addDealerCodeOutlet.alpha = 0.6
                    }
                    cell.beefEmailSelectionOutlet.alpha = 0.6
                }
                
                if pviduser == 13 {
                    let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                    
                    if fetchAnimalTbl.count == 0 {
                        UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
                        UserDefaults.standard.set(true, forKey: keyValue.beefPlaceOrderCheck.rawValue)
                        cell.beefPlaceAnSelectionTitle.alpha = 1
                        cell.beefPlaceSelectionOutlet.alpha = 1
                        cell.beefEmailSelectionOutlet.isHidden = true
                        cell.emailMeSelectionTtile.isHidden = true
                        cell.beefEmailMeInfoBtn.isHidden =  true
                        cell.beefEmailSelectionheightConstraint.constant = 0
                        cell.beefPlaceanOrderTopConstraint.constant = 0
                        
                        if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            cell.addDealerCodeLbl.alpha = 1
                            cell.addDealerCodeOutlet.alpha = 1
                        }
                        else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            cell.addDealerCodeLbl.alpha = 0.6
                            cell.addDealerCodeOutlet.alpha = 0.6
                        }
                    }
                    else {
                        cell.beefPlaceAnSelectionTitle.alpha = 0.6
                        cell.beefPlaceSelectionOutlet.alpha = 0.6
                        cell.addDealerCodeLbl.alpha = 0.6
                        cell.addDealerCodeOutlet.alpha = 0.6
                        UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
                        
                        if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            cell.addDealerCodeLbl.alpha = 1
                            cell.addDealerCodeOutlet.alpha = 1
                        }
                        else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            cell.addDealerCodeLbl.alpha = 0.6
                            cell.addDealerCodeOutlet.alpha = 0.6
                        }
                        
                        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                        cell.beefAgreeTopConstarintt.constant = 12
                        cell.beefinfoBtnSelectionOutlet.isHidden = true
                        cell.beefAgreeHeightConstraint.constant = 0
                        cell.beefPricingTextHeight.constant = 0
                        cell.beefEmailSelectionTopConstranint.constant = 0
                        cell.beefEmailSelectionOutlet.isHidden = true
                        cell.emailMeSelectionTtile.isHidden = true
                        cell.beefEmailMeInfoBtn.isHidden =  true
                        cell.termsBtnnOutlet.isHidden = true
                        cell.beefEmailSelectionheightConstraint.constant = 0
                        cell.beefPlaceanOrderTopConstraint.constant = 0
                    }
                }
                
                if pviduser == 5 {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue{
                        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                        
                        if fetchAnimalTbl.count == 0 {
                            cell.beefPlaceAnSelectionTitle.alpha = 1
                            cell.beefPlaceSelectionOutlet.alpha = 1
                            if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.beefEmailSelectionOutlet.isSelected == false{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            
                            if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                            }
                            else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                        }
                        else {
                            cell.beefPlaceAnSelectionTitle.alpha = 0.6
                            cell.beefPlaceSelectionOutlet.alpha = 0.6
                            cell.addDealerCodeLbl.alpha = 0.6
                            cell.addDealerCodeOutlet.alpha = 0.6
                            if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.beefEmailSelectionOutlet.isSelected == false{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            
                            if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                            }
                            else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                            
                            UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                            cell.beefAgreeTopConstarintt.constant = 12
                            cell.beefinfoBtnSelectionOutlet.isHidden = true
                            cell.beefAgreeHeightConstraint.constant = 0
                            cell.beefPricingTextHeight.constant = 0
                            cell.beefEmailSelectionTopConstranint.constant = 0
                            cell.termsBtnnOutlet.isHidden = true
                        }
                    }
                }
                
                if pviduser == 7 || pviduser == 6 {
                    if UserDefaults.standard.string(forKey: keyValue.brzGenoType.rawValue) == keyValue.genotypeKey.rawValue{
                        cell.beefPlaceAnSelectionTitle.alpha = 1
                        cell.beefPlaceSelectionOutlet.alpha = 1
                        cell.addDealerCodeOutlet.alpha = 1
                        cell.addDealerCodeLbl.alpha = 1
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    }
                    else{
                        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                        
                        if fetchAnimalTbl.count == 0 {
                            cell.beefPlaceAnSelectionTitle.alpha = 1
                            cell.beefPlaceSelectionOutlet.alpha = 1
                            if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true {
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                            }
                            else  if cell.beefPlaceSelectionOutlet.isSelected == false{
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                            if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.beefEmailSelectionOutlet.isSelected == false{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                        }
                        else {
                            cell.beefPlaceAnSelectionTitle.alpha = 0.6
                            cell.beefPlaceSelectionOutlet.alpha = 0.6
                            cell.addDealerCodeOutlet.alpha = 0.6
                            cell.addDealerCodeLbl.alpha = 0.6
                            
                            if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            }
                            else  if cell.beefEmailSelectionOutlet.isSelected == false{
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            }
                            
                            if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                            }
                            else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                                cell.addDealerCodeLbl.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                            cell.beefAgreeTopConstarintt.constant = 12
                            cell.beefinfoBtnSelectionOutlet.isHidden = true
                            cell.beefAgreeHeightConstraint.constant = 0
                            cell.beefPricingTextHeight.constant = 0
                            cell.beefEmailSelectionTopConstranint.constant = 0
                            cell.termsBtnnOutlet.isHidden = true
                        }
                    }
                }
            }
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
                cell.orderDefaultTitle?.text = ButtonTitles.orderDefaultsText.localized
                cell.evaluationTitle.text = NSLocalizedString(LocalizedStrings.providerMarkets, comment: "")
                cell.editBtnOutlet.setTitle(ButtonTitles.editText.localized, for: .normal)
                cell.nominatorTitle.text = ButtonTitles.nominatorText.localized
                cell.placeAnotrderTitle.text = ButtonTitles.placeAnOrderText.localized
                cell.emailMeEnterTtitle.text = LocalizedStrings.emailEnteredData.localized
            }
            
            cell.billingContact.text = NSLocalizedString(LocalizedStrings.billingContact, comment: "")
            cell.agrreLbl.text = ButtonTitles.agreeToAcceptance.localized
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  != marketNameType.Dairy.rawValue{
                cell.beefPlaceAnSelectionTitle.text = ButtonTitles.placeAnOrderText.localized
                cell.emailMeSelectionTtile.text = LocalizedStrings.emailEnteredData.localized
            }
            
            let pviduser = (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue))
            if pviduser == 13 && UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Beef.rawValue {
                cell.submitOrderOutlet.setTitle(ButtonTitles.blockyardOrder.localized, for: .normal)
            }
            else {
                cell.submitOrderOutlet.setTitle(NSLocalizedString(ButtonTitles.submitText, comment: ""), for: .normal)
            }
            
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
                cell.nominatorlbl.isHidden = false
                cell.nominatorTitle.isHidden = false
            }
            else{
                cell.nominatorlbl.isHidden = true
                cell.nominatorTitle.isHidden = true
            }
            
            if UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) == nil || UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String == ""{
                cell.nominatorlbl.setTitle("    Zoetis".uppercased(), for: .normal)
            }
            else {
                let nomi = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
                let ab  = "    " + nomi!.uppercased()
                cell.nominatorlbl.setTitle(ab, for: .normal)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.reviewOrderCell) as! ReviewOrderCell
            cell.sectionTitle.text = "   \(set[indexPath.section])   "
            cell.collView.tag = indexPath.section
            cell.sectionTitle.layoutIfNeeded()
            cell.sectionTitle.layer.masksToBounds = true
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
                if uniqueProductArrayBeef.count > 0{
                    cell.ProductArrayBeef = uniqueProductArrayBeef[set[indexPath.section]]!
                    cell.collView.delegate = cell
                    cell.collView.dataSource = cell
                    let rem:Int = cell.ProductArrayBeef.count % 3
                    let quo:Int = cell.ProductArrayBeef.count / 3
                    var height = 0
                    if rem > 0{
                        height = (quo * 70) + 35
                    }else if rem == 0{
                        height = (quo * 70)
                    }
                    cell.collViewHeight.constant = CGFloat(height) + 40
                    cell.collView.reloadData()
                }
            }
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Dairy.rawValue{
                if uniqueProductArray.count > 0{
                    cell.ProductArray = uniqueProductArray[set[indexPath.section]]!
                    cell.collView.delegate = cell
                    cell.collView.dataSource = cell
                    let rem:Int = cell.ProductArray.count % 3
                    let quo:Int = cell.ProductArray.count / 3
                    var height = 0
                    if rem > 0{
                        height = (quo * 70) + 35
                    } else if rem == 0 {
                        height = (quo * 70)
                    }
                    cell.collViewHeight.constant = CGFloat(height) + 40
                    cell.collView.reloadData()
                }
            }
            cell.itemSelection = itemSelection
            return cell
        }
    }
}
