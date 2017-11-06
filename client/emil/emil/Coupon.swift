//
//  TimeTable.swift
//  emil
//
//  Created by 山川拓也 on 2017/10/28.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit

extension UIColor {
    class func orange0() -> UIColor {
        return UIColor(red: 254.0 / 255, green: 241.0 / 255, blue: 229.0 / 255, alpha: 1.0)
    }
    
    class func orange1() -> UIColor {
        return UIColor(red: 248.0 / 255, green: 198.0 / 255, blue: 149.0 / 255, alpha: 1.0)
    }
    
    class func orange2() -> UIColor {
        return UIColor(red: 240.0 / 255, green: 175.0 / 255, blue: 110.0 / 255, alpha: 1.0)
    }
    
    class func orange4() -> UIColor {
        return UIColor(red: 238.0 / 255, green: 150.0 / 255, blue: 64.0 / 255, alpha: 1.0)
    }
    
    class func orange5() -> UIColor {
        return UIColor(red: 229.0 / 255, green: 116.0 / 255, blue: 15.0 / 255, alpha: 1.0)
    }
}

class Coupon: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Coupon: UITableView!
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var AddCouponBtn: UIButton!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var TotalAll: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var t = 0
    var ta = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Coupon.register(UINib(nibName: "CustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCellTableViewCell")
        
        
        /* 画面上部の影部分 */
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.3 // 透明度
        shadow.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        shadow.layer.shadowRadius = 5 // ぼかし量
        
        /* 画面下部の新規追加ボタンの設定 */
        AddCouponBtn.backgroundColor = UIColor.orange4()
        AddCouponBtn.layer.borderWidth = 2.0
//        AddCouponBtn.layer.borderColor = UIColor.red.cgColor
        AddCouponBtn.layer.cornerRadius = 10.0
        AddCouponBtn.setTitleColor(UIColor.white,for: UIControlState.normal)
        AddCouponBtn.layer.masksToBounds = true

        Coupon.delegate = self
        Coupon.dataSource = self
        
        Total.text = "18594"
        TotalAll .text = "18594"
        
        t = Int(Total.text!)!
        ta = Int(TotalAll.text!)!
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
        cell.gift.text = appDelegate.coupon_data[indexPath.row].gift
        cell.smileage.text = String(appDelegate.coupon_data[indexPath.row].smileage)

        if let path: String = Bundle.main.path(forResource: "check", ofType: "png") {
            cell.couponImg.image = UIImage(contentsOfFile: path)
        }else {
            print("指定されたファイルが見つかりません")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数を設定
        return appDelegate.coupon_data.count
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
            print("OK")
            self.t = self.ta - self.appDelegate.coupon_data[indexPath.row].smileage
            self.ta = self.t
            
            self.Total.text = String(self.t)
            self.appDelegate.coupon_data.remove(at: indexPath.row)
            self.Coupon.reloadData()
            
            
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
    
    /* 戻るボタン */
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moveToEdit(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "EditCoupon", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    
}



