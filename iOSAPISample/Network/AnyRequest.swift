//
//  AnyRequest.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/28.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import Foundation
import Alamofire

class AnyRequest: Requestable {
    var url: MitsumitsuAPI
    let method: HTTPMethod
    let requestType: RequestType
    var parameters: Parameters
    var useCache: Bool

    init(_ url: MitsumitsuAPI,
         _ method: HTTPMethod = .get,
         _ requestType: RequestType = .normal,
         _ parameters: Parameters = [:],
         _ useCache: Bool = false) {
        self.url = url
        self.method = method
        self.requestType = requestType
        self.parameters = parameters
        self.useCache = useCache
    }
}

extension AnyRequest {

    static func get<T>(_ url: MitsumitsuAPI, _ parameters: Parameters = [:], _ mapper : @escaping ((Json) -> T?), _ completion: ((ExecuteResult<T?, APIErrorP>) -> Void)?) {
        AnyRequest(url, .get, .normal, parameters).execute(mapper, completion)
    }

    static var simpleResponseMapper: ((Json) -> SimpleResponse?) {
        return { json in return SimpleResponse(json: json) }
    }

    static func get(_ url: MitsumitsuAPI, _ parameters: Parameters = [:], _ completion: ((ExecuteResult<SimpleResponse?, APIErrorP>) -> Void)?) {
        //Log.d("url: \(url)")
        AnyRequest(url, .get, .normal, parameters).execute(self.simpleResponseMapper, completion)
    }

    static func post(_ url: MitsumitsuAPI, _ parameters: Parameters = [:], _ completion: ((ExecuteResult<SimpleResponse?, APIErrorP>) -> Void)?) {
        Log.d("url: \(url)")
        AnyRequest(url, .post, .normal, parameters).execute(self.simpleResponseMapper, completion)
    }
}

// MARK: プロフィール
extension AnyRequest {
/*
    private static func _profile(_ url: MitsumitsuAPI, parameters: Parameters = [:], _ completion: ((ExecuteResult<UserData?, APIErrorP>) -> Void)?) {
        let mapper: ((Json) -> UserData?) = { json in
            return UserData(json: json["data"] as! Json)
        }
        AnyRequest(url, .get, .normal, parameters).execute(mapper, completion)
    }

    static func login(_ phoneNumber: String, _ password: String, _ completion: ((ExecuteResult<String?, APIErrorP>) -> Void)?) {
        AnyRequest._login(MitsumitsuAPI.login(phone: phoneNumber, pass: password), completion)
    }

    private static func _login(_ url: MitsumitsuAPI, parameters: Parameters = [:], _ completion: ((ExecuteResult<String?, APIErrorP>) -> Void)?) {
        Log.d("url: \(url)")
        let mapper: ((Json) -> String?) = { json in
            return json["jwt"] as? String
        }
        AnyRequest(url, .post, .normal, parameters).execute(mapper, completion)
    }

    static func postLogin(_ url: MitsumitsuAPI, _ parameters: Parameters = [:], _ completion: ((ExecuteResult<SimpleResponse?, APIErrorP>) -> Void)?) {
        Log.d("url: \(url)")
        AnyRequest(url, .post, .normal, parameters).execute(self.simpleResponseMapper, completion)
    }
*/
    static var anyMapper: ((Json) -> Any?) {
        return { json in return json }
    }

}

