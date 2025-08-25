//
//  ReviewOrderListVc.swift
//  SearchPoint
//

import Foundation
import UIKit


//MARK: CLASS
class ReviewOrderListVc: NSObject,UITextViewDelegate, objectPickfromConfilict {
    
    //MARK: VARIABLES
    var value = 0
    weak var delegateCustomNew : objectPickforcellDelegate?
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var set = [String]()
    var uniqueProductArray = Dictionary<String, [ProductAdonAnimalTbl]>()
    var uniqueProductArrayBeef = Dictionary<String, [ProductAdonAnimlTbLBeef]>()
    var itemSelection:String = ""
    var pricingLinkc :String?
    
    func firstLevel(check: Bool) {
        if !check {
            self.delegateCustomNew?.selectionObjectcell(check: true)
        }
        else if check  {
            self.delegateCustomNew?.selectionObjectcell(check: true)
        }
    }
    
    //MARK: TEXTVIEW DELEGATE
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "1"{
            
            let url =  NSURL(string: pricingLinkc ?? "")! as URL
            UIApplication.shared.open(url) { (Bool) in
                
            }
        }
        return true
    }
    
}

