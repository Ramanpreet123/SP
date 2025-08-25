//
//  SideMenuTableViewCell.swift
//  SearchPoint
//
//  Created by Avinash Singh on 10/10/2019.
//  ""
//

import UIKit

//MARK: SIDE MENU TABLE VIEW CELL
class SideMenuTableViewCell: UITableViewCell {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
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
