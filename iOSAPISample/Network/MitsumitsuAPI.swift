//
//  MitsumitsuAPI.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation
import UIKit
import YMTGetDeviceName

enum MitsumitsuAPI: API {
    // 新API
    // ログイン
    case login(phone: String, pass: String)
    // SMSを生成する
    case sms(phone: String)
    // 電話番号を確定させる
    case phone(phone: String, sms: String)
    // 新規会員登録
    case member_regist(name: String, phone_number: String, sex: Int, birth_day: String, password: String, password_confirm: String)
    // プロフィール選択項目取得
    case items_profiles
    // プロフィール設定登録
    case members_profiles_basic(height: Int, body_type_id: Int, prefecture_id: Int, annual_income_id: Int, drinking_type_id: Int, smoking_type_id: Int, occupation_id: Int)
    // いいね内容入力
    case members_profiles_offer(romance_price_point: Int, eating_price_point: Int, drinking_price_point: Int)
    // お気に入り登録
    case members_add_favorite(member_id: Int)
    // お気に入り削除
    case members_delete_favorite(member_id: Int)
    // お気に入りしたユーザ一覧を取得
    case favorites(page: Int)
    // プロフィール写真のアップロード
    case members_profiles_assets(image: UIImage)
    // 20文字以内でつぶやきを登録
    case members_profiles_tweet(tweet: String)
    // 紹介文を登録
    case members_profiles_intro(introduction: String)
    // お問い合わせカテゴリー項目
    case items_inquiry_categories
    // お問い合わせ
    case inquiry(inquiry_category_id: Int, content：: String, email: String, images: [UIImage])
    // ログイン後に表示されるおすすめ女性・男性のデータを取得する。
    // メンバー一覧
    case members(page: Int)
    // 現在のパスワード確認
    case settings_passwords_verification(password: String)
    // パスワード変更 PATCH
    case settings_password(password: String)
    // 年齢認証用のファイルをアップロードする
    case members_age_verification(image: UIImage)
    // 今日会いたい PATCH Toggle
    case todays_member
    // お知らせの一覧を取得する
    case notifications(page: Int)
    // お知らせを既読に
    case notifications_read(notification_id: Int)
    // プッシュ通知設定 プッシュ通知設定の現在の設定を返す
    case settings_push_notification
    // プッシュ通知変更/いいねマッチ
    case settings_push_notifications_matched_offer(bool: Bool)
    // プッシュ通知変更/いいねされた
    case settings_push_notifications_offered(bool: Bool)
    // プッシュ通知変更/メッセージを受けた
    case settings_push_notifications_message(bool: Bool)
    // その他のお知らせ
    case settings_push_notifications_other(bool: Bool)
    // プライベートモードの現在の設定を返す
    case settings_private_modes
    // プライベートモードの更新 PATCH
    case settings_private_modes_update(bool: Bool)
    // 違反報告カテゴリ
    case items_violation_categories
    // 違反報告をする
    case members_violation_report(member_id: Int, violation_category_id: Int, content: String)
    // ブロックする
    case members_block(member_id: Int)
    // ブロック一覧を取得
    case blocks(page: Int)
    // ブロックを取り消す DELETE
    case blocks_delete(id: Int)
    // 電話番号個別、電話帳一括の両方でブロックする
    case phones_blocks(phones: [String])
    // 電話でブロックしたユーザ一覧を取得する
    case phones_blocks_list(page: Int)
    // 電話番号ブロックを取り消す DELETE
    case phones_blocks_delete(id: Int)
    // いいねする
    case members_offer(member_id: Int, meeting_type: Int, proposal_price_point: Int, date_schedule_candidates: [Date])
    // 自分が行ったいいねの一覧を取得する
    case offers(page: Int)
    // いいねされた一覧を取得する
    case offereds(page: Int)
    // いいねをスキップする
    case offer_skip(offer_id: Int)
    // いいねを承認する
    case offer_accept(offer_id: Int)
    // マイページで使用する為の自分のプロフィール詳細を取得する
    case members_profile
    // お相手のプロフィール詳細
    case members_detail(member_id: Int)
    // プロフィール-年収変更
    case mypage_profiles_annual_income(annual_income_id: Int)
    // プロフィール-体型変更
    case mypage_profiles_body_type(body_type_id: Int)
    // プロフィール-お酒変更
    case mypage_profiles_drinking_type(drinking_type_id: Int)
    // プロフィール-身長変更
    case mypage_profiles_height(height: Int)
    // プロフィール-ニックネーム変更
    case mypage_profiles_name(name: String)
    // プロフィール-いいね内容変更
    case mypage_profiles_offer_conditions(romance_price_point: Int, eating_price_point: Int , drinking_price_point: Int)
    // プロフィール-住んでいる地域変更
    case mypage_profiles_prefecture(prefecture_id: Int)
    // プロフィール-たばこ変更
    case mypage_profiles_smoking_type(smoking_type_id: Int)
    // プロフィール-つぶやき変更
    case mypage_profiles_tweet(tweet: String)
    // 会いたい場所
    case desired_meeting_place(place: String)
    
