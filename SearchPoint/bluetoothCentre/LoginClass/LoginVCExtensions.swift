//
//  LoginVCExtensions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 07/02/24.
//

import Foundation

// MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension LoginViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == countryTableView {
            return countryArray.count
        }
        else {
            return langArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell ()
        cell.selectionStyle = .none
        if tableView == countryTableView {
            let country  = countryArray[indexPath.row]
            cell.textLabel!.text = country.localized as? String
        }
        else {
            let lang  = langArray[indexPath.row]
            cell.textLabel!.text = lang.localized as? String
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == droperTableView {
            let str = langArray[indexPath.row]
            languageLblOutlet.text = str
            let del = UIApplication.shared.delegate as? AppDelegate
            signInOutlet.setTitle(ButtonTitles.signInText, for: .normal)
          //  custoerBtnOutlet.setTitle(ButtonTitles.custSupportText, for: .normal)
            tableView.reloadData()
            del?.initialNetworkCheck()
            buttonPressed1()
        }
        else {
            switch indexPath.row {
            case 0:
             //  UAT "4_exyopvziJXGNbuqKvYcbzw" PROD "4_L--cXvkEWyIjuM9XOIlJrg"
                selectedApiKey = GigyaAPIKeys.ukAPIKey
                langArray.removeAll()
                langArray = [LanguageNames.englishUK]
                languageLblOutlet.text = LanguageNames.englishUK
                
            case 1:
                //  UAT "4_exyopvziJXGNbuqKvYcbzw" PROD "4_L--cXvkEWyIjuM9XOIlJrg"
                selectedApiKey = GigyaAPIKeys.ukAPIKey
                langArray.removeAll()
                langArray = [LanguageNames.englishUK, "Italian"]
                languageLblOutlet.text = LanguageNames.englishUK
                
            case 2:
                //  UAT "4_exyopvziJXGNbuqKvYcbzw" PROD "4_L--cXvkEWyIjuM9XOIlJrg"
                selectedApiKey = GigyaAPIKeys.ukAPIKey
                langArray.removeAll()
                langArray = [LanguageNames.englishUK, LanguageNames.netherland]
                languageLblOutlet.text = LanguageNames.englishUK
            
                
            case 3:
                //  UAT "4_I38N59hxBqQwKY30RJwy6g" PROD "4_i0BUr32vWPuNLzU8fArqcg"
                selectedApiKey = GigyaAPIKeys.usAPIKey
                langArray.removeAll()
                langArray = [LanguageNames.englishUSA, LanguageNames.spanish]
                languageLblOutlet.text = LanguageNames.englishUSA
                
            case 4:
                //  UAT "4_I38N59hxBqQwKY30RJwy6g" PROD "4_i0BUr32vWPuNLzU8fArqcg"
                selectedApiKey = GigyaAPIKeys.usAPIKey
                langArray.removeAll()
                langArray = [LanguageNames.englishUSA, LanguageNames.portuguese]
                languageLblOutlet.text = LanguageNames.englishUSA
                
            case 5, 6:
                //  UAT "4_C4hqAZvJCptAjErx_643wA" PROD "4_upnVzQfh44I-NbavSu5yTw"
                selectedApiKey = GigyaAPIKeys.ausAPIKey
                langArray.removeAll()
                langArray = [LanguageNames.englishUK]
                languageLblOutlet.text = LanguageNames.englishUK
                
            default:
                break
            }
            
            countryArray.removeAll()
            countryArray = [NSLocalizedString(CountryNames.unitedKingdom, comment: ""),NSLocalizedString(CountryNames.italy, comment: ""),NSLocalizedString(CountryNames.netherland, comment: ""), NSLocalizedString(CountryNames.usa, comment: ""), NSLocalizedString(CountryNames.brazil, comment: ""), NSLocalizedString(CountryNames.australia, comment: ""), NSLocalizedString(CountryNames.newZealand, comment: "")]
            let del = UIApplication.shared.delegate as? AppDelegate
            let country  = countryArray[indexPath.row]
            countryLblOutlet.text = country.localized
            tableView.reloadData()
            del?.initialNetworkCheck()
            countryButtonPressed()
        }
    }
    
}


// MARK: - TEXTFIELD DELEGATES
extension LoginViewController :UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}

