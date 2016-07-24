//
//  ViewController.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let  button:UIButton = UIButton()
        //设置frame
        let frame = CGRectMake(100, 60, 100, 60)
        button.frame = frame
        //设置字体颜色
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        //设置字体
        button.setTitle("点我有惊喜", forState: UIControlState.Normal)
        //添加方法
        button.addTarget(self, action: #selector(ViewController.buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
        //添加到父控件
        self.view.addSubview(button)

    }

    func buttonClick(){
        let pickerVC = PhotoLibaryViewController()
        pickerVC.show()
//        let photoGroupVC = PhotoGroupPickerViewController()
////        self.presentViewController(photoGroupVC, animated: false,completion: nil)
//        self.navigationController?.pushViewController(photoGroupVC , animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

