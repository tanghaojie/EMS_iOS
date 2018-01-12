//
//  RequestJson_Logout.swift
//  JTiOS
//
//  Created by JT on 2018/1/12.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_Logout: Mappable {
    var id: Int?
    init(id: Int) {
        self.id = id
    }
    required init?(map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
    }
}
