//
//  Json_QueryEventList.swift
//  JTiOS
//
//  Created by JT on 2017/12/25.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_QueryEventList: Mappable {
    var uid: Int?
    var eventname: String?
    var statecode: String?
    var typecode: String?
    var vt: Int? = 0
    var starttime: String?
    var endtime: String?
    var pagenum: Int?
    var pagesize: Int? = 10
    init() {}
    required init?(map: Map) {}    
    func mapping(map: Map) {
        uid         <- map["uid"]
        eventname   <- map["eventname"]
        statecode   <- map["statecode"]
        typecode    <- map["typecode"]
        vt          <- map["vt"]
        starttime   <- map["starttime"]
        endtime     <- map["endtime"]
        pagenum     <- map["pagenum"]
        pagesize    <- map["pagesize"]
    }
}
