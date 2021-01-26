//
//  ExecuteResult.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//
// @see : https://github.com/antitypical/Result/blob/master/Result/Result.swift

import Foundation

enum ExecuteResult<T, Error: Swift.Error>: CustomStringConvertible, CustomDebugStringConvertible {
    case success(T)
    case failure(Error)

    init(value: T) {
        self = .success(value)
    }

    init(error: Error) {
        self = .failure(error)
    }

    init(_ value: T?, failWith: @autoclosure () -> Error) {
        self = value.map(ExecuteResult.success) ?? .failure(failWith())
    }

    init(_ f: @autoclosure () throws -> T) {
        self.init(attempt: f)
    }

    init(attempt f: () throws -> T) {
        do {
            self = .success(try f())
        } catch {
            self = .failure(error as! Error)
        }
    }

    func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }

    func analysis<Result>(ifSuccess: (T) -> Result, ifFailure: (Error) -> Result) -> Result {
        switch self {
        case let .success(value):
            return ifSuccess(value)
        case let .failure(value):
            return ifFailure(value)
        }
    }
}

// MARK: Error

extension ExecuteResult {

    static var errorDomain: String { return "net.skgroupinc.paters.ExecuteResult" }

    static var functionKey: String { return "\(errorDomain).function" }

    static var fileKey: String { return "\(errorDomain).file" }

    static var lineKey: String { return "\(errorDomain).line" }

    static func error(_ message: String? = nil, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        var userInfo: [String: Any] = [
            functionKey: function,
            fileKey: file,
            lineKey: line,
            ]

        if let message = message {
            userInfo[NSLocalizedDescriptionKey] = message
        }

        return NSError(domain: errorDomain, code: 0, userInfo: userInfo)
    }
}

// MARK: CustomStringConvertible

extension ExecuteResult {

    var description: String {
        return analysis(
            ifSuccess: { ".success(\($0))" },
            ifFailure: { ".failure(\($0))" })
    }
}

// MARK: CustomDebugStringConvertible

extension ExecuteResult {

    var debugDescription: String {
        return description
    }
}

