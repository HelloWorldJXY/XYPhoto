//
//  PhotoLibaryViewController.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos
class PhotoLibaryViewController: UIViewController ,PHPhotoLibraryChangeObserver{
    
    var assetCollection : PHAssetCollection?
    var collectionView : PhotoLibaryCollectionView!
    var  navTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue

        setnav()
        // Do any additional setup after loading the view.
        
        let collectionViewFollowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        collectionViewFollowLayout.itemSize = CGSize(width: screenWidth*0.3,height: screenWidth*0.3)
        collectionViewFollowLayout.minimumLineSpacing = CGFloat(1)
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        collectionView = PhotoLibaryCollectionView(frame: rect, collectionViewLayout: collectionViewFollowLayout)
        if let assetCollection = assetCollection {
            collectionView.setUpAssetCollection(assetCollection)
            title = navTitle
        }else{
            let cameraRollAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
            getGroupData(cameraRollAlbums as! PHFetchResult<AnyObject>)

        }
        view.addSubview(collectionView)
        
    }

    func setnav() {
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 70, height: 44)
        backButton.backgroundColor = UIColor.clear
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        backButton.setImage(UIImage(named: "backIcon"), for: UIControlState())
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        backButton.setTitle("返回", for: UIControlState())
        backButton.addTarget(self, action: #selector(PhotoLibaryViewController.backButtonClick), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        let cancleButton = UIButton(type: .custom)
        cancleButton.frame = CGRect(x: 0, y: 0, width: 110, height: 44)
        cancleButton.backgroundColor = UIColor.clear
        cancleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, -40)
        cancleButton.setTitle("取消", for: UIControlState())
        cancleButton.setTitleColor(UIColor.white, for: UIControlState())
        cancleButton.addTarget(self, action: #selector(PhotoLibaryViewController.cancleButtonClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: cancleButton)

    }
    
    func  backButtonClick() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func getGroupData(_ phAssestResult :PHFetchResult<AnyObject>) {
        
        weak var weakSelf = self
        
        phAssestResult.enumerateObjects( {(collections, count, success) in
            
            
            print("phAssestResult count     \(count)")
            if let collection = collections as? PHAssetCollection {
                weakSelf!.collectionView.setUpAssetCollection(collection)
            }
        } )
    }
   
    func  cancleButtonClick() {

        self.dismiss(animated: true, completion: nil)
      
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        PHPhotoLibrary.shared().register(self)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange){
        
    }
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
}
