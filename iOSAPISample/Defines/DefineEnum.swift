//
//  DefineEnum.swift
//  P3
//
//  Created by ahihi on 11/14/18.
//  Copyright © 2018 ahihi. All rights reserved.
//

import Foundation

//MARK: - Price of action (unit: point (balancePoint of User))
enum PRICE: Int {
    case BUY_MEDIA
    case OFFER
    case CHAT
    /*
    var value: Int {
        switch self {
        case .BUY_MEDIA:
            return User.get().isPremium ? 0 : (User.get().sex! == GENDER.MALE.rawValue ? 5 : 1)
        case .OFFER:
            return User.get().isPremium ? 0 : (User.get().sex! == GENDER.MALE.rawValue ? 1 : 0)
        case .CHAT:
            return User.get().isPremium ? 0 : (User.get().sex! == GENDER.MALE.rawValue ? 4 : 1)
        }
    }*/
}


enum GENDER:Int {
    case MALE = 1
    case FEMALE = 2
    
    var string: String {
        switch self {
        case .MALE:
            return "男性"
        case .FEMALE:
            return "女性"
        }
    }
    
    var en_string: String {
        switch self {
        case .MALE:
            return "male"
        case .FEMALE:
            return "female"
        }
    }
}

enum USER_TYPE: Int {
    case FACEBOOK = 1
    case PHONE = 2
}

enum MY_PAGE_SECTION: String {
    case IMAGE = "image"
    case ABOUT = "自己紹介"
    case TWEET = "つぶやき"
    case DESIRED_PLACE = "会いたい場所"
    case PROFILE = "基本プロフィール"
    case OFFER_CONTENT = "チケット"
    case HELP = "help"
    
    var index: Int {
        switch self {
        case .IMAGE: return 0
        case .ABOUT: return 1
        case .TWEET: return 2
        case .DESIRED_PLACE: return 3
        case .PROFILE: return 4
        case .OFFER_CONTENT: return 5
        case .HELP: return 6
        }
    }

    // テーブルセクション数
    static var count:Int {return MY_PAGE_SECTION.HELP.index+1}
}
enum MY_PAGE_CELL_PROFILE: String {
    case NAME = "ニックネーム"
    case AGE = "年齢"
    case HEIGHT = "身長"
    case LIVE_IN = "住んでいる地域"
    case BODY_TYPE = "体型"
    case INCOME = "年収"
    case SAKE = "お酒"
    case TABAKO = "タバコ"
    case JOB = " 職業"
    var index: Int {
        switch self {
        case .NAME:     return 0
        case .AGE:      return 1
        case .HEIGHT:   return 2
        case .LIVE_IN:  return 3
        case .BODY_TYPE: return 4
        case .INCOME:   return 5
        case .SAKE:     return 6
        case .TABAKO:   return 7
        case .JOB:      return 8
        }
    }
    static var count:Int {return MY_PAGE_CELL_PROFILE.JOB.index+1}
}

enum MY_PAGE_CELL_PROFILE_FEMALE: String {
    case NAME = "ニックネーム"
    case AGE = "年齢"
    case HEIGHT = "身長"
    case LIVE_IN = "住んでいる地域"
    case BODY_TYPE = "体型"
    //case INCOME = "年収"
    case SAKE = "お酒"
    case TABAKO = "タバコ"
    case JOB = " 職業"
    var index: Int {
        switch self {
        case .NAME:     return 0
        case .AGE:      return 1
        case .HEIGHT:   return 2
        case .LIVE_IN:  return 3
        case .BODY_TYPE: return 4
        //case .INCOME: return 5
        case .SAKE:     return 5
        case .TABAKO:   return 6
        case .JOB:      return 7
        }
    }
    static var count:Int {return MY_PAGE_CELL_PROFILE_FEMALE.JOB.index+1}
}

