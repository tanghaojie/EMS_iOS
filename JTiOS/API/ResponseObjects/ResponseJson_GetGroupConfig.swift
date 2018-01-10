//
//  ResponseJson_GetGroupConfig.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class ResponseJson_GetGroupConfig: ResponseJson_BaseList {
    var data: [Object_GetGroupConfig]?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
