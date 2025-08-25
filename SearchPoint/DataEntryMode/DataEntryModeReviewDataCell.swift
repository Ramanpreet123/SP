//
//  DataEntryModeReviewDataCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 15/12/20.
//

import UIKit



class DataEntryModeReviewDataCell: UITableViewCell {
    
    @IBOutlet weak var bckroundView: UIView!
    @IBOutlet weak var onFarmIdTitleLbl: UILabel!
    @IBOutlet weak var officalIdTitleLbl: UILabel!
    @IBOutlet weak var barcodeTitleLbl: UILabel!
    @IBOutlet weak var onFarmIdLbl: UILabel!
    @IBOutlet weak var officalIdLbl: UILabel!
    @IBOutlet weak var barcodeLbl: UILabel!
    @IBOutlet weak var fourthLbl: UILabel!
    @IBOutlet weak var fourthTitleLbl: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scanBarCodeButton: UIButton!
    @IBOutlet weak var enteredBarCodeView: UIView!
    @IBOutlet weak var txtFldBarCode: UITextField!
    @IBOutlet weak var barCodeTextView: UIView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var txtBarCodeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnScanCodeHeightConstraint: NSLayoutConstraint!
    
    var data: AnimalMaster?
    var delegate: ADHCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setAnimalData(animalData: AnimalMaster, index: Int) {
        self.data = animalData
        self.onFarmIdLbl.text = animalData.farmId
        self.officalIdLbl.text  = animalData.offsireId
        self.barView.isHidden = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
    
}
