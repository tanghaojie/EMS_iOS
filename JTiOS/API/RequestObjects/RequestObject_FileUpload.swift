//
//  RequestObject_UploadFile.swift
//  JTiOS
//
//  Created by JT on 2018/1/17.
//  Copyright © 2018年 JT. All rights reserved.
//
class RequestObject_FileUpload {
    var typenum: Int
    var frid: Int
    var actualtime: Date
    var files: [Object_FileUpload]
    init(typenum: Int, frid: Int, actualtime: Date, files: [Object_FileUpload]) {
        self.typenum = typenum
        self.frid = frid
        self.actualtime = actualtime
        self.files = files
    }
}
