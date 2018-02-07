//
//  JTMediaCollectionViewCellData.swift
//  JTiOS
//
//  Created by JT on 2018/2/5.
//  Copyright © 2018年 JT. All rights reserved.
//
class JTMediaCollectionViewCellDatas {
    var previewData: JTMediaCollectionViewCellData?
    var data: JTMediaCollectionViewCellData?
    var needData: ((@escaping needDataSuccess) -> ())?
    typealias needDataSuccess = (JTMediaCollectionViewCellData) -> ()
    
    init(previewData: JTMediaCollectionViewCellData?, data: JTMediaCollectionViewCellData? = nil, needData: ((needDataSuccess) -> ())? = nil) {
        self.previewData = previewData
        self.data = data
        self.needData = needData
    }
    
    class JTMediaCollectionViewCellData {
        var url: URL?
        var type: JTMediaCollectionViewCellDatasType
        
        init(url: URL?, type: JTMediaCollectionViewCellDatasType) {
            self.url = url
            self.type = type
        }
    }
    
    enum JTMediaCollectionViewCellDatasType {
        case Image
        case Video
        case Unknown
        case VideoCover
    }
}