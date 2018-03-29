//
//  APIUrl.swift
//  JTiOS
//
//  Created by JT on 2017/12/22.
//  Copyright © 2017年 JT. All rights reserved.
//

class APIUrl {
    //http://218.6.216.146:10064/emsweb
    internal static var baseUrl = "/"
    internal static let test = "api/app/test"
    internal static let login = "api/user/Login"
    internal static let logout = "api/user/Logout"
    internal static let loginState = "api/user/LoginState"
    internal static let queryEventList = "api/event/QueryEventList"
    internal static let queryRelationEventList = "api/event/QueryRelationEventList"
    internal static let getGroupConfig = "api/config/GetGroupConfig"
    internal static let createEvent = "api/event/CreateEvent"
    internal static let queryTaskList = "api/task/QueryTaskList"
    internal static let queryEventInfo = "api/event/QueryEventInfo"
    internal static let queryProcessList = "api/process/QueryProcessList"
    internal static let createProcessExecute = "api/process/CreateProcessExecute"
    internal static let queryFile = "api/file/QueryFile"
    internal static let file = "api/file"
    internal static let fileUpload = "api/file/UploadFile"
    internal static let uploadPoints = "api/track/UploadPoints"
}

extension APIUrl {
    internal static var loginFullUrl: String { get { return APIUrl.baseUrl + "/" + APIUrl.login } }
    internal static var queryEventInfoFullUrl: String { get { return APIUrl.baseUrl + "/" + APIUrl.queryEventInfo } }
}

extension APIUrl {
    
    internal static func getBaseUrl() {
        guard let settings = Data.shareInstance.GetData_Settings() else { return }
        if let u = settings.apiBaseUrl {
            baseUrl = u
        }
    }
    
    internal static func checkAPIStatus(handler: ((Bool) -> Void)? = nil) {
        ServiceManager.shareInstance.provider.request(.test) {
            result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                guard 200 == statusCode else {
                    if let h = handler { h(false) }
                    return
                }
                let json = String(data: moyaResponse.data, encoding: .utf8)
                guard let jsonStr = json else {
                    if let h = handler { h(false) }
                    return
                }
                let res = ResponseJson_Base(JSONString: jsonStr)
                guard let r = res else {
                    if let h = handler { h(false) }
                    return
                }
                guard 0 == r.status else {
                    if let h = handler { h(false) }
                    return
                }
                if let h = handler { h(true) }
            case .failure(_):
                if let h = handler { h(false) }
                return
            }
        }
    }
    
}
