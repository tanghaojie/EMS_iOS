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
    func uploadFile(requestObject: RequestObject_FileUpload, handler: ((Bool, String?) -> Void)? = nil) {
        ServiceManager.shareInstance.provider.request(Service.fileUpload(object: requestObject)) {
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
                let data = moyaResponse.data
                let json = String(data: data, encoding: .utf8)
                guard let jsonStr = json else {
                    if let h = handler {
                        h(false, Messager.shareInstance.unableParseData2String)
                    }
                    return
                }
                let res = ResponseJson_FileUpload(JSONString: jsonStr)
                guard let r = res else {
                    if let h = handler {
                        h(false, Messager.shareInstance.unableParseJsonString2JsonObject)
                    }
                    return
                }
                guard 0 == r.status else {
                    if let h = handler {
                        h(false, r.msg)
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
    
}
