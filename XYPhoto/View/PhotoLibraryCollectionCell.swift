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
    
    @IBAction func selectButtonClick(_ sender: AnyObject) {
        selectState = !selectState
        setButton()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setOriginStatus() {
        imageView.isHidden = true
        selectButton.isHidden = true
    }
    
    func setButton()  {
        if selectState {
            selectButton.setImage(UIImage(named: "fliter_selected_tribe_"), for: UIControlState())
        }else{
            selectButton.setImage(UIImage(named: "quan"), for: UIControlState())
        }
    }
    func fillData(_ phAsset : PHAsset)  {
        imageView.isHidden = false
        selectButton.isHidden = false
        setButton()
        backgroundColor = UIColor.white
        let option = PHImageRequestOptions()
        option.deliveryMode = .opportunistic
        option.isSynchronous = true
        PHCachingImageManager().requestImage(for: phAsset, targetSize: CGSize(width: 2048, height: 2048), contentMode: .aspectFit, options: option, resultHandler: { (image, objects) in//获取相册的缩略图
            self.imageView.image = image!

        })

    }
}
