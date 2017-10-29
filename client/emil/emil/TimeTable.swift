//
//  TimeTable.swift
//  emil
//
//  Created by 山川拓也 on 2017/10/28.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
    
    class func hex ( hexStr : NSString, alpha : CGFloat) -> UIColor {
        var alpha = alpha
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("不正な値だよ")
            return UIColor.white
        }
    }
}

class TimeTable: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var total_smile: UILabel!
    
    @IBOutlet weak var timetabelColelctionView: UICollectionView!
    
    var weekArray = ["","日", "月", "火", "水", "木", "金", "土",
                     "1", "", "", "", "", "", "", "",
                     "2", "", "", "", "", "", "", "",
                     "休", "", "", "", "", "", "", "",
                     "3", "", "", "", "", "", "", "",
                     "4", "", "", "", "", "", "", "",
                     "昼", "", "", "", "", "", "", "",
                     "5", "", "", "", "", "", "", "",
                     "6", "", "", "", "", "", "", "",
                     "放", "", "", "", "", "", "", ""]
    var titles: [String] = [ "F7C594", "E4740E", "FFFFFF"]
    
    let cellMargin: CGFloat = 0.0 //マージン
    
    var comment = ""
//    let linePoint: CGFloat = 5     // 罫線の太さ
//    let numberOfCols: CGFloat = 7  // 1行に表示するセルの数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        total_smile.text = "18594"
        timetabelColelctionView.delegate = self
        timetabelColelctionView.dataSource = self
//        timetabelColelctionView.backgroundColor = UIColor.black
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
        switch(section){
        case 0:
            return 80
            
        default:
            print("error")
            return 0
        }
    }
    //3
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! CalendarCell
//        cell.textLabel.backgroundColor = UIColor.white
//        //テキストカラー
//        if (indexPath.row % 7 == 0) {
//            cell.textLabel.textColor = UIColor.red
//        } else if (indexPath.row % 7 == 6) {
//            cell.textLabel.textColor = UIColor.blue
//        } else {
//            cell.textLabel.textColor = UIColor.gray
//        }
//        //テキスト配置
//        if indexPath.section == 0 {
//            cell.textLabel.text = weekArray[indexPath.row]
//        } else {
//            cell.textLabel.text = leaves[indexPath.row]
//            //月によって1日の場所は異なる(後ほど説明します)
//        }
//
//        return cell
//    }
    
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = floor((collectionView.frame.size.width - (1*(8-1))) / 8)
        return CGSize(width:size, height:size)

    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
//    }
//
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 1
//    }
    
    /*
     Cellが選択された際に呼び出される
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        print("SectionNum:\(indexPath.section)")
        
    }
    
    /*
     Cellに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CalendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! CalendarCell
        
        switch(indexPath.section){
        case 0:
            
            /*
             * To Do
             * index.rowの値に応じて色を変えるようにする
             * 現状これはまずい
             */
            cell.backgroundColor = UIColor.white
            if (indexPath.row > 7 && indexPath.row % 8 != 0) {
                cell.backgroundColor = UIColor.hex(hexStr: "F7C594", alpha: 1)
            }
            if(indexPath.row % 7 == 0 && indexPath.row & 8 != 7){
                cell.backgroundColor = UIColor.hex(hexStr: "FFFFFF", alpha: 1)
                
            }
            if(indexPath.row == 17 || indexPath.row == 25 || indexPath.row == 53 || indexPath.row == 71 ||
                indexPath.row == 41 || indexPath.row == 37 || indexPath.row == 34 || indexPath.row == 67 ) {
                cell.backgroundColor = UIColor.hex(hexStr: "E4740E", alpha: 1)
            }
            if(indexPath.row == 18 || indexPath.row == 28 || indexPath.row == 75 || indexPath.row == 79 ||
                indexPath.row == 44 || indexPath.row == 68 || indexPath.row == 13 || indexPath.row == 21 ||
                indexPath.row == 50 || indexPath.row == 57 || indexPath.row == 17 || indexPath.row == 59) {
                cell.backgroundColor = UIColor.hex(hexStr: "EE9540", alpha: 1)
            }
            cell.textLabel.text = weekArray[indexPath.row]

        default:
            print("section error")
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    /*
     Sectionに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Section", for: indexPath)
        
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


