//
//  RequestJson_QueryFile.swift
//  JTiOS
//
//  Created by JT on 2018/1/15.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_QueryFile: Mappable {
    var frid: Int?
    var typenum: Int?
    var hp: Int?
    init(frid: Int, typenum: Int, hp: Int? = nil) {
        self.frid = frid
        self.typenum = typenum
        self.hp = hp
    }
    required init?(map: Map) {}
    func mapping(map: Map) {
        frid <- map["frid"]
        typenum <- map["typenum"]
        hp <- map["hp"]
    }
}
