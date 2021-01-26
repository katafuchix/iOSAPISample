//
//  Define.swift
//  P3
//
//  Created by ahihi on 11/14/18.
//  Copyright © 2018 ahihi. All rights reserved.
//

import Foundation
//import Firebase
//import FirebaseRemoteConfig

struct Mitsu {

    /// 開発版モード
    /// - Budle ID: 開発版
    /// - API接続先: 開発環境
    ///
    static var DEBUG: Bool {
        #if DEBUG || PAYMENT
        // DEBUG、PAYMENTが定義されていたら開発モード
        return true
        #else
        return false
        #endif
    }

    /// 課金試験モード
    /// - Budle ID: 製品版
    /// - API接続先: 開発環境
    ///
    static var PAYMENT: Bool {
        #if PAYMENT
        // PAYMENTが定義済みの場合のみ、課金試験モード
        return true
        #else
        return false
        #endif
    }

    /// 製品版モード
    /// - Budle ID: 製品版
    /// - API接続先: 本番環境
    ///
    static var PRODUCTION: Bool {
        #if PRODUCTION
        // PRODUCTIONが定義済みの場合のみ製品版モード
        return true
        #else
        return false
        #endif
    }

    /**
     GoogleService-Info.plist path
     */
    static var GoogleServiceInfoPlistPath: String {
        if Mitsu.DEBUG {
            return Bundle.main.path(forResource: "GoogleService-Info-Develop", ofType: "plist")!
        } else {
            return Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        }
    }

    static let ProductionURL = "https://api.mitsumitsu-app.com/"
    static let StagingURL = "http://api-staging.mitsumitsu-app.com/"
    //static let StagingURL = "http://localhost:3000/"
    
    /// Base URL
    static var BaseURL: String {
        if Mitsu.DEBUG {
            return self.StagingURL
        } else {
            return self.ProductionURL
        }
    }

    static let BaseURLHost = URL(string: Mitsu.BaseURL)?.host
    
    static let ProductionWebSocketURL = "https://ws.mitsumitsu-app.com"
    static let StagingWebSocketURL = "http://ws-staging.mitsumitsu-app.com"
    
    /// WebSocket
    static var WebSocketURL: String {
        if Mitsu.DEBUG {
            return self.StagingWebSocketURL
        } else {
            return self.ProductionWebSocketURL
        }
    }
    
    /// Purchase receipt verify url (Sandbox)
    static let AppPurchaseSandboxVerifyURL = "https://sandbox.itunes.apple.com/verifyReceipt"
    
    /// InAppPurchase secret key
    static let InAppPurchaseSecret = "55cd675e2c0e48d6a340c0a5a202cad1"

    static let LPURL = "http://lp.mitsumitsu-app.com/"

    // 希望しない
    static let NOT_DESIRED_VALUE = -1
    static let NOT_DESIRED_TEXT  = "希望しない"
    static let MIN_POINT_VALUE   = 5000
    
    // 男性
    static let DEF_POINT_DRINKING_MAN  = 5000
    static let DEF_POINT_EATING_MAN    = 10000
    static let DEF_POINT_ROMANCE_MAN   = 20000

    /// App Store URL
    static let AppStoreURL = "itms-apps://itunes.apple.com/app/id1458068398"

    /// App Store URL (Erlier version)
    static let AppStoreEarlierURL = "itms-apps://itunes.apple.com/us/app/apple-store/id1458068398"

    /// App Store Review URL
    static let AppReviewURL = AppStoreURL + "?action=write-review"
    
    /// AppsFlyer
    static var appsFlyerDevKey: String {
        if Mitsu.DEBUG {
            return "5FwscjhFZLfhsTN2LNFVwS"
        } else {
            return "5FwscjhFZLfhsTN2LNFVwS"
        }
    }
    // itunes id
    static var appleAppID: String {
        if Mitsu.DEBUG {
            return "id1480520595"
        } else {
            return "id1458068398"
        }
    }

    // ランキングは有料会員のみ
    static var isRankingForPaidOnly : Bool = true
}


// MARK: - AIQUA
let AIQUA_APP_ID        = "aa0321b8a8454157636b"
let AIQUA_APP_GROUP     = "group.com.mitsumitsu-app"
let AIQUA_APP_ID_DEV    = "17d99c56985edd30232a"
let AIQUA_APP_GROUP_DEV = "group.com.mitsumitsu-app.dev"

// MARK: - Date format

let DATE_FORMAT_BIRTHDAY = "yyyy年MM月dd日"

