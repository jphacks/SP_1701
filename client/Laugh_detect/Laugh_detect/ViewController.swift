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
    @IBOutlet weak var recImg: UIImageView!
    
    var powerLevel: PowerLevel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AudioRecoderManagerのrecFlagを監視
        AudioRecoderManager.shared.addObserver(self, forKeyPath: "recFlag",options: [.old, .new], context: nil)
        
        //マイクからの音量検知を開始
        powerLevel = PowerLevel()
        powerLevel?.start()
        
    }
    
    //AudioRecoderManagerのrecFlagの値が変更された際に呼ばれる
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if(change![.newKey]! as! Bool){  //ture
            recLabel.text = "Rec"
            recImg.image = UIImage(named: "mic1.png")!
        }else{
            recLabel.text = ""
            recImg.image = UIImage(named: "mic0.png")!
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



