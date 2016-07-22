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

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blueColor()
        
        let collectionViewFollowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.mainScreen().bounds.width
        collectionViewFollowLayout.itemSize = CGSizeMake(screenWidth*0.3,screenWidth*0.3)
        collectionViewFollowLayout.minimumLineSpacing = CGFloat(1)
        let rect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        collectionView = PhotoLibaryCollectionView(frame: rect, collectionViewLayout: collectionViewFollowLayout)
        if let assetCollection = assetCollection {
            collectionView.setUpAssetCollection(assetCollection)
            title = navTitle
        }
        view.addSubview(collectionView)
        
        setnav()
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
    func  cancleButtonClick() {

        self.navigationController?.popViewControllerAnimated(true)
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTopViewController() {
        
    }
    
    func show() {
        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController

//        let photoGroupVC = PhotoGroupPickerViewController()
//        self.presentViewController(photoGroupVC, animated: false) {
//            rootVC?.presentViewController(vc, animated: true, completion: nil)
//        }
        if ((rootVC?.isKindOfClass(UIViewController)) != nil) {
//            navigationController?.topViewController!.presentViewController(self, animated: true, completion: nil)
//            rootVC?.navigationController?.presentViewController(self, animated: true, completion: nil)
            rootVC?.presentViewController(self, animated: true, completion: nil)
        }else if ((rootVC?.isKindOfClass(UINavigationController)) != nil) {
            rootVC?.presentViewController(self, animated: true, completion: nil)
        }
    }
   
    func topViewControllerWithRootViewController(rootViewController:UIViewController) -> UIViewController {
        return UIViewController()
    }
}
