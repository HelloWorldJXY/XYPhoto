//
//  PhotoGroupCell.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos
class PhotoGroupCell: UITableViewCell {
    var nameFont = CGFloat(16)
    var group : PHAssetCollection!

    @IBOutlet weak var thumbImgView: UIImageView!
    
    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var groupCountslabel: UILabel!
    
    @IBOutlet weak var groupNameLabWid: NSLayoutConstraint!
    
    @IBOutlet weak var countsLabWid: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commomInitCell(_ group: PhotoGroupItem) {
        for subView in contentView.subviews {
            subView.isHidden = false
        }
        imageView?.clipsToBounds = true
        selectionStyle = .none

        
        var groupNameString = group.groupName
        if groupNameString == "Camera Roll" {
            groupNameString = "我的相册"
        }
        else if groupNameString == "My Photo Stream"{
            groupNameString = "我的照片流"
            
        }else if groupNameString == "Recently Added"{
            groupNameString = "最近添加"
            
        }else if groupNameString == "Selfies"{
            groupNameString = "自拍"
        }else if groupNameString == "Screenshots"{
            groupNameString = "屏幕快照"
        }else{
            groupNameString = groupNameString?.trimmingCharacters(in: CharacterSet.whitespaces)
            groupNameString = groupNameString?.replacingOccurrences(of: " ", with: "")
        }
        groupNameLabel.text = groupNameString
        let groupNameLength = CGFloat((groupNameString?.characters.count)! * Int(nameFont))
        let margin = CGFloat(5)
        groupNameLabWid.constant = margin * 2 + groupNameLength

        
        let groupAsset = group.group        
        let fetchResult = PHAsset.fetchAssets(in: groupAsset!, options: nil)
        
        if let phAsset = fetchResult.lastObject  {
            let option = PHImageRequestOptions()
            option.deliveryMode = .opportunistic
            option.isSynchronous = true

            PHImageManager().requestImage(for: phAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option, resultHandler: { (image, objects) in//获取相册的缩略图
                
                self.imageView?.image = image
                
            })
        }
        
        groupCountslabel.text =  String(fetchResult.count)
        groupNameLabel.font = UIFont.boldSystemFont(ofSize: nameFont)
        
        var countString = "(" + String(fetchResult.count) + ")"
        countString = countString.trimmingCharacters(in: CharacterSet.whitespaces)
        let countsLength = CGFloat(countString.characters.count * Int(nameFont))
        countsLabWid.constant =  countsLength
        groupCountslabel.text = countString
        groupCountslabel.font = UIFont.systemFont(ofSize: nameFont)

        self.group = groupAsset
        
       

    }
}
