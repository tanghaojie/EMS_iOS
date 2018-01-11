//
//  ResponseJson_CreateProcessExecute.swift
//  JTiOS
//
//  Created by JT on 2018/1/11.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class ResponseJson_CreateProcessExecute: ResponseJson_Base {
    var data: Object_ID?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
