//
//  OfflinePopUp.swift
//  SearchPoint
//
//  Created by "" on 21/11/19.
//

import UIKit

protocol offlineCustomView {
    
    func crossBtnCall()
}


class OfflinePopUp: UIView {
    var delegate: offlineCustomView?
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var uperView: UIView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var offineTextViw: UITextView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: ClassIdentifiers.offlineViewNib, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func draw(_ rect: CGRect) {
        
        title.text = NSLocalizedString("Restrições offline", comment: "")
        NSLocalizedString(AlertMessagesStrings.alertString, comment: "")
        
        let arrayString = [NSLocalizedString(LocalizedStrings.orderStoredDuringOfflineMode, comment: ""), NSLocalizedString(LocalizedStrings.lastTimeActions, comment: ""), NSLocalizedString(LocalizedStrings.lastTimeSampleStates, comment: "")
                           
        ]
        offineTextViw.attributedText = add(stringList: arrayString, font: offineTextViw.font!, bullet: "•")
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        delegate?.crossBtnCall()
    }
    
    func add(stringList: [String],font: UIFont, bullet: String = "\u{2022}",indentation: CGFloat = 20,lineSpacing: CGFloat = 2,            paragraphSpacing: CGFloat = 12, textColor: UIColor = .black, bulletColor: UIColor = .black) -> NSAttributedString {
        
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for string in stringList {
            let formattedString = "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        return bulletList
    }
    
    
}
