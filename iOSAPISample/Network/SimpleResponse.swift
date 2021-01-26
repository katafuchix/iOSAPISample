//
//  SimpleResponse.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation
import ObjectMapper

public struct SimpleResponse: JsonMappable, Mappable {
    
    var result: Bool = false
    var message: String = ""
    var error_code: Int?
    var jsonData: [String: Any] = [:]
    
    public init?(json: Json) {
        guard let result = json["result"] as? Bool else { return nil }
        self.result = result
        self.message = (json["message"] as? String) ?? ""
        self.error_code = json["error_code"] as? Int
        self.jsonData = json
    }
    
    public init?(map: Map) {
        guard map.JSON["result"] as? Bool != nil else { return nil }
    }
    
    mutating public func mapping(map: Map) {
        result      <- map["result"]
        message     <- map["message"]
        error_code  <- map["error_code"]
        for (key, value) in map.JSON {
            jsonData[key] = value
        }
    }
}

/*
public struct SimpleResponse: JsonMappable, Mappable {

    var result: Bool = false
    var message: String = ""
    var error_code: Int?
    var jsonData: Json = [:]
    var data: Json = [:]
    var error: Json = [:]

    public init?(json: Json) {
        guard let result = json["result"] as? Bool else { return nil }
        self.result = result
        self.message = (json["message"] as? String) ?? ""
        self.error_code = json["error_code"] as? Int
        self.jsonData = json
        self.data = json["data"] as? Json ?? [:]
        self.error = json["error"] as? Json ?? [:]
    }

    public init?(map: Map) {
        guard map.JSON["result"] as? Bool != nil else { return nil }
    }

    mutating public func mapping(map: Map) {

        result      <- map["result"]
        message     <- map["message"]
        error_code  <- map["error_code"]
        
        for (key, value) in map.JSON {
            jsonData[key] = value
        }
        data     <- map["data"]
        error    <- map["error"]
        message  <- map["error"]["message"]
    }
}
*/
