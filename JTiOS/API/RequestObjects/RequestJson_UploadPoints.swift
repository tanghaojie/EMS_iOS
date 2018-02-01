//
//  RequestJson_UploadPoints.swift
//  JTiOS
//
//  Created by JT on 2018/1/31.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_UploadPoints: Mappable {
    var uid: Int?
    var tnum: Date?
    var points: [Object_Point]?
    init(uid: Int, tnum: Date, points: [Object_Point]) {
        self.uid = uid
        self.tnum = tnum
        self.points = points
    }
    required init?(map: Map) {}
    func mapping(map: Map) {
        uid <- map["uid"]
        tnum <- (map["tnum"], DateFormatterTransform(dateFormatter: DateFormatter.JTDateFormatter2))
        points <- map["points"]
    }
}
