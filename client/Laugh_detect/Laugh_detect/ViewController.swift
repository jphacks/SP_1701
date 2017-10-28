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
    
    var audioRecorder: AVAudioRecorder?
    
    var dirURL: NSURL?
    var recordingURL: NSURL?
    let fileName = "recording.caf"

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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAudioRecorder() {
        
        // 録音用URLを設定
        let dirURL = documentsDirectoryURL()
        print(dirURL)
        let fileName = "recording.caf"
        let recordingsURL = dirURL.appendingPathComponent(fileName)
        
        // 録音設定
        let recordSettings: [String: AnyObject] =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject,
             AVEncoderBitRateKey: 16 as AnyObject,
             AVNumberOfChannelsKey: 2 as AnyObject,
             AVSampleRateKey: 44100.0 as AnyObject]
        
        do {
            audioRecorder = try AVAudioRecorder(url: recordingsURL!, settings: recordSettings)
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
            fileUpload()
        }else{
            audioRecorder?.record()
        }
    }
    
    func fileUpload(){
        let myUrl:NSURL = NSURL(string: "http://kentaiwami.jp")!
        let fileurldata:Data = try! Data(contentsOf:recordingURL! as URL)
        let request = NSMutableURLRequest(url: myUrl as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let base64String = fileurldata.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        let params = ["sound":[ "content_type": "audio/aac", "filename":"test.m4a", "file_data": base64String]]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
    
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if let data = data, let response = response {
                print(response)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(json)
                } catch {
                    print("Serialize Error")
                }
            } else {
                print(error ?? "Error")
            }
        }
        task.resume()
    }
        
}



