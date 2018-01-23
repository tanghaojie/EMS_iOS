//
//  JTMediaPickerData.swift
//  JTiOS
//
//  Created by JT on 2018/1/23.
//  Copyright © 2018年 JT. All rights reserved.
//
class JTMediaPickerData {
    
    var type: JTMediaPickerDataType
    var url: URL
    
    init(type: JTMediaPickerDataType, url: URL) {
        self.type = type
        self.url = url
    }

    enum JTMediaPickerDataType {
        case Image
        case Video
    }
}
