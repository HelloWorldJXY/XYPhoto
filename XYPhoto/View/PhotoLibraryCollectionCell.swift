//
//  PhotoLibraryCollectionCell.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos
class PhotoLibraryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var selectButton: UIButton!
    var selectState = false
    
    @IBAction func selectButtonClick(sender: AnyObject) {
        selectState = !selectState
        setButton()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setOriginStatus() {
        imageView.hidden = true
        selectButton.hidden = true
    }
    
    func setButton()  {
        if selectState {
            selectButton.setImage(UIImage(named: "fliter_selected_tribe_"), forState: .Normal)
        }else{
            selectButton.setImage(UIImage(named: "quan"), forState: .Normal)
        }
    }
    func fillData(phAsset : PHAsset)  {
        imageView.hidden = false
        selectButton.hidden = false
        setButton()
        backgroundColor = UIColor.whiteColor()
        let option = PHImageRequestOptions()
        option.deliveryMode = .Opportunistic
        option.synchronous = true
        PHImageManager().requestImageForAsset(phAsset, targetSize: CGSizeMake(2048, 2048), contentMode: .AspectFit, options: option, resultHandler: { (image, objects) in//获取相册的缩略图
            self.imageView.image = image!

        })

    }
}
