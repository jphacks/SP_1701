//
//  EditCoupon.swift
//  emil
//
//  Created by 山川拓也 on 2017/10/29.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit

class EditCoupon: UIViewController {
    
    @IBOutlet weak var giftText: UITextField!
    @IBOutlet weak var smileageNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveToCoupon(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
