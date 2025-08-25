//
//  ConflicedImportListCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/12/20.
//

import UIKit

class ConflicedImportListCell: UITableViewCell {

    
    @IBOutlet weak var onFarmIdTitle: UILabel!
    @IBOutlet weak var officaialIdTitle: UILabel!
    @IBOutlet weak var barcodeTitle: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var farmIdLbl: UILabel!
    @IBOutlet weak var officialIdLbl: UILabel!
    @IBOutlet weak var barcodeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
