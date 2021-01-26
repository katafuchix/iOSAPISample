//
//  Loading.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/27.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import UIKit
import SVProgressHUD

class Loading {
    class func start(statusString: String! = nil) {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show(withStatus: statusString)
        SVProgressHUD.show()
    }
    class func stop() {
        SVProgressHUD.dismiss()
    }
}