enum MY_PAGE_CELL_OFFER_CONTENT: String {
    case CAFE = "カフェ"
    case MEAL_SAKE = "食事／お酒"
    case HIGHT_QUALITY = "おまかせ"
    var index: Int {
        switch self {
        case .CAFE: return 0
        case .MEAL_SAKE: return 1
        case .HIGHT_QUALITY: return 2
        }
    }
    static var count:Int {return MY_PAGE_CELL_OFFER_CONTENT.HIGHT_QUALITY.index+1}
}


enum tabIndex: Int {
    case search = 0
    case offerList
    case message
    case calendar
    case myPage
}


enum LOGIN_STATUS: String {
    case online         = "オンライン"
    case in_24hours     = "24時間以内"
    case in_3days       = "3日以内"
    case in_a_week      = "1週間以内"
    case in_a_month     = "1ヶ月以内"
    case over_a_month   = "1ヶ月以上"
}

/*
 class LoginStatus < ActiveHash::Base
   include ActiveHash::Enum
   self.data = [
     { id: 1, disp_name: "オンライン", name: 'online', period: 3.hours },
     { id: 2, disp_name: "24時間以内", name: 'in_24hours', period: 24.hours },
     { id: 3, disp_name: "3日以内", name: 'in_3days', period: 3.days },
     { id: 4, disp_name: "1週間以内", name: 'in_a_week', period: 1.week },
     { id: 5, disp_name: "1ヶ月以内", name: 'in_a_month', period: 1.month },
     { id: 6, disp_name: "1ヶ月以上", name: 'over_a_month', period: nil }
   ]
   enum_accessor :name
 end
 */

enum MESSAGE_TYPE: String {
    case system_notification    = "system_notification"
    case conversation           = "conversation"
}

/*
 date_schedule_adjustment_initiated: Offer 時に候補日が指定されている場合に、メッセージルームに投稿されるシステム通知
 date_schedule_adjustment_rescheduled: スケジュール調整ワークフローで、再度候補日を提案した際に投稿されるシステム通知 (カレンダー対応第一弾ではこの通知は発生しません)
 date_schedule_adjustment_accepted: 候補日を承諾した際に投稿されるシステム通知
 date_schedule_adjustment_confirmed: 承諾された候補日で確定した際に投稿されるシステム通知
 date_schedule_adjustment_cancelled: スケジュール調整をキャンセルした場合に投稿されるシステム通知
 date_schedule_created: デート予定を手動登録した場合に投稿されるシステム通知
 date_schedule_updated: デート予定を更新した場合に投稿されるシステム通知
 date_schedule_removed: デート予定を削除した場合に投稿されるシステム通知
 date_schedule_review_requested: レビュー依頼時に投稿されるシステム通知
 */

enum EXTRA_TYPE: String {
    case date_schedule_adjustment_initiated     = "date_schedule_adjustment_initiated"
    case date_schedule_adjustment_rescheduled   = "date_schedule_adjustment_rescheduled"
    case date_schedule_adjustment_accepted      = "date_schedule_adjustment_accepted"
    case date_schedule_adjustment_confirmed     = "date_schedule_adjustment_confirmed"
    case date_schedule_adjustment_cancelled     = "date_schedule_adjustment_cancelled"
    case date_schedule_created          = "date_schedule_created"
    case date_schedule_updated          = "date_schedule_updated"
    case date_schedule_removed          = "date_schedule_removed"
    case date_schedule_review_requested = "date_schedule_review_requested"

    var message: String {
        switch self {
        case .date_schedule_adjustment_initiated     : return "date_schedule_adjustment_initiated"
        case .date_schedule_adjustment_rescheduled   : return "date_schedule_adjustment_rescheduled"
        case .date_schedule_adjustment_accepted      : return "date_schedule_adjustment_accepted"
        case .date_schedule_adjustment_confirmed     : return "date_schedule_adjustment_confirmed"
        case .date_schedule_adjustment_cancelled     : return "date_schedule_adjustment_cancelled"
        case .date_schedule_created          : return "date_schedule_created"
        case .date_schedule_updated          : return "date_schedule_updated"
        case .date_schedule_removed          : return "date_schedule_removed"
        case .date_schedule_review_requested : return "date_schedule_review_requested"
        }
    }
}
