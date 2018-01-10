//
//  Uid.swift
//  JTiOS
//
//  Created by JT on 2018/1/3.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class Object_Uid: Mappable {
    var id: Int?
    var realname: String?
    var duty: String?
    var phone: String?
    var sex: String?
    var email: String?
    var orgname: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        id              <- map["id"]
        realname        <- map["realname"]
        duty            <- map["duty"]
        phone           <- map["phone"]
        sex             <- map["sex"]
        email           <- map["email"]
        orgname         <- map["orgname"]
    }
}
