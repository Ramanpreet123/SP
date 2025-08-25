//
//  ViewAnimalCell.swift
//  SearchPoint
//
//  Created by "" on 28/11/2019.
//

import UIKit

//MARK: VIEW ANIMAL CELL
class ViewAnimalCell: UITableViewCell {
    
    @IBOutlet weak var eartaginfoHeight: NSLayoutConstraint!
    @IBOutlet weak var officialIdLbl: UILabel!
    @IBOutlet weak var earTagLbl: UILabel!
    @IBOutlet weak var rgnTitle: UILabel!
    @IBOutlet weak var rgdTitleLabel: UILabel!
    @IBOutlet weak var rgdLbl: UILabel!
    @IBOutlet weak var rgdColonLbl: UILabel!
    @IBOutlet weak var sampleconLbl: UILabel!
    @IBOutlet weak var rgnLbl: UILabel!
    @IBOutlet weak var barcodetitle: UILabel!
    @IBOutlet weak var eartagHeight: NSLayoutConstraint!
    @IBOutlet weak var innnerView: UIView!
    @IBOutlet weak var farmIDLbl: UILabel!
    @IBOutlet weak var barcodeLbl: UILabel!
    @IBOutlet weak var barcodeTtileLbl: UILabel!
    @IBOutlet weak var onFarmIdTitle: UILabel!
    @IBOutlet weak var officalIdTitle: UILabel!
    @IBOutlet weak var thirdColonLbl: UILabel!
    @IBOutlet weak var dobTtileLbl: UILabel!
    @IBOutlet weak var dobTitle: UILabel!
    @IBOutlet weak var sexTitle: UILabel!
    @IBOutlet weak var sexTitleLbl: UILabel!
    @IBOutlet weak var sexColonLbl: UILabel!
    @IBOutlet weak var dobColonLbl: UILabel!
    @IBOutlet weak var rgdTtileBefLabel: UILabel!
    
    //MARK: UI METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setViewForBeef (){
        dobTtileLbl.isHidden = true
        dobTtileLbl.isHidden = true
        sexTitle.isHidden = true
        sexTitleLbl.isHidden = true
        sexColonLbl.isHidden = true
        dobColonLbl.isHidden = true
    }
    
}
