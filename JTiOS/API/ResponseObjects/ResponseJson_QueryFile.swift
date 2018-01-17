//
//  ResponseJson_QueryFile.swift
//  JTiOS
//
//  Created by JT on 2018/1/15.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class ResponseJson_QueryFile: ResponseJson_BaseList {
    var data: [Object_File]?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
