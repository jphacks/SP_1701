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
    
    //グラフを表示
    class Graph: UIView {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        override func draw(_ rect: CGRect) {
            
            /*
             セグメントボタンの選択箇所によってそれぞれのグラフを表示する
             */
            switch appDelegate.segment_number {
            case 0:
                drow_week_bar(data: appDelegate.this_week_total)
            case 1:
                drow_week_bar(data: appDelegate.last_week_total)
            case 2:
                drow_week_bar(data: appDelegate.last2_week_total)
            default:
                break
            }
        }
        
        /*
         グラフの描画
         */
        func drow_week_bar(data:JSON){
            for i in 0..<7 {
                let point = data["weekly"][i].intValue //笑った回数分のポイント
                let path = UIBezierPath(roundedRect: CGRect(x: 20+i*40, y: 400-point/3, width: 30, height: point/3), cornerRadius: 0)
                
                UIColor.orange.setFill() // 色をセット
                path.fill()
            }
        }
    }
    
    /*
     ビューにグラフを配置する
     */
    func setGraph() {
        let graphview = Graph(frame : CGRect(x: 30,y: 240,width: 300,height: 330))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
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
    
    @IBAction func changeWeek(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            appDelegate.segment_number = 0
            week.text = "11月12日から一週間分のスマイレージ"
            setGraph()
        case 1:
            appDelegate.segment_number = 1
            week.text = "11月05日から一週間分のスマイレージ"
            setGraph()
        case 2:
            appDelegate.segment_number = 2
            week.text = "10月29日から一週間分のスマイレージ"
            setGraph()
        default:
            break
        }
    }
}

