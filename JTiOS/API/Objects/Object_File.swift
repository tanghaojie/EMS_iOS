//
//  Object_File.swift
//  JTiOS
//
//  Created by JT on 2018/1/9.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class Object_File: Mappable {
    var id: Int?
    var frid: Int?
    var typenum: Int?
    var oldfilename: String?
    var path: String?
    var contenttype: String?
    var size: Int64?
    var createtime: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        id    <- map["id"]
        frid    <- map["frid"]
        typenum    <- map["typenum"]
        oldfilename    <- map["oldfilename"]
        path    <- map["path"]
        contenttype    <- map["contenttype"]
        size    <- map["size"]
        createtime    <- map["createtime"]
    }
}

