//
//  APIUrl.swift
//  JTiOS
//
//  Created by JT on 2017/12/22.
//  Copyright © 2017年 JT. All rights reserved.
//

class APIUrl {
    static var baseUrl = "http://39.104.66.207:10064/emsweb"
    
    static let login = "api/user/Login"
    static var loginFullUrl: String { get { return APIUrl.baseUrl + "/" + APIUrl.login } }
    
    static let logout = "api/user/Logout"
    
    static let loginState = "api/user/LoginState"
    
    static let queryEventList = "api/event/QueryEventList"
    
    static let getGroupConfig = "api/config/GetGroupConfig"
    
    static let createEvent = "api/event/CreateEvent"
    
    static let queryTaskList = "api/task/QueryTaskList"
    
    static let queryEventInfo = "api/event/QueryEventInfo"
    static var queryEventInfoFullUrl: String { get { return APIUrl.baseUrl + "/" + APIUrl.queryEventInfo } }
    
    static let queryProcessList = "api/process/QueryProcessList"
    
    static let createProcessExecute = "api/process/CreateProcessExecute"
}
