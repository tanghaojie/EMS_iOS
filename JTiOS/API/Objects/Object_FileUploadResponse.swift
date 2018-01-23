//
//  Object_FileUploadResponse.swift
//  JTiOS
//
//  Created by JT on 2018/1/23.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class Object_FileUploadResponse: Mappable {
    required init?(map: Map) {}
    var id: Int?
    var filename: String?
    var oldfilename: String?
    func mapping(map: Map) {
        id    <- map["id"]
        filename    <- map["filename"]
        oldfilename    <- map["oldfilename"]
    }
}
