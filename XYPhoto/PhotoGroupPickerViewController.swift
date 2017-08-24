//
//  PhotoGroupPickerViewController.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//
import UIKit
import Photos

class PhotoGroupPickerViewController: UIViewController,PhotoGroupTableDelegate {
    var tableView : PhotoGroupTableView!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setUpTableView()
    }
    
    func setUpTableView(){
        if tableView == nil{
            tableView = PhotoGroupTableView()
            let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            tableView.setUpSelf(rect)
            tableView.photoGroupDelegate = self
            view.addSubview(tableView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setnav()
    }
    func setnav() {
        title = "照片"
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 110, height: 44)
        backButton.backgroundColor = UIColor.clear
        backButton.setTitle("取消", for: UIControlState())
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40)
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        backButton.addTarget(self, action: #selector(PhotoLibaryViewController.cancleButtonClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: backButton)
        self.navigationItem.hidesBackButton = true
    }
    
    func  cancleButtonClick() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func didSelectPhotoGroupTableRowCallBack(_ assetCollection : PHAssetCollection ,name : String){
        let vc = PhotoLibaryViewController()
        print(self.navigationController)
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navTitle = name
        vc.assetCollection = assetCollection
    }
}
