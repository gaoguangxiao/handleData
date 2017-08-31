//
//  ViewController.swift
//  handleData
//
//  Created by gaoguangxiao on 2017/8/31.
//  Copyright © 2017年 gaoguangxiao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        let handleDic = []
        //        print(handleDic)
        let ud = UserDefaults.standard
//        if (ud.value(forKey: "Model") != nil) {
//            //右束支
//            let f = NSKeyedUnarchiver.unarchiveObject(with: ud.value(forKey: "Model") as! Data)as!FeedModel
//            print("获取成功：\(f.title!)")
//        }else{
        
            let url = "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
            Alamofire.request(url,method: .post).responseJSON {
                (response) in
                if response.result.isSuccess{
                    
                    let netData = JSON(response.result.value!)
                    
                    print("执行OK\(netData)")
                    
                    let feed = netData.dictionary?["feed"]
                    let f = FeedModel.getDic(dic: feed!)
                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: f)
                    ud.setValue(encodedObject, forKey: "Model")
                    ud.synchronize()
                    
                    let eee = NSKeyedUnarchiver.unarchiveObject(with: ud.value(forKey: "Model") as! Data)as!FeedModel
                    print("获取成功：\(eee.title)")
                    
                }else{
                    print("提示加载失败")
                }
            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

