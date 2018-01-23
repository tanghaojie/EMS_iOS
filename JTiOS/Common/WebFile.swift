//
//  Image.swift
//  JTiOS
//
//  Created by JT on 2018/1/16.
//  Copyright © 2018年 JT. All rights reserved.
//
class WebFile {
    static let shareInstance = WebFile()
    private init() {}
    
    func saveFile(requestObject: RequestObject_FileDownload, handler: ((Bool, String?) -> Void)? = nil) {
        ServiceManager.shareInstance.provider.request(.fileDownload(object: requestObject)) {
            result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if 200 != statusCode {
                    if let h = handler {
                        h(false, Messager.shareInstance.failedHttpResponseStatusCode)
                    }
                    return
                }
                if let h = handler {
                    h(true, nil)
                }
            case let .failure(error):
                if let h = handler {
                    h(false, error.errorDescription)
                }
            }
        }
    }
    func getFile(requestObject: RequestObject_File, handler: ((Bool, Foundation.Data?, String?) -> Void)? = nil) {
        ServiceManager.shareInstance.provider.request(.file(object: requestObject)) {
            result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if 200 != statusCode {
                    if let h = handler {
                        h(false, nil, Messager.shareInstance.failedHttpResponseStatusCode)
                    }
                    return
                }
                if let h = handler {
                    h(true, moyaResponse.data, nil)
                }
            case let .failure(error):
                if let h = handler {
                    h(false, nil, error.errorDescription)
                }
            }
        }
    }
    func uploadFile(requestObject: RequestObject_FileUpload, handler: ((Bool, String?, [Object_FileUploadResponse]?) -> Void)? = nil) {
        ServiceManager.shareInstance.provider_300s.request(Service.fileUpload(object: requestObject)) {
            result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if 200 != statusCode {
                    if let h = handler {
                        h(false, Messager.shareInstance.failedHttpResponseStatusCode, nil)
                    }
                    return
                }
                let data = moyaResponse.data
                let json = String(data: data, encoding: .utf8)
                guard let jsonStr = json else {
                    if let h = handler {
                        h(false, Messager.shareInstance.unableParseData2String, nil)
                    }
                    return
                }
                let res = ResponseJson_FileUpload(JSONString: jsonStr)
                guard let r = res else {
                    if let h = handler {
                        h(false, Messager.shareInstance.unableParseJsonString2JsonObject, nil)
                    }
                    return
                }
                guard 0 == r.status else {
                    if let h = handler {
                        h(false, r.msg, nil)
                    }
                    return
                }
                if let h = handler {
                    h(true, nil, r.data)
                }
            case let .failure(error):
                if let h = handler {
                    h(false, error.errorDescription, nil)
                }
            }
        }
    }
    
    func uploadJTMediaPickerData(media: [JTMediaPickerData], typenum: FileTypenum, frid: Int) {
        let count = media.count
        if count <= 0 { return }
        for index in 0 ..< count {
            let m = media[index]
            let mUrl = m.url
            let path = mUrl.path
            if !FileManager.default.fileExists(atPath: path) || !FileManager.default.isReadableFile(atPath: path) { continue }
            
            let filename = mUrl.lastPathComponent
            let pathExtension = mUrl.pathExtension.uppercased()
            let mime: String
            if pathExtension == "JPEG" { mime = "image/jpeg" }
            else if pathExtension == "JPG" { mime = "image/jpg" }
            else if pathExtension == "PNG" { mime = "image/png" }
            else if pathExtension == "MP4" { mime = "video/mp4" }
            else { mime = "" }
            let data = FileManager.default.contents(atPath: path)
            guard let d = data else { continue }
            let upload = Object_FileUpload(data: d, name: "file", fileName: filename, mimeType: mime)
            let request = RequestObject_FileUpload(typenum: typenum, frid: frid, actualtime: Date(), files: [upload])
            WebFile.shareInstance.uploadFile(requestObject: request) { success, _, response in
                if success, let res = response {
                    for r in res {
                        guard let old = r.oldfilename else { continue }
                        guard old.uppercased() == filename.uppercased() else { continue }
                        guard let new = r.filename else { continue }
                        let newUrl = SystemFile.shareInstance.getFileURL(typenum: typenum, frid: Int64(frid), filename: new)
                        let _ = FileManage.shareInstance.copyItem(from: mUrl, to: newUrl)
                    }
                }
            }
        }
        
    }
    
}
