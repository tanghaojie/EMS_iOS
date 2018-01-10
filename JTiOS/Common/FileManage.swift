//
//  FileManager.swift
//  JTiOS
//
//  Created by JT on 2017/12/20.
//  Copyright © 2017年 JT. All rights reserved.
//

class FileManage {
    static let shareInstance = FileManage()
    private init() {}
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
 
}
