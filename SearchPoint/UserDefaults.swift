//
//  UserDefaults.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 21/06/22.
//

import Foundation

extension String{
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(with arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}

final class UserDefaultsHelper {
    static func setData<T>(value: T, key: keyValue) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    static func getData<T>(type: T.Type, forKey: keyValue) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    static func removeData(key: keyValue) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}
