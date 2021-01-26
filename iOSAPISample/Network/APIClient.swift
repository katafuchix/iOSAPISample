//
//  APIClient.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/28.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import Foundation
import Alamofire
//import Crashlytics

enum APIErrorP: Error, CustomStringConvertible {
    case notReachable
    case timeout
    case noResponseValue
    case apiError(SimpleResponse)
    case responseError(NSError)
    case encodingError(Error)
    case unknown

    // ユーザー表示用
    var description: String {
        switch self {
        case .notReachable:
            return "ネットワークに接続されていません。"
        case .timeout:
            return "通信がタイムアウトになりました。電波のいい場所で再度お試しいただくようお願いします。"
        case .apiError(let res):
            return res.message
        default:
            return "ネットワーク環境が不安定です。電波のいい場所で再度お試しいただくようお願いします。"
        }
    }

    var jsonData: Json? {
        switch self {
        case .apiError(let res):
            return res.jsonData
        default:
            return nil
        }
    }
}

struct APIClient {

    fileprivate static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        // Timeout
        if Mitsu.DEBUG {
            configuration.timeoutIntervalForRequest = 30
        } else {
            configuration.timeoutIntervalForRequest = 20
        }

        return Alamofire.SessionManager(configuration: configuration)
    }()

    fileprivate static var counter: Int = 0 {
        didSet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = (self.counter > 0)
        }
    }

    fileprivate init() {}

    static func request(_ request: Requestable, _ completion: ((ExecuteResult<Json, APIErrorP>) -> Void)? = nil) {

        if NetworkReachabilityManager()!.isReachable == false {
            completion?(.failure(.notReachable))
            return
        }

        let apiCompletion = self.wrappedCompletion(request.useCache, request, completion)
        let method = request.method
        //let url = request.url.urlString
        let url = request.url.buildURL
        self.counter += 1

        Log.d(url)
        Log.d(request.parameters)

        switch request.requestType {
        case .normal:
            // キャッシュがあればそれを返す
            if request.useCache {
                if let cache = APICache.loadCacheJSON(request) {
                    completion?(self.checkResponse(cache))
                } else {
                    var request = request
                    request.useCache = false
                }
            }
            self.manager.request(url,
                                 method: method,
                                 parameters: request.parameters,
                                 encoding: URLEncoding.default,
                                 headers: nil)
                .responseJSON() { response in
                    self.counter = max(self.counter - 1, 0)
                    apiCompletion(response)
            }
        case .multipartFormData(let threshold, let block):
            self.manager.upload(multipartFormData: block,
                                usingThreshold: threshold,
                                to: url,
                                method: request.method,
                                headers: nil){ encodingResult in
                                    self.counter = max(self.counter - 1, 0)
                                    switch encodingResult {
                                    case .success(let upload, _, _):
                                        upload.responseJSON(completionHandler: apiCompletion)
                                    case .failure(let error):
                                        completion?(.failure(.encodingError(error)))
                                    }
            }
        }
    }

    fileprivate static func wrappedCompletion(_ useCache: Bool, _ request: Requestable, _ completion: ((ExecuteResult<Json, APIErrorP>) -> Void)?) -> ((Alamofire.DataResponse<Any>) -> Void) {
        return { response in

            switch response.result {
            case .success(let value):
                if let v = value as? Json {
                    let res = self.checkResponse(v)

                    // キャッシュ処理
                    let _ = res.analysis(ifSuccess: { json in
                        let _ = APICache.cacheJSON(request, json: v)
                        return true
                    }, ifFailure: { error in
                        return false
                    })

                    completion?(res)
                } else {
                    completion?(.failure(.noResponseValue))
                }
            case .failure(let error):
                Log.e(error.localizedDescription)
                //Crashlytics.sharedInstance().recordError(error)
                completion?(.failure(.responseError(error as NSError)))
            }
        }
    }

    private static func checkResponse(_ json: Json) -> ExecuteResult<Json, APIErrorP> {
        guard let result = json["result"] as? Bool else { return .failure(.noResponseValue) }
        //guard let result = json["success"] as? Bool else { return .failure(.noResponseValue) }
        if result != true {
            if let res = SimpleResponse(json: json) {
                return .failure(.apiError(res))
            } else {
                return .failure(.noResponseValue)
            }
        }
        Log.d("checkResponse result")
        Log.d(json)
        return .success(json)
    }
}

