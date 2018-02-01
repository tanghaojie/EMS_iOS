//
//  Object_Point.swift
//  JTiOS
//
//  Created by JT on 2018/1/31.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class Object_Point: Mappable {
    var x: Double?
    var y: Double?
    var t: Int64?
    init(x: Double, y: Double, t: Int64) {
        self.x = x
        self.y = y
        self.t = t
    }
    required init?(map: Map) {}
    func mapping(map: Map) {
        x    <- map["x"]
        y    <- map["y"]
        t    <- map["t"]
    }
}
