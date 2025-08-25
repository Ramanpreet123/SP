//
//  animalDetailCell.swift
//  SearchPoint
//
//  Created by Rajni on 21/05/25.
//
import Foundation
import UIKit

class AnimalDetailCell: UITableViewCell {
    
    @IBOutlet weak var earTagLbl: UILabel!
    @IBOutlet weak var earTagValueLbl: UILabel!
    @IBOutlet weak var officialIdLbl: UILabel!
    @IBOutlet weak var officialIdValueLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dobValueLbl: UILabel!
    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var groupNameValueLbl: UILabel!
    @IBOutlet weak var breadLbl: UILabel!
    @IBOutlet weak var breadValueLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderValueLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var resultValueLbl: UILabel!
    @IBOutlet weak var orderDateLbl: UILabel!
    @IBOutlet weak var orderDateValueLbl: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
