//
//  JsonMappable.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonMappable {

    init?(json: Json)
}

extension JsonMappable {

    init?(anyJson: Any?) {
        guard let anyJ = anyJson as? Json else { return nil }
        self.init(json: anyJ)
    }
}

extension JsonMappable {

    static func mapping(_ json: [Json]) -> [Self] {
        return json.compactMap { Self.init(json: $0) }
    }
}
