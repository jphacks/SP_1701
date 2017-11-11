//
//  FileUploader.swift
//  Laugh_detect
//
//  Created by Yuto Kumagai on 2017/11/10.
//  Copyright © 2017年 !kie. All rights reserved.
//

import Foundation

public func fileUpload(fileURL: URL){
    let myUrl:NSURL = NSURL(string: "https://kentaiwami.jp/emil/api/sound/")!
    let fileurldata:Data = try! Data(contentsOf:fileURL as URL)
    print(fileURL)
    let base64String = fileurldata.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    
    let params:[String:Any] = ["user_id": "1", "file_data": base64String]
    
    let request = NSMutableURLRequest(url: myUrl as URL)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
    
    let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
        if let data = data, let response = response {
            print(response)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print(json)
            } catch {
                print("Serialize Error")
            }
        } else {
            print(error ?? "Error")
        }
    }
    task.resume()
}