    // マイページメイン画像更新
    case mypage_profiles_images(image: UIImage)
    // サブ画像アップロード
    case mypage_profiles_sub_images(image: UIImage)
    // サブ画像削除
    case delete_mypage_profiles_sub_images(id: Int)
    
    // メッセージルーム一覧
    case message_rooms(page: Int)
    // メッセージルームの一覧を返す。
    case message_rooms_search(q:String,  page: Int)
    // メッセージ一覧
    case get_messages(room_id: Int, page: Int)
    // メッセージ送信
    case post_message_text(room_id: Int, text: String)
    case post_message_image(room_id: Int, image: UIImage)
    // メッセージ削除
    case delete_massege(room_id: Int, message_id: Int)

    // 現在ポイント+ポイント一覧
    case points
    // 購読一覧の価格リストを取得する
    case subscriptions
    // ポイント履歴
    case point_history(page: Int)

    // デバイストークン
    case devices
    // デバイストークン削除
    case devices_delete(device_id: String)  // delete
    
    // パスワード忘れ
    // パスワード変更本人確認 POST
    case members_passwords_sms(phone_number: String)
    // パスワード忘れSMS確認
    case members_passwords_sms_verification(phone_number: String, sms: String)
    // パスワード変更
    case members_password(phone_number: String, password: String, sms: String)

    // アプリ内課金
    // ポイント購入
    case purchase_point(receipt: String)
    // 有料会員
    case purchase_subscriptions(receipt: String)
    // リストア
    case purchase_restoration(receipt: String)
    
    // 足あと取得
    case foot_print(page: Int)
    // 足あと記録
    case post_footprint(member_id: Int)

    // アピール動画
    // アピール動画を新規作成し、動画アップロード用の URL を取得する。
    case appeal_videos(note: String)  // POST
    // アピール動画一覧
    case appeal_videos_list(page: Int)   // GET
    // アップロードしたアピール動画の取得GET
    case members_profiles_appeal_videos(page: Int)
    // 特定会員のアピール動画
    case members_appeal_videos(member_id: Int, page: Int)
    // アピール動画いいね
    case appeal_videos_like_post(video_id: Int)     // POST
    // アピール動画いいね解除
    case appeal_videos_like_delete(video_id: Int)   // DELETE
    // アピール動画再生可否
    case appeal_videos_playable(video_id: Int)   // GET
    // アピール動画削除
    case members_profiles_appeal_video_delete(video_id: Int)   // DELETE
    case members_profiles_appeal_videos_delete(video_ids: [Int])   // DELETE

    // 検索
    case members_online(page: Int)
    case members_between_5m_and_1d(page: Int)
    case members_between_1d_and_7d_new_comer(page: Int)
    case members_between_1d_and_7d_not_new_comer(page: Int)
    case members_between_7d_and_30d(page: Int)
    case members_over_30d(page: Int)

    // ログインボーナス
    case bonuses_login_latest
    
    // リリースキャンペーン第二弾
    case release_second
    
    // カレンダー関係
    // マッチ済みオファー
    case matched_offers(page: Int)
    // デート予定一覧
    case date_schedules(year: Int, month: Int)
    // デート予定一覧 候補あり
    case date_schedules_candidate(year: Int, month: Int)
    // デート予定作成
    case create_date_schedule(matched_offer_id: Int, planned_at: String, location: String, note: String, reminders: [String])
    // デート予定更新
    case update_date_schedule(date_schedule_id: Int, planned_at: String, location: String, note: String, reminders: [String])
    // デート予定削除
    case delete_date_schedule(date_schedule_id: Int)
    // デート詳細
    case get_date_schedules(date_schedule_id: Int)
    
