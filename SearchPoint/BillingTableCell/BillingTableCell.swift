//
//  BillingTableViewDelegate.swift
//  SearchPoint
//
//  Created by "" on 22/11/2019.
//

import Foundation
import Alamofire
import CoreData

//MARK: BILLING TABLE VIEW CELL
class BillingCell:UITableViewCell, UITextFieldDelegate{
    
    //MARK: OUTLETS
    @IBOutlet weak var dealerCodeView: UIView!
    @IBOutlet weak var addDealerCodeTextField: UITextField!
    @IBOutlet weak var addDealerCodeLabel: UILabel!
    @IBOutlet weak var addDealerCodeOutlet: UIButton!
    @IBOutlet weak var billingBtnOutlet: UIButton!
    @IBOutlet weak var nominatorLbl: UILabel!
    @IBOutlet weak var clarifideLbl: UILabel!
    @IBOutlet weak var submitOrderOutlet: UIButton!
    @IBOutlet weak var submitOrderAction: UIButton!
    @IBOutlet weak var bilingLLbl: UILabel!
    @IBOutlet weak var billingContactTitle: UILabel!
    @IBOutlet weak var reviewOrderBtnTitle: UIButton!
    @IBOutlet weak var lastReviewViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nominatorTitle: UILabel!
    @IBOutlet weak var evaluationTitle: UILabel!
    @IBOutlet weak var lastViewheight: NSLayoutConstraint!
    @IBOutlet weak var emailOrderBtnOutlet: UIButton!
    @IBOutlet weak var infoBtnEmailOutlet: UIButton!
    @IBOutlet weak var infooBtnSubmitOutlet: UIButton!
    @IBOutlet weak var infoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var reviewOrderBtnTtile: UIButton!
    @IBOutlet weak var billingContactLbl: UILabel!
    @IBOutlet weak var beefsubmitInfoBtn: UIButton!
    @IBOutlet weak var orderDefaultTtile: UILabel!
    @IBOutlet weak var editBtnOutlet: customButton!
    @IBOutlet weak var agreeLl: UILabel!
    @IBOutlet weak var termLbl: UILabel!
    @IBOutlet weak var termsBelowConstraint: NSLayoutConstraint!
    @IBOutlet weak var agreeInfoBtnOutelt: UIButton!
    @IBOutlet weak var submitBtnHeightConsraint: NSLayoutConstraint!
    @IBOutlet weak var emailOrderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var agreeLblHeightConsraint: NSLayoutConstraint!
    @IBOutlet weak var agreeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var pricingBtnOutlet: UIButton!
    @IBOutlet weak var priceLinklbl: UILabel!
    @IBOutlet weak var forInfoHeightConsraint: NSLayoutConstraint!
    @IBOutlet weak var beefEmaiInfoBtnOutlet: UIButton!
    @IBOutlet weak var beefEmailMeOutlet: UIButton!
    @IBOutlet weak var termsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pricingTextView: UITextView!
    @IBOutlet weak var placeAnotrderTitle: UILabel!
    @IBOutlet weak var emailMeEnterTtitle: UILabel!
    @IBOutlet weak var pricingHEIGHTconstraint: NSLayoutConstraint!
    @IBOutlet weak var emailMeSelectionTtile: UILabel!
    @IBOutlet weak var pricingTexthEIGHT: NSLayoutConstraint!
    @IBOutlet weak var agreeTextHeight: NSLayoutConstraint!
    @IBOutlet weak var beefEmailMeTopSelectionConstraint: NSLayoutConstraint!
    @IBOutlet weak var beefAggreeTopConstaraint: NSLayoutConstraint!
    @IBOutlet weak var termsInfoBtnOutlet: UIButton!
    @IBOutlet weak var beefPlaceanOrderCheckboxTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var beefEmailMeCheckboxHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var beefPlaceAnSelectionTitle: UILabel!
    @IBOutlet weak var beefPlaceSelectionOutlet: UIButton!
    @IBOutlet weak var emailCheckOutlet: UIButton!
    @IBOutlet weak var placeAnOutlet: UIButton!
    @IBOutlet weak var beefinfoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var beefEmailSelectionOutlet: UIButton!
    
