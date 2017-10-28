//
//  APIManager.swift
//  emil
//
//  Created by Yuto Kumagai on 2017/10/29.
//  Copyright © 2017年 !kie. All rights reserved.
//

import Foundation

// API接続先
let urlStr = "http://kentaiwami.jp/pinkie/api/"

public func callAPI(name: String) -> NSDictionary!{
    
    // 取得したJSONを格納する変数を定義
    var getJson: NSDictionary!
    
    var APIUrl = urlStr + name
    
    if let url = URL(string: APIUrl) {
        let req = NSMutableURLRequest(url: url)
        req.httpMethod = "GET"
        // req.httpBody = "userId=\(self.userId)&code=\(self.code)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
            //print(resp!.url!)
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
            
            // 受け取ったdataをJSONパース、エラーならcatchへジャンプ
            do {
                // dataをJSONパースし、変数"getJson"に格納
                getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
            } catch {
                print ("json error")
                return
            }
        })
        task.resume()
    }
    
    return getJson
}
