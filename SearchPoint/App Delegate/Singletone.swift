//
//  Singletone.swift
//  SearchPoint
//
//  Created by Yamini Sunkara on 1/9/22.
//

import Foundation
class Singleton {
    var name:String?
    var isfilter = true
    static let shared = Singleton()
    
    private init() {
        
    }
}
