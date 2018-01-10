//
//  RequestJson_QueryProcessList.swift
//  JTiOS
//
//  Created by JT on 2018/1/9.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_QueryProcessList: Mappable {
    var id: Int?
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        id         <- map["id"]
    }
}
