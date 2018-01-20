//
//  RequestJson_File.swift
//  JTiOS
//
//  Created by JT on 2018/1/15.
//  Copyright © 2018年 JT. All rights reserved.
//
import Alamofire
class RequestObject_FileDownload {
    var typenum: FileTypenum
    var frid: Int
    var filename: String
    var destination: DownloadRequest.DownloadFileDestination
    var prefix: ImagePrefix
    
    init(typenum: FileTypenum, frid: Int, filename: String, prefix: ImagePrefix, destination: @escaping DownloadRequest.DownloadFileDestination) {
        self.typenum = typenum
        self.frid = frid
        self.filename = filename
        self.destination = destination
        self.prefix = prefix
    }
}
