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
    
    private let fileManager = FileManager.default
    let tmpImageSaveDir = "JT_Image_Temp_Directory_123"
    
    lazy var documentDir: String = {
        let x = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return x ?? ""
    }()
    lazy var documentFile: URL = {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
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
        if !fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            try! fileManager.createDirectory(
                atPath: path,
                withIntermediateDirectories: true,
                attributes: nil)
        }
    }
    func createDirectory(url: URL){
        var isDir = ObjCBool(true)
        if !fileManager.fileExists(atPath: url.path, isDirectory: &isDir) {
            try! fileManager.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil)
        }
    }
    
    func copyItem(from: URL, to: URL) -> Bool {
        guard fileManager.fileExists(atPath: from.path) && fileManager.isReadableFile(atPath: from.path) else { return false }
        do {
            try fileManager.copyItem(at: from, to: to)
            return true
        } catch {
            return false
        }
    }
    
    func fileExist(atPath: String) -> Bool {
        return fileManager.fileExists(atPath: atPath)
    }
    
    func delete(url: URL) -> Bool {
        if !fileManager.fileExists(atPath: url.path) { return true }
        if !fileManager.isDeletableFile(atPath: url.path) { return false }
        do {
            try fileManager.removeItem(at: url)
            return true
        } catch {
            return false
        }
    }

    func cacheDirectoryDownloadDestination(subPaths: [String]?) -> DownloadRequest.DownloadFileDestination {
        var path = cacheDir
        if let subs = subPaths {
            var isDir = ObjCBool(true)
            for subPath in subs {
                path.append("/" + subPath)
                if !fileManager.fileExists(atPath: path, isDirectory: &isDir) {
                    try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                }
            }
        }
        let url = URL(fileURLWithPath: path)
        return { temporaryUrl, response in
            return (url, DownloadRequest.DownloadOptions.removePreviousFile)
        }
    }
}
