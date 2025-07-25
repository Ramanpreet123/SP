//
//  ReviewOrderCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 01/03/24.
//

import Foundation

//MARK: CLASS
class ReviewOrderCell:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var addDealerCodeOutlet: UIButton!
    @IBOutlet weak var dealerCodeView: UIView!
    @IBOutlet weak var addDealerCodeLbl: UILabel!
    @IBOutlet weak var addDealerCodeTxtField: UITextField!
    @IBOutlet weak var collView:UICollectionView!
    @IBOutlet weak var sectionTitle:PaddingLabel!
    @IBOutlet weak var collViewHeight:NSLayoutConstraint!
    @IBOutlet weak var nominatorlbl: customButton!
    @IBOutlet weak var providerLbl: customButton!
    @IBOutlet weak var billingContact: UILabel!
    @IBOutlet weak var evaluationTitle: UILabel!
    @IBOutlet weak var agrreLbl: UILabel!
    @IBOutlet weak var termAceeptedLbl: UILabel!
    @IBOutlet weak var priceLinklbl: UILabel!
    @IBOutlet weak var nominatorTitle: UILabel!
    @IBOutlet weak var editBtnOutlet: UIButton!
    @IBOutlet weak var pricingBtnOutlet: UIButton!
    @IBOutlet weak var submitOrderOutlet: UIButton!
    @IBOutlet weak var submitTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var agreeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var agreeLblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailOrderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var termsBelowLbl: NSLayoutConstraint!
    @IBOutlet weak var forInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var submitOrderBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lastviewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var emailOrderBtnOutlet: UIButton!
    @IBOutlet weak var beefsubmitInfoBtn: UIButton!
    @IBOutlet weak var infoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var emailMeSelectionOutlet: UIButton!
    @IBOutlet weak var placeAnOrderSelectionOutlet: UIButton!
    @IBOutlet weak var infoButton1: UIButton!
    @IBOutlet weak var infoButton2: UIButton!
    @IBOutlet weak var orderDefaultTitle: UILabel!
    @IBOutlet weak var infoButton3: UIButton!
    @IBOutlet weak var beefEmailMeBtnOutlet: UIButton!
    @IBOutlet weak var beefEmailMeInfoBtn: UIButton!
    @IBOutlet weak var pricingTextView: UITextView!
    @IBOutlet weak var pricingTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var pricingTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitTopConstaint: NSLayoutConstraint!
    @IBOutlet weak var emailMeEnterTtitle: UILabel!
    @IBOutlet weak var beefPlaceAnSelectionTitle: UILabel!
    @IBOutlet weak var placeAnotrderTitle: UILabel!
    @IBOutlet weak var agrreBelowContsint: NSLayoutConstraint!
    @IBOutlet weak var emailCheckBoxTopContraint: NSLayoutConstraint!
    @IBOutlet weak var termsBtnnOutlet: UIButton!
    @IBOutlet weak var beefAgreeTopConstarintt: NSLayoutConstraint!
    @IBOutlet weak var beefAgreeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var beefPricingTextHeight: NSLayoutConstraint!
    @IBOutlet weak var beefEmailSelectionTopConstranint: NSLayoutConstraint!
    @IBOutlet weak var beefEmailSelectionheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var beefPlaceanOrderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailMeSelectionTtile: UILabel!
    @IBOutlet weak var bilingBtnOutlet: UIButton!
    @IBOutlet weak var beefinfoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var beefEmailSelectionOutlet: UIButton!
    @IBOutlet weak var beefPlaceSelectionOutlet: UIButton!
    
    //MARK: VARIABLES
    var itemSelection:String!
    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
    var ProductArray = [ProductAdonAnimalTbl]()
    var ProductArrayBeef = [ProductAdonAnimlTbLBeef]()
    var isAgree = false
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    weak var delegateCustom : objectPickfromConfilict?
    var dealerCodeLabel = UILabel(frame: CGRect(x: 8, y: 8, width: 175, height: 15))
    let image = UIImage(named: "cross")
    var button = UIButton(type: UIButton.ButtonType.custom)
    
    //MARK: AWAKE FROM NIB
    override func awakeFromNib() {
        if infoBtnSelectionOutlet != nil {
            if ( UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  false ) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  nil ) {
                infoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            } else {
                infoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            }
        }
        if beefinfoBtnSelectionOutlet != nil {
            if ( UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  false ) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  nil ){
                beefinfoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            } else {
                beefinfoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            }
        }
        if lastviewHeightConst != nil {
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
                lastviewHeightConst.constant = 420
            }
            else{
                lastviewHeightConst.constant = 470
                if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
                    lastviewHeightConst.constant = 380
                }
            }
        }
        
        self.button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.dealerCodeLabel.isUserInteractionEnabled = true
        self.dealerCodeLabel.addGestureRecognizer(tap)
    }
    
    //MARK: IB ACTIONS
    @IBAction func infoBtnSelection(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == true {
            sender.isSelected = false
            infoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        else {
            sender.isSelected = true
            infoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        isAgree = !isAgree
    }
    
    @IBAction func beefEmailMeSelectionAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
        
        if fetchAnimalTbl.count == 0 {
            beefPlaceAnSelectionTitle.alpha = 1
            beefPlaceSelectionOutlet.alpha = 1
            if UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true {
                sender.isSelected = false
                beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            else {
                sender.isSelected = true
                beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                UserDefaults.standard.set(true, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
        }
        else {
            if UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true {
                sender.isSelected = false
                beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.unCheckImg), for: .normal)
                UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            else {
                sender.isSelected = true
                beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                UserDefaults.standard.set(true, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            isAgree = !isAgree
            beefPlaceAnSelectionTitle.alpha = 0.6
            beefPlaceSelectionOutlet.alpha = 0.6
            beefEmailSelectionOutlet.alpha=1
        }
    }
    
    @IBAction func beefPlaceMeSelectionAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue))
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        
        if pviduser == 13 {
            UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
            
        }
        
        if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true {
            sender.isSelected = false
            beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            addDealerCodeOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            self.addDealerCodeTxtField.isHidden = true
            UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.addDealerCodeCheck.rawValue)
            addDealerCodeOutlet.isEnabled = false
            addDealerCodeLbl.alpha = 0.6
            addDealerCodeOutlet.alpha = 0.6
            self.dealerCodeView.alpha = 0.6
            self.dealerCodeView.isUserInteractionEnabled = false

        } else {
            sender.isSelected = true
            beefPlaceSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            UserDefaults.standard.set(true, forKey: keyValue.beefPlaceOrderCheck.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.addDealerCodeCheck.rawValue)
            addDealerCodeOutlet.isEnabled = true
            let addDealerCodeCheck = UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool
            let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
            if addDealerCodeCheck == true {
              if dealerCode == "" || dealerCode == nil{ }
              else {
                self.dealerCodeView.isHidden = false
                self.dealerCodeView.alpha = 0.6
                self.dealerCodeView.isUserInteractionEnabled = false
              }
               
            }
           
            addDealerCodeLbl.alpha = 1
            addDealerCodeOutlet.alpha = 1

        }
        
        if pviduser == 5 {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                
                if fetchAnimalTbl.count == 0 {
                    beefPlaceAnSelectionTitle.alpha = 1
                    beefPlaceSelectionOutlet.alpha = 1
                }
                else {
                    beefPlaceAnSelectionTitle.alpha = 0.6
                    beefPlaceSelectionOutlet.alpha = 0.6
                    delegateCustom?.firstLevel!(check: false)
                }
                
            }
        } else if pviduser == 7 || pviduser == 6 || pviduser == 13{
            let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
            if fetchAnimalTbl.count == 0 {
                beefPlaceAnSelectionTitle.alpha = 1
                beefPlaceSelectionOutlet.alpha = 1
            } else {
                beefPlaceAnSelectionTitle.alpha = 0.6
                beefPlaceSelectionOutlet.alpha = 0.6
                
                delegateCustom?.firstLevel!(check: false)
            }
        }
    }
    
    @IBAction func emailMeCheckBoxSelection(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
            let getAnimalData = fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser)
            
            if (getAnimalData.count == 0) || (pviduser == 2 && getAnimalData.count == 1) {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                    
                } else {
                    sender.isSelected = true
                    emailMeSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 1
                
            } else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailMeSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                    
                } else {
                    sender.isSelected = true
                    emailMeSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 0.6
                placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            }
        }
        else if pviduser == 4 || pviduser == 6 || pviduser == 8 {
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailMeSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 1
            }
            else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailMeSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailMeSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                isAgree = !isAgree
                placeAnOrderSelectionOutlet.alpha = 0.6
            }
        }
    }
    
    @IBAction func placeAnOrderCheckBoxSelection(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
            sender.isSelected = false
            placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.placeOrderCheck.rawValue)
        }
        else {
            sender.isSelected = true
            placeAnOrderSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            UserDefaults.standard.set(true, forKey: keyValue.placeOrderCheck.rawValue)
        }
        
        isAgree = !isAgree
        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                if pviduser == 3 {
                    if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true{
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    } else {
                        delegateCustom?.firstLevel!(check: false)
                    }
                } else {
                    if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                    }else {
                        delegateCustom?.firstLevel!(check: false)
                    }
                }
            }
        } else if pviduser == 4 || pviduser == 6 || pviduser == 8 {
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                delegateCustom?.firstLevel!(check: false)
            }
        }
    }
    
    @IBAction func beefInfoBtnSelection(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == true {
            sender.isSelected = false
            beefinfoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        else {
            sender.isSelected = true
            beefinfoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        
        isAgree = !isAgree
    }
    
    @IBAction func addDealerCodeAction(_ sender: UIButton) {
        self.addDealerCodeTxtField.delegate = self
        let placeOrderCheck = UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        if placeOrderCheck == true {
            if UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool == true {
                sender.isSelected = false
                addDealerCodeOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                UserDefaults.standard.set(false, forKey: keyValue.addDealerCodeCheck.rawValue)
              if dealerCode == "" || dealerCode == nil{ 
                DispatchQueue.main.async {
                    self.addDealerCodeTxtField.text = ""
                    self.addDealerCodeTxtField.setLeftPaddingPoints(10.0)
                    self.addDealerCodeTxtField.layer.borderWidth = 1.0
                    self.addDealerCodeTxtField.layer.borderColor = UIColor.lightGray.cgColor
                    self.addDealerCodeTxtField.layer.cornerRadius = 20.0
                    self.addDealerCodeTxtField.isHidden = false
                }
              }
              else {
                self.dealerCodeView.isHidden = false
                self.dealerCodeView.alpha = 1
                self.dealerCodeView.isUserInteractionEnabled = true
              }
            } else {
                sender.isSelected = true
                addDealerCodeOutlet.setImage(#imageLiteral(resourceName: ImageNames.unCheckImg), for: .normal)
                UserDefaults.standard.set(true, forKey: keyValue.addDealerCodeCheck.rawValue)
                self.addDealerCodeTxtField.isHidden = true
              if dealerCode == "" || dealerCode == nil{ } else{
                self.dealerCodeView.alpha = 0.6
                self.dealerCodeView.isUserInteractionEnabled = false
              }
            }
        }
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func buttonClicked(sender: UIButton) {
        let buttonRow = sender.tag
        self.dealerCodeLabel.text = ""
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        self.dealerCodeView.isHidden = true
        
        if UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool == false {
            self.addDealerCodeTxtField.isHidden = false
        } else {
            self.addDealerCodeTxtField.isHidden = true
        }
        
    }
    
  @objc func tapFunction(sender:UITapGestureRecognizer) {
    let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
    self.addDealerCodeTxtField.isHidden = false
    if dealerCode == "" || dealerCode == nil{ } else{
      self.addDealerCodeTxtField.delegate = self
      self.addDealerCodeTxtField.text = dealerCode
      self.addDealerCodeTxtField.becomeFirstResponder()
    }
  }
    
    @objc func addonsBtnClick(_ sender:UIButton) {
        let productDict = NSMutableDictionary()
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            
            let addoniD = ProductArrayBeef[sender.tag]
            productDict.setValue(addoniD.animalTag, forKey: keyValue.animalId.rawValue)
            productDict.setValue(addoniD.productId, forKey: keyValue.smallProductId.rawValue)
            NotificationCenter.default.post(name: Notification.Name("ReviewAddonsbeef"), object: nil, userInfo: productDict as? [AnyHashable : Any])
        }
        else {
            let addoniD = ProductArray[sender.tag]
            productDict.setValue(addoniD.animalId, forKey: keyValue.animalId.rawValue)
            productDict.setValue(addoniD.productId, forKey: keyValue.smallProductId.rawValue)
            NotificationCenter.default.post(name: Notification.Name("ReviewAddons"), object: nil, userInfo: productDict as? [AnyHashable : Any])
        }
    }
    
    //MARK: COLLECTION VIEW DATASOURCE AND DELEGATE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            return ProductArrayBeef.count
        }
        else{
            return ProductArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var animalIdN = Int64()
        var productIdN = Int16()
        if UIDevice().userInterfaceIdiom == .phone {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.reviewOrderItemCellIdentifier, for: indexPath) as! ReviewOrderItemCell
            cell.addOnsBtnOutlet.setTitle(NSLocalizedString("View Add-On's", comment: ""), for: .normal)
            cell.sectionTitle.layoutIfNeeded()
            cell.sectionTitle.layer.masksToBounds = true
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                if pvid == 5 || pvid == 7 || pvid == 13 {
                    if itemSelection == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                        cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalbarCodeTag
                    }
                    else if  itemSelection == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                        cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalTag
                    }
                    else{
                        cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalTag
                    }
                }
                
                if pvid == 6{
                    if itemSelection == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                        cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalTag
                    }
                    else if  itemSelection == LocalizedStrings.seriesText{
                        cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalbarCodeTag
                    }
                    else if itemSelection == LocalizedStrings.RGNText{
                        cell.sectionTitle.text = ProductArrayBeef[indexPath.row].rgn
                    }
                    else if itemSelection == LocalizedStrings.RGDText || itemSelection == LocalizedStrings.RGDorAnimalIDText{
                        cell.sectionTitle.text = ProductArrayBeef[indexPath.row].rgd
                    }
                }
                
                if UserDefaults.standard.bool(forKey: keyValue.beefBVDVSeleted.rawValue)  && pvid == 13 {
                    updateAdonData(entity: Entities.subProductBeefTblEntity, adonId: 1, status: "true", animaltag:  ProductArrayBeef[indexPath.row].animalTag ?? "", orderId: 1, userId: 1)
                    updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: 1, status: "true",productId: 52)
                }
                
                let addonsArrayBeef = (fetchSubProductDataTrueBeef(entityName:Entities.subProductBeefTblEntity,productId: (Int(ProductArrayBeef[indexPath.row].productId)),animalTag: ProductArrayBeef[indexPath.row].animalTag ?? "", status: "true",orderId:Int(ProductArrayBeef[indexPath.row].orderId),userId:Int(ProductArrayBeef[indexPath.row].userId)) as? [SubProductTblBeef])!
                
                if addonsArrayBeef.count == 0 {
                    cell.addOnsBtnOutlet.isHidden = true
                  
                } else {
                    cell.addOnsBtnOutlet.isHidden = false
                }
            }
            else {
                if itemSelection == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                    cell.sectionTitle.text = ProductArray[indexPath.row].animalbarCodeTag
                }
                else if  itemSelection == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                    cell.sectionTitle.text = ProductArray[indexPath.row].animalTag
                }
                else if itemSelection == "EarTag" || itemSelection == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
                    cell.sectionTitle.text = ProductArray[indexPath.row].earTag
                }
                else{
                    cell.sectionTitle.text = ProductArray[indexPath.row].farmId
                }
               
                let addonsArray = ((fetchSubProductDataDairyreview(productId: Int(ProductArray[indexPath.row].productId),animalTag: Int(ProductArray[indexPath.row].animalId),orderId:Int(ProductArray[indexPath.row].orderId),userId:Int(ProductArray[indexPath.row].userId), status: "true") as? [SubProductTbl])!)
                
                if addonsArray.count == 0 {
                    cell.addOnsBtnOutlet.isHidden = true
                } else {
                    cell.addOnsBtnOutlet.isHidden = false
                    
                }
            }
            cell.addOnsBtnOutlet.tag = indexPath.item
            cell.addOnsBtnOutlet.addTarget(self, action: #selector(ReviewOrderCell.addonsBtnClick(_:)), for: .touchUpInside)
            return cell
        }
        else {
         //   if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewOrderItemCelliPad", for: indexPath) as! ReviewOrderItemCelliPad
        //    cell.sectionTitle.sizeToFit()
                cell.sectionTitle.layoutIfNeeded()
                cell.sectionTitle.layer.masksToBounds = true
            cell.sectionTitle.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
                if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
                    let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                    if pvid == 5 || pvid == 7 || pvid == 13 {
                        if itemSelection == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                            cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalbarCodeTag
                        }
                        else if  itemSelection == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                            cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalTag
                        }
                        else{
                            cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalTag
                        }
                    }
                    
                    if pvid == 6{
                        if itemSelection == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                            cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalTag
                        }
                        else if  itemSelection == LocalizedStrings.seriesText{
                            if ProductArrayBeef[indexPath.row].animalbarCodeTag != ""{
                                cell.sectionTitle.text = ProductArrayBeef[indexPath.row].animalbarCodeTag
                            } else {
                                cell.sectionTitle.text = "N/A"
                            }
                            
                        }
                        else if itemSelection == LocalizedStrings.RGNText{
                            if ProductArrayBeef[indexPath.row].rgn != ""{
                                cell.sectionTitle.text = ProductArrayBeef[indexPath.row].rgn
                            } else {
                                cell.sectionTitle.text = "N/A"
                            }
                          //  cell.sectionTitle.text = ProductArrayBeef[indexPath.row].rgn
                        }
                        else if itemSelection == LocalizedStrings.RGDText || itemSelection == LocalizedStrings.RGDorAnimalIDText{
                            if ProductArrayBeef[indexPath.row].rgd != ""{
                                cell.sectionTitle.text = ProductArrayBeef[indexPath.row].rgd
                            } else {
                                cell.sectionTitle.text = "N/A"
                            }
                          //  cell.sectionTitle.text = ProductArrayBeef[indexPath.row].rgd
                        }
                    }
                    
                    if UserDefaults.standard.bool(forKey: keyValue.beefBVDVSeleted.rawValue)  && pvid == 13 {
                        updateAdonData(entity: Entities.subProductBeefTblEntity, adonId: 1, status: "true", animaltag:  ProductArrayBeef[indexPath.row].animalTag ?? "", orderId: 1, userId: 1)
                        updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: 1, status: "true",productId: 52)
                    }
                    
                    let addonsArrayBeef = (fetchSubProductDataTrueBeef(entityName:Entities.subProductBeefTblEntity,productId: (Int(ProductArrayBeef[indexPath.row].productId)),animalTag: ProductArrayBeef[indexPath.row].animalTag ?? "", status: "true",orderId:Int(ProductArrayBeef[indexPath.row].orderId),userId:Int(ProductArrayBeef[indexPath.row].userId)) as? [SubProductTblBeef])!
                    
                    if addonsArrayBeef.count == 0 {
                       // cell.addOnsBtnOutlet.isHidden = true
                    } else {
                       // cell.addOnsBtnOutlet.isHidden = false
                    }
                    
                    if addonsArrayBeef.count == 0 {
                        cell.addOnCollectionView.isHidden = true
                       cell.addOnCollectionViewHeight.constant = 0
                    }
                    
                    else {
                        cell.addonsArrayBeef = addonsArrayBeef
                        cell.addOnCollectionView.isHidden = false
                        cell.addOnCollectionView.dataSource = cell
                        cell.addOnCollectionView.delegate = cell
                        cell.addOnCollectionView.reloadData()
                        
                        
                    }
                    
                    if addonsArrayBeef.count > 0 {
                        cell.addOnCollectionViewHeight.constant = 60
                    }
                    
                    if addonsArrayBeef.count > 3 {
                        cell.addOnCollectionViewHeight.constant = 110
                    }
                }
                else {
                    if itemSelection == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                        cell.sectionTitle.text = ProductArray[indexPath.row].animalbarCodeTag
                    }
                    else if  itemSelection == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                        if ProductArray[indexPath.row].animalTag != ""{
                            cell.sectionTitle.text = ProductArray[indexPath.row].animalTag
                        } else {
                            cell.sectionTitle.text = "N/A"
                        }
                    }
                    else if itemSelection == "EarTag" || itemSelection == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
                        if ProductArray[indexPath.row].earTag != ""{
                            cell.sectionTitle.text = ProductArray[indexPath.row].earTag
                        } else {
                            cell.sectionTitle.text = "N/A"
                        }
                    }
                    else{
                        if ProductArray[indexPath.row].farmId != ""{
                            cell.sectionTitle.text = ProductArray[indexPath.row].farmId
                        } else{
                            cell.sectionTitle.text = "N/A"
                        }
                    }
                    animalIdN = ProductArray[indexPath.row].animalId
                    UserDefaults.standard.set(ProductArray[indexPath.row].animalId, forKey: "animalId")
                    productIdN = ProductArray[indexPath.row].productId
                    UserDefaults.standard.set(ProductArray[indexPath.row].productId, forKey: "productId")
                    
                    let addonsArray = ((fetchSubProductDataDairyreview(productId: Int(ProductArray[indexPath.row].productId),animalTag: Int(ProductArray[indexPath.row].animalId),orderId:Int(ProductArray[indexPath.row].orderId),userId:Int(ProductArray[indexPath.row].userId), status: "true") as? [SubProductTbl])!)
                    
                    if addonsArray.count == 0 {
                        cell.addOnCollectionView.isHidden = true
                    //    cell.addOnCollectionViewHeight.constant = 0
                    }
                    
                    else {
                        cell.addonsArray = addonsArray
                        cell.addOnCollectionView.isHidden = false
                        cell.addOnCollectionView.dataSource = cell
                        cell.addOnCollectionView.delegate = cell
                        cell.addOnCollectionView.reloadData()
                        
                        
                    }
                    
                    if addonsArray.count > 0 {
                        cell.addOnCollectionViewHeight.constant = 60
                    }
                    
                    if addonsArray.count > 3 {
                        cell.addOnCollectionViewHeight.constant = 110
                    }
                    
                    
                }
                
                return cell
           // }
          //  else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.addonsCellId, for: indexPath as IndexPath) as! ReviewAddonsCell
