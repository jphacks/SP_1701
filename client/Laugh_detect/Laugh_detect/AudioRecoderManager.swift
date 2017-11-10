//
//  AudioRecoderManager.swift
//  Laugh_detect
//
//  Created by Yuto Kumagai on 2017/11/11.
//  Copyright © 2017年 !kie. All rights reserved.
//

import AVFoundation

class AudioRecoderManager: NSObject {
    static let sharedInstance = AudioRecoderManager()
    var audioRecorder: AVAudioRecorder?

    func setupAudioRecorder() {
        let recordSettings: [String: AnyObject] =
        [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject,
        AVEncoderBitRateKey: 16 as AnyObject,
        AVNumberOfChannelsKey: 2 as AnyObject,
        AVSampleRateKey: 44100.0 as AnyObject]
        
        /*
        do {
            //TODO
            //音声ファイルのパスをどのクラスからでも取得できるようにする
            //audioRecorder = try AVAudioRecorder(url: recordingURL! as URL, settings: recordSettings)
        } catch {
            //audioRecorder = nil
        }
 */
    }
}
