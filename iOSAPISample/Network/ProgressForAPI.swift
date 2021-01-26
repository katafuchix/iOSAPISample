//
//  ProgressForAPI.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/03/11.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import Foundation
import SVProgressHUD

open class ProgressForAPI {

    var startMessage: String?
    var successMessage: String?
    var errorMessage: String?
    var isDismiss: Bool = false

    public init() {
        self.startMessage       = ""
        self.successMessage     = ""
        self.errorMessage       = ""
    }

    public init(startMessage: String? = nil,
                successMessage: String? = nil,
                errorMessage: String? = nil,
                isDismiss: Bool = false) {

        self.startMessage = startMessage
        self.successMessage = successMessage
        self.errorMessage = errorMessage
        self.isDismiss = isDismiss
    }

    func showStart() {
        SVProgressHUD.show(withStatus: startMessage)
    }

    func showSuccess() {
        if isDismiss {
            SVProgressHUD.dismiss()
            return
        }
        SVProgressHUD.showSuccess(withStatus: successMessage)
    }

    func showError(error: APIError) {
        if isDismiss {
            SVProgressHUD.dismiss()
            return
        }

        if let message = errorMessage {
            SVProgressHUD.showError(withStatus: message)
        } else {
            SVProgressHUD.showError(withStatus: error.description)
        }
    }

    func dismiss() {
        SVProgressHUD.dismiss()
    }
}
