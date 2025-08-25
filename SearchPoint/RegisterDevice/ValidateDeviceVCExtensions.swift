//
//  ValidateDeviceVCExtensions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 07/02/24.
//

import Foundation

// MARK: - RESPONSE VALIDATE DEVICE API
extension ValidateDeviceController: ResponseValidateDeviceApi {
    func deviceValidateSuccess(){
        self.dismiss(animated: false, completion: nil)
        self.hideIndicator()
        self.delegate?.validateCodeSuccess()
    }
    
    func responseRecievedStatusForValidateDevice(status:Bool, response : ValidateDeviceModel?) {
        self.hideIndicator()
        if response != nil {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidValidationCode, comment: ""), duration: 2, position: .bottom)
        } else {
            if Connectivity.isConnectedToInternet() {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.deviceValidated, comment: ""), duration: 2, position: .bottom)
            }
            else {
                self.view.makeToast(NSLocalizedString(AlertMessagesStrings.noInternetConnected, comment: ""), duration: 2, position: .bottom)
            }
        }
    }
}

// MARK: - RESPONSE REGISTER DEVICE API
extension ValidateDeviceController: ResponseRegisterDeviceApi {
    func responseRecievedStatusForRegisterDevice(status: Bool) {
        self.hideIndicator()
        CommonClass.showAlertMessage(self, titleStr: AlertMessagesStrings.alertString, messageStr: LocalizedStrings.somethingWentWrong)
    }
}

// MARK: - TEXTFIELD DELEGATES
extension ValidateDeviceController: UITextFieldDelegate {
  @objc func textFieldDidChange(_ textField: UITextField) {
          guard let text = textField.text else { return }
          
          if text.count == 1 { // Move to the next field if 1 digit is entered
              if let nextTextField = nextTextField(after: textField) {
                  nextTextField.becomeFirstResponder()
              } else {
                  textField.resignFirstResponder() // Last field entered, dismiss keyboard
              }
          } else if text.count == 0 { // Move to the previous field on backspace
              if let previousTextField = previousTextField(before: textField) {
                  previousTextField.becomeFirstResponder()
              }
          }
      }
  func nextTextField(after textField: UITextField) -> UITextField? {
          if let index = codeTextFields.firstIndex(of: textField), index < codeTextFields.count - 1 {
              return codeTextFields[index + 1]
          }
          return nil
      }
      
      func previousTextField(before textField: UITextField) -> UITextField? {
          if let index = codeTextFields.firstIndex(of: textField), index > 0 {
              return codeTextFields[index - 1]
          }
          return nil
      }
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        _ = self.isValidOTP()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        _ = self.isValidOTP()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nextTextField = self.view.viewWithTag(textField.tag + 1) as? UITextField
        let previousTextField = self.view.viewWithTag(textField.tag - 1) as? UITextField
        if backSpaceIsPressedIfReplacementStringIs(string) && previousTextField != nil {
            textField.text = ""
            previousTextField?.becomeFirstResponder()
            return false
        }
        
        if nextTextField == nil && textField.text!.count > 0 {
            textField.resignFirstResponder()
            return false
        } else {
        }
        
        _ = self.isValidOTP()
        guard shouldWriteInNext(textField: nextTextField, WithTextInCurrentField: textField.text!, newText: string) else {
            return true
        }
        
        nextTextField!.text = string
        if nextTextFieldIsLastTextField(textField: nextTextField!) && isValidOTP() {
            DispatchQueue.main.async {
                textField.resignFirstResponder()
            }
            return false
        } else {
            nextTextField?.becomeFirstResponder()
        }
        return false
    }
    
    private func backSpaceIsPressedIfReplacementStringIs(_ string: String) -> Bool {
        return string == ""
    }
    
    private func shouldWriteInNext(textField: UITextField?, WithTextInCurrentField currentText: String, newText: String) -> Bool {
        return textField != nil && newText != "" && currentText.count >= 1
    }
    
    private func nextTextFieldIsLastTextField(textField: UITextField) -> Bool {
        let lastTextField = codeTextFields.last! as UITextField
        return textField == lastTextField
    }
}
