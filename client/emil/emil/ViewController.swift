//
//  ViewController.swift
//  emil
//
//  Created by Yuto Kumagai on 2017/10/27.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //viewを定義
        let graphview = Graph(frame : CGRect(x: 0,y: 200,width: view.bounds.width,height: 300))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
        
        //画面の幅と高さ
        //print(view.bounds.width)
        //print(view.bounds.height)
        
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
                let point = count[i]*20 //笑った回数分のポイント
                let path = UIBezierPath(roundedRect: CGRect(x: 40+i*50, y: 300-point, width: 40, height: 100+point), cornerRadius: 0)
                
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
                let point = count[i]*20 //笑った回数分のポイント
                let path = UIBezierPath(roundedRect: CGRect(x: 40+i*50, y: 300-point, width: 40, height: 100+point), cornerRadius: 0)
                
                UIColor.orange.setFill() // 色をセット
                path.fill()
                
            }
            
        }
    }
    
    //1つ前の過去のグラフを表示
    @IBAction func beforeGraph(_ sender: Any) {
        //viewを定義
        let graphview = Graph2(frame : CGRect(x: 0,y: 200,width: view.bounds.width,height: 300))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
    }
    
    //押すごとに最新のグラフを表示
    @IBAction func advanceGraph(_ sender: Any) {
        //viewを定義
        let graphview = Graph(frame : CGRect(x: 0,y: 200,width: view.bounds.width,height: 300))
        graphview.backgroundColor = UIColor.white
        view.addSubview(graphview)
    }
    
}

