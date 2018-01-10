//
//  LoginResponseUser.swift
//  JTiOS
//
//  Created by JT on 2018/1/3.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class Object_LoginResponseUser: Mappable {
    var id: Int?
    var realname: String?
    var username: String?
    var rolename: String?
    var portraiturl: String?
    var phone: String?
    var email: String?
    var remark: String?
    var rolecode: String?
    var online: Bool?
    required init?(map: Map) {}
    func mapping(map: Map) {
        id          <- map["id"]
        realname    <- map["realname"]
        username    <- map["username"]
        rolename    <- map["rolename"]
        portraiturl <- map["portraiturl"]
        phone       <- map["phone"]
        email       <- map["email"]
        remark      <- map["remark"]
        rolecode    <- map["rolecode"]
        online      <- map["online"]
    }
}
