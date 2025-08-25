//
//  OPSCollectionViewCell.swift
//  SearchPoint
//
//  Created by "" on 17/10/2019.
//  ""
//

import UIKit

class OPSCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var infoBtnOutlet: UIButton!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var addonInfoBtnOutlet: UIButton!

    
    var completionHandler : (() -> Void)? = nil
    
    @IBAction func infoButtonAction(_ sender: UIButton) {
        if let completion = completionHandler {
            completion()
        }
    }
    
}
