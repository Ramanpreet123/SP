//
//  ValidateDeviceController.swift
//  SearchPoint
//
//  Created by "" 29/04/20.
//

import UIKit


// MARK: - VALIDATE DEVICE CONTROLLER CLASS
class ValidateDeviceController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var pleaseEnterLabel: UILabel!
    @IBOutlet weak var codeGetFromEmailLabel: UILabel!
    @IBOutlet weak var firstDigit: UITextField!
    @IBOutlet weak var secondDigit: UITextField!
    @IBOutlet weak var thirdDigit: UITextField!
    @IBOutlet weak var fourthDigit: UITextField!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var didNotConnectLabel: UILabel!
    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var resendValidationOutlet: UIButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    var dataViewModelLogin:LoginViewModel!
    var dataModel: LoginModel?
    var delegate: ValidateDeviceControllerDelegate?
    var dataViewModel: ValidateDeviceViewModel!
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
    var validationCode = ""
    var codeTextFields: [UITextField]!
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as! Int
    var enteredOTP: String {
        var otp = ""
        
        for otpField in codeTextFields {
            otp += otpField.text!
        }
        validationCode  = otp
        return otp
    }
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        validateButton.isEnabled = false
        validateButton.alpha = 0.5
        UserDefaults.standard.set(false, forKey: keyValue.mustRegisterDevice.rawValue)
        codeGetFromEmailLabel.text = NSLocalizedString(LocalizedStrings.enterValidateCode, comment: "")
      //  self.validateButton.setTitle(NSLocalizedString(LocalizedStrings.validateDevice, comment: ""), for: .normal)
        self.configureTextFields()
        let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.resendCode, comment: ""), attributes: self.attrs)
        
        if UIDevice().userInterfaceIdiom == .phone {
            resendValidationOutlet.setAttributedTitle(attributeString, for: .normal)
            
        }
        subTitleLbl.text = NSLocalizedString(LocalizedStrings.checkSpamFolder, comment: "")
        
    }
    
    // MARK: - METHODS AND FUNCTIONS
    private func configureTextFields() {
      self.codeTextFields = [firstDigit, secondDigit, thirdDigit, fourthDigit]
      codeTextFields.forEach { textField in
          textField.delegate = self
          textField.font = textField.font?.withSize(30)
          textField.keyboardType = .phonePad
          textField.tintColor = .blue
         textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
      }
  }
    
    
    private func validateCode() {
        self.showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
        self.dataViewModel =  ValidateDeviceViewModel(ref: self, callBack: self.deviceValidateSuccess)
        self.dataViewModel.delegate = self
        self.dataViewModel.validateDevice(validationCode: validationCode)
    }
    
    func deviceRegisterSu(){
        self.view.makeToast(NSLocalizedString(LocalizedStrings.validationCodeSent, comment: ""), duration: 2, position: .bottom)
    }
    
    func showErrorMessageIfOTPIsInvalid() -> Bool {
        guard isValidOTP() else {
            CommonClass.showAlertMessage(self, titleStr: AlertMessagesStrings.alertString, messageStr: AlertMessagesStrings.enterValidationCode)
            return false
        }
        
        return true
    }
    
     func isValidOTP() -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if self.enteredOTP.count == 4 {
                self.validateButton.isEnabled = true
                self.validateButton.alpha = 1
            }else {
                self.validateButton.isEnabled = false
                self.validateButton.alpha = 0.5
            }
        }
        return enteredOTP.count == 4
    }
    
    // MARK: - IB ACTIONS
    @IBAction func validateCode(_ sender: UIButton) {
        if firstDigit.text == "" ||  secondDigit.text == "" || thirdDigit.text == "" ||  fourthDigit.text == "" {
            return
        }
        
        self.view.endEditing(true)
        guard self.showErrorMessageIfOTPIsInvalid() else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString,comment:""), messageStr: NSLocalizedString(AlertMessagesStrings.enterValidationCode, comment: ""))
            return
        }
        if Connectivity.isConnectedToInternet() {
            self.validateCode()
        }
        else {
            self.view.makeToast(NSLocalizedString(AlertMessagesStrings.noInternetConnected, comment: ""), duration: 2, position: .bottom)
            return
        }
    }
    
    @IBAction func resendValidationCode(_ sender: UIButton) {
        self.showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
        let validationModel = RegisterDeviceViewModel(callBack :self.deviceRegisterSu)
        validationModel.register()
        self.hideIndicator()
    }
}
