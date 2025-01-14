//
//  MyTransformer.swift
//  SearchPoint
//
//  Created by Mobile Programming on 18/03/21.
//

import Foundation

/// Never Called!
@objcMembers public final class MyTransformer: ValueTransformer {

    public override init() {
        super.init()
        fatalError("Nevern gets executed")
    }
    public override class func transformedValueClass() -> AnyClass {
        fatalError("Nevern gets executed")
      
        return NSData.self
    }

    public override class func allowsReverseTransformation() -> Bool {
        fatalError("Nevern gets executed")
       
        return true
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        fatalError("Nevern gets executed")
       
        guard let string = value as? String else {return nil}
        return string.data(using: .utf8)
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        fatalError("Nevern gets executed")
      
        guard let data = value as? Data else {return nil}
        return String(data: data, encoding: .utf8)
    }
}

