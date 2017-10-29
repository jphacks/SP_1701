//
//  ViewController.swift
//  emil
//
//  Created by Yuto Kumagai on 2017/10/27.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet weak var total_smile_point: UILabel!
    @IBOutlet weak var smileage: UIImageView!
    // API接続先
    let urlStr = "http://kentaiwami.jp/pinkie/api/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //viewを定義
        let graphview = Graph(frame : CGRect(x: 30,y: 180,width: 300,height: 400))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
        
        //スマイルポイント
        let point=2400
        
        //スマイルポイントを表示
        total_smile_point.text = "\(point)"
        
        // バンドルした画像ファイルを読み込み
        let image = UIImage(named: "smileage.png")
        // Image Viewに画像を設定
        smileage.image = image
        
        callAPI(name: "asd")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func moveTimeTable(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Timetable", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    
    @IBAction func moveCoupon(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Coupon", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    
    //グラフを表示
    class Graph: UIView {
        override func draw(_ rect: CGRect) {
            
            let count = [7, 8, 2, 5, 6, 4, 9]//笑った回数
            
            for i in 0..<7 {
                let point = count[i]*40 //笑った回数分のポイント
                let path = UIBezierPath(roundedRect: CGRect(x: 20+i*40, y: 400-point, width: 30, height: point), cornerRadius: 0)
                
                UIColor.orange.setFill() // 色をセット
                path.fill()
                
            }
            
        }
    }
    
    //過去のグラフを表示（実際には上記のGraphで表示するようにする）
    class Graph2: UIView {
        override func draw(_ rect: CGRect) {
            
            let count = [1, 3, 5, 7, 6, 4, 5]//笑った回数
            
            for i in 0..<7 {
                let point = count[i]*40 //笑った回数分のポイント
                let path = UIBezierPath(roundedRect: CGRect(x: 20+i*40, y: 400-point, width: 30, height: point), cornerRadius: 0)
                
                UIColor.orange.setFill() // 色をセット
                path.fill()
                
            }
            
        }
    }
    
    //1つ前の過去のグラフを表示
    @IBAction func beforeGraph(_ sender: Any) {
        //viewを定義
        let graphview = Graph2(frame : CGRect(x: 30,y: 180,width: 300,height: 400))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
    }
    
    //押すごとに最新のグラフを表示
    @IBAction func advancegraph(_ sender: Any) {
        //viewを定義
        let graphview = Graph(frame : CGRect(x: 30,y: 180,width: 300,height: 400))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
    }
    
    public func callAPI(name: String){
        
        let APIUrl = urlStr + "get_weekly_laugh"
        if let url = URL(string: APIUrl) {
            let req = NSMutableURLRequest(url: url)
            req.httpMethod = "POST"
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
                // 受け取ったdataをJSONパース、エラーならcatchへジャンプ
                do {
                    var json = try JSONSerialization.jsonObject(with: data!, options:[]) as? Dictionary<String, String>
                    print(json)
                    
                } catch {
                    print ("json error")
                    return
                }
            })
            task.resume()
        }
    }
    
}