    //MARK: VARIABLES
    weak var delegateCustom : objectPickfromConfilict?
    var dealerCodeLabel = UILabel(frame: CGRect(x: 8, y: 8, width: 150, height: 15))
    let image = UIImage(named: "cross")
    var button = UIButton(type: UIButton.ButtonType.custom)
    
    
    //MARK: AWAKE FROM NIB
    override func awakeFromNib() {
        self.button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.dealerCodeLabel.isUserInteractionEnabled = true
        self.dealerCodeLabel.addGestureRecognizer(tap)
        
        if infoBtnSelectionOutlet != nil {
            if ( UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  false ) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  nil ) {
                infoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            } else {
                UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
                infoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            }
        }
        
        if beefinfoBtnSelectionOutlet != nil {
            if ( UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  false ) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  nil ){
                beefinfoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            } else {
                UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
                beefinfoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            }
        }
        
        if UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String == nil{
            billingBtnOutlet.setTitle("N/A", for: .normal)
        }
        else {
            billingBtnOutlet.setTitle(UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String, for: .normal)
        }
        
        let clariText = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        clarifideLbl.text = "     " + (clariText ?? "")
        if UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String == nil || UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String == ""{
            nominatorLbl.text = "     Zoetis".uppercased()
        }
        else {
            let nomi = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
            nominatorLbl.text = "     " + nomi!.uppercased()
        }
        if lastViewheight != nil {
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
                lastViewheight.constant = 150
            }
            else{
                lastViewheight.constant = 150
            }
        }
        if lastReviewViewHeight != nil {
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
                lastReviewViewHeight.constant = 150
            }
            else{
                lastReviewViewHeight.constant = 150
            }
        }
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        self.addDealerCodeTextField.isHidden = false
        if dealerCode == "" || dealerCode == nil{
        } else {
            self.addDealerCodeTextField.delegate = self
            self.addDealerCodeTextField.text = dealerCode
            self.addDealerCodeTextField.becomeFirstResponder()
        }
        
    }
    
    @objc func buttonClicked(sender: UIButton) {
        let buttonRow = sender.tag
        self.dealerCodeLabel.text = ""
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        self.dealerCodeView.isHidden = true
        
        if UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool == false {
            self.addDealerCodeTextField.isHidden = false
            self.addDealerCodeTextField.layer.borderWidth = 1.0
            self.addDealerCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
            self.addDealerCodeTextField.layer.cornerRadius = 20.0
            self.addDealerCodeTextField.isHidden = false
        } else {
            self.addDealerCodeTextField.isHidden = true
        }
        
    }
    
    
    //MARK: IB ACTION METHODS
    @IBAction func emailCheckBoxAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 1
            }
            else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 0.6
            }
        }
        else if pviduser == 4 || pviduser == 6 || pviduser == 8{
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 1
            }
            else {
                if UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true {
                    sender.isSelected = false
                    emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                else {
                    sender.isSelected = true
                    emailCheckOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                    UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
                }
                placeAnOutlet.alpha = 0.6
            }
        }
    }
    
    @IBAction func placeAnAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
            sender.isSelected = false
            placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.placeOrderCheck.rawValue)
        }
        else {
            sender.isSelected = true
            placeAnOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            UserDefaults.standard.set(true, forKey: keyValue.placeOrderCheck.rawValue)
        }
        
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3  || pviduser == 10 || pviduser == 11 || pviduser == 12{
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                if pviduser == 3 {
                    if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                        placeAnOutlet.alpha = 1
                    }
                    else {
                        delegateCustom?.firstLevel!(check: false)
                    }
                }
                else {
                    if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
                        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                        placeAnotrderTitle.alpha = 1
                        emailMeEnterTtitle.alpha = 1
                        placeAnOutlet.alpha = 1
                    }else {
                        delegateCustom?.firstLevel!(check: false)
                    }
                }
            }
        }
        else if pviduser == 4 || pviduser == 6 || pviduser == 8 {
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
            }
            else {
                delegateCustom?.firstLevel!(check: false)
            }
        }
    }
    
    @IBAction func checkBoxBtnAction(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == true {
            sender.isSelected = false
            infoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
            
        } else {
            sender.isSelected = true
            infoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
    }
    
    @IBAction func beefcheckBoxBtnAction(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == true {
            sender.isSelected = false
            beefinfoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
            
        } else {
            sender.isSelected = true
            beefinfoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
    }
    
    @IBAction func beefEmailMeSelectionAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        sender.isSelected = true
        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
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
                beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                UserDefaults.standard.set(true, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            else {
                sender.isSelected = true
                beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                UserDefaults.standard.set(true, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            beefPlaceAnSelectionTitle.alpha = 0.6
            beefPlaceSelectionOutlet.alpha = 0.6
            beefEmailSelectionOutlet.alpha=1
        }
    }
    
    @IBAction func beefPlaceMeSelectionAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue))
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        
        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        if pviduser == 13 {
            UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
        }
        if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true {
            sender.isSelected = false
            beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
            addDealerCodeOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            self.addDealerCodeTextField.isHidden = true
            UserDefaults.standard.set(false, forKey: keyValue.addDealerCodeCheck.rawValue)
            addDealerCodeOutlet.isEnabled = false
            addDealerCodeLabel.alpha = 0.6
            addDealerCodeOutlet.alpha = 0.6
            self.dealerCodeView.alpha = 0.6
            self.dealerCodeView.isUserInteractionEnabled = false
        }
        else {
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
            
            addDealerCodeLabel.alpha = 1
            addDealerCodeOutlet.alpha = 1
        }
        
        if pviduser == 5 {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue {
                let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                
                if fetchAnimalTbl.count == 0 {
                    beefPlaceAnSelectionTitle.alpha = 1
                    beefPlaceSelectionOutlet.alpha = 1
                }
                else {
                    beefPlaceAnSelectionTitle.alpha = 0.6
                    beefPlaceSelectionOutlet.alpha = 0.6
                    beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    delegateCustom?.firstLevel!(check: true)
                }
            }
        }
        
        if pviduser == 7 || pviduser == 6 || pviduser == 13{
            let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
            if fetchAnimalTbl.count == 0 {
                beefPlaceAnSelectionTitle.alpha = 1
                beefPlaceSelectionOutlet.alpha = 1
            }
            else {
                beefPlaceAnSelectionTitle.alpha = 0.6
                beefPlaceSelectionOutlet.alpha = 0.6
                beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                delegateCustom?.firstLevel!(check: true)
            }
        }
    }
    
    @IBAction func addDealerCodeAction(_ sender: UIButton) {
        self.addDealerCodeTextField.delegate = self
        let placeOrderCheck = UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        if placeOrderCheck == true {
            if UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool == true {
                sender.isSelected = false
                addDealerCodeOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                UserDefaults.standard.set(false, forKey: keyValue.addDealerCodeCheck.rawValue)
              if dealerCode == "" || dealerCode == nil{
                DispatchQueue.main.async {
                    self.addDealerCodeTextField.text = ""
                    self.addDealerCodeTextField.setLeftPaddingPoints(10.0)
                    self.addDealerCodeTextField.layer.borderWidth = 1.0
                    self.addDealerCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
                    self.addDealerCodeTextField.layer.cornerRadius = 20.0
                    self.addDealerCodeTextField.isHidden = false
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
                self.addDealerCodeTextField.isHidden = true
              if dealerCode == "" || dealerCode == nil{ } else{
                self.dealerCodeView.alpha = 0.6
                self.dealerCodeView.isUserInteractionEnabled = false
              }
            }
        }
    }
    
    
    //MARK: TEXTFIELD DELEGATES
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            self.dealerCodeView.isHidden = false
            self.dealerCodeView.isUserInteractionEnabled = true
            self.dealerCodeView.alpha = 1
            self.dealerCodeView.backgroundColor = UIColor(displayP3Red: 255/255, green: 224/255, blue: 203/255, alpha: 1.0)
            self.dealerCodeLabel.text = textField.text
            self.addDealerCodeTextField.isHidden = true
            UserDefaults.standard.setValue(textField.text, forKey: keyValue.dealerCode.rawValue)
            textField.text = ""
        }
        else {
            self.addDealerCodeTextField.resignFirstResponder()
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
