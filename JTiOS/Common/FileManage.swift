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
    lazy var tmpDir: String = {
        var x = NSTemporaryDirectory()
        if "/" == x.last {
            x.removeLast()
        }
        return x
    }()
    
    func saveFile(url: URL, data: Foundation.Data) -> Bool {
        let dir = url.deletingLastPathComponent()
        createDirectory(url: dir)
        do {
            try data.write(to: url)
            return true
        }
        catch { return false }
    }
    
    func createDirectory(path: String) {
        var isDir = ObjCBool(true)
        if !FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            try! FileManager.default.createDirectory(
                atPath: path,
                withIntermediateDirectories: true,
                attributes: nil)
        }
    }
    func createDirectory(url: URL){
        var isDir = ObjCBool(true)
        if !FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) {
            try! FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil)
        }
    }

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
