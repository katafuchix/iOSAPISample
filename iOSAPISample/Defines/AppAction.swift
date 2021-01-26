//
//  AppAction.swift
//  P3
//
//  Created by NAVIGO-TUANNT on 1/15/19.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation
enum GO_TO_SCREEN: String {
    case NOF_MAIN                   = "mitsumitsuapp://splash"
    case NOF_LIST_OFFER             = "mitsumitsuapp://offers"
    case NOF_APPEAL                 = "mitsumitsuapp://tweets"
    case NOF_APPEAL_DETAIL          = "mitsumitsuapp://tweets?tweet_id"
    case NOF_MESSAGE_LIST           = "mitsumitsuapp://messages"
    case NOF_AGE_VERIFICATION       = "mitsumitsuapp://ageVerification"
    case APP_TUTORIAL               = "app://goToTutorial"
    case NONE                   = ""
     
    var index: Int {
        switch self {
        case .NOF_MAIN: return 0
        case .NOF_LIST_OFFER: return 1
        case .NOF_APPEAL: return 2
        case .NOF_APPEAL_DETAIL: return 21
        case .NOF_MESSAGE_LIST: return 3
        case .NOF_AGE_VERIFICATION: return 6
        case .APP_TUTORIAL: return 10
        default : return -1
        }
    }
    static let actionKey = "deep_link"
}
