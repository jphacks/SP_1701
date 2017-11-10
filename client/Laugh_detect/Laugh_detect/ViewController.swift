//
//  ViewController.swift
//  Laugh_detect
//
//  Created by Yuto Kumagai on 2017/10/27.
//  Copyright © 2017年 !kie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recLabel: UILabel!

    var obj: PowerLevel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AudioRecoderManagerのrecFlagを監視
        AudioRecoderManager.shared.addObserver(self, forKeyPath: "recFlag",options: [.old, .new], context: nil)
        
        obj = PowerLevel()
        obj?.start()
        
    }
    
    //AudioRecoderManagerのrecFlagの値が変更された際に呼ばれる
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if(change![.newKey]! as! Bool){  //ture
            recLabel.text = "Rec"
        }else{
            recLabel.text = ""
        }
    }
    
    @IBAction func startRecordButtonTapped(_ sender: Any) {
        if (AudioRecoderManager.shared.audioRecorder?.isRecording)! {
            AudioRecoderManager.shared.audioRecorder?.stop()
            convertFile(fileURL: FilePathManager.shared.path! as URL)
        }else{
            AudioRecoderManager.shared.audioRecorder?.record()
            AudioRecoderManager.shared.setRecFlag(bool: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



