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

public func callAPI(name: String){
    
    let APIUrl = urlStr + name
    if let url = URL(string: APIUrl) {
        let req = NSMutableURLRequest(url: url)
        req.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
            // 受け取ったdataをJSONパース、エラーならcatchへジャンプ
            do {
                var json = try JSONSerialization.jsonObject(with: data!, options:[]) as? [Dictionary<String, String>]
            
            } catch {
                print ("json error")
                return
            }
        })
        task.resume()
    }
}
