//
//  OrdingProductSelectionCollectionViewCell.swift
//  SearchPoint
//
//  Created by "" on 02/10/2019.
//  ""
//

import UIKit

class OrdingProductSelectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var infoBtnOutlet: UIButton!
    @IBOutlet weak var Lbl: UILabel!
    
    var completionHandler : (() -> Void)? = nil
    
    @IBAction func infoButtonAction(_ sender: UIButton) {
        if let completion = completionHandler {
            completion()
        }
    }
}
