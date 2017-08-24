//
//  PhotoLibraryManager.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/26.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit

class PhotoLibraryManager {
    
    internal  func show(_ viewcontroller : UIViewController) {
        let pickerVC = PhotoLibaryViewController()
        let photoGroupVC = PhotoGroupPickerViewController()
        let nav = UINavigationController.init(rootViewController: photoGroupVC)
        nav.pushViewController(pickerVC, animated: false)
        nav.navigationBar.barStyle = .black
        viewcontroller.present(nav, animated: true,completion: nil)
        
    }
    
}
