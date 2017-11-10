//
//  ViewController.swift
//  emil
//
//  Created by Yuto Kumagai on 2017/10/27.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var total_smile_point: UILabel!
    @IBOutlet weak var smileage: UIImageView!
    @IBOutlet weak var week: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var segment_number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スマイレージ
        let point = appDelegate.total_smileage
        total_smile_point.text = "\(point)"
        
        week.text = "11月12日から一週間分のスマイレージ"
        
        let image = UIImage(named: "smileage.png")
        // Image Viewに画像を設定
        smileage.image = image
        
        //viewを定義
        let graphview = Graph(frame : CGRect(x: 30,y: 240,width: 300,height: 330))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
        
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        override func draw(_ rect: CGRect) {
            if appDelegate.segment_number == 0 {
                print("おう")
                for i in 0..<7 {
                    let point = appDelegate.this_week_total["weekly"][i].intValue //笑った回数分のポイント
                    let path = UIBezierPath(roundedRect: CGRect(x: 20+i*40, y: 400-point/3, width: 30, height: point/3), cornerRadius: 0)
                    
                    UIColor.orange.setFill() // 色をセット
                    path.fill()
                }
            }else if appDelegate.segment_number == 1 {
                print("いえい")
                for i in 0..<7 {
                    let point = appDelegate.last_week_total["weekly"][i].intValue //笑った回数分のポイント
                    let path = UIBezierPath(roundedRect: CGRect(x: 20+i*40, y: 400-point/3, width: 30, height: point/3), cornerRadius: 0)
                    
                    UIColor.orange.setFill() // 色をセット
                    path.fill()
                }
            } else if appDelegate.segment_number == 2 {
                for i in 0..<7 {
                    let point = appDelegate.last2_week_total["weekly"][i].intValue //笑った回数分のポイント
                    let path = UIBezierPath(roundedRect: CGRect(x: 20+i*40, y: 400-point/3, width: 30, height: point/3), cornerRadius: 0)
                    
                    UIColor.orange.setFill() // 色をセット
                    path.fill()
                }
            }
        }
    }
    
    //過去のグラフを表示（実際には上記のGraphで表示するようにする）
    class Graph2: UIView {
        override func draw(_ rect: CGRect) {
            
            let json = callAPI(name: "laughs", params:["1","2017","11","05"])
            let each_day_points = json["weekly"]
            
            for i in 0..<7 {
                let point = each_day_points[i].intValue //笑った回数分のポイント
                let path = UIBezierPath(roundedRect: CGRect(x: 20+i*40, y: 400-point/3, width: 30, height: point/3), cornerRadius: 0)
                
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
        
        week.text = "11月05日から一週間分のスマイレージ"
    }
    
    //押すごとに最新のグラフを表示
    @IBAction func advancegraph(_ sender: Any) {
        //viewを定義
        let graphview = Graph(frame : CGRect(x: 30,y: 180,width: 300,height: 400))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
        
        week.text = "11月12日から一週間分のスマイレージ"
    }
    
    @IBAction func changeWeek(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            appDelegate.segment_number = 0
            let graphview = Graph(frame : CGRect(x: 30,y: 240,width: 300,height: 330))
            graphview.backgroundColor = UIColor.white
            view.addSubview(graphview)
        case 1:
            appDelegate.segment_number = 1
            let graphview = Graph(frame : CGRect(x: 30,y: 240,width: 300,height: 330))
            graphview.backgroundColor = UIColor.white
            view.addSubview(graphview)
        case 2:
            appDelegate.segment_number = 2
            let graphview = Graph(frame : CGRect(x: 30,y: 240,width: 300,height: 330))
            graphview.backgroundColor = UIColor.white
            view.addSubview(graphview)
        default:
            break
        }
    }
}

