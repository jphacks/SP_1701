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
            // エラー処理
            fatalError("カテゴリ設定失敗")
        }
        
        // sessionのアクティブ化
        do {
            try session.setActive(true)
        } catch {
            // audio session有効化失敗時の処理
            // (ここではエラーとして停止している）
            fatalError("session有効化失敗")
        }
        
        dirURL = documentsDirectoryURL()
        recordingURL = dirURL?.appendingPathComponent(fileName) as NSURL?
        
        self.setupAudioRecorder()
        
        obj = PowerLevel()
        obj?.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAudioRecorder() {
        // 録音設定
        let recordSettings: [String: AnyObject] =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject,
             AVEncoderBitRateKey: 16 as AnyObject,
             AVNumberOfChannelsKey: 2 as AnyObject,
             AVSampleRateKey: 44100.0 as AnyObject]
        
        do {
            audioRecorder = try AVAudioRecorder(url: recordingURL! as URL, settings: recordSettings)
        } catch {
            audioRecorder = nil
        }
        
    }
    /// DocumentsのURLを取得
    func documentsDirectoryURL() -> NSURL {
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        
        if urls.isEmpty {
            
            fatalError("URLs for directory are empty.")
        }
        
        return urls[0] as NSURL
    }
    
    @IBAction func startRecordButtonTapped(_ sender: Any) {
        if (audioRecorder?.isRecording)! {
            audioRecorder?.stop()
            convertFile(fileURL: recordingURL! as URL)
            recLabel.text = ""
        }else{
            audioRecorder?.record()
            recLabel.text = "Rec"
        }
    }
}



