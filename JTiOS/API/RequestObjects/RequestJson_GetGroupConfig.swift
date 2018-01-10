//
//  RequestJson_GetGroupConfig.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_GetGroupConfig: Mappable {
    var id: Int?
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        id         <- map["id"]
    }
}
