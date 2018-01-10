//
//  QueryEventList.swift
//  JTiOS
//
//  Created by JT on 2018/1/3.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class Object_Event: Mappable {
    var id: Int?
    var createuid: Int?
    var realname: String?
    var eventname: String?
    var typecode: String?
    var levelcode: String?
    var geometry: Object_Geometry?
    var address: String?
    var statecode: String?
    var sbtime: String?
    var cltime: String?
    var zhtime: String?
    var jstime: String?
    var createtime: String?
    var remark: String?
    var fcount: Int?
    var typecode_alias: String?
    var levelcode_alias: String?
    var statecode_alias: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        id              <- map["id"]
        createuid       <- map["createuid"]
        realname        <- map["realname"]
        eventname       <- map["eventname"]
        typecode        <- map["typecode"]
        levelcode       <- map["levelcode"]
        geometry        <- map["geometry"]
        address         <- map["address"]
        statecode       <- map["statecode"]
        sbtime          <- map["sbtime"]
        cltime          <- map["cltime"]
        zhtime          <- map["zhtime"]
        jstime          <- map["jstime"]
        createtime      <- map["createtime"]
        remark          <- map["remark"]
        fcount          <- map["fcount"]
        typecode_alias  <- map["typecode_alias"]
        levelcode_alias <- map["levelcode_alias"]
        statecode_alias <- map["statecode_alias"]
    }
}
