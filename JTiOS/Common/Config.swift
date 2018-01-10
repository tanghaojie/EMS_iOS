//
//  Config.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//
class Config {
    var typename: String!
    var getGroupConfig: Object_GetGroupConfig?
    
    static let EventTypeName = "EventType"
    static let EventLevelName = "EventLevel"
    static func getConfig(successHandler: (([Object_GetGroupConfig])->Void)? = nil) {
        guard let u = systemUser, let uid = u.id else { return }
        let jsonGetGroupConfig = RequestJson_GetGroupConfig()
        jsonGetGroupConfig.id = uid
        ServiceManager.shareInstance.provider.request( .getGroupConfig(json: jsonGetGroupConfig)) {
            result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if 200 != statusCode { return }
                let data = moyaResponse.data
                let json = String(data: data, encoding: .utf8)
                guard let jsonStr = json else { return }
                let res = ResponseJson_GetGroupConfig(JSONString: jsonStr)
                guard let r = res else { return }
                if 0 != r.status { return }
                systemAllConfig = r.data
                if let h = successHandler, let c = systemAllConfig { h(c) }
            case .failure(_): break
            }
        }
    }
    
    init(typename: String) {
        self.typename = typename
        guard let c = systemAllConfig else {
            Config.getConfig()
            return
        }
        for x in c {
            if typename == x.name {
                getGroupConfig = x
                break
            }
        }
    }
}
