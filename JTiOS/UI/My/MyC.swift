//
//  MyC.swift
//  JTiOS
//
//  Created by JT on 2018/1/12.
//  Copyright © 2018年 JT. All rights reserved.
//
class MyC {
    
    func loginState(handler: ((Bool, String?) -> Void)? = nil) {
        global_SystemUser = nil
        ServiceManager.shareInstance.provider.request(.loginState) {
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
                let res = ResponseJson_Login(JSONString: jsonStr)
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
                global_SystemUser = r.data
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
