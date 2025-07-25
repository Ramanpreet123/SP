//
//  CustomCell.swift
//  DemoPageMeu
//
//  Created by Mobile Programming on 24/03/21.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameValueLbl: UILabel!
    @IBOutlet weak var buttonHide: UIButton!
    @IBOutlet weak var barnBtn: UIButton!
    @IBOutlet weak var dollarBtn: UIButton!
    @IBOutlet weak var notAssignedBtn: UIButton!
    @IBOutlet weak var barnImage: UIImageView!
    @IBOutlet weak var dollarImage: UIImageView!
    @IBOutlet weak var threeDot: UILabel!
    @IBOutlet weak var notAssignedLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
