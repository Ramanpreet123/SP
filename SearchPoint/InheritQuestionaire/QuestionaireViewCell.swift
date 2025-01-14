//
//  QuestionaireViewCell.swift
//  SearchPoint
//
//  Created by "" 16/03/20.
//

import UIKit

class QuestionaireViewCell: UITableViewCell {
    
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var questionlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.radioButton.isUserInteractionEnabled = false
        self.questionlabel.isUserInteractionEnabled = false
        
        self.radioButton.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
