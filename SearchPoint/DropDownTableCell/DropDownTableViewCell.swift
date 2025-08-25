//
//  DropDownTableViewCell.swift
//  MakeDropDown
//
//  Created by ems on 02/05/19.
//  Copyright © 2019 Majesco. All rights reserved.
//

import UIKit

//MARK: DROP DOWN TABLEVIEW CELL
class DropDownTableViewCell: UITableViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
