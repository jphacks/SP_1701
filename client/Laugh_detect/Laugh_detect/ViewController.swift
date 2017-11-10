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
    
    var audioRecorder: AVAudioRecorder?
    
    var dirURL: NSURL?
    var recordingURL: NSURL?
    let fileName = "recording.caf"
    var obj: PowerLevel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 録音可能カテゴリに設定する
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch  {
            fatalError("カテゴリ設定失敗")
        }
        
        // sessionのアクティブ化
        do {
            try session.setActive(true)
        } catch {
            fatalError("session有効化失敗")
        }
        self.setupAudioRecorder()
        
        obj = PowerLevel()
        obj?.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAudioRecorder() {
        let recordSettings: [String: AnyObject] =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject,
             AVEncoderBitRateKey: 16 as AnyObject,
             AVNumberOfChannelsKey: 2 as AnyObject,
             AVSampleRateKey: 44100.0 as AnyObject]
        
        do {
            audioRecorder = try AVAudioRecorder(url: FilePathManager.shared.path! as URL, settings: recordSettings)
        } catch {
            audioRecorder = nil
        }
        
    }

    @IBAction func startRecordButtonTapped(_ sender: Any) {
        if (audioRecorder?.isRecording)! {
            audioRecorder?.stop()
            convertFile(fileURL: FilePathManager.shared.path! as URL)
            recLabel.text = ""
        }else{
            audioRecorder?.record()
            recLabel.text = "Rec"
        }
    }
}



