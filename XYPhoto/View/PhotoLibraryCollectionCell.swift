//
//  PhotoLibraryCollectionCell.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit

class PhotoLibraryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setOriginStatus() {
        imageView.hidden = true
        selectButton.hidden = true
    }
    
    func setData(image:UIImage , status:Bool) {
        imageView.hidden = false
        selectButton.hidden = false
        imageView.image = image
        if status {
            selectButton.setImage(UIImage(named: "fliter_selected_tribe_"), forState: .Normal)
        }else{
            selectButton.setImage(UIImage(named: "quan"), forState: .Normal)
        }
    }
}
