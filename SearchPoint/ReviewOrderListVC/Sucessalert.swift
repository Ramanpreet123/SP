//
//  Sucessalert.swift
//  SearchPoint
//
//  Created by yamini jyothsna on 03/06/22.
//

import Foundation
import UIKit


//MARK: CLASS
class Sucessalert: UIViewController{
    
    //MARK: OUTLETS
    @IBOutlet weak var textview: UILabel!
    @IBOutlet weak var Ackbutton: UIButton!
    
    //MARK: VARIABLES
    var dataModel:LoginModel?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: keyValue.lngId.rawValue) == 2{
            Ackbutton.setImage(UIImage.init(named: ImageNames.acknowledgeButton1Img), for: .normal)
        }
        Ackbutton.setTitle("", for: .normal)
        textview.text = UserDefaults.standard.value(forKey: AlertMessagesStrings.alertString) as? String
    }
    
    //MARK: IB ACTIONS
    @IBAction func Ackbutton(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func backbutton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
