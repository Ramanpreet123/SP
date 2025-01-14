//
//  SampleTrackingDetailCell.swift
//  SearchPoint
//
//  Created by "" on 08/11/19.
//  ""
//

import UIKit

class SampleTrackingDetailCell: UITableViewCell {
    
    @IBOutlet weak var orderIdBttn: customButton!
    @IBOutlet weak var officialIdTitleLabel: UILabel!
    @IBOutlet weak var officialIDLbl: UILabel!
    @IBOutlet weak var onFarmIdTitleLabel: UILabel!
    @IBOutlet weak var onFarm_IDLbl: UILabel!
    @IBOutlet weak var barcodeTitleLabel: UILabel!
    @IBOutlet weak var barcode_Lbl: UILabel!
    @IBOutlet weak var tableInnerview: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productInProgress: UILabel!
    @IBOutlet weak var earTagLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

