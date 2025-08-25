//
//  BillingTableViewCell.swift
//  SearchPoint
//
//  Created by "" on 08/11/19.
//  ""
//

import UIKit

//MARK: BILLING TABLEVIEW CELL CLASS
class BillingTableViewCell: UITableViewCell {

    //MARK: OUTLETS
    @IBOutlet weak var AddrLbl: UILabel!
    @IBOutlet weak var radioBtnOutlet: UIButton!
    @IBOutlet weak var radioBtnReview: UIButton!
    @IBOutlet weak var addressReviewLbl: UILabel!
    
    //MARK: AWAKE FROM NIB
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
