//
//  FileManager.swift
//  JTiOS
//
//  Created by JT on 2017/12/20.
//  Copyright © 2017年 JT. All rights reserved.
//
import Alamofire
class FileManage {
    static let shareInstance = FileManage()
    private init() {}
    
    lazy var documentDir: String = {
        let x = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return x ?? ""
    }()
    lazy var documentFile: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()
    lazy var cacheDir: String = {
        let x = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        return x ?? ""
    }()

    func cacheDirectoryDownloadDestination(subPaths: [String]?) -> DownloadRequest.DownloadFileDestination {
        var path = cacheDir
        if let subs = subPaths {
            var isDir = ObjCBool(true)
            for subPath in subs {
                path.append("/" + subPath)
                if !FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
                    try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                }
            }
        }
        let url = URL(fileURLWithPath: path)
        return { temporaryUrl, response in
            return (url, DownloadRequest.DownloadOptions.removePreviousFile)
        }
    }
}