// ポイントの種類
enum pointTextFieldTag: Int {
    case drinking = 1     // カフェ
    case eating         // 食事
    case romance        // 上質
}

// age_verification: 年齢確認, 0:未確認,1:確認中,2:確認済, 3:却下
enum ageVerificationStatus: Int {
    case not_verified = 0
    case verifying
    case verified
    case rejected
}

// unapproved: 0, approved: 1, rejected: 2
enum textVerificationStatus: Int {
    case unapproved = 0
    case approved
    case rejected
    
    var value: String {
        switch self {
        case .unapproved:
            return "審査中"
        case .approved:
            return "審査済"
        case .rejected:
            return "却下済"
        }
    }
}

//NONE:いいねなし, FROM_OFFER:いいね済み, OFFERED:被いいね済み, MATCHING: いいね成立
// 使っていない
enum offerRelation: Int {
    case none = 0
    case from_offer
    case offerd
    case matching

    var value: String {
        switch self {
        case .none:
            return "いいねなし"
        case .from_offer:
            return "いいね済み"
        case .offerd:
            return "被いいね済み"
        case .matching:
            return "いいね成立"
        }
    }
}

enum MeetingType: Int {
    case romance = 1 // おまかせ
    case eating      // 食事/お酒
    case drinking    // カフェ
    case undefine

    var text: String {
        switch self {
        case .romance:
            return "おまかせ"
        case .eating:
            return "食事／お酒"
        case .drinking:
            return "カフェ"
        case .undefine:
            return ""
        }
    }
    
}

enum MeetingTypeString: String {
    case romance // おまかせ
    case eating      // 食事/お酒
    case drinking    // カフェ
    case undefine

    var text: String {
        switch self {
        case .romance:
            return "おまかせ"
        case .eating:
            return "食事／お酒"
        case .drinking:
            return "カフェ"
        case .undefine:
            return ""
        }
    }
    
    // メッセージ用テキスト
    var messageText: String {
        switch self {
        case .romance:
            return "おまかせ"
        case .eating:
            return "食事/お酒"
        case .drinking:
            return "カフェ"
        case .undefine:
            return ""
        }
    }
}

// カレンダーリマインダ用
enum SCHEDULE_reminders: Int, CaseIterable {
    case one_hours_ago      //= "1_hours_ago"
    case on_that_day        //= "on_that_day"
    case previous_day       //= "previous_day"
    case three_days_ago     //= "3_days_ago"

    var text : String {
        switch self {
        case .one_hours_ago :    return "1時間前"
        case .on_that_day :      return "当日"
        case .previous_day :     return "前日"
        case .three_days_ago :   return "3日前"
        }
    }
    
    var value: String {
        switch self {
        case .one_hours_ago :    return "1_hours_ago"
        case .on_that_day :      return "on_that_day"
        case .previous_day :     return "previous_day"
        case .three_days_ago :   return "3_days_ago"
        }
    }
}

enum PROCESSING_STATUS: Int {
    // 0:アップロード中
    case uploading = 0
    // 1:エンコーディング中
    case encoding
    // 2:エンコーディング済み
    case encoded

    var text: String {
        switch self {
        case .uploading:
            return "アップロード中"
        case .encoding:
            return "エンコーディング中"
        case .encoded:
            return "エンコーディング済み"
        }
    }
}

// 一時保存用の仮URL
let TEMP_MOVIE_PATH = "\(NSTemporaryDirectory())TrimmedMovie.mp4"


enum POINT_HISTOARY: String {
  case purchase                  = "purchase"
  case bonus_register            = "bonus_register"
  case bonus_complete_profile    = "bonus_complete_profile"
  case used_create_offer         = "used_create_offer"
  case used_create_chat          = "used_create_chat"
  case increment_admin           = "increment_admin"
  case decrement_admin           = "decrement_admin"
  case bonus_login               = "bonus_login"
    
    var text: String {
        switch self {
            case .purchase:
                return "ポイント購入"
            case .bonus_register:
                return "会員登録ボーナス"
            case .bonus_complete_profile:
                return "プロフィール入力完了ボーナス"
            case .used_create_offer:
                return "会いたい送信"
            case .used_create_chat:
                return "チャット開始"
            case .increment_admin:
                return "管理画面からの付与"
            case .decrement_admin:
                return "管理画面での減算"
            case .bonus_login:
                return "ログインボーナス"
        }
    }
}

typealias closeClosure = () -> Void
