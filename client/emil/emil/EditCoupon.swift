//
//  EditCoupon.swift
//  emil
//
//  Created by 山川拓也 on 2017/10/29.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit

class EditCoupon: UIViewController, UITextFieldDelegate,UITextViewDelegate {
    
    
    @IBOutlet weak var giftText: UITextView!
    @IBOutlet weak var smileageNumber: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var gt = "" //やることの文
    var sp = 0 //スマイレージ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giftText.layer.borderColor = UIColor.gray.cgColor
        giftText.layer.borderWidth = 1.0
        smileageNumber.layer.borderColor = UIColor.gray.cgColor
        smileageNumber.layer.borderWidth = 1.0
        
        giftText.returnKeyType = .done
        smileageNumber.returnKeyType = .done
        
        
        giftText.delegate = self
        smileageNumber.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveToCoupon(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Coupon", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    

    //「やること」が変更された
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange : \(giftText.text!)")
        gt = String(giftText.text)
        
    }
    
    /*
     UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
     */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        sp = Int(textField.text!)!
        return true
    }
    
    /*
     改行ボタンが押された際に呼ばれるデリゲートメソッド.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder() //キーボードを閉じる
            return false
        }
        return true
    }
    
    func showOK() {
        
        let alert = UIAlertController(
            title: "完了",
            message: "登録しました",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true, completion: nil)
        appDelegate.coupon_data.append((gift: gt, smileage: sp))
    }
    
    @IBAction func alertShow(_ sender: Any) {
        showOK()
        /*
         * To Do
         * 配列にデータを追加する
         *
         */
    }
    
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

