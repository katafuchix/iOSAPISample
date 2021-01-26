//
//  ViewController.swift
//  iOSAPISample
//
//  Created by cano on 2020/04/19.
//  Copyright © 2020 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    var auth_token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bind()
        //self.request()
    }

    func request() {
        //let request: Observable<SimpleResponse> = APIClientRx.post(api: SampleAPI.login(id: "aaaaaa", pass: "test1234"))
        
        let request: Observable<SimpleResponse> = APIClientRx.post(api: SampleAPI.create(id: "aaaaaa2", pass: "test1234", sex: 0))
        
        request.asObservable().subscribeAPIwithProgress( //.subscribeAPIwithProgress(
            progress: ProgressForAPI(isDismiss: true),
            onNext: { [unowned self] (response) in
                print(response)
                
                if response.result {
                    let json = JSON(response.jsonData)
                    print("json")
                    print(json)
                    if let auth_token = json["name"].string {
                        self.auth_token = auth_token
                        self.showSelectImage(self)
                    }
                } 
                
            },
            onError: { [unowned self]  (error) in
                self.showAlert(error.description)
            }
        ).disposed(by: self.rx.disposeBag)
    }
    
    func bind() {
        self.button.rx.tap.asDriver().drive(onNext: { [unowned self] _ in
            self.request()
            /*
            self.showSelectImage(self)
            print("self.auth_token")
            print(self.auth_token)
            */
        }).disposed(by: rx.disposeBag)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 画像選択、カメラ撮影後
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.originalImage] as? UIImage {
/*
            var imageCropVC : RSKImageCropViewController!
            imageCropVC = RSKImageCropViewController(image: pickedImage, cropMode: RSKImageCropMode.square)
            imageCropVC.moveAndScaleLabel.text = "切り取り範囲を選択"
            imageCropVC.cancelButton.setTitle("キャンセル", for: .normal)
            imageCropVC.chooseButton.setTitle("完了", for: .normal)
            imageCropVC.delegate = self
            imagePicker.pushViewController(imageCropVC, animated: true)
 */
            let request: Observable<SimpleResponse> = APIClientRx.post(api: SampleAPI.mypage_profiles_images(auth_token: self.auth_token, image: pickedImage))
            request.asObservable().subscribeAPIwithProgress( //.subscribeAPIwithProgress(
                progress: ProgressForAPI(isDismiss: true),
                onNext: { [unowned self] (response) in
                    print(response)
                    
                    if response.result {
                        let json = JSON(response.jsonData)
                        print("json")
                        print(json)
                    }
                    
                },
                onError: { [unowned self]  (error) in
                    self.showAlert(error.description)
                }
            ).disposed(by: self.rx.disposeBag)
        }
    }
}
