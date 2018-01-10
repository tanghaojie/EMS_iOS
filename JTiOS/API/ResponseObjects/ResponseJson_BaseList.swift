//
//  ListBaseResponse.swift
//  JTiOS
//
//  Created by JT on 2017/12/21.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class ResponseJson_BaseList: ResponseJson_Base {
    var total: Int?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        total   <- map["total"]
    }
}
