


//
//  ListingTableViewCell.swift
//  SearchPoint
//
//  Created by "" on 10/04/20.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var firstAnimalTag: UILabel!
    @IBOutlet weak var firstBarcode: UILabel!
    @IBOutlet weak var onFarmIdLbl: UILabel!
    
    @IBOutlet weak var secondAnimalTag: UILabel!
    @IBOutlet weak var secondBarcode: UILabel!
    
    @IBOutlet weak var thirdAnimalTag: UILabel!
    @IBOutlet weak var thirdBarcode: UILabel!

    
    @IBOutlet weak var titleBarcode: UILabel!
    @IBOutlet weak var earTagLbl: UILabel!
    
    @IBOutlet weak var thirdEartagTitleLbl: UILabel!
    
    
    @IBOutlet weak var onFarmTitleLbl: UILabel!
    @IBOutlet weak var officalIdTitleLbl: UILabel!
    @IBOutlet weak var barcodeTitleLbl: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
