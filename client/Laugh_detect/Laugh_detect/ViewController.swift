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
        
        obj = PowerLevel()
        obj?.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRecordButtonTapped(_ sender: Any) {
        //if (audioRecorder?.isRecording)! {
        if (AudioRecoderManager.shared.audioRecorder?.isRecording)! {
            AudioRecoderManager.shared.audioRecorder?.stop()
            convertFile(fileURL: FilePathManager.shared.path! as URL)
            recLabel.text = ""
        }else{
            AudioRecoderManager.shared.audioRecorder?.record()
            recLabel.text = "Rec"
        }
    }
}



