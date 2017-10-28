//
//  TimeTable.swift
//  emil
//
//  Created by 山川拓也 on 2017/10/28.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit

class Coupon: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Coupon: UITableView!
    @IBOutlet weak var shadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Coupon.register(UINib(nibName: "CustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCellTableViewCell")
        
        
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.3 // 透明度
        shadow.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        shadow.layer.shadowRadius = 5 // ぼかし量
        
        Coupon.delegate = self
        Coupon.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作る
        /*
         * To Do
         * 画像を乗っける
         * ギフトを配列に変える
         */
        let cell = Coupon.dequeueReusableCell(withIdentifier: "CustomCellTableViewCell", for: indexPath) as! CustomCellTableViewCell
        cell.gift.text = "ハンバーーーーグ"
        cell.smileage.text = String(120)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数を設定
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルがタップされた時の処理
        print("タップされたセルのindex番号: \(indexPath.row)")

        let alert: UIAlertController = UIAlertController(title: "確認", message: "このクーポンを使いますか？", preferredStyle:  UIAlertControllerStyle.alert)
        

        // 使用ボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "使用", style: UIAlertActionStyle.default, handler:{

            (action: UIAlertAction!) -> Void in
            /*
             *
             * To Do
             * クーポン使用の場合の処理を書く
             * 押したセルの情報を削除する
             * 押したセルのマイレージの分を使用可能マイレージから引く
             */
            print("OK")
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{

            (action: UIAlertAction!) -> Void in
            //キャンセルだから何もしない
            print("Cancel")
        })

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}



