//
//  OPSTableViewCell.swift
//  SearchPoint
//
//  Created by "" on 17/10/2019.
//  ""
//

import UIKit

//MARK: OPS TABLE VIEW CELL
class OPSTableViewCell: UITableViewCell {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var deleteBttn: UIButton!
    @IBOutlet weak var OfficialId: UILabel!
    @IBOutlet weak var OnFarmId: UILabel!
    @IBOutlet weak var Barcode: UILabel!
    @IBOutlet weak var vollView: UICollectionView!
    @IBOutlet weak var thirdColonLbl: UILabel!
    @IBOutlet weak var addOnProductsLbl: UILabel!
    @IBOutlet weak var barcodeTitle: UILabel!
    @IBOutlet weak var earTagTtitle: UILabel!
    @IBOutlet weak var farmIdTitle: UILabel!
    @IBOutlet weak var farmidTitleBottom: NSLayoutConstraint!
    @IBOutlet weak var farmidHeight: NSLayoutConstraint!
    @IBOutlet weak var rgdTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var rgdColonheight: NSLayoutConstraint!
    @IBOutlet weak var rgdLbl: UILabel!
    @IBOutlet weak var onFarmIDTitle: UILabel!
    @IBOutlet weak var officalIdTitle: UILabel!
    @IBOutlet weak var barcodeTitleleft: UILabel!
    @IBOutlet weak var rgdOrAnimalID: UILabel!
    @IBOutlet weak var farmIdColonHeight: NSLayoutConstraint!
    
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
