//
//  FileConverter.swift
//  Laugh_detect
//
//  Created by Yuto Kumagai on 2017/11/10.
//  Copyright © 2017年 !kie. All rights reserved.
//

import AVFoundation

public func convertFile(fileURL: URL) {
    let audioURL = fileURL
    let fileMgr = FileManager.default
    let dirPaths = fileMgr.urls(for: .documentDirectory,
                                in: .userDomainMask)
    let outputUrl = dirPaths[0].appendingPathComponent("recording.mp4")
    let asset = AVAsset.init(url: audioURL)
    let exportSession = AVAssetExportSession.init(asset: asset, presetName: AVAssetExportPresetHighestQuality)
    
    // remove file if already exits
    let fileManager = FileManager.default
    do{
        try? fileManager.removeItem(at: outputUrl)
    }catch{
        print("can't")
    }
    
    exportSession?.outputFileType = AVFileType.mp4
    exportSession?.outputURL = outputUrl
    exportSession?.metadata = asset.metadata
    exportSession?.exportAsynchronously(completionHandler: {
        if (exportSession?.status == .completed)
        {
            print("AV export succeeded.")
            fileUpload(fileURL: outputUrl)
            
        }
        else if (exportSession?.status == .cancelled)
        {
            print("AV export cancelled.")
        }
        else
        {
            print ("Error is \(String(describing: exportSession?.error))")
            
        }
    })
}
