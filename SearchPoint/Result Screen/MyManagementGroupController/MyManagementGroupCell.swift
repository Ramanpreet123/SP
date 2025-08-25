//
//  MyManagementGroupCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 08/03/21.
//

import UIKit

class MyManagementGroupCell: UITableViewCell {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var barnBtnOutlet: UIButton!
    @IBOutlet weak var emailBtnOutlet: UIButton!
    @IBOutlet weak var deleteBtnOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
