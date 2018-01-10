//
//  RequestJson_.swift
//  JTiOS
//
//  Created by JT on 2018/1/3.
//  Copyright © 2018年 JT. All rights reserved.
//
import ObjectMapper
class RequestJson_QueryEventInfo: Mappable {
    var id: Int?
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        id         <- map["id"]
    }
}