    // デート予定調整
    // 承諾
    case date_schedule_adjustments_accept(date_schedule_adjustment_id: Int, accepted_candidate: String)
    // 確定
    case date_schedule_adjustments_confirm(date_schedule_adjustment_id: Int)
    // リスケジュール
    //case date_schedule_adjustments_reschedule(date_schedule_adjustment_id: Int, accepted_candidate: Date)
    // 中止
    case date_schedule_adjustments_cancel(date_schedule_adjustment_id: Int)

    // ランキング
    case rankings(term: String)
    
    private var apiVersion: String {
        switch self {
        case .date_schedules_candidate(_, _):
            return "v2/"
        default:
            return "v1/"
        }
    }
    

    var buildURL: URL {
        //return URL(string: Mitsu.BaseURL + "/api/" + apiVersion + endpoint)!
         return URL(string: Mitsu.BaseURL + "api/" + apiVersion + endpoint)!
    }

    var endpoint: String {
        switch self {

        // 新API
        case .login( _, _):                      return "login"
        case .sms( _):                           return "members/sms"
        case .phone( _, _):                        return "members/phone"
        case .member_regist(_, _, _, _, _, _):   return "members/profile"
        case .items_profiles:                 return "items/profiles"
        case .members_profiles_basic(_, _, _, _, _, _, _): return "members/profiles/basic"
        case .members_profiles_offer(_, _, _): return "members/profiles/offer"
        case .members_add_favorite(let member_id): return "members/\(member_id)/favorite"
        case .members_delete_favorite(let member_id): return "members/\(member_id)/favorite"
        case .favorites( _): return "favorites"
        case .members_profiles_assets( _): return "members/profiles/assets"
        case .members_profiles_tweet( _): return "members/profiles/tweet"
        case .members_profiles_intro( _): return "members/profiles/intro"
        case .items_inquiry_categories: return "items/inquiry_categories"
        case .inquiry( _, _, _, _): return "inquiry"
        case .members( _): return "members"
        case .settings_passwords_verification( _): return "settings/passwords/verification"
        case .settings_password( _): return "settings/password"
        case .members_age_verification( _): return "age_verification"
        case .todays_member: return "todays/member"
        case .notifications( _): return "notifications"
        case .notifications_read(let notification_id): return "notifications/\(notification_id)/read"
        case .settings_push_notification: return "settings/push_notification"
        case .settings_push_notifications_matched_offer( _): return "settings/push_notifications/matched_offer"
        case .settings_push_notifications_offered( _): return "settings/push_notifications/offered"
        case .settings_push_notifications_message( _): return "settings/push_notifications/message"
        case .settings_push_notifications_other( _): return "settings/push_notifications/other"
        case .settings_private_modes: return "settings/private_modes"
        case .settings_private_modes_update( _): return "settings/private_modes"
        case .items_violation_categories: return "items/violation_categories"
        case .members_violation_report(let member_id, _, _): return "members/\(member_id)/violation_report"
        case .members_block(let member_id): return "members/\(member_id)/block"
        case .blocks( _): return "blocks"
        case .blocks_delete(let id): return "blocks/\(id)"
        case .phones_blocks( _): return "phones/blocks"
        case .phones_blocks_list( _): return "phones/blocks"
        case .phones_blocks_delete(let id): return "phones/blocks/\(id)"
        case .members_offer(let member_id, _, _, _):     return "members/\(member_id)/offer"

        // いいね関係
        case .offers( _): return "offers"
        case .offereds( _): return "offereds"
        case .offer_skip(let offer_id): return "offers/\(offer_id)/skipped"
        case .offer_accept(let offer_id): return "offers/\(offer_id)/matched"

        case .members_profile: return "members/profile"
        case .members_detail(let member_id): return "members/\(member_id)"
        case .mypage_profiles_annual_income( _): return "mypage/profiles/annual_income"
        case .mypage_profiles_body_type( _): return "mypage/profiles/body_type"
        case .mypage_profiles_drinking_type( _): return "mypage/profiles/drinking_type"
        case .mypage_profiles_height( _): return "mypage/profiles/height"
        case .mypage_profiles_name( _): return "mypage/profiles/name"
        case .mypage_profiles_offer_conditions( _,_,_): return "mypage/profiles/offer_conditions"
        case .mypage_profiles_prefecture( _): return "mypage/profiles/prefecture"
        case .mypage_profiles_smoking_type( _): return "mypage/profiles/smoking_type"
        case .mypage_profiles_tweet( _): return "mypage/profiles/tweet"
        case .desired_meeting_place( _): return "mypage/profiles/desired_meeting_place"

        case .mypage_profiles_images( _): return "mypage/profiles/images"
        case .mypage_profiles_sub_images( _): return "mypage/profiles/sub_images"
        case .delete_mypage_profiles_sub_images(let id): return "mypage/profiles/sub_images/\(id)"
            
        // メッセージ関係
        case .message_rooms( _): return "message_rooms"
        case .message_rooms_search(let q, let page):
            if let query =
                q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                return "message_rooms?q=\(query)&page=\(page)"
            }
            return "message_rooms?q=&page=\(page)"
        case .get_messages(let room_id, _):     return "message_rooms/\(room_id)/messages"
        case .post_message_text(let room_id, _):     return "message_rooms/\(room_id)/messages"
        case .post_message_image(let room_id, _):     return "message_rooms/\(room_id)/messages"
        case .delete_massege(let room_id, let message_id): return "message_rooms/\(room_id)/messages/\(message_id)"
            
        // 購入
        case .points: return "points"
        case .subscriptions: return "subscriptions"
        case .point_history( _): return "point_histories"

        // トークン
        case .devices: return "devices"
        case .devices_delete(let device_id): return "devices/\(device_id)"
            
        // パスワード忘れ
        // パスワード変更本人確認 POST
        case .members_passwords_sms( _): return "members/passwords/sms"
        // パスワード忘れSMS確認
        case .members_passwords_sms_verification(_, _): return "members/passwords/sms/verification"
        // パスワード変更 PATCH
        case .members_password( _, _, _): return "members/password"

        // アプリ内課金
        // ポイント購入
        case .purchase_point( _): return "points"
        // 有料会員
        case .purchase_subscriptions( _): return "subscriptions"
        // リストア
        case .purchase_restoration( _): return "restoration"
            
        // 足あと取得
        case .foot_print( _): return "footprints"
        
        // 足あと記録
        case .post_footprint(let member_id):     return "members/\(member_id)/footprints"

        // アピール動画
        case .appeal_videos( _): return "appeal_videos"
        case .appeal_videos_list( _): return "appeal_videos"
        case .members_profiles_appeal_videos( _): return "members/profiles/appeal_videos"
        case .members_appeal_videos(let member_id, _): return "members/\(member_id)/appeal_videos"
        case .appeal_videos_like_post(let video_id): return "appeal_videos/\(video_id)/like"
        case .appeal_videos_like_delete(let video_id): return "appeal_videos/\(video_id)/like"
        case .appeal_videos_playable(let video_id): return "appeal_videos/\(video_id)/playable"
            
        case .members_profiles_appeal_video_delete(let video_id): return "members/profiles/appeal_videos/\(video_id)"
        case .members_profiles_appeal_videos_delete(let video_ids): return "members/profiles/appeal_videos?id[]=" + video_ids.map {"\($0)"} .joined(separator: "&id[]=")

        case .members_online( _): return "members/online"
        case .members_between_5m_and_1d( _): return "members/between_5m_and_1d"
        case .members_between_1d_and_7d_new_comer( _): return "members/between_1d_and_7d/new_comer"
        case .members_between_1d_and_7d_not_new_comer( _): return "members/between_1d_and_7d/not_new_comer"
        case .members_between_7d_and_30d( _): return "members/between_7d_and_30d"
        case .members_over_30d( _): return "members/over_30d"

        case .bonuses_login_latest: return "bonuses/login/latest"
        case .release_second: return "participated_campaigns/release_second"

        //カレンダー関係
        case .matched_offers( _): return "matched_offers"
        case .date_schedules(let year, let month): return "date_schedules?year=\(year)&month=\(month)"
        case .date_schedules_candidate(let year, let month): return "date_schedules?year=\(year)&month=\(month)"
        case .create_date_schedule( _, _, _, _, _): return "date_schedules"
        case .update_date_schedule(let date_schedule_id, _, _, _, _): return "date_schedules/\(date_schedule_id)"
        case .delete_date_schedule(let date_schedule_id): return "date_schedules/\(date_schedule_id)"
        case .get_date_schedules(let date_schedule_id): return "date_schedules/\(date_schedule_id)"
        
        // デート予定調整
        // 承諾
        case .date_schedule_adjustments_accept(let date_schedule_adjustment_id, _): return "date_schedule_adjustments/\(date_schedule_adjustment_id)/accept"
        // 確定
        case .date_schedule_adjustments_confirm(let date_schedule_adjustment_id): return "date_schedule_adjustments/\(date_schedule_adjustment_id)/confirm"
        // リスケジュール
        //case .date_schedule_adjustments_reschedule(let date_schedule_adjustment_id): return "date_schedule_adjustments/\(date_schedule_adjustment_id)/reschedule"
        // 中止
        case .date_schedule_adjustments_cancel(let date_schedule_adjustment_id): return "date_schedule_adjustments/\(date_schedule_adjustment_id)/cancel"
        
        // ランキング
        case .rankings(let term): return "rankings/\(term)"

        }
    }

    var parameters: Parameters {
        var params: Parameters = [:]

        //params["offset"]  = 0
        //params["limit"]   = 20
        return params
        
        /*
        switch self {
        case .login(let phone, let password):
            params = [
                "auth": [
                    "phone_number": phone,
                    "password": password
                ]
            ]
            return params
        case .sms(let phone):
            params = [
                "member": [
                    "phone_number": phone
                ]
            ]
            return params
        case .phone(let phone, let sms):
            params = [
                "member": [
                    "phone_number": phone,
                    "sms": sms
                ]
            ]
            return params
        case .member_regist(let name, let phone_number, let sex, let birth_day, let password, let password_confirm):
            var str_sex = "male"
            if sex == 2 {
                str_sex = "female"
            }
            params = [
                "member": [
                    "name":                 name,
                    "phone_number":         phone_number,
                    "sex":                  str_sex,
                    "birth_day":            birth_day,
                    "password":             password,
                    "password_confirm":    password_confirm
                ]
            ]
            return params

        case .members_profiles_basic(let height, let body_type_id, let prefecture_id, let annual_income_id, let drinking_type_id, let smoking_type_id, let occupation_id):
            params = [
                "member": [
                    "height":           height,
                    "body_type_id":     body_type_id,
                    "prefecture_id":    prefecture_id,
                    "annual_income_id": annual_income_id,
                    "drinking_type_id": drinking_type_id,
                    "smoking_type_id":  smoking_type_id,
                    "occupation_id":    occupation_id
                ]
            ]
            return params

        case .members_profiles_offer(let romance_price_point, let eating_price_point, let drinking_price_point):
            
            let romance_price_point_val = romance_price_point >= 0 ? "\(romance_price_point)" : ""
            let eating_price_point_val = eating_price_point >= 0 ? "\(eating_price_point)" : ""
            let drinking_price_point_val = drinking_price_point >= 0 ? "\(drinking_price_point)" : ""
            
            params = [
                "member": [
                    "romance_price_point":  romance_price_point_val,
                    "eating_price_point":   eating_price_point_val,
                    "drinking_price_point": drinking_price_point_val
                ]
            ]
            return params

        case .members_add_favorite(let member_id):
            params = [
                "member_id": member_id
            ]
            return params

        case .members_profiles_assets(let image),
             .mypage_profiles_images(let image),
             .mypage_profiles_sub_images(let image):
            guard let imageData = image.pngData() else { return params }
            let base64String = imageData.base64EncodedString()
            params = [
                "member": [
                    //"image": "data:image/jpeg;base64," + base64String
                    "image":  base64String
                ]
            ]
            return params

        case .members_profiles_tweet(let tweet):
            params = [
                "member": [
                    "tweet": tweet
                ]
            ]
            return params

        case .members_profiles_intro(let intro):
            params = [
                "member": [
                    "introduction": intro
                ]
            ]
            return params
        
        case .desired_meeting_place(let place):
            params = [
                "member": [
                    "desired_meeting_place": place
                ]
            ]
            print("params")
            print(params)
            return params
        
         case .inquiry(let inquiry_category_id, let content, let email, let images):
            var postImages = [String]()
            for image in images {
                // サイズを1/5にして送信する
                /*if let img = image.ResizeUIImage(width: image.size.width/5, height: image.size.width/5) ,let imageData = img.pngData() {
                    postImages.append(imageData.base64EncodedString())
                }*/
            }
            
            var size : Int = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            let code:String = String(cString:machine)
            
            params = [
                "inquiry": [
                    "inquiry_category_id": inquiry_category_id,
                    "content":   content,
                    "email": email,
                    "images": postImages,
                    // アプリのバージョン
                    "app_version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "",
                    // OS情報
                    "os_version": "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)",
                    // 端末名 機種
                    "model_name": "\(UIDevice.current.name) ( \(YMTGetDeviceName.share.getDeviceName()) )"
                ]
            ]
            return params

        case .settings_passwords_verification(let password) :
            params = [
                "auth": [
                    "password": password
                ]
            ]
            return params

        case .settings_password(let password) :
            params = [
                "member": [
                    "password": password
                ]
            ]
            return params

        case .members_age_verification(let image):
            guard let imageData = image.pngData() else { return params }
            let base64String = imageData.base64EncodedString()
            params = [
                "age_verification": [
                    //"image": "data:image/jpeg;base64," + base64String
                    "image":  base64String
                ]
            ]
            return params

        case .settings_push_notifications_matched_offer(let bool):
            params = [
                "member": [
                     "permit_matched_offer_notification": bool
                ]
            ]
            return params

        case .settings_push_notifications_offered(let bool):
            params = [
                "member": [
                    "permit_offered_notification": bool
                ]
            ]
            return params

        case .settings_push_notifications_message(let bool):
            params = [
                "member": [
                    "permit_message_notification": bool
                ]
            ]
            return params

        case .settings_push_notifications_other(let bool):
            params = [
                "member": [
                    "permit_other_notifications": bool
                ]
            ]
            return params

        case .settings_private_modes_update(let bool):
            params = [
                "member": [
                    "private_mode": bool
                ]
            ]
            return params

        case .members_violation_report(_, let violation_category_id, let content):
            params = [
                "violation_report": [
                    "violation_category_id": violation_category_id,
                    "content": content
                ]
            ]
            return params

        case .phones_blocks(let phones):
            params = [
                "block": [
                    "phones": phones
                ]
            ]
            return params

        case .members_offer(_, let meeting_type, let proposal_price_point, let date_schedule_candidates):

            let date_schedules = date_schedule_candidates.compactMap { $0.toStringforOfferAPIYMDhhmm()}
            params = [
                "offer": [
                    "meeting_type": meeting_type,
                    "proposal_price_point": proposal_price_point,
                    "date_schedule_candidates": date_schedules
                ]
            ]
            return params

        case .mypage_profiles_annual_income(let annual_income_id):
            params = [
                "member": [
                    "annual_income_id": annual_income_id
                ]
            ]
            return params

        case .mypage_profiles_body_type(let body_type_id):
            params = [
                "member": [
                    "body_type_id": body_type_id
                ]
            ]
            return params

        case .mypage_profiles_drinking_type(let drinking_type_id):
            params = [
                "member": [
                    "drinking_type_id": drinking_type_id
                ]
            ]
            return params

        case .mypage_profiles_height(let height):
            params = [
                "member": [
                    "height": height
                ]
            ]
            return params

        case .mypage_profiles_name(let name):
            params = [
                "member": [
                    "name": name
                ]
            ]
            return params

        case .mypage_profiles_offer_conditions(let romance_price_point, let eating_price_point, let drinking_price_point):
            
            let romance_price_point_val = romance_price_point >= 0 ? "\(romance_price_point)" : ""
            let eating_price_point_val = eating_price_point >= 0 ? "\(eating_price_point)" : ""
            let drinking_price_point_val = drinking_price_point >= 0 ? "\(drinking_price_point)" : ""
            params = [
                "member": [
                    "romance_price_point": romance_price_point_val,
                    "eating_price_point": eating_price_point_val,
                    "drinking_price_point": drinking_price_point_val
                ]
            ]
            return params

        case .mypage_profiles_prefecture(let prefecture_id):
            params = [
                "member": [
                    "prefecture_id": prefecture_id
                ]
            ]
            return params

        case .mypage_profiles_smoking_type(let smoking_type_id):
            params = [
                "member": [
                    "smoking_type_id": smoking_type_id
                ]
            ]
            return params

        case .mypage_profiles_tweet(let tweet):
            params = [
                "member": [
                    "tweet": tweet
                ]
            ]
            return params

        // メッセージ送信
        case .post_message_text(_, let text):
            params = [
                "message": [
                    "body": text,
                    "image":  ""
                ]
            ]
            return params
        
        case .post_message_image(_, let image):
            guard let imageData = image.pngData() else { return params }
            let base64String = imageData.base64EncodedString()
            params = [
                "message": [
                    "body": "",
                    "image":  base64String
                ]
            ]
            return params
        
        // 検索
        case .members(let page),
             .members_online(let page),
             .members_between_5m_and_1d(let page),
             .members_between_1d_and_7d_new_comer(let page),
             .members_between_1d_and_7d_not_new_comer(let page),
             .members_between_7d_and_30d(let page),
             .members_over_30d(let page):
            params["page"] = page
            
            var q = Json()
            // q[today_ok_eq]: 今日会える true か false
            if SearchData.is_today_ok {
                q["today_ok_eq"] = SearchData.is_today_ok
            }
            
            // q[login_status_id_eq] 最終ログイン
            if SearchData.last_login_id > 0 {
                q["login_status_id_eq"] = SearchData.last_login_id
            }
            
            // q[birth_day_age_gteq]: 年齢○歳以上
            if SearchData.age_from > 0 {
                let age_from = ProfileItemManager.ageRange.filter { $0.id == SearchData.age_from }.first?.name.replacingOccurrences(of: "歳", with: "")
                q["birth_day_age_gteq"] = age_from
            }
            // q[birth_day_age_lteq]: 年齢○歳以下
            if SearchData.age_to > 0 {
                let age_to = ProfileItemManager.ageRange.filter { $0.id == SearchData.age_to }.first?.name.replacingOccurrences(of: "歳", with: "")
                q["birth_day_age_lteq"] = age_to
            }
            // q[height_gteq]: 身長○cm以上
            if SearchData.height_from > 0 {
                let height_from = ProfileItemManager.heightRange.filter { $0.id == SearchData.height_from }.first?.name.replacingOccurrences(of: "cm", with: "")
                q["height_gteq"] = height_from
            }
            // q[height_lteq]: 身長○cm以下
            if SearchData.height_to > 0 {
                let height_to = ProfileItemManager.heightRange.filter { $0.id == SearchData.height_to }.first?.name.replacingOccurrences(of: "cm", with: "")
                q["height_lteq"] = height_to
            }
            // 居住地
            if SearchData.prefectures_ids != [0] {
                q["prefecture_id_in"] = SearchData.prefectures_ids
            }
            //q[body_type_id_eq]: 体型
            if SearchData.body_types_id > 0 {
                q["body_type_id_eq"] = SearchData.body_types_id
            }
            //q[annual_income_id_eq]: 年収
            if SearchData.annual_incomes_id > 0 {
                q["annual_income_id_eq"] = SearchData.annual_incomes_id
            }
            //q[drinking_type_id_eq]: お酒
            if SearchData.drinking_types_id > 0 {
                q["drinking_type_id_eq"] = SearchData.drinking_types_id
            }
            //q[smoking_type_id_eq]: タバコ
            if SearchData.smoking_types_id > 0 {
                q["smoking_type_id_eq"] = SearchData.smoking_types_id
            }
            //q[occupation_id_eq]: 職業
            if SearchData.occupations_female_id > 0 {
                q["occupation_id_eq"] = SearchData.occupations_female_id
            }
            if SearchData.occupations_male_id > 0 {
                q["occupation_id_eq"] = SearchData.occupations_male_id
            }

            //q[romance_price_point_gteq]: おまかせ○M以上
            //q[romance_price_point_lteq]: おまかせ○M以下
            if SearchData.romancePricePointFlag {
                if SearchData.charge_from > 0 {
                    q["romance_price_point_gteq"] = SearchData.charge_from
                }
                if SearchData.charge_to > 0 {
                    q["romance_price_point_lteq"] = SearchData.charge_to
                }
            }
            //q[eating_price_point_gteq]: 食事お酒○M以上
            //q[eating_price_point_lteq]: 食事お酒○M以下
            else if SearchData.eatingPricePointFlag {
                if SearchData.charge_from > 0 {
                    q["eating_price_point_gteq"] = SearchData.charge_from
                }
                if SearchData.charge_to > 0 {
                    q["eating_price_point_lteq"] = SearchData.charge_to
                }
            }
            //q[drinking_price_point_gteq]: カフェ○M以上
            //q[drinking_price_point_lteq]: カフェ○M以下
            else if SearchData.drinkingPricePointFlag {
                if SearchData.charge_from > 0 {
                    q["drinking_price_point_gteq"] = SearchData.charge_from
                }
                if SearchData.charge_to > 0 {
                    q["drinking_price_point_lteq"] = SearchData.charge_to
                }
            }

            params["q"] = q
            return params
            
        // 一覧用API
        case .favorites(let page),
             .notifications(let page),
             .blocks(let page),
             .phones_blocks_list(let page),
             .offers(let page),
             .offereds(let page),
             .message_rooms(let page),
             .foot_print(let page) ,
             .appeal_videos_list(let page),
             .members_profiles_appeal_videos(let page),
             .members_appeal_videos(_, let page),
             .point_history(let page),
             .matched_offers(let page),
             .get_messages(_, let page):
            
            params["page"] = page
            return params

        // deveice token
        case .devices:
            print("device_token : \(AccountData.deviceToken!)")
            print("device_id : \(UIDevice.current.identifierForVendor!.uuidString)")
            params = [
                 "device": [
                    "os": "ios",
                    "device_token": AccountData.deviceToken!,
                    "device_id": UIDevice.current.identifierForVendor!.uuidString
                ]
            ]
            return params

            // パスワード忘れ
        // パスワード変更本人確認 POST
        case .members_passwords_sms(let phone_number):
            params = [
                "member": [
                    "phone_number": phone_number
                ]
            ]
            return params

        // パスワード再設定用 SMS 確認
        case .members_passwords_sms_verification(let phone_number, let sms):
            params = [
                "member": [
                    "phone_number": phone_number,
                    "sms": sms
                ]
            ]
            return params

        // パスワード変更
        case .members_password(let phone_number, let password, let sms):
            params = [
                "member": [
                    "phone_number": phone_number,
                    "password": password,
                    "sms": sms
                ]
            ]
            return params

        // アプリ内課金
        // ポイント購入
        case .purchase_point(let receipt):
            params = [
                "member": [
                    "receipt": receipt
                ]
            ]
            return params
        // 月額会員購入
        case .purchase_subscriptions(let receipt):
            params = [
                "subscription": [
                    "receipt": receipt
                ]
            ]
            return params
        // リストア
        case .purchase_restoration(let receipt):
            params = [
                "restoration": [
                    "receipt": receipt
                ]
            ]
            return params

        // アピール動画
        case .appeal_videos(let note):
            params = [
                "appeal_video": [
                    "note": note
                ]
            ]
            return params

        // カレンダー関係
        // デート予定作成
        case .create_date_schedule(let matched_offer_id, let planned_at
            , let location, let note, let reminders):
            params = [
                "date_schedule": [
                    "offer_id"   : matched_offer_id,
                    "planned_at" : planned_at,
                    "location"   : location,
                    "note"       : note,
                    "reminders"  : reminders
                ]
            ]
            return params
        
        // デート予定更新
        case .update_date_schedule(_, let planned_at
            , let location, let note, let reminders):
            params = [
                "date_schedule": [
                    "planned_at" : planned_at,
                    "location"   : location,
                    "note"       : note,
                    "reminders"  : reminders
                ]
            ]
            return params
        // 承諾
        case .date_schedule_adjustments_accept(_, let accepted_candidate):
            params = [
                "accept": [
                    "accepted_candidate"   : accepted_candidate
                ]
            ]
            return params
        default:
            return params
        }
        */
    }
}
