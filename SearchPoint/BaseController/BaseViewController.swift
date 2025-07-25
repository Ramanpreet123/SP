//
//  BaseViewController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/06/22.
//

import UIKit

protocol BaseDataSources {
    func setUpClosures()
    func setUpView()
}

class BaseViewController: UIViewController {

    var baseVwModel: BaseViewModel? {
        didSet {
            initBaseModel()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    final func initBaseModel() {
        // Native binding
        baseVwModel?.showAlertClosure = { [weak self] (_ type: AlertType) in
            DispatchQueue.main.async {
                if type == .success, let message = self?.baseVwModel?.alertMessage {
                    if message.count > 0 {
                        let configAlert: AlertUI = ("", message)
                        UIAlertController.showAlert(configAlert)
                    }
                } else {
                    if let errorMessage = self?.baseVwModel?.errorMessage, errorMessage.count > 0 {
                        let configAlert: AlertUI = ("", errorMessage)
                        UIAlertController.showAlert(configAlert)
                    }
                }
            }
        }
        
        baseVwModel?.updateLoadingStatus = { [weak self] () in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                let isLoading = self.baseVwModel?.isLoading ?? false
                if isLoading == true {
                    DispatchQueue.main.async {
//                        MBProgressHUD.showAdded(to: self.view, animated: true)
                        print("Show Loader here")
                    }
                } else {
                    DispatchQueue.main.async {
//                        MBProgressHUD.hide(for: self.view, animated: true)
                        print("Show Loader here")
                    }
                }
            }
        }
    }
    /// This method would execute when user switches from dark mode to light or Vice-versa.
    /// You can use this method in your view controller as well if you have different checks according to your requirments.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
   }
}

/* extension BaseViewController {
    
    private func _storyboard() ->  UIStoryboard? {
        return UIStoryboard(name: Storyboards.main, bundle:nil)
    }
    
    func webViewController() -> UIViewController {
        if let viewC = _storyboard()?.instantiateViewController(withIdentifier: "WebViewVC") {
            return viewC
        }
        return UIViewController()
    }
    
    func mainStoryboardController(withIdentifier identifier: String) -> UIViewController {
        if let viewC = _storyboard()?.instantiateViewController(withIdentifier: identifier) {
            return viewC
        }
        return UIViewController()
    }
    
} */

extension UIViewController {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
}

enum ColorCompatibility {
    static var myOlderiOSCompatibleColorName: UIColor {
        if UIViewController().isDarkMode {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return UIColor.white
            }
        } else {
            return UIColor.white
        }
    }
}
