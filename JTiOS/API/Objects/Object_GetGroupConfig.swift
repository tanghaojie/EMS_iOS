//
//  GetGroupConfig.swift
//  JTiOS
//
//  Created by JT on 2018/1/3.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper
class Object_GetGroupConfig: Mappable {
    var code: String?
    var name: String?
    var alias: String?
    var list: [Object_GetGroupConfig]?
    init() {
        
    }
    required init?(map: Map) {}
    func mapping(map: Map) {
        code    <- map["code"]
        name    <- map["name"]
        alias   <- map["alias"]
        list    <- map["list"]
    }
}
