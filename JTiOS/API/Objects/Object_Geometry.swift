//
//  Geometry.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//
import ObjectMapper
class Object_Geometry: Mappable {
    var type: String?
    var coordinates: AnyObject?
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        type            <- map["type"]
        coordinates     <- map["coordinates"]
    }
}
extension Object_Geometry {
    var JTGeometryString: String? {
        let t = self.type ?? ""
        var cStr = ""
        let type = t.uppercased()
        if type == "POINT" {
            if let coordinates = self.coordinates, let c = coordinates as? [Double], c.count == 2 {
                cStr = "[\(c[0]), \(c[1])]"
            }
        } else if type == "LINESTRING" {
            if let coordinates = self.coordinates, let c = coordinates as? [[Double]] {
                var x = "["
                let last = c.count - 1
                for index in 0...last {
                    let p = c[index]
                    let px = "[\(p[0]), \(p[1])]"
                    x += px
                    if index != last {
                        x += ","
                    }
                }
                x += "]"
                cStr = x
            }
        } else if type == "POLYGON" {
            if let coordinates = self.coordinates, let c = coordinates as? [[[Double]]] {
                var x = "["
                let last = c.count - 1
                for index in 0...last {
                    x += "["
                    let l = c[index]
                    let lLast = l.count - 1
                    for i in 0...lLast {
                        let p = l[i]
                        let px = "[\(p[0]), \(p[1])]"
                        x += px
                        if lLast != i{
                            x += ","
                        }
                    }
                    if index != last {
                        x += "],["
                    }
                }
                x += "]"
                cStr = x
            }
        }
        return "{\"type\":\"\(t)\",\"coordinates\":\(cStr)}"
    }
}

