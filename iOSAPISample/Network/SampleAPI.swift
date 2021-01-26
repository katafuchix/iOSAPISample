//
//  SampleAPI.swift
//  iOSAPISample
//
//  Created by cano on 2020/04/19.
//  Copyright © 2020 cano. All rights reserved.
//

import Foundation
import UIKit

enum SampleAPI: API {
    case login(id: String, pass: String)
    case create(id: String, pass: String, sex: Int)
    
    // マイページメイン画像更新
    case mypage_profiles_images(auth_token: String, image: UIImage)
    
    private var apiVersion: String {
        return "v1/"
    }
    

    var buildURL: URL {
        //return URL(string: Mitsu.BaseURL + "/api/" + apiVersion + endpoint)!
        print("http://localhost:3000/" + "api/" + apiVersion + endpoint)
        return URL(string: "http://localhost:3000/" + "api/" + apiVersion + endpoint)!
    }

    var endpoint: String {
        switch self {
            case .login( _, _):                      return "test/user/login"
            case .create(_, _, _):                        return "test/user/create"
            case .mypage_profiles_images(_, _): return "users/me/profile/images/create"
        }
    }
    
    
    var parameters: Parameters {
        var params: Parameters = [:]
        
        switch self {
        case .login(let id, let password):
            params = [
                    "id": id,
                    "password": password
            ]
            return params

        case .create(let id, let password, let sex):
            params = [
                    "id": id,
                    "password": password,
                    "sex": sex
            ]
            return params
        
        case .mypage_profiles_images(let auth_token, let image):
            guard let imageData = image.pngData() else { return params }
            let base64String = imageData.base64EncodedString()
            params = [
                "auth_token": auth_token,
                    "image": "data:image/jpeg;base64," + base64String
                    //"image":  base64String
            ]
            return params

        }
        
        return params
    }
}
