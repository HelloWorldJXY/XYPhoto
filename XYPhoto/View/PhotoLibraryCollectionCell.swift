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

    var imageView: UIImageView!
    var selectButton: UIButton!
    
    var selectState = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
//        self.imageView.contentMode = .scaleToFill
//        self.imageView.clipsToBounds = true
        
        self.selectButton = UIButton(type: .custom)
        self.selectButton.setImage(UIImage(named: "fliter_normal_tribe_"), for: .normal)
        self.selectButton.frame = CGRect(x: self.bounds.size.width - 25, y: 5, width: 20, height: 20)
        self.selectButton.addTarget(self, action: #selector(PhotoLibraryCollectionCell.selectButtonClick(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.selectButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func selectButtonClick(_ sender: AnyObject) {
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
            selectButton.setImage(UIImage(named: "fliter_normal_tribe_"), for: UIControlState())
        }
    }
    func fillData(_ phAsset : PHAsset)  {
//        setButton()
//        backgroundColor = UIColor.white
        let option = PHImageRequestOptions()
        option.deliveryMode = .opportunistic
        option.isSynchronous = true
        PHCachingImageManager().requestImage(for: phAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: { (image, objects) in//获取相册的缩略图
            self.imageView.image = image!

        })

    }
}
