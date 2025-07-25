//
//  CustomerCell.swift
//  SearchPoint
//
//  Created by "" 05/06/20.
//

import UIKit

//MARK: CUSTOMER TABLEVIEW CELL
class CustomerCell: UITableViewCell {

    //MARK: IB OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: METHODS AND FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
