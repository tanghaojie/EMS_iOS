//
//  WarningDetailCommandingVM.swift
//  JTiOS
//
//  Created by JT on 2018/1/2.
//  Copyright © 2018年 JT. All rights reserved.
//

class WarningDetailCommandingVM {
    var status: String?
    var name: String?
    var type: String?
    var level: String?
    var time: Date?
    var address: String?
    var trend: String?
    var reason: String?
    var measure: String?
    var emergencyPlan: AnyObject?
    var implementationPlan: AnyObject?
    var startTime: Date?
    var commandTime: Date?
    var point: AGSPoint?
    var files: [Object_File]?
}
