//
//  JTMediaCollectionViewCellData.swift
//  JTiOS
//
//  Created by JT on 2018/2/5.
//  Copyright © 2018年 JT. All rights reserved.
//
import Moya
class JTMediaCollectionViewCellDatas {
    var previewData: JTMediaCollectionViewCellData?
    var data: JTMediaCollectionViewCellData?
    var needData: ((ProgressBlock?, @escaping needDataSuccess) -> Cancellable?)?
    typealias needDataSuccess = (JTMediaCollectionViewCellData) -> ()
    
    init(previewData: JTMediaCollectionViewCellData?, data: JTMediaCollectionViewCellData? = nil, needData: ((ProgressBlock?, @escaping needDataSuccess) -> Cancellable?)? = nil) {
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
