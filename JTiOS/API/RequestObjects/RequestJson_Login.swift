//
//  Login.swift
//  JTiOS
//
//  Created by JT on 2017/12/21.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_Login: Mappable {
    var username: String?
    var password: String?
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        username <- map["username"]
        password <- map["password"]
    }
}
