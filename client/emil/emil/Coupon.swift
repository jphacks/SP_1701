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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Coupon.register(UINib(nibName: "CustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCellTableViewCell")

        // Delegate設定
        Coupon.delegate = self
        
        // DataSource設定
        Coupon.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作る
        
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
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // アクセサリボタン（セルの右にあるボタン）がタップされた時の処理
        print("タップされたアクセサリがあるセルのindex番号: \(indexPath.row)")
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}