// MARK: - REGISTER AND VALIDATE RESPONSE DELEGATES
extension LoginViewController : ResponseRegisterDeviceApi, ValidateDeviceControllerDelegate {
    func deviceRegisterSuccess() {
        var storyBoard = UIStoryboard()
        if UIDevice().userInterfaceIdiom == .pad {
            storyBoard = UIStoryboard(name: "iPad", bundle: nil)
        }
        else {
            storyBoard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        }
        self.hideIndicator()
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.validateDeviceController) as! ValidateDeviceController
        newViewController.dataModel = dataViewModel.modalObject
        newViewController.dataViewModelLogin = dataViewModel
        newViewController.delegate = self
        self.navigationController?.present(newViewController, animated: false, completion: nil)
    }
    
    func responseRecievedStatusForRegisterDevice(status:Bool) {
        self.hideIndicator()
        CommonClass.showAlertMessage(self, titleStr: AlertMessagesStrings.alertString.localized, messageStr: AlertMessagesStrings.somethingWromgAlert.localized)
    }
    
    func validateCodeSuccess() {
        
        if let termsStatusCheck = dataViewModel.modalObject?.agreedToTermsOfService {
            UserDefaults.standard.set(termsStatusCheck, forKey: keyValue.terms.rawValue)
        }
        
        if !UserDefaults.standard.bool(forKey: keyValue.terms.rawValue) {
            let popOverVC = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: ClassIdentifiers.terms_ConditionVC1) as! Terms_ConditionsVC
            popOverVC.dataModel = loginScreenSetViewModel.modalObject
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
        } else {
            UserDefaults.standard.set("true", forKey: keyValue.firstLogin.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.mustRegisterDevice.rawValue)
            if UserDefaults.standard.value(forKey: AlertMessagesStrings.alertString) as! String == "" {
                var storyBoard = UIStoryboard()
                if UIDevice().userInterfaceIdiom == .phone {
                     storyBoard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                }
                else {
                     storyBoard = UIStoryboard(name: "iPad", bundle: nil)
                }
                let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
                newViewController.dataModel = loginScreenSetViewModel.modalObject
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            else
            {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let newViewController11 = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.sucessAlertVC) as! Sucessalert
                newViewController11.dataModel = dataViewModel.modalObject
                self.navigationController?.pushViewController(newViewController11, animated: true)
            }
        }
    }
}

// MARK: - LOGIN API RESPONSE DELEGATES

extension LoginViewController : ResponseDelegate, ResponseLoginApi, LoginScreenSetApiResponse {
    func ssologoutMethod()
    {
        gigya.logout() { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    func responseRecievedForLoginScreenSet(status: Bool) {
        self.hideIndicator()
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidMailPwd, comment: ""))
        self.view.isUserInteractionEnabled = true
    }
    
    func showAlertMessage(message: String) {
        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(message, comment: ""))
        self.ssologoutMethod()
    }
    
    
    func responseRecievedStatusForLoginDevice(status: Bool, response: LoginModel?) {
        self.hideIndicator()
        
        CommonClass.showAlertMessage(
            self,
            titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""),
            messageStr: NSLocalizedString(AlertMessagesStrings.invalidMailPwd, comment: "")
        )
        
        self.view.isUserInteractionEnabled = true
    }
    func responseRecievedStatus(status: Bool) {
        if Connectivity.isConnectedToInternet() {
            if !status {
                CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:  NSLocalizedString(AlertMessagesStrings.invalidMailPwd, comment: ""))
                self.view.isUserInteractionEnabled = true
                hideIndicator()
                
            } else {
                self.view.isUserInteractionEnabled = false
            }
            
        } else {
            self.view.makeToast(NSLocalizedString(AlertMessagesStrings.noInternetConnected, comment: ""), duration: 2, position: .bottom)
            self.view.isUserInteractionEnabled = true
            hideIndicator()
        }
    }
    
    
    func responseRecieved(_ data: Data?, status: Bool) {
        
        if status {
            let decoder = JSONDecoder()
            modalObject = try? decoder.decode(LoginModel.self, from: data!)
            if modalObject != nil {
                saveLoginDat(dataModel: modalObject!)
            }
        }
        else {
            let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.authFailed, comment: ""), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                
                UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
                self.hideIndicator()
                
                self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                self.sideMenuViewController?.hideMenuViewController()
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
    }

}

