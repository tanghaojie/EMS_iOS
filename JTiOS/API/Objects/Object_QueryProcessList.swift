//
//  Object_QueryProcessList.swift
//  JTiOS
//
//  Created by JT on 2018/1/9.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class Object_QueryProcessList: Mappable {
    var id: Int?
    var tid: Int?
    var opuid: Int?
    var realname: String?
    var summary: String?
    var content: String?
    var statecode: String?
    var address: String?
    var geometry: Object_Geometry?
    var personuids: [Object_Uid]?
    var leaderuids: [Object_Uid]?
    var starttime: String?
    var endtime: String?
    var remark: String?
    var finish: Bool?
    var statecode_alias: String?
    var files: [Object_File]?
    required init?(map: Map) { }
    func mapping(map: Map) {
        id         <- map["id"]
        tid         <- map["tid"]
        opuid         <- map["opuid"]
        realname         <- map["realname"]
        summary         <- map["summary"]
        content         <- map["content"]
        statecode         <- map["statecode"]
        address         <- map["address"]
        geometry         <- map["geometry"]
        personuids         <- map["personuids"]
        leaderuids         <- map["leaderuids"]
        starttime         <- map["starttime"]
        endtime         <- map["endtime"]
        remark         <- map["remark"]
        finish         <- map["finish"]
        statecode_alias         <- map["statecode_alias"]
        files         <- map["files"]
    }
}
