//
//  NotesAndPhotosCell.swift
//  SearchPoint
//
//  Created by Rajni on 21/05/25.
//

import Foundation
import UIKit

class NotesAndPhotosCell: UITableViewCell {
    
    @IBOutlet weak var providerBtn: UIButton!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet weak var photosBtn: UIButton!
    @IBOutlet weak var banBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
