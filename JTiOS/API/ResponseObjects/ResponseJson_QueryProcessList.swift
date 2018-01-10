//
//  ResponseJson_QueryProcessList.swift
//  JTiOS
//
//  Created by JT on 2018/1/9.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class ResponseJson_QueryProcessList: ResponseJson_BaseList {
    var data: [Object_QueryProcessList]?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
