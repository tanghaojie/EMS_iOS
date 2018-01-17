//
//  Image.swift
//  JTiOS
//
//  Created by JT on 2018/1/16.
//  Copyright © 2018年 JT. All rights reserved.
//
class Image {
    static let shareInstance = Image()
    private init() {}
    
    func saveImage(requestObject: RequestObject_FileDownload, handler: ((Bool, String?) -> Void)? = nil) {
        ServiceManager.shareInstance.provider.request(Service.fileDownload(object: requestObject)) {
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
    func getImage(requestObject: RequestObject_File, handler: ((Bool, Foundation.Data?, String?) -> Void)? = nil) {
        ServiceManager.shareInstance.provider.request(Service.file(object: requestObject)) {
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
    
}
