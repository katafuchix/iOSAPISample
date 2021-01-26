//
//  Requestable.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/28.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType {
    case normal
    case multipartFormData(encodingMemoryThreshold: UInt64, multipartFormDataBlock: MultipartFormDataBlock)
}

protocol Requestable {

    var url: MitsumitsuAPI { get }
    var method: HTTPMethod { get }
    var requestType: RequestType { get }
    var parameters: Parameters { get set }
    var useCache: Bool { get set }
}

protocol ResponseMappable {

    associatedtype Element

    func mapping(_ json: Json) -> Element?
}

protocol ResponseMergeable : ResponseMappable {

    associatedtype MergeType : Collection

    func merge(_ lhs: Self.MergeType?, rhs: Self.Element?) -> MergeType?
}

extension Requestable {

    func execute<T>(_ mapper : @escaping ((Json) -> T),_ completion: ((ExecuteResult<T, APIErrorP>) -> Void)?) {
        APIClient.request(self) { result in
            switch result {
            case .success(let v):
                completion?(.success(mapper(v)))
            case .failure(let e):
                completion?(.failure(e))
            }
        }
    }
}
