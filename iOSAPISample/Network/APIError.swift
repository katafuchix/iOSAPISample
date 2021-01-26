//
//  APIError.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation

public enum APIError: Error, CustomStringConvertible {
    case notReachable
    case timeout
    case noResponseValue
    case apiError(SimpleResponse)
    case responseError(NSError, SimpleResponse?)
    /// CodableによるJSONパース失敗
    case jsonError(Error)

    public var description: String {
        switch self {
        case .notReachable:
            return "ネットワークに接続されていません。"
        case .timeout:
            return "通信がタイムアウトになりました。電波のいい場所で再度お試しいただくようお願いします。"
        case .apiError(let res):
            return res.message
        case .responseError( _, let res):
            if let r = res {
                if let mess = r.message as? String { //r.error["message"] as? String {
                    return mess
                }
                return "ネットワーク環境が不安定です。電波のいい場所で再度お試しいただくようお願いします。"
            } else {
                return "ネットワーク環境が不安定です。電波のいい場所で再度お試しいただくようお願いします。"
            }
        default:
            return "ネットワーク環境が不安定です。電波のいい場所で再度お試しいただくようお願いします。"
        }
    }

    var jsonData: Json? {
        switch self {
        case .apiError(let res):
            return res.jsonData
        case .responseError( _, let res):
            return res?.jsonData
        default:
            return nil
        }
    }
}
