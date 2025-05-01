//
//  SampleTrackingCell.swift
//  SearchPoint
//
//  Created by "" on 06/11/19.
//  ""
//

import UIKit

class SampleTrackingCell: UITableViewCell {

    @IBOutlet weak var bckGroundView: UIView!
    @IBOutlet weak var dateOrderedLbl: UILabel!
    @IBOutlet weak var packagedRecievedLbl: UILabel!
    @IBOutlet weak var sampleCountLbl: UILabel!
    @IBOutlet weak var orderIdBtnOutlet: UIButton!
    @IBOutlet weak var labelDateOrdered: UILabel!
    @IBOutlet weak var labelPackageRecievde: UILabel!
    @IBOutlet weak var labelSampleCount: UILabel!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
