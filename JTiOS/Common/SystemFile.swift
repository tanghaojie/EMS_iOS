//
//  SystemFile.swift
//  JTiOS
//
//  Created by JT on 2018/1/21.
//  Copyright © 2018年 JT. All rights reserved.
//
class SystemFile {
    static let shareInstance = SystemFile()
    private init() {}
    
    private let name = "JT"
    
    public var directoryURL: URL {
        get {
            let cache = FileManage.shareInstance.cacheDir
            var url = URL(fileURLWithPath: cache, isDirectory: true)
            url.appendPathComponent(name, isDirectory: true)
            return url
        }
    }
    
    func getDirectoryURL(typenum: FileTypenum, frid: Int64) -> URL {
        var url = directoryURL.appendingPathComponent(String(typenum.rawValue), isDirectory: true)
        url.appendPathComponent(String(frid), isDirectory: true)
        return url
    }
    
    func getFileURL(typenum: FileTypenum, frid: Int64, filename: String, withCreateDirectory: Bool = true) -> URL {
        var url = getDirectoryURL(typenum: typenum, frid: frid)
        if withCreateDirectory {
            FileManage.shareInstance.createDirectory(url: url)
        }
        url.appendPathComponent(filename)
        return url
    }
}
