//
//  RequestJson_CreateProcessExecute.swift
//  JTiOS
//
//  Created by JT on 2018/1/11.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_CreateProcessExecute: Mappable {
    var tid: Int?
    var opuid: Int?
    var summary: String?
    var content: String?
    var statecode: String?
    var address: String?
    var geometry: String?
    var personuids: [Int]?
    var leaderuids: [Int]?
    var starttime: Date? = Date()
    var remark: String?
    init(tid: Int, opuid: Int, startTime: Date) {
        self.tid = tid
        self.opuid = opuid
        self.starttime = startTime
    }
    required init?(map: Map) { }
    func mapping(map: Map) {
        tid         <- map["tid"]
        opuid   <- map["opuid"]
        summary   <- map["summary"]
        content    <- map["content"]
        statecode          <- map["statecode"]
        address   <- map["address"]
        geometry     <- map["geometry"]
        personuids     <- map["personuids"]
        leaderuids    <- map["leaderuids"]
         starttime    <- (map["starttime"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter))
         remark    <- map["remark"]
    }
}
