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
    func pause() -> UIImage? {
        return UIImage(named: "pause")
    }
    func play() -> UIImage? {
        return UIImage(named: "play")
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
    func point() -> UIImage? {
        return UIImage(named: "point")
    }
    func point2() -> UIImage? {
        return UIImage(named: "point2")
    }
    func location() -> UIImage? {
        return UIImage(named: "location")
    }
}
