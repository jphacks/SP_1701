//
//  AudioRecoderManager.swift
//  Laugh_detect
//
//  Created by Yuto Kumagai on 2017/11/11.
//  Copyright © 2017年 !kie. All rights reserved.
//

import AVFoundation

class AudioRecoderManager: NSObject {
    static let shared = AudioRecoderManager()
    var audioRecorder: AVAudioRecorder?
    
    private override init(){
        super.init()
        setupAudioSession()
        setupAudioRecorder()
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

    func setupAudioSession(){
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
    }
}
