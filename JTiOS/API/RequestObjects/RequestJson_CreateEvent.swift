//
//  RequestJson_createEvnet.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_CreateEvent: Mappable {
    var createuid: Int?
    var sourcecode: String? = "0001010200000001"
    var eventname: String?
    var typecode: String?
    var levelcode: String?
    var geometry: String?
    var address: String?
    var statecode: String? = "0001010400000001"
    var sbtime: Date?
    var remark: String?
    var cltime: Date?
    var trend: String?
    var causes: String?
    var measures: String?
    var vt: Int?
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        createuid         <- map["createuid"]
        sourcecode         <- map["sourcecode"]
        eventname         <- map["eventname"]
        typecode         <- map["typecode"]
        levelcode         <- map["levelcode"]
        geometry         <- map["geometry"]
        address         <- map["address"]
        statecode         <- map["statecode"]
        sbtime         <- (map["sbtime"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter))
        remark         <- map["remark"]
        cltime         <- (map["cltime"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter))
        trend         <- map["trend"]
        causes         <- map["causes"]
        measures         <- map["measures"]
        vt         <- map["vt"]
    }
}
