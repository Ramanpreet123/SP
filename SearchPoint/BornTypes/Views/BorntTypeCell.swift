//
//  BorntTypeCell.swift
//  SearchPoint
//
//  Created by "" 01/05/20.
//

import UIKit

class BorntTypeCell: UICollectionViewCell {

    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var bornTypeLabel: UILabel!
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleButton.setTitle("", for: .normal)
        self.titleButton.layer.cornerRadius = 19
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.bounds.size.width {
            case 375:
                buttonWidth.constant = 100
            case 414:
                buttonWidth.constant = 110
            default:
                break
            }
        }
    }

}
