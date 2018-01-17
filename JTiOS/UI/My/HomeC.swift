//
//  MyC.swift
//  JTiOS
//
//  Created by JT on 2018/1/12.
//  Copyright © 2018年 JT. All rights reserved.
//
class HomeC {
    
    func loginState(handler: ((Bool, String?) -> Void)? = nil) {
        global_SystemUser = nil
        ServiceManager.shareInstance.provider_2s.request(.loginState) {
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
    
    func logout(handler: ((Bool, String?) -> Void)? = nil) {
        guard let user = global_SystemUser else {
            if let h = handler {
                h(false, Messager.shareInstance.notLogin)
            }
            return
        }
        guard let id = user.id else {
            if let h = handler {
                h(false, Messager.shareInstance.notLogin)
            }
            return
        }
        let json = RequestJson_Logout(id: id)
        ServiceManager.shareInstance.provider.request(.logout(json: json)) {
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
                let res = ResponseJson_Base(JSONString: jsonStr)
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
                global_SystemUser = nil
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
    
    func getHeadPortrait(handler: ((Bool, Foundation.Data?, String?) -> Void)? = nil) {
        if let filename = global_SystemUser?.portraiturl {
            if let id = global_SystemUser?.id {
                let request = RequestObject_File(typenum: FileTypenum.HeadPortrait.rawValue, frid: id, filename: filename, prefix: ImagePrefix.Origin)
                WebFile.shareInstance.getFile(requestObject: request) {
                    success, data, msg in
                    if let h = handler {
                        h(success, data, msg)
                    }
                }
            }
        }
    }
    
    
    
}
