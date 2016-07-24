//
//  PhotoLibaryViewController.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos
class PhotoLibaryViewController: UIViewController {
    
    var assetCollection : PHAssetCollection?
    var collectionView : PhotoLibaryCollectionView!
    var  navTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blueColor()

        setNavgationView()
        setnav()
        // Do any additional setup after loading the view.
        
        let collectionViewFollowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.mainScreen().bounds.width
        collectionViewFollowLayout.itemSize = CGSizeMake(screenWidth*0.3,screenWidth*0.3)
        collectionViewFollowLayout.minimumLineSpacing = CGFloat(1)
        let rect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        collectionView = PhotoLibaryCollectionView(frame: rect, collectionViewLayout: collectionViewFollowLayout)
        if let assetCollection = assetCollection {
            collectionView.setUpAssetCollection(assetCollection)
            title = navTitle
        }else{
            let cameraRollAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil)
            getGroupData(cameraRollAlbums)

        }
        view.addSubview(collectionView)
        
    }

    func setnav() {
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRectMake(0, 0, 70, 44)
        backButton.backgroundColor = UIColor.lightGrayColor()
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        backButton.setTitle("取消", forState: .Normal)
        backButton.addTarget(self, action: #selector(PhotoLibaryViewController.cancleButtonClick), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: backButton)

    }
    
    
    
    func getGroupData(phAssestResult :PHFetchResult) {
        
        weak var weakSelf = self
        
        phAssestResult.enumerateObjectsUsingBlock( {(collections, count, success) in
            
            
            print("phAssestResult count     \(count)")
            if let collection = collections as? PHAssetCollection {
                weakSelf!.collectionView.setUpAssetCollection(collection)
            }
        } )
    }
   
    func  cancleButtonClick() {

        self.navigationController?.popViewControllerAnimated(true)
      
    }
    
    
    
    func setNavgationView() {
        let groupVC = PhotoGroupPickerViewController()
        let navgationC = UINavigationController.init(rootViewController: groupVC)
        navgationC.view.frame = view.bounds
        
        self.addChildViewController(navgationC)
        
        self.view.addSubview(navgationC.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTopViewController() -> UIViewController{
        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController

        return  topViewControllerWithRootViewController(rootVC!)
    }
    
    func show() {
        setUpTopViewController().presentViewController(self, animated: true, completion: nil)

    }
   
    func topViewControllerWithRootViewController(rootViewController:UIViewController) -> UIViewController {
        
        if rootViewController.isKindOfClass(UITabBarController) {
            let tabbarController = rootViewController as? UITabBarController
            return topViewControllerWithRootViewController((tabbarController?.selectedViewController)!)
        }else if rootViewController.isKindOfClass(UINavigationController) {
            let navgationController = rootViewController as? UINavigationController
            if let presentedViewcontroller = navgationController?.presentedViewController {
                return topViewControllerWithRootViewController(presentedViewcontroller)
            }else{
                return rootViewController
 
            }
        }else if rootViewController.isKindOfClass((rootViewController.presentedViewController?.classForCoder)!) {
            let viewcontroller = rootViewController
            return topViewControllerWithRootViewController(viewcontroller)
        }else{
            return rootViewController

        }
    }
}
