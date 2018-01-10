//
//  SystemInfo.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//

class SystemInfo {
    static let shareInstance = SystemInfo()
    private init() {}
    
    let ScreenWidth = UIScreen.main.bounds.width
    let ScrennHeight = UIScreen.main.bounds.height
    
}
