//
//  CommanInfoPopUpController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 01/04/21.
//

import UIKit

//MARK: COMMON INFO POP UP CONTROLLER
class CommanInfoPopUpController: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var infoTextLbl: UITextView!
    @IBOutlet weak var doneBtnOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var stringGetThroughArray = String()
    var langId = Int()
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTextLbl.text = stringGetThroughArray
        self.langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int ?? 1
        doneBtnOutlet.setTitle(ButtonTitles.closeText.localized, for: .normal)
    }
    
    //MARK: ib actions
    @IBAction func doneBtnClick(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
