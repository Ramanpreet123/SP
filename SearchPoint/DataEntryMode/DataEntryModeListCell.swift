//
//  DataEntryModeListCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/12/20.
//

import UIKit

class DataEntryModeListCell: UITableViewCell {
    
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var listDesclabel: UILabel!
    @IBOutlet weak var emailButtonOutlet: UIButton!
    @IBOutlet weak var backrounView: UIView!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
