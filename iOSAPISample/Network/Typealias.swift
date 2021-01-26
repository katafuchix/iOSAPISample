//
//  Typealias.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation
import Alamofire

public typealias Json = [String : Any]
typealias TextAttrubutes = [NSAttributedString.Key : AnyObject]

typealias VoidClosure = (() -> Void)
typealias BoolClosure = ((Bool) -> Void)

typealias Parameters = [String : Any]
typealias HTTPMethod = Alamofire.HTTPMethod
typealias MultipartFormDataBlock = ((Alamofire.MultipartFormData) -> Void)

//typealias JSON = [String: Any]
