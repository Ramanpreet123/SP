//
//  ReviewOrderFilteriPadVC.swift
//  SearchPoint
//
//  Created by Rajni on 14/03/25.
//

import Foundation
import UIKit

class ReviewOrderFilteriPadVC: UIViewController{
    @IBOutlet weak var earTagButton: UIButton!
    @IBOutlet weak var earTagRadioImg: UIImageView!
    @IBOutlet weak var barcodeButton: UIButton!
    @IBOutlet weak var barcodeRadioImg: UIImageView!
    @IBOutlet weak var ascendingButton: UIButton!
    @IBOutlet weak var descendingButton: UIButton!
    
    var selectedField: String = "Barcode"
    var selectedOrder: String = "Ascending"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        earTagRadioImg.image = UIImage(named: "radioSeletedBtn")
        barcodeRadioImg.image = UIImage(named: "radioBtn")
        ascendingButton.backgroundColor = UIColor.init(hex: "#FF5C02")
        ascendingButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func fieldSelected(_ sender: UIButton) {
        if sender.tag == 1{
            earTagRadioImg.image = UIImage(named: "radioSeletedBtn")
            barcodeRadioImg.image = UIImage(named: "radioBtn")
            selectedField =  "Eartag"
        } else {
            earTagRadioImg.image = UIImage(named: "radioBtn")
            barcodeRadioImg.image = UIImage(named: "radioSeletedBtn")
            selectedField =  "Barcode"
        }
    }
    
    @IBAction func orderSelected(_ sender: UIButton) {
        if sender.tag == 100{
            ascendingButton.backgroundColor = UIColor.init(hex: "#FF5C02")
            ascendingButton.setTitleColor(UIColor.white, for: .normal)
            ascendingButton.tintColor = UIColor.white
            
            descendingButton.backgroundColor = UIColor.white
            descendingButton.setTitleColor(UIColor.black, for: .normal)
            descendingButton.tintColor = UIColor.black
            descendingButton.layer.borderWidth = 2
            descendingButton.layer.cornerRadius = 20
            descendingButton.layer.borderColor =  UIColor.init(red: 0/255, green: 109/255, blue: 123/255, alpha: 1.0).cgColor
        } else {
            descendingButton.backgroundColor = UIColor.init(hex: "#FF5C02")
            descendingButton.setTitleColor(UIColor.white, for: .normal)
            descendingButton.tintColor = UIColor.white
            
            ascendingButton.backgroundColor = UIColor.white
            ascendingButton.setTitleColor(UIColor.black, for: .normal)
            ascendingButton.tintColor = UIColor.black
            ascendingButton.layer.borderWidth = 2
            ascendingButton.layer.cornerRadius = 20
            ascendingButton.layer.borderColor =  UIColor.init(red: 0/255, green: 109/255, blue: 123/255, alpha: 1.0).cgColor
        }
        selectedOrder = sender.currentTitle ?? "Ascending"
    }
    
    func updateSelection() {
        earTagButton.isSelected = (selectedField == "Ear Tag")
        barcodeButton.isSelected = (selectedField == "Barcode")
        ascendingButton.isSelected = (selectedOrder == "Ascending")
        descendingButton.isSelected = (selectedOrder == "Descending")
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
