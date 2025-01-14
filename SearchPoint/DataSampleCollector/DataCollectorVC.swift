//
//  DataCollectorVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 24/05/22.
//

import UIKit

//MARK: DATA COLLECTOR VC
class DataCollectorVC: UIViewController , ResponseDataCollectorApi {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblsampleCollector: UILabel!
    @IBOutlet weak var lblAddressHeader: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtSampleCollector: UITextField!
    @IBOutlet weak var txtaddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    
    //MARK: VARIABLES AND CONSTANTS
    var offline = Bool()
    var dataViewModel: DataCollectorViewModel!
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
//        txtSampleCollector.placeholder = ButtonTitles.pleaseEnterText.localized
//        setupUI()
//        setupLangaugeBR()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    //    initialNetworkCheck()
    }
    
    //MARK: INITIAL UI METHODS
    func setupUI() {
        txtSampleCollector.layer.cornerRadius = 22
        txtCity.layer.cornerRadius = 22
        txtaddress.layer.cornerRadius = 22
        txtZipCode.layer.cornerRadius = 22
        txtSampleCollector.clipsToBounds = true
        txtCity.clipsToBounds = true
        txtaddress.clipsToBounds = true
        txtZipCode.clipsToBounds = true
        txtSampleCollector.layer.borderWidth = 0.5
        txtCity.layer.borderWidth = 0.5
        txtaddress.layer.borderWidth = 0.5
        txtZipCode.layer.borderWidth = 0.5
        txtSampleCollector.layer.borderColor = UIColor.lightGray.cgColor
        txtCity.layer.borderColor = UIColor.lightGray.cgColor
        txtaddress.layer.borderColor = UIColor.lightGray.cgColor
        txtZipCode.layer.borderColor = UIColor.lightGray.cgColor
        btnCancel.layer.borderWidth = 0.5
        btnCancel.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        btnCancel.setTitleColor(UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1), for: .normal)
    }
    
    func setupLangaugeBR() {
        lblHeader.text = NSLocalizedString(ButtonTitles.orderSampleCollectors, comment: "")
        lblsampleCollector.text = NSLocalizedString(ButtonTitles.sampleCollectorsNeeded, comment: "") //
        lblAddressHeader.text = NSLocalizedString(ButtonTitles.pleaseEnterAddress, comment: "")
        txtSampleCollector.placeholder = NSLocalizedString(ButtonTitles.pleaseEnterText, comment: "")
        txtaddress.placeholder = NSLocalizedString(ButtonTitles.addressBlockText, comment: "")
        txtCity.placeholder = NSLocalizedString(ButtonTitles.cityText, comment: "")
        txtZipCode.placeholder = NSLocalizedString(ButtonTitles.zipCodeText, comment: "")
        btnCancel.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        btnSubmit.setTitle(NSLocalizedString(ButtonTitles.submitText, comment: ""), for: .normal)
    }
    
    func initialNetworkCheck() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.hideIndicator()
            self.offLineBtn.isUserInteractionEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc  func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            if offline == false {
                offline = true
            }
        } else {
            self.offLineBtn.isUserInteractionEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    // MARK: - IB ACTIONS
    @IBAction func showMenu(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func acnCancel(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func SubmitButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if txtSampleCollector.text == "" && txtaddress.text == "" && txtCity.text == "" && txtZipCode.text == "" {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
        }
        else if txtSampleCollector.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterSampleCollectors, comment: ""))
        }
        else if txtaddress.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterAddressBlock, comment: ""))
        }
        else if txtCity.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterCity, comment: ""))
        }
        else if txtZipCode.text == ""{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterZipCode, comment: ""))
        }
        else{
            self.CallAddCollectorApi()
        }
        
    }
    
    func CallAddCollectorApi() {
        dataViewModel =  DataCollectorViewModel(ref: self, callBack: navigateToAnotherVc)
        dataViewModel.delegate = self
    }
    
    func navigateToAnotherVc(){
        UserDefaults.standard.setValue(true, forKey: keyValue.collectorIdentifier.rawValue)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    func responseRecievedStatus(status: Bool) {}
}
