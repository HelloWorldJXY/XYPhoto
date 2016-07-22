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
    func didSelectPhotoGroupTableRowCallBack(assetCollection : PHAssetCollection ,name : String)
}

class PhotoGroupTableView: UITableView,UITableViewDataSource,UITableViewDelegate {
    var tableCellIdentifier = "PhotoGroupCell"
    var groups = [PhotoGroupItem]()
    var assetsFetchResults: PHFetchResult?
    var totleCount = 0
    weak var photoGroupDelegate : PhotoGroupTableDelegate?
    func setUpSelf(rect : CGRect){
        frame = rect
        backgroundColor = UIColor.clearColor()
        separatorStyle = .SingleLine
        separatorInset = UIEdgeInsetsMake(0, -120, 0, -120)
        registerNib(UINib(nibName : tableCellIdentifier, bundle : nil), forCellReuseIdentifier: tableCellIdentifier)
        
        setDataSource()
    }
    
    func setDataSource() {
        
        
        
        let states = PHPhotoLibrary.authorizationStatus()
        if states == .Denied {
            showAlert()
        }else if states == .Authorized{
            delegate = self
            dataSource = self
            
            weak var weakSelf = self
            self.groups.removeAll()


           
            let cameraRollAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil)
            getGroupData(cameraRollAlbums)
        
            let recentAddAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumRecentlyAdded, options: nil)
            getGroupData(recentAddAlbums)
            
            
//            let SelfieAndScreenshotsAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .Any, options: nil)
//            SelfieAndScreenshotsAlbums.enumerateObjectsUsingBlock( {(collections, count, success) in
//                if let assetCollection = collections as? PHAssetCollection {
//                     if assetCollection.localizedTitle == "Screenshots" || assetCollection.localizedTitle == "Selfies"{
//                        weakSelf!.fillDataSoure(assetCollection)
//                    }
//                }
//            } )

            let userAlbumsOptions = PHFetchOptions()
            userAlbumsOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0")
            
            let userAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: userAlbumsOptions)
            print("userAlbums : \(userAlbums.count)")
            getGroupData(userAlbums)
           
        }
        
    }
    
    func getGroupData(phAssestResult :PHFetchResult) {
        
        weak var weakSelf = self

        phAssestResult.enumerateObjectsUsingBlock( {(collections, count, success) in
            
            
            print("phAssestResult count     \(count)")
            if let collection = collections as? PHAssetCollection {
                weakSelf!.fillDataSoure(collection)
            }
        } )
    }
    
    func fillDataSoure(phAssetCollection : PHAssetCollection) {
        weak var weakSelf = self

        let onlyImagesOptions = PHFetchOptions()
        onlyImagesOptions.predicate = NSPredicate(format: "mediaType = %i", PHAssetMediaType.Image.rawValue)
        if let result = PHAsset.fetchKeyAssetsInAssetCollection(phAssetCollection, options: onlyImagesOptions) {
            print("Images count: \(result.count)")
            let groupItem = PhotoGroupItem()
            groupItem.groupName = phAssetCollection.localizedTitle
            groupItem.group = phAssetCollection
            weakSelf!.groups.append(groupItem)
            
            weakSelf?.reloadData()
                
        }
    }
    func refesh(){

        reloadData()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.groups.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellIdentifier, forIndexPath: indexPath) as! PhotoGroupCell
        for subView in cell.contentView.subviews {
            subView.hidden = true
        }
        let group = groups[indexPath.row]
        
        cell.commomInitCell(group)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! PhotoGroupCell
        if let target = photoGroupDelegate {
            target.didSelectPhotoGroupTableRowCallBack(cell.group!, name: cell.groupNameLabel.text!)
        }
    }

}
extension PhotoGroupTableView{
    func showAlert()  {
         let   mainInfoDictory =  NSBundle.mainBundle().infoDictionary!
            
        let appName = mainInfoDictory["CFBundleName"] as! String
        let alertController = UIAlertController(title: "提示",message: "请前往设置－>隐私－>照片,允许该" + appName + "使用获取相册功能", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default,handler: {  action in
            
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default,handler: {  action in
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        rootViewController!.presentViewController(alertController, animated: true, completion: nil)

    }
    
}
