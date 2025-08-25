//
//  ImportListCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 24/12/20.
//

import UIKit

//MARK: IMPORT LIST TABLEVIEW CELL
class ImportListCell: UITableViewCell {

    //MARK: IB OUTLETS
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var listNameDescLbl: UILabel!
    @IBOutlet weak var importCellBackrounfView: UIView!
    
    //MARK: AWAKE FROM NIB
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
