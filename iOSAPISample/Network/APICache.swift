//
//  APICache.swift
//  mitsumitsu_iOS
//
//  Created by k.katafuchi on 2019/02/28.
//  Copyright © 2019 Smart Routine Corp. All rights reserved.
//

import Foundation
import SwiftyJSON

class APICache: NSObject {

    private static var cache_path: URL? {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/Cache/"
        do {
            // ディレクトリが存在するかどうかの判定
            if !FileManager.default.fileExists(atPath: path) {
                // ディレクトリが無い場合ディレクトリを作成する
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false , attributes: nil)
            }
        } catch {
            Log.e("キャッシュディレクトリ判定に失敗しました")
            return nil
        }
        return URL(string: path)
    }

    private static func generateCacheFilePath(_ request: Requestable) -> String? {
        guard let path = self.cache_path else {
            return nil
        }

        let params = NSMutableString(string: "")
        for (k, v) in request.parameters {
            if k == "page" {
                params.append("_$\(k)=\(v)")
                break
            }
        }
        //let fileName = request.url.urlString + (params as String)
        // return path.appendingPathComponent(fileName.md5(), isDirectory: false).absoluteString
        let fileName = request.url.buildURL.absoluteString + (params as String)
        return path.appendingPathComponent(fileName, isDirectory: false).absoluteString
    }

    static func cacheJSON(_ request: Requestable, json: Json) -> Bool {
        guard let filePath = self.generateCacheFilePath(request) else {
            return false
        }

        do {
            let jsonData = try JSON(json).rawData()
            return FileManager.default.createFile(atPath: filePath, contents: jsonData, attributes: nil)
        } catch {
            Log.e("キャッシュファイルの作成に失敗しました")
            return false
        }
    }

    static func loadCacheJSON(_ request: Requestable) -> Json? {
        guard let filePath = self.generateCacheFilePath(request) else {
            return nil
        }

        if let jsonData = FileManager.default.contents(atPath: filePath) {
            return try! JSON(data: jsonData).dictionaryObject
        }

        return nil
    }

    static func clear() {
        guard let path = self.cache_path else {
            return
        }
        do {
            let fileNames = try FileManager.default.contentsOfDirectory(atPath: path.absoluteString)
            for name in fileNames {
                let filePath = path.appendingPathComponent(name).absoluteString
                if FileManager.default.isDeletableFile(atPath: filePath) {
                    try FileManager.default.removeItem(atPath: filePath)
                }
            }
        } catch {
            Log.e("キャッシュ削除に失敗しました")
            return
        }
    }
}
