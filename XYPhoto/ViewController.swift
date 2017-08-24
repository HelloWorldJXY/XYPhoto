//
//  ViewController.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let  button:UIButton = UIButton()
        //设置frame
        let frame = CGRect(x: 100, y: 60, width: 100, height: 60)
        button.frame = frame
        //设置字体颜色
        button.setTitleColor(UIColor.red, for: UIControlState())
        //设置字体
        button.setTitle("点我有惊喜", for: UIControlState())
        //添加方法
        button.addTarget(self, action: #selector(ViewController.buttonClick), for: UIControlEvents.touchUpInside)
        //添加到父控件
        self.view.addSubview(button)

    }

    func buttonClick(){
//        let status = PHPhotoLibrary.authorizationStatus()
//        
//        switch status {
//        case .authorized:
            PhotoLibraryManager().show(self)
//            break
//        case .notDetermined:
//            PHPhotoLibrary.requestAuthorization({ (status) in })
//            break
//        case .denied:
//            fetchAlbumAuthoration()
//            break
//        default:
//            fetchAlbumAuthoration()
//        }
    }
    
    func fetchAlbumAuthoration(){
        let alertController = UIAlertController(title: "此应用无权限访问相册", message: "您可以到设置-隐私-照片，打开访问权限", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "去设置", style: .default) { (alertAction) in
            let settingUrl = URL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.openURL(settingUrl!)
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancleAction)
        alertController.addAction(settingAction)
        self.present(alertController, animated: true, completion: nil)
    }
    deinit {
        print("viewcontroller deinit")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

