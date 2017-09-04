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
    
    public func  reloadCellWithPHAssetCollection(assetCollection : PHAssetCollection)  {
        thumbImgView?.clipsToBounds = true
        thumbImgView.image = UIImage(named: "thumbs_default")
        selectionStyle = .none
        let fetchResult = PHAsset.fetchAssets(in: assetCollection , options: nil)
        self.groupNameLabel.text = assetCollection.localizedTitle
        let groupNameLength = CGFloat((assetCollection.localizedTitle?.characters.count)! * Int(nameFont))
        let margin = CGFloat(5)
        groupNameLabWid.constant = margin * 2 + groupNameLength
        
        var countString = "(" + String(fetchResult.count) + ")"
        countString = countString.trimmingCharacters(in: CharacterSet.whitespaces)
        let countsLength = CGFloat(countString.characters.count * Int(nameFont))
        countsLabWid.constant =  countsLength
        self.groupCountslabel.text = countString

        if let lastCollection = fetchResult.lastObject {
            let option = PHImageRequestOptions()
            option.deliveryMode = .opportunistic
            option.isSynchronous = true

            PHImageManager.default().requestImage(for: lastCollection, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option) { (thumbImg, objects) in
                DispatchQueue.main.async {
                    self.thumbImgView?.image = thumbImg
                }
            }
        }

    }
    deinit {
        print("PhotoGroupCell deinit")
    }
}
