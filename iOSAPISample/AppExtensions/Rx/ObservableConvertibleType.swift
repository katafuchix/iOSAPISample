//
//  ObservableConvertibleType.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/28.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum RxResult<Response> {
    case succeeded(Response)
    case failed(Error)
}

extension ObservableConvertibleType {
    func resultDriver() -> Driver<RxResult<Element>> {
        return self.asObservable()
            .map { RxResult.succeeded($0) }
            .asDriver { Driver.just(RxResult.failed($0)) }
    }

    func materializeAsDriver() -> Driver<Event<Element>> {
        return self.asObservable()
            .materialize()
            .asDriver(onErrorDriveWith: .empty())
    }
}

