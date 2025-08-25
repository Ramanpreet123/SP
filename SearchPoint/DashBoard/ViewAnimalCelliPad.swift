//
//  ViewAnimalCelliPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 25/01/25.
//

import Foundation
//MARK: VIEW ANIMAL CELL
class ViewAnimalCelliPad: UICollectionViewCell {
    
    @IBOutlet weak var barcodeSeperator: UIView!
    @IBOutlet weak var deleteIcon: UIButton!
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
    
    var deleteAction:((_ string: String?) -> Void)?
    
    //MARK: UI METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setViewForBeef (){
        dobTtileLbl.isHidden = true
        dobTtileLbl.isHidden = true
        sexTitle.isHidden = true
        sexTitleLbl.isHidden = true
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        self.deleteAction?("")
    }
}
