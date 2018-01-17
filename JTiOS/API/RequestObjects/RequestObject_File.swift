//
//  RequestObject_File.swift
//  JTiOS
//
//  Created by JT on 2018/1/16.
//  Copyright © 2018年 JT. All rights reserved.
//
class RequestObject_File {
    var typenum: Int
    var frid: Int
    var filename: String
    var prefix: ImagePrefix
    
    init(typenum: Int, frid: Int, filename: String, prefix: ImagePrefix) {
        self.typenum = typenum
        self.frid = frid
        self.filename = filename
        self.prefix = prefix
    }
}
