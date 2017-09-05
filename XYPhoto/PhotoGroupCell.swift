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
    let cellHeight = 60
    var group : PHAssetCollection!

    var thumbImgView: UIImageView!
    var groupNameLabel: UILabel!
    var groupCountslabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.thumbImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cellHeight, height: cellHeight))
        self.thumbImgView.clipsToBounds = true
        self.thumbImgView.image = UIImage(named: "thumbs_default")
        
        self.groupNameLabel = UILabel()
        self.groupNameLabel.frame = CGRect(x: Int(thumbImgView.frame.maxX + 15), y: 0, width: 50, height: cellHeight)
        self.groupNameLabel.font = UIFont.systemFont(ofSize: nameFont)
        self.groupNameLabel.textColor = UIColor.gray
        
        self.groupCountslabel = UILabel()
        self.groupCountslabel.frame = CGRect(x: Int(groupNameLabel.frame.maxX + 15), y: 0, width: 50, height: cellHeight)
        self.groupCountslabel.font = UIFont.systemFont(ofSize: 15)
        self.groupCountslabel.textColor = UIColor.lightGray
        
        self.addSubview(self.thumbImgView)
        self.addSubview(self.groupNameLabel)
        self.addSubview(self.groupCountslabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func  reloadCellWithPHAssetCollection(assetCollection : PHAssetCollection)  {

        selectionStyle = .none
        let fetchResult = PHAsset.fetchAssets(in: assetCollection , options: nil)
        let name = assetCollection.localizedTitle! as NSString
        let maxSize = CGSize(width: 320, height: 100)
        let nameAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: nameFont)]

        self.groupNameLabel.text = name as String
        let nameRect : CGRect = name.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: nameAttributes, context: nil)
        self.groupNameLabel.frame = CGRect(x: Int(thumbImgView.frame.maxX + 15), y: 0, width: Int(nameRect.size.width + 10), height: cellHeight)
        
        let countString  = NSString(string: "( " + String(fetchResult.count) + " )")
        let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: nameFont)]
        let rect:CGRect = countString.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        self.groupCountslabel.text = countString as String
        self.groupCountslabel.frame = CGRect(x: Int(groupNameLabel.frame.maxX + 15), y: 0, width: Int(rect.size.width + 10), height: cellHeight)

        if let lastCollection = fetchResult.lastObject {
            let option = PHImageRequestOptions()
            option.deliveryMode = .opportunistic
            option.isSynchronous = true

            PHImageManager.default().requestImage(for: lastCollection, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option) { (thumbImg, objects) in
                DispatchQueue.main.async {
                    self.thumbImgView.image = thumbImg
                }
            }
        }

    }
    deinit {
        //print("PhotoGroupCell deinit")
    }
}
