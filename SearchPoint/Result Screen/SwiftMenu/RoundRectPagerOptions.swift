//
//  RoundRectPageMenuOptions.swift
//  PageMenuExample
//
//  Created by Tamanyan on 3/10/29 H.
//  Copyright © 29 Heisei Tamanyan. All rights reserved.
//

import Foundation
import Swift_PageMenu

struct UnderlinePagerOption: PageMenuOptions {
    
    var isInfinite: Bool = false
    
    var menuItemSize: PageMenuItemSize {
        return .sizeToFit(minWidth: 80, height: 30)
    }
    
    var menuTitleColor: UIColor {
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
    }
    
    var menuTitleSelectedColor: UIColor {
        return UIColor.black
    }
    
    var menuCursor: PageMenuCursor {
        return .underline(barColor: UIColor.black, height: 2)
    }
    
    var font: UIFont {
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    var menuItemMargin: CGFloat {
        return 8
    }
    
    var tabMenuBackgroundColor: UIColor {
        return .white
    }
    
    public init(isInfinite: Bool = false) {
        self.isInfinite = isInfinite
    }
}
