//
//  PhotoLibaryCollectionView.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos

class PhotoLibaryCollectionView: UICollectionView ,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var cellIdentifier = "PhotoLibraryCollectionCell"
    var assetCollection : PHAssetCollection?
    
    var assetArray = [PHAsset]()
    
    func setUpAssetCollection( assetCollection : PHAssetCollection) {
        backgroundColor = UIColor.whiteColor()
        delegate = self
        dataSource = self
        self.registerNib(UINib.init(nibName: cellIdentifier, bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: cellIdentifier)
        weak var weakSelf = self
        
        let fetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
        fetchResult.enumerateObjectsUsingBlock { (asset, count, success) in
            weakSelf!.assetArray.append(asset as! PHAsset)
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return assetArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhotoLibraryCollectionCell
        cell.setOriginStatus()
        let phasset = assetArray[indexPath.row]
        cell.fillData(phasset)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        return false
    }

    
}
