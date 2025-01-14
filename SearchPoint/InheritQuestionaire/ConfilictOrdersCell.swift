//
//  ConfilictOrdersCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 20/11/20.
//

import UIKit

// MARK: - CONFLICT ORDER CELL
class ConfilictOrdersCell: UITableViewCell {

    // MARK: - IB OUTLETS
    @IBOutlet weak var onFarmIdTitleLbl: UILabel!
    @IBOutlet weak var officalIdTitleLbl: UILabel!
    @IBOutlet weak var barcodeTitleLbl: UILabel!
    @IBOutlet weak var onFarmIdLbl: UILabel!
    @IBOutlet weak var officalIdLbl: UILabel!
    @IBOutlet weak var barcodeLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
