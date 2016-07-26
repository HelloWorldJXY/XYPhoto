//
//  PhotoLibraryManager.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/26.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit

class PhotoLibraryManager {
    
    public  func show(viewcontroller : UIViewController) {
        let pickerVC = PhotoLibaryViewController()
        let photoGroupVC = PhotoGroupPickerViewController()
        let nav = UINavigationController.init(rootViewController: photoGroupVC)
        nav.pushViewController(pickerVC, animated: false)
        nav.navigationBar.barStyle = .Black
        viewcontroller.presentViewController(nav, animated: true,completion: nil)
        
    }
    
}
