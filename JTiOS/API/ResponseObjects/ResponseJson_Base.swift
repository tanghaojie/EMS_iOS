//
//  BaseResponse.swift
//  JTiOS
//
//  Created by JT on 2017/12/21.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class ResponseJson_Base: Mappable {
    var msg: String?
    var status: Int?
    required init?(map: Map) {}
    func mapping(map: Map) {
        msg     <- map["msg"]
        status  <- map["status"]
    }
}
