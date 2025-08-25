//
//  Untitled.swift
//  SearchPoint
//
//  Created by Rajni on 22/05/25.
//

import UIKit

protocol MyCollectionViewCellDelegate: AnyObject {
    func didTapHideButton(for tableIndexPath: IndexPath)
    func didTapShowButton(for tableIndexPath: IndexPath)
}
class IndexCardCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    weak var delegate: MyCollectionViewCellDelegate?
    var tableIndexPath: IndexPath?
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
