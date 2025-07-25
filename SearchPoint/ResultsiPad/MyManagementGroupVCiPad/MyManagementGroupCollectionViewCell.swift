//
//  MyManagementGroupCollectionViewCell.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 19/05/25.
//

import Foundation
import UIKit

class MyManagementGroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var barnBtnOutlet: UIButton!
    @IBOutlet weak var emailBtnOutlet: UIButton!
    @IBOutlet weak var deleteBtnOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
