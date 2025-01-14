//
//  BeefConfilictOrdersCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 23/12/20.
//

import UIKit

// MARK: - BEEF CONFLICT ORDER CELL
class BeefConfilictOrdersCell: UITableViewCell {

    @IBOutlet weak var onFarmIdTitleLbl: UILabel!
    @IBOutlet weak var officalIdTitleLbl: UILabel!
    @IBOutlet weak var barcodeTitleLbl: UILabel!
    @IBOutlet weak var fourthTitleLbl: UILabel!
    @IBOutlet weak var onFarmIdLbl: UILabel!
    @IBOutlet weak var officalIdLbl: UILabel!
    @IBOutlet weak var barcodeLbl: UILabel!

    @IBOutlet weak var fourthLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