//                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
//                let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
//                let animalId = UserDefaults.standard.value(forKey: "animalId") as? Int ?? 0
//                let productId = UserDefaults.standard.value(forKey: "productId") as? Int ?? 0
//                let addonsArray = ((fetchSubProductDataDairyreview(productId: productId,animalTag: animalId,orderId:orderId,userId:userId, status: "true") as? [SubProductTbl])!)
//                let addon = addonsArray[indexPath.row - 1]
//                cell.addontitle.text = addon.adonName
//                return cell
            //    }
                
            }
        }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if UIDevice().userInterfaceIdiom == .pad {
            return UIEdgeInsets(top: 15.0,left: 15.0,bottom: 15.0,right: 0)
        } else {
            return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let itemWidth = collectionView.frame.size.width / 2 - 30

        guard isPad else {
            return CGSize(width: itemWidth, height: 35)
        }

        var countsArray: [Int] = []

        if let marketName = UserDefaults.standard.string(forKey: keyValue.name.rawValue),
           marketName == marketNameType.Beef.rawValue {
            countsArray = ProductArrayBeef.map {
                let subproducts = fetchSubProductDataTrueBeef(
                    entityName: Entities.subProductBeefTblEntity,
                    productId: Int($0.productId),
                    animalTag: $0.animalTag ?? "",
                    status: "true",
                    orderId: Int($0.orderId),
                    userId: Int($0.userId)
                ) as? [SubProductTblBeef] ?? []
                return subproducts.count
            }
        } else {
            countsArray = ProductArray.map {
                let subproducts = fetchSubProductDataDairyreview(
                    productId: Int($0.productId),
                    animalTag: Int($0.animalId),
                    orderId: Int($0.orderId),
                    userId: Int($0.userId),
                    status: "true"
                ) as? [SubProductTbl] ?? []
                return subproducts.count
            }
        }

        if countsArray.isEmpty {
            return CGSize(width: itemWidth, height: 70)
        }

        // 🔁 Ensure consistent height between both items in a row
        let item = indexPath.item
        let pairIndex = item % 2 == 0 ? item + 1 : item - 1

        let currentCount = countsArray[safe: item] ?? 0
        let pairCount = countsArray[safe: pairIndex] ?? 0
        let maxCount = max(currentCount, pairCount)

        let height: CGFloat = maxCount == 0 ? 70 : maxCount > 3 ? 200 : 150

        return CGSize(width: itemWidth, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if UIDevice().userInterfaceIdiom == .pad {
//           // return CGSize(width: 180, height: 60)
//          var countsArray = [Int]()
//           
//            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
//                for (index,_) in ProductArrayBeef.enumerated() {
//                    let addonsArrayBeef = (fetchSubProductDataTrueBeef(entityName:Entities.subProductBeefTblEntity,productId: (Int(ProductArrayBeef[indexPath.row].productId)),animalTag: ProductArrayBeef[indexPath.row].animalTag ?? "", status: "true",orderId:Int(ProductArrayBeef[indexPath.row].orderId),userId:Int(ProductArrayBeef[indexPath.row].userId)) as? [SubProductTblBeef])!
//                        countsArray.append(addonsArrayBeef.count)
//                        
//                    }
//            }
//            else {
//                for (index,_) in ProductArray.enumerated() {
//                    let addonsArray = ((fetchSubProductDataDairyreview(productId: Int(ProductArray[index].productId),animalTag: Int(ProductArray[index].animalId),orderId:Int(ProductArray[index].orderId),userId:Int(ProductArray[index].userId), status: "true") as? [SubProductTbl])!)
//                    countsArray.append(addonsArray.count)
//                    
//                }
//            }
//            if countsArray.count == 0 {
//                return CGSize(width: collectionView.frame.size.width / 2 - 30, height: 70)
//            }
//            let heightValue: Double = (countsArray[indexPath.item] == 0) ? 150 : (countsArray.max() ?? 0 > 3 ? 200 : 150)
//           
//            return CGSize(width: collectionView.frame.size.width / 2 - 30, height: heightValue)
//        }
//        else {
//            return CGSize(width: collectionView.frame.size.width / 2 - 30, height: 35)
//        }
//    }
    
    //MARK: TEXTFIELD DELEGATES
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            self.dealerCodeView.isHidden = false
            self.dealerCodeView.isUserInteractionEnabled = true
            self.dealerCodeView.alpha = 1
            self.dealerCodeView.backgroundColor = UIColor(displayP3Red: 255/255, green: 224/255, blue: 203/255, alpha: 1.0)
            self.dealerCodeLabel.text = textField.text
            self.addDealerCodeTxtField.isHidden = true
            UserDefaults.standard.setValue(textField.text, forKey: keyValue.dealerCode.rawValue)
            textField.text = ""
        }
        else {
            self.addDealerCodeTxtField.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {
            return true
        }
        let ACCEPTABLE_CHARACTERS = LocalizedStrings.alphaNumericFormat
        let check  = ACCEPTABLE_CHARACTERS.contains(string)
        if check == false {
          return false
        }
        let maxLength = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}




