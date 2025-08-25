//
//  BeefProductsTableViewCell.swift
//  SearchPoint
//
//  Created by "" on 05/03/20.
//

import UIKit

class BeefProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var iiBttn: customButton!
    @IBOutlet weak var iBttn: customButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var radioBttn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
