//
//  PhotoGroupTableView.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos

@objc protocol PhotoGroupTableDelegate {
    func didSelectPhotoGroupTableRowCallBack(_ assetCollection : PHAssetCollection)
}

class PhotoGroupTableView: UITableView,UITableViewDataSource,UITableViewDelegate {
    var tableCellIdentifier = "PhotoGroupCell"
    var groups = [PhotoGroupItem]()
    var assetsFetchResults = NSMutableArray(capacity: 0)
    var totleCount = 0
    weak var photoGroupDelegate : PhotoGroupTableDelegate?
    
    func setUpSelf(_ rect : CGRect){
        frame = rect
        backgroundColor = UIColor.clear
        separatorStyle = .singleLine
        separatorInset = UIEdgeInsetsMake(0, -120, 0, -120)
        register(PhotoGroupCell.self, forCellReuseIdentifier: tableCellIdentifier)
        delegate = self
        dataSource = self
        setDataSource()
    }
    
    func setDataSource() {
        
        fetchAssetCollections()
    }
    
    func fetchAssetCollections() {
        //smart albums
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        //user albums
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        
        let assetArray = [smartAlbums,albums]
        
        getAssetsData(assetArray)
    }
    
    func getAssetsData(_ data : Array <PHFetchResult<PHAssetCollection>>) {
        var tmpArray = Array<PHAssetCollection>()
        
        for collectionAssets in data {
            collectionAssets.enumerateObjects({ (collection, start, stop) in
                    tmpArray.append(collection)
            })
        }
        self.assetsFetchResults.addObjects(from: tmpArray);
        self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.assetsFetchResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! PhotoGroupCell

        let assetCollection = self.assetsFetchResults.object(at: indexPath.row)
        cell.reloadCellWithPHAssetCollection(assetCollection: assetCollection as! PHAssetCollection)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assetCollection = self.assetsFetchResults.object(at: indexPath.row)
        if let target = photoGroupDelegate {
            target.didSelectPhotoGroupTableRowCallBack(assetCollection as! PHAssetCollection)
        }
    }

}
extension PhotoGroupTableView{
    func showAlert()  {
         let   mainInfoDictory =  Bundle.main.infoDictionary!
            
        let appName = mainInfoDictory["CFBundleName"] as! String
        let alertController = UIAlertController(title: "提示",message: "请前往设置－>隐私－>照片,允许该" + appName + "使用获取相册功能", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "去设置", style: UIAlertActionStyle.default,handler: {  action in
            let openUrl = URL(string: UIApplicationOpenSettingsURLString)
            if UIApplication.shared.canOpenURL(openUrl!){
                UIApplication.shared.openURL(openUrl!)
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default,handler: {  action in
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController!.present(alertController, animated: true, completion: nil)

    }
    
}
