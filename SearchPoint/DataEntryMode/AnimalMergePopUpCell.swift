//
//  AnimalMergePopUpCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 05/05/21.
//

import UIKit

class AnimalMergePopUpCell: UITableViewCell {
    
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var listDescriptionLbl: UILabel!
    @IBOutlet weak var crossBtnOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
