//
//  FilePathManager.swift
//  Laugh_detect
//
//  Created by Yuto Kumagai on 2017/11/11.
//  Copyright © 2017年 !kie. All rights reserved.
//

import Foundation

class FilePathManager: NSObject {
    static let shared = FilePathManager()
    var path: NSURL?
    
    private override init(){
        super.init()
        let directoryURL = documentsDirectoryURL()
        let fileName = "recording.caf"
        path = directoryURL.appendingPathComponent(fileName) as NSURL?
    }
    
    func documentsDirectoryURL() -> NSURL {
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        
        if urls.isEmpty {
            fatalError("URLs for directory are empty.")
        }
        return urls[0] as NSURL
    }
}
