//
//  Message.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//

class Messager {
    static let shareInstance = Messager()
    private init() {}
    
    let ok = "确定"
    let logining = "正在登录"
    let notOpen = "暂未开放"
    let loginFailed = "登录失败"
    let notLogin = "未登录"
    let error = "错误"
    let failedHttpResponseStatusCode = "Failed http response status code."
    let wrongResponseData = "Wrong response data."
    let unableParseData2String = "Unable parse [Data] to [String]."
    let unableParseJsonString2JsonObject = "Unable parse [JsonString] to [JsonObject]."
    let pleaseInputEventName = "请输入事件名称"
    let pleaseSelectEventType = "请选择事件类型"
    let pleaseSelectEventLevel = "请选择事件级别"
    let cannotGetLocationInfo = "无法获得位置信息"
    let createEventFailed = "上报事件失败"
    let eventCreating = "事件上报中"
    let tryAgain = "请重试"
    let taskDealCreating = "任务处理上报中"
    let createTaskDealFailed = "任务处理上报失败"
}
