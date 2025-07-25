//
//  RegisterTotpResolverProtocol.swift
//  GigyaTfa
//
//  Created by Shmuel, Sagi on 24/06/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation

protocol RegisterTotpResolverProtocol {
    func registerTotp(completion: @escaping (RegisterTotpResult) -> Void )
}
