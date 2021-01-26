//
//  UIViewController+Extension.swift
//  iOSAPISample
//
//  Created by cano on 2020/04/19.
//  Copyright © 2020 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// https://qiita.com/katafuchix/items/50266e0eb52a032c9629

struct AlertAction {
    var title: String
    var style: UIAlertAction.Style

    static func action(title: String, style: UIAlertAction.Style = .default) -> AlertAction {
        return AlertAction(title: title, style: style)
    }
}

extension UIViewController {
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction]) -> Observable<Int>
    {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(index)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }

            self.present(alertController, animated: true, completion: nil)

            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}

extension UIViewController {
    
    func showSelectImage(_ vc: UIViewController) {
        
        let actionSheet = UIAlertController(title: "", message: "アップロード方法を選択", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 選択肢を生成
        let cameraAction = UIAlertAction(
            title: "写真を撮る",
            style: .default,
            handler: { [weak self] _ in
                // カメラが利用可能か
                if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self?.showAlert("カメラへアクセスできません", "設定アプリにてフォトアルバムへのアクセスを許可してください")
                }
                // 写真を選ぶビュー
                let pickerView = UIImagePickerController()
                // 写真の選択元をカメラにする
                pickerView.sourceType = .camera
                // トリミング機能ON
                //pickerView.allowsEditing = true
                // デリゲート
                pickerView.delegate = vc as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                
                pickerView.modalTransitionStyle = .crossDissolve
                pickerView.modalPresentationStyle = .overCurrentContext
                
                // ビューに表示
                self?.present(pickerView, animated: true)
        })
        
        let selectedAlbumAtion = UIAlertAction(
            title: "ライブラリから選ぶ",
            style: .default,
            handler: { [weak self] _ in
                // カメラロールが利用可能か
                if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    self?.showAlert("フォトアルバムへアクセスできません", "設定アプリにてフォトアルバムへのアクセスを許可してください")
                    return
                }
                // 写真を選ぶビュー
                let pickerView = UIImagePickerController()
                // 写真の選択元をカメラロールにする
                pickerView.sourceType = .photoLibrary
                // トリミング機能ON
                //pickerView.allowsEditing = true
                // デリゲート
                pickerView.delegate = vc as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                // ビューに表示
                self?.present(pickerView, animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // アクションを追加
        if UIImagePickerController.isSourceTypeAvailable(.camera) { actionSheet.addAction(cameraAction) }
        actionSheet.addAction(selectedAlbumAtion)
        actionSheet.addAction(cancelAction)
        actionSheet.popoverPresentationController?.sourceView = view
        present(actionSheet, animated: true, completion: nil)
    }
    
}
