//
//  PhotoGroupItem.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos

class PhotoGroupItem: NSObject {

    var thumbImage : UIImage!
    var groupName : String!
    var  assetCounts : NSInteger = 0
    
    var group : PHAssetCollection!
    
}
