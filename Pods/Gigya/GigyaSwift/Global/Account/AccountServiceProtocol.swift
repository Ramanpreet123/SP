//
//  IOCAccountServiceProtocol.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 21/04/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation

public protocol AccountServiceProtocol: AnyObject {
    var account: Any? { get set }

    var accountCacheTime: Int { get set }

    func getAccount<T: Codable>() -> T

    func setAccount<T: Codable>(newAccount: T) -> [String: AnyObject]

    func isCachedAccount() -> Bool

    func clear()
}
