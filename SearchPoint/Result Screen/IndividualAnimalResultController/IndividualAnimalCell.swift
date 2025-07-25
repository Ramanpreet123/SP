//
//  IndividualAnimalCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 15/03/21.
//

import UIKit

class IndividualAnimalCell: UICollectionViewCell {
    @IBOutlet weak var titleName: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected { //
               titleName.textColor = .black
            } else {
                titleName.textColor = .gray

            }
        }
    }
}

class IndividualAnimaltableCell: UITableViewCell {
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var hideBtnOutlet: UIButton!
}
