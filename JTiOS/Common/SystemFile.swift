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
    
    func uploadFullDirectoryFiles(typenum: FileTypenum, frid: Int, handler: ((Bool, String?) -> Void)? = nil) {
        let url = getDirectoryURL(typenum: typenum, frid: Int64(frid))
        var isDir = ObjCBool(true)
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) else { return }
        let contents = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
        guard let c = contents else { return }
        
        var uploadFiles = [Object_FileUpload]()
        for item in c {
            let path = item.path
            let filename = item.lastPathComponent
            guard FileManager.default.fileExists(atPath: path) && FileManager.default.isWritableFile(atPath: path) else { continue }
            let pathExtension = item.pathExtension.uppercased()
            let mime: String
            if pathExtension == "JPEG" {
                mime = "image/jpeg"
            } else if pathExtension == "JPG" {
                mime = "image/jpg"
            } else {
                mime = ""
            }
            let data = FileManager.default.contents(atPath: path)
            guard let d = data else { continue }
            let upload = Object_FileUpload(data: d, name: "file", fileName: filename, mimeType: mime)
            uploadFiles.append(upload)
        }
        let request = RequestObject_FileUpload(typenum: typenum, frid: frid, actualtime: Date(), files: uploadFiles)
        WebFile.shareInstance.uploadFile(requestObject: request, handler: handler)
    }
    
}
