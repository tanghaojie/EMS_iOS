//
//  RequestJson_QueryTaskList.swift
//  JTiOS
//
//  Created by JT on 2018/1/3.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_QueryTaskList: Mappable {
    var uid: Int?
    var eid: Int?
    var statecode: String?
    var starttime: Date?
    var endtime: Date?
    var pagenum: Int?
    var pagesize: Int? = 10
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        uid         <- map["uid"]
        eid         <- map["eid"]
        statecode   <- map["statecode"]
        starttime   <- (map["starttime"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter))
        endtime     <- (map["endtime"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter))
        pagenum     <- map["pagenum"]
        pagesize    <- map["pagesize"]
    }
}
