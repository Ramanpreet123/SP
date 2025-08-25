//
//  TipPopUp.swift
//  SearchPoint
//
//  Created by "" on 27/11/19.
//
//

import UIKit

class TipPopUp: UIView {
    
    @IBOutlet weak var elipseImage2: UIImageView!
    @IBOutlet weak var elipseImage1: UIImageView!
    @IBOutlet weak var arrow_Top: UIImageView!
    @IBOutlet weak var arrow_left: UIImageView!
    var delegate: offlineCustomView1?
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: ClassIdentifiers.tipPopUpNib, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
   
    
    @IBOutlet weak var textLbl2: UILabel!
    @IBOutlet weak var textLabel1: UILabel!
}
