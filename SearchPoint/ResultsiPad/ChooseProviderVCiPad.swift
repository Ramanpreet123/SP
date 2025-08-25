//
//  ChooseProviderVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 27/05/25.
//

import Foundation
import UIKit

//MARK: CLASS
class ChooseProviderVCiPad: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var cdcbButton: UIButton!
    @IBOutlet weak var herdityButton: UIButton!
    @IBOutlet weak var datageneButton: UIButton!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var heightConstraint : NSLayoutConstraint!
    @IBOutlet weak var stackView : UIStackView!
    
    //MARK: VARIABLES AND CONSTANTS
    var isCDCBFound = Bool()
    var isDategeneFound = Bool()
    var isHerdityFound = Bool()
    var delegate : chosseProviderDelegate?
    var selectedValue = Int()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        titleLBL.text = LocalizedStrings.foundMultipleResults.localized
        cdcbButton.isHidden = !isCDCBFound
        datageneButton.isHidden = !isDategeneFound
        herdityButton.isHidden = !isHerdityFound
        if selectedValue == 2 {
            heightConstraint.constant = 250
        }
    }
    
    //MARK: IB ACTIONS
    @IBAction func cdbButtonAction(sender: UIButton){
        if sender.tag == 100 {
            self.delegate?.selectedProviderIndex(providerName: LocalizedStrings.clarifideCDCB)
        } else if sender.tag == 101{
            self.delegate?.selectedProviderIndex(providerName: LocalizedStrings.clarifideDataGene)
            
        } else if sender.tag == 102 {
            self.delegate?.selectedProviderIndex(providerName: LocalizedStrings.herdity)
        }
        self.dismiss(animated: true)
    }
}
