//
//  APIManager.swift
//  emil
//
//  Created by Yuto Kumagai on 2017/10/29.
//  Copyright © 2017年 !kie. All rights reserved.
//

import Foundation
import SwiftyJSON

// API接続先
let urlStr = "https://kentaiwami.jp/emil/api/"

public func callAPI(name: String, params: [String]) -> JSON{

    var json: JSON?
    var APIUrl = urlStr + name + "/"
    for param in params{
        APIUrl = APIUrl + param + "/"
    }
    print("API: " + APIUrl)
    
    //サーバーからの受信を待ちたいためNSCondition()を用いて同期通信のように動かす
    let condition = NSCondition()
    
    if let url = URL(string: APIUrl) {
        let req = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
            condition.lock()
            if err != nil {
                print(err!)
                return
            }
            json = JSON(data: data!)
            condition.signal()
            condition.unlock()
        })
        condition.lock()
        task.resume()
        condition.wait()
        condition.unlock()
    }
    
    if json != nil{
        return json!
    }else{
        return JSON.null
    }
}
