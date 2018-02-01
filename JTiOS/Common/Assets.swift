//
//  Assets.swift
//  JTiOS
//
//  Created by JT on 2018/1/29.
//  Copyright © 2018年 JT. All rights reserved.
//
class Assets {
    static let shareInstance = Assets()
    private init() {}
    
    func unknownFile() -> UIImage? {
        return UIImage(named: "unknownFile")
    }
    func noImage() -> UIImage? {
        return UIImage(named: "noImage")
    }
    func noImage2() -> UIImage? {
        return UIImage(named: "noImage2")
    }
    func play3() -> UIImage? {
        return UIImage(named: "play3")
    }
    
    func uploadLocation() -> UIImage? {
        return UIImage(named: "uploadLocation")
    }
    func uploadingLocation() -> UIImage? {
        return UIImage(named: "uploadingLocation")
    }
}
