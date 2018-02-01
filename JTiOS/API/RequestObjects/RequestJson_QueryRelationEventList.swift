//
//  Request_QueryRelationEventList.swift
//  JTiOS
//
//  Created by JT on 2018/1/30.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_QueryRelationEventList: Mappable {
    var createuid: Int?
    var starttime: Date?
    var endtime: Date?
    var pagenum: Int?
    var pagesize: Int? = 10
    init(createuid: Int, pagenum: Int) {
        self.createuid = createuid
        self.pagenum = pagenum
    }
    required init?(map: Map) {}
    func mapping(map: Map) {
        createuid         <- map["createuid"]
        starttime   <- (map["starttime"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter))
        endtime     <- (map["endtime"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter))
        pagenum     <- map["pagenum"]
        pagesize    <- map["pagesize"]
    }
}
