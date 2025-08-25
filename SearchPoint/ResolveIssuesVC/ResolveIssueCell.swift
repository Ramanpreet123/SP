//
//  ResolveIssueCell.swift
//  SearchPoint
//
//  Created by Avinash Singh on 26/10/19.
//  ""
//

import UIKit

//MARK: RESOLVE ISSUES CELL
class ResolveIssueCell: UITableViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var OfficialId: UILabel!
    @IBOutlet weak var barcode: UILabel!
    @IBOutlet weak var products: UILabel!
    @IBOutlet weak var actionRequired: UILabel!
    @IBOutlet weak var OnFarmId: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var actionRequired1: UILabel!
    @IBOutlet weak var earTagLabel: UILabel!
    @IBOutlet weak var serieLbl: UILabel!
    @IBOutlet weak var rgnLbl: UILabel!
    @IBOutlet weak var rgdLbl: UILabel!
    @IBOutlet weak var LabelOfficalId: UILabel!
    @IBOutlet weak var LabelOnFarmId: UILabel!
    @IBOutlet weak var LabelEarTag: UILabel!
    @IBOutlet weak var LabelBarcode: UILabel!
    @IBOutlet weak var LabelOrderId: UILabel!
    @IBOutlet weak var LabelProduct: UILabel!
    @IBOutlet weak var LabelStatus: UILabel!
    @IBOutlet weak var LabelActionRequired: UILabel!
    
    
    //MARK: AWAKE FROM NIB
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
   
}

