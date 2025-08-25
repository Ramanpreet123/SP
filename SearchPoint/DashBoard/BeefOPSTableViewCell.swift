//
//  BeefOPSTableViewCell.swift
//  SearchPoint
//
//  Created by "" on 14/03/2020.
//

import UIKit

//MARK: BEEF OPS TABLE VIEW CELL
class BeefOPSTableViewCell: UITableViewCell {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var deleteBttn: UIButton!
    @IBOutlet weak var OfficialId: UILabel!
    @IBOutlet weak var OnFarmId: UILabel!
    @IBOutlet weak var Barcode: UILabel!
    @IBOutlet weak var vollView: UICollectionView!
    @IBOutlet weak var barcodeTitle: UILabel!
    @IBOutlet weak var earTagTtitle: UILabel!
    @IBOutlet weak var farmIdTitle: UILabel!
    @IBOutlet weak var farmidTitleBottom: NSLayoutConstraint!
    @IBOutlet weak var rgdTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var rgdColonheight: NSLayoutConstraint!
    @IBOutlet weak var rgdLbl: UILabel!
    @IBOutlet weak var farmIdColonHeight: NSLayoutConstraint!
    @IBOutlet weak var rgdOrAnimalId: UILabel!
    
    //MARK: VARIABLES
    var arr2 :[String]?

    //MARK: AWAKE FROM NIB
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
