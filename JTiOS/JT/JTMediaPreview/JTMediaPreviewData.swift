//
//  JTMediaPreviewData.swift
//  JTiOS
//
//  Created by JT on 2018/1/25.
//  Copyright © 2018年 JT. All rights reserved.
//
class JTMediaPreviewData {
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    let imageView: UIImageView = UIImageView()
    init(image: UIImage? = nil) {
        self.image = image
    }
}

