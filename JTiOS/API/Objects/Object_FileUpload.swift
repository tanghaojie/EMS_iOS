//
//  Object_FileUpload.swift
//  JTiOS
//
//  Created by JT on 2018/1/17.
//  Copyright © 2018年 JT. All rights reserved.
//
class Object_FileUpload {
    var data: Foundation.Data
    var name: String
    var fileName: String?
    var mimeType: String?
    init(data: Foundation.Data, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
