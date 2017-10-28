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
}

class TimeTable: UIViewController {
    
    @IBOutlet weak var total_smile: UILabel!
    @IBOutlet weak var oneday_smile: UILabel!
    
    @IBOutlet weak var timetabelColelctionView: UICollectionView!
    
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timetabelColelctionView.delegate = self as? UICollectionViewDelegate
        timetabelColelctionView.dataSource = self as? UICollectionViewDataSource
        timetabelColelctionView.backgroundColor = UIColor.green
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


