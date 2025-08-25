//
//  ProductwiseTermsCell.swift
//  SearchPoint
//
//  Created by "" 13/05/20.
//

import UIKit
import  WebKit

//MARK: PRODUCT WISE TERMS TABLEVIEW CELL
class ProductwiseTermsCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(htmlString: String) {
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
