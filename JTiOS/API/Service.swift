//
//  Service.swift
//  JTiOS
//
//  Created by JT on 2017/12/21.
//  Copyright © 2017年 JT. All rights reserved.
//

import Moya
enum Service {
    case login(json: RequestJson_Login)
    case queryEventList(json: RequestJson_QueryEventList)
    case getGroupConfig(json: RequestJson_GetGroupConfig)
    case createEvent(json: RequestJson_CreateEvent)
    case queryTaskList(json: RequestJson_QueryTaskList)
    case queryEventInfo(json: RequestJson_QueryEventInfo)
    case queryProcessList(json: RequestJson_QueryProcessList)
    case createProcessExecute(json: RequestJson_CreateProcessExecute)
    case loginState
}
extension Service: TargetType {
    var baseURL: URL { return URL(string: APIUrl.baseUrl)! }
    var path: String {
        switch self {
        case .login:
            return APIUrl.login
        case .queryEventList:
            return APIUrl.queryEventList
        case .getGroupConfig:
            return APIUrl.getGroupConfig
        case .createEvent:
            return APIUrl.createEvent
        case .queryTaskList:
            return APIUrl.queryTaskList
        case .queryEventInfo:
            return APIUrl.queryEventInfo
        case .queryProcessList:
            return APIUrl.queryProcessList
        case .createProcessExecute:
            return APIUrl.createProcessExecute
        case .loginState:
            return APIUrl.loginState
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .queryEventList, .getGroupConfig, .createEvent, .queryTaskList, .queryEventInfo, .queryProcessList, .createProcessExecute, .loginState :
            return .post
        }
    }
    var task: Task {
        switch self {
        case .login(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .queryEventList(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .getGroupConfig(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .createEvent(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .queryTaskList(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .queryEventInfo(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .queryProcessList(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .createProcessExecute(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .loginState:
            return Task.requestPlain
        }
    }
    var sampleData: Foundation.Data {
        switch self {
        case .login(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .queryEventList(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .getGroupConfig(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .createEvent(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .queryTaskList(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .queryEventInfo(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .queryProcessList(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .createProcessExecute(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .loginState:
            return "sdf".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
