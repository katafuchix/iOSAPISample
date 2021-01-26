//
//  Request.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/02.
//  Copyright © 2019 ahihi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/// コールバックの形式でAPIをこコールできるクラス
class Request {
    let session: URLSession = URLSession.shared
    // GET METHOD
    func get(url: String, completionHandler: @escaping (JSON) -> Void) {
        Alamofire.request(url).responseJSON { response in
            Log.d(response.request as Any)  // original URL request
            Log.d(response.response as Any) // HTTP URL response
            Log.d(response.data as Any)     // server data
            Log.d(response.result.value as Any)   // result of response serialization

            guard let object = response.result.value else {
                return
            }

            let json = JSON(object)
            completionHandler(json)
        }
    }

    // POST METHOD
    func post(url: String, params: Parameters, completionHandler: @escaping (JSON) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil )
            .responseJSON { response in
                Log.d(response.request as Any)  // original URL request
                Log.d(response.response as Any) // URL response
                Log.d(response.result.value as Any)   // result of response serialization

                guard let object = response.result.value else {
                    return
                }

                let json = JSON(object)
                completionHandler(json)
        }
    }

    // DELETE METHOD
    func delete(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request: URLRequest = URLRequest(url: url)

        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
