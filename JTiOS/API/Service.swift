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
    case logout(json: RequestJson_Logout)
    case queryFile(json: RequestJson_QueryFile)
    case fileDownload(object: RequestObject_FileDownload)
    case file(object: RequestObject_File)
    case fileUpload(object: RequestObject_FileUpload)
    case queryRelationEventList(object: RequestJson_QueryRelationEventList)
    case uploadPoints(object: RequestJson_UploadPoints)
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
        case .logout:
            return APIUrl.logout
        case .queryFile:
            return APIUrl.queryFile
        case .fileDownload(let object):
            return APIUrl.file + "/" + String(describing: object.typenum.rawValue) + "/" + String(describing: object.frid)
        case .file(let object):
            return APIUrl.file + "/" + String(describing: object.typenum.rawValue) + "/" + String(describing: object.frid)
        case .fileUpload:
            return APIUrl.fileUpload
        case .queryRelationEventList:
            return APIUrl.queryRelationEventList
        case .uploadPoints:
            return APIUrl.uploadPoints
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .queryEventList, .getGroupConfig, .createEvent, .queryTaskList, .queryEventInfo, .queryProcessList, .createProcessExecute, .loginState, .logout, .queryFile, .fileUpload, .queryRelationEventList, .uploadPoints :
            return .post
        case .fileDownload, .file:
            return .get
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
        case .logout(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .queryFile(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .fileDownload(let object):
            return Task.downloadParameters(parameters: ["filename": object.prefix.rawValue + object.filename], encoding: URLEncoding.queryString, destination: object.destination)
        case .file(let object):
            return Task.requestParameters(parameters: ["filename": object.prefix.rawValue + object.filename], encoding: URLEncoding.queryString)
        case .fileUpload(let object):
            var multipartDatas = [MultipartFormData]()
            for file in object.files {
                let data = MultipartFormData(provider: .data(file.data), name: file.name, fileName: file.fileName, mimeType: file.mimeType)
                multipartDatas.append(data)
            }
            let urlParameters: [String : Any] = ["frid": object.frid, "typenum": object.typenum.rawValue, "actualtime": object.actualtime]
            return Task.uploadCompositeMultipart(multipartDatas, urlParameters: urlParameters)
        case .queryRelationEventList(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
        case .uploadPoints(let json):
            return Task.requestData((json.toJSONString()?.utf8Encoded)!)
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
            return "nil".utf8Encoded
        case .logout(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .queryFile(let json):
            return (json.toJSONString()?.utf8Encoded)!
        case .fileDownload:
            return "nil".utf8Encoded
        case .file:
            return "nil".utf8Encoded
        case .fileUpload:
            return "nil".utf8Encoded
        case .queryRelationEventList:
            return "nil".utf8Encoded
        case .uploadPoints:
            return "nil".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}
