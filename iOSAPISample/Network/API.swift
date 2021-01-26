//
//  API.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation

protocol API {
    var buildURL: URL { get }
    var parameters: [String: Any] { get }
}
