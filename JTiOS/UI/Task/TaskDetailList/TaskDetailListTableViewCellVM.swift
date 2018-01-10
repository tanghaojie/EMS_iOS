//
//  TaskDetailListTableViewCellVM.swift
//  JTiOS
//
//  Created by JT on 2018/1/9.
//  Copyright © 2018年 JT. All rights reserved.
//

class TaskDetailListTableViewCellVM {
    init(data: Object_QueryProcessList?) {
        self.data = data
        if let d = data {
            topLabel = d.summary
            bottomLabel1 = d.statecode_alias
            bottomLabel2 = d.starttime?.toJTFormateDate
            personuids = d.personuids
            leaderuids = d.leaderuids
            address = d.address
            content = d.content
            remark = d.remark
        }
    }
    var topLabel: String?
    var bottomLabel1: String?
    var bottomLabel2: Date?
    var personuids: [Object_Uid]?
    var leaderuids: [Object_Uid]?
    var address: String?
    var content: String?
    var remark: String?
    var data: Object_QueryProcessList?
}
