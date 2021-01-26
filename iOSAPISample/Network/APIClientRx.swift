//
//  AppClient.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RxAlamofire
import RxSwift
import Reachability

struct APIClientRx {

    private static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        // Timeout
        configuration.timeoutIntervalForRequest = {
            if Mitsu.DEBUG {
                return 30
            } else {
                return 20
            }
        }()

        return Alamofire.SessionManager(configuration: configuration)
    }()

    private static var counter: Int = 0 {
        didSet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = (self.counter > 0)
        }
    }

    private static func json(method: HTTPMethod = .get,
                             api: API,
                             encoding: ParameterEncoding = URLEncoding.default,
                             headers: [String: String]? = nil) -> Observable<Any> {
        if NetworkReachabilityManager()!.isReachable == false {
            return Observable.error(APIError.notReachable)
        }

        counter += 1

        var authHeaders  = [
            "Authorization" : "" //(AccountData.jwt != nil) ? "Bearer \(AccountData.jwt!)" :  ""
        ]
        if let headers = headers {
            authHeaders = authHeaders.merging(headers, uniquingKeysWith: +)
        }

        print("Headers")
        print(authHeaders)

        return manager.rx.responseJSON(method,
                                       api.buildURL,
                                       parameters: api.parameters,
                                       encoding: encoding,
                                       headers: authHeaders)
            .debug()
            .catchError { error in
                counter = max(counter - 1, 0)
                let e = error as NSError
                if e.code == NSURLErrorTimedOut {
                    return Observable.error(APIError.timeout)
                }
                let res = Mapper<SimpleResponse>().map(JSONObject: json)
                return Observable.error(APIError.responseError(error as NSError, res))
            }
            .flatMap { (response, json) -> Observable<(HTTPURLResponse, Any)> in
                counter = max(counter - 1, 0)
                //if 200 ..< 300 ~= response.statusCode {
                if response.statusCode == 401 {
                    // 401を受け取ったらログアウト処理 認証がおかしい場合
                    //UtilManager.logout()
                    return Observable.just((response, json)) // 実行されない
                //} else if 200 ... 500 ~= response.statusCode {
                } else if 200 ..< 300 ~= response.statusCode {
                    return Observable.just((response, json))
                } else {
                    let res = Mapper<SimpleResponse>().map(JSONObject: json)
                    let error = ExecuteResult<Any, NSError>.error(res?.message)
                    return Observable.error(APIError.responseError(error as NSError, res))
                }
            }
            .map{ response, json in
                return json
        }
    }

    /// get Mappable Object
    static func get<T: Mappable>(api: API,
                                 encoding: ParameterEncoding = URLEncoding.default,
                                 headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .get, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let item: T = Mapper<T>().map(JSONObject: json) {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }

    /// get Mappable Array
    static func get<T: Mappable>(api: API,
                                 key: String?,
                                 encoding: ParameterEncoding = URLEncoding.default,
                                 headers: [String: String]? = nil) -> Observable<[T]> {
        return APIClientRx.json(method: .get, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<[T]> in
                if let key = key {
                    if let jsonObject = json as? [String: Any],
                        let jsonArray = jsonObject[key] as? [[String: Any]] {
                        let item: [T] = Mapper<T>().mapArray(JSONArray: jsonArray)
                        return Observable<[T]>.of(item)
                    }
                } else {
                    if let jsonArray = json as? [[String: Any]] {
                        let item: [T] = Mapper<T>().mapArray(JSONArray: jsonArray)
                        return Observable<[T]>.of(item)
                    }
                }

                if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                    return Observable.error(APIError.apiError(res))
                }
                return Observable.error(APIError.noResponseValue)
            }
            .observeOn(MainScheduler.instance)
    }

    /// get Value with Key
    static func getValue<T>(api: API,
                            key: String,
                            encoding: ParameterEncoding = URLEncoding.default,
                            headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .get, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let jsonObject = json as? [String: Any], let item = jsonObject[key] as? T {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }

    /// post, return Mappable Object
    static func post<T: Mappable>(api: API,
                                  encoding: ParameterEncoding = URLEncoding.default,
                                  headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .post, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let item: T = Mapper<T>().map(JSONObject: json) {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }

    /// post, return Value with Key
    static func post<T>(api: API,
                        key: String,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .post, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let jsonObject = json as? [String: Any], let item = jsonObject[key] as? T {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }

    /// post, return Optional Value with Key
    static func postOptional<T>(api: API,
                                key: String,
                                encoding: ParameterEncoding = URLEncoding.default,
                                headers: [String: String]? = nil) -> Observable<T?> {
        return APIClientRx.json(method: .post, api: api, encoding: encoding, headers: headers)
            .flatMap { (json) -> Observable<T?> in
                if let jsonObject = json as? [String: Any] {
                    let item = jsonObject[key] as? T
                    return Observable<T?>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
    }

    /// patch, return Mappable Object
    static func patch<T: Mappable>(api: API,
                                  encoding: ParameterEncoding = URLEncoding.default,
                                  headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .patch, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let item: T = Mapper<T>().map(JSONObject: json) {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }

    /// potch, return Value with Key
    static func patch<T>(api: API,
                        key: String,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .patch, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let jsonObject = json as? [String: Any], let item = jsonObject[key] as? T {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }

    /// delete, return Mappable Object
    static func delete<T: Mappable>(api: API,
                                   encoding: ParameterEncoding = URLEncoding.default,
                                   headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .delete, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let item: T = Mapper<T>().map(JSONObject: json) {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }
    
    /// delete, return Value with Key
    static func delete<T>(api: API,
                         key: String,
                         encoding: ParameterEncoding = URLEncoding.default,
                         headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.json(method: .delete, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (json) -> Observable<T> in
                if let jsonObject = json as? [String: Any], let item = jsonObject[key] as? T {
                    return Observable<T>.of(item)
                } else {
                    if let res = Mapper<SimpleResponse>().map(JSONObject: json) {
                        return Observable.error(APIError.apiError(res))
                    }
                    return Observable.error(APIError.noResponseValue)
                }
            }
            .observeOn(MainScheduler.instance)
    }

    /// mapping JSON Object
    static func mapping<T: Mappable>() -> ((Any) -> T?) {
        return { (json) -> T? in
            let item: T? = Mapper<T>().map(JSONObject: json)
            return item
        }
    }

    ///  mapping JSON Array
    static func mappingToArray<T: Mappable>() -> ((Any) -> [T]) {
        return { (json) -> [T] in
            let item: [T] = Mapper<T>().mapArray(JSONObject: json) ?? []
            return item
        }
    }
}

// MARK: - Swift 4, Codable対応版

extension APIClientRx {

    /// CodableにはDataが必要なので、
    /// json(method:,api:,encoding:,headers)を元にData返却版を作成
    /// - returns: 通信不達 → APIError.notReachable, その他エラー → APIError.responseError
    ///
    private static func data(method: HTTPMethod = .get,
                             api: API,
                             encoding: ParameterEncoding = URLEncoding.default,
                             headers: [String: String]? = nil) -> Observable<Data> {

        if NetworkReachabilityManager()!.isReachable == false {
            return Observable.error(APIError.notReachable)
        }

        counter += 1

        return manager.rx.responseData(method,
                                       api.buildURL,
                                       parameters: api.parameters,
                                       encoding: encoding,
                                       headers: headers)
            //.debug()
            .catchError { error in
                counter = max(counter - 1, 0)
                let e = error as NSError
                if e.code == NSURLErrorTimedOut {
                    return Observable.error(APIError.timeout)
                }
                let res = Mapper<SimpleResponse>().map(JSONObject: json)
                return Observable.error(APIError.responseError(error as NSError, res))
            }
            .flatMap { (response, data) -> Observable<Data> in
                counter = max(counter - 1, 0)
                if 200 ..< 300 ~= response.statusCode {
                    return Observable.just(data)
                } else {
                    let res = Mapper<SimpleResponse>().map(JSONObject: json)
                    let error = ExecuteResult<Any, NSError>.error(res?.message)
                    return Observable.error(APIError.responseError(error as NSError, res))
                }
        }
    }

    /// Codable対応のget
    ///
    static func get<T: Decodable>(api: API,
                                  encoding: ParameterEncoding = URLEncoding.default,
                                  headers: [String: String]? = nil) -> Observable<T> {
        return APIClientRx.data(method: .get, api: api, encoding: encoding, headers: headers)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { (data) -> Observable<T> in
                let decoder = JSONDecoder()
                do {
                    let item = try decoder.decode(T.self, from: data)
                    return Observable.just(item)
                }
                catch let error {
                    // ここはJSONパース失敗の処理です
                    return Observable.error(APIError.jsonError(error))
                }
            }
            .observeOn(MainScheduler.instance)
    }
}
