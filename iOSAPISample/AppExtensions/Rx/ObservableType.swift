//
//  ObservableType.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/03/11.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {

    public func subscribeAPI(onNext: ((Self.Element) -> Swift.Void)? = nil,
                                onError: ((APIError) -> Swift.Void)? = nil,
                                onCompleted: (() -> Swift.Void)? = nil,
                                onDisposed: (() -> Swift.Void)? = nil) -> Disposable {
        return subscribe(
            onNext: { (data) in
                onNext?(data)
            },
            onError: { (error) in
                print(error)
                let e = error as! APIError
                Log.e(e.description)
                onError?(e)
            },
            onCompleted: {
                onCompleted?()
            },
            onDisposed: {
                onDisposed?()
            }
        )
    }

    public func subscribeAPIwithProgress(progress: ProgressForAPI = ProgressForAPI(),
                                         onNext: ((Self.Element) -> Swift.Void)? = nil,
                                            onError: ((APIError) -> Swift.Void)? = nil,
                                            onCompleted: (() -> Swift.Void)? = nil,
                                            onDisposed: (() -> Swift.Void)? = nil) -> Disposable {
        progress.showStart()

        return subscribe(
            onNext: { (data) in
                progress.showSuccess()
                onNext?(data)
            },
            onError: { (error) in
                print(error)
                let e = error as! APIError
                Log.e(e.description)
                progress.showError(error: e)
                onError?(e)
            },
            onCompleted: {
                onCompleted?()
            },
            onDisposed: {
                progress.dismiss()
                onDisposed?()
            }
        )
    }

}
