//
//  PowerLevel.swift
//  Laugh_detect
//
//  Created by Yuto Kumagai on 2017/11/09.
//  Copyright © 2017年 !kie. All rights reserved.
//

import AVFoundation

final class PowerLevel: NSObject {
    private let captureSession_ = AVCaptureSession()

    private let serialQueue_ = DispatchQueue(label: "PowerLevel.serialqueue.audio")
    override init() {
        super.init()
        setupCaptureRoute()
    }
    
    func setupCaptureRoute() {
        // OSがデフォルトにしているマイクデバイスを選ぶ
        let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
        
        // マイクデバイスをキャプチャセッションにつなぐ入力クラスを用意
        let audioInput = try! AVCaptureDeviceInput(device: audioDevice!)
        
        // マイク入力の出力先（今回はデータをデリゲートメソッドに渡す）を用意
        let audioDataOut = AVCaptureAudioDataOutput()
        // デリゲートオブジェクトを設定
        audioDataOut.setSampleBufferDelegate(self, queue: serialQueue_)
        
        // キャプチャセッションに入出力を接続。これでいつでもstartできる
        captureSession_.addInput(audioInput)
        captureSession_.addOutput(audioDataOut)
    }
    
    func start() { captureSession_.startRunning() /* 開始 */ }
    func stop() { captureSession_.stopRunning() /* 停止 */ }
}

// デリゲートメソッドの用意
extension PowerLevel: AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       fromConnection connection: AVCaptureConnection!) {
        
        // キャプチャコネクションからオーディオチャンネルを取得し、パワーレベル(dB)を入手
        let audioChannels = connection.audioChannels.filter{ $0 is AVCaptureAudioChannel }
        audioChannels.forEach {
            print("\($0.averagePowerLevel) / \($0.peakHoldLevel)")
        }
    }
}