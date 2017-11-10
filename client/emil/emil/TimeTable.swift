//
//  TimeTable.swift
//  emil
//
//  Created by 山川拓也 on 2017/10/28.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit
import SwiftyJSON

class TimeTable: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var total_smile: UILabel!
    @IBOutlet weak var timetabelColelctionView: UICollectionView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
    
    let cellMargin: CGFloat = 0.0 //マージン
    
    var segment_number = 0
    
    var skip_number: Int = 0

    //    let linePoint: CGFloat = 5     // 罫線の太さ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        total_smile.text = String(appDelegate.total_smileage)
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
        
        cell.backgroundColor = UIColor.white
        
        if segment_number == 0 {
            drow_background_cell(data: appDelegate.this_week, cell: cell, indexPath: indexPath)
            
        }else if segment_number == 1{
            drow_background_cell(data: appDelegate.last_week, cell: cell, indexPath: indexPath)
            
        }else if segment_number == 2{
            drow_background_cell(data: appDelegate.last2_week, cell: cell, indexPath: indexPath)
            
        }
        cell.textLabel.text = weekArray[indexPath.row]
        
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
    
    /*
     *
     * セルごとに値を確認し、背景（芝生）の色を絵画する
     */

    func drow_background_cell(data: JSON, cell: CalendarCell, indexPath: IndexPath){
        for i in 0...8 {
            skip_number = 8*i + 9
            for j in 0...6 {
                if indexPath.row == skip_number {
                    
//                    print(indexPath.row)
//                    print(skip_number)
                    
                    switch data[i][j].intValue {
                    case 1...10:
                        cell.backgroundColor = UIColor.orange0()
                    case 11...20:
                        cell.backgroundColor = UIColor.orange1()
                    case 21...40:
                        cell.backgroundColor = UIColor.orange2()
                    case 41...60:
                        cell.backgroundColor = UIColor.orange3()
                    case 61...400:
                        cell.backgroundColor = UIColor.orange4()
                    case 0:
                        cell.backgroundColor = UIColor.white
                    default:
                        print("どこかがおかしいです")
                    }
                }
                skip_number = skip_number + 1
            }
        }
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     * セグメントボタンを押した時の処理
     * どこかのボタンを押すたびにCollectionViewをリロードするようにする
     */
    @IBAction func segment_change(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            segment_number = 0
            self.timetabelColelctionView.reloadData()
        case 1:
            segment_number = 1
            self.timetabelColelctionView.reloadData()
        case 2:
            segment_number = 2
            self.timetabelColelctionView.reloadData()
        default:
            break
        }
    }
}
