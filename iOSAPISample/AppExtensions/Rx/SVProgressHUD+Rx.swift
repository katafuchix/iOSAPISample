//
//  SVProgressHUD+Rx.swift
//  mitsumitsu_iOS
//
//  Created by cano on 2020/01/21.
//  Copyright © 2020 Smart Routine Corp. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa

extension Reactive where Base: SVProgressHUD {
    static func isAnimating() -> AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            switch event {
            case .next(let value):
                if value {
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                }
            default:
                break
            }
        }
    }
}
