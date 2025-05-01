//
//  DataListCellView.swift
//  SearchPoint
//
//  Created by Rajni on 13/03/25.
//

import Foundation
import UIKit
class DataListCollectionCellView: UICollectionViewCell {
    
    var checkAction:((_ string: String?) -> Void)?
    
    @IBOutlet weak var animalCountTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var animalCountLabel: UILabel!
    @IBOutlet weak var listDesclabel: UILabel!
    @IBOutlet weak var emailButtonOutlet: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var backrounView: UIView!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    
    
    @IBAction func checkAction(_ sender: Any) {
        self.checkAction?("")
    }
}
