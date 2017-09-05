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
    
    func setUpAssetCollection( _ assetCollection : PHAssetCollection) {
        backgroundColor = UIColor.white
        delegate = self
        dataSource = self

        self.register(PhotoLibraryCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        weak var weakSelf = self
        
        let fetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
        fetchResult.enumerateObjects({ (asset, count, success) in
            weakSelf!.assetArray.append(asset )
        })
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return assetArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoLibraryCollectionCell
        let phasset = assetArray[indexPath.row]
        cell.fillData(phasset)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool{
        return false
    }

    
}
