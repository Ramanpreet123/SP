//
//  ReviewController_TermsVC.swift
//  SearchPoint
//
//  Created by "" 12/05/20.
//

import UIKit

//MARK: CLASS
class ReviewController_TermsVC: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var okBtnOutlet: UIButton!
    
    //MARK: VARIABLES
    var terms = ""
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        okBtnOutlet.setTitle(NSLocalizedString("Ok", comment: ""), for: .normal)
        self.textView.text = terms
        let attrs : [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15)]
        
        let attributedString = NSMutableAttributedString(string: terms, attributes: attrs)
        self.textView.attributedText = attributedString
        self.textView.isUserInteractionEnabled = true
        self.textView.isEditable = false
        self.textView.isSelectable = true
        
        self.textView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    
    //MARK: IB ACTIONS
    @IBAction func okayButtonAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
