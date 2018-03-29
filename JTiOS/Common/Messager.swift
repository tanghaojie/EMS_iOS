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
    let warning = "警告"
    let cancel = "取消"
    let wait = "请稍后"
    let loading = "加载中"
    
    let logining = "正在登录"
    let notOpen = "暂未开放"
    let loginFailed = "登录失败"
    let notLogin = "未登录"
    let error = "错误"
    let album = "相册"
    let camera = "拍照"
    let video = "视频"
    let delete = "删除"
    let cannotUseCamera = "摄像头无法使用"
    let cannotUseMicrophone = "麦克风无法使用"
    let uploading = "上传中"
    let compressing = "压缩中"
    let compressFailed = "压缩失败"
    let uploadPointsFailedPleaseRestartApp = "上传点位失败，请重启App尝试"
    
    let clearCacheSuccess = "清除缓存成功"
    
    let pleaseTakeVideo = "请录制视频"
    let videoFinish = "录制完成"
    let videoFailed = "录制失败"
    let saveImageFailed = "保存图片失败"
    
    let ifDelete = "是否删除"
    
    let uploadFailed = "上传失败"
    let redirecting = "跳转中"
    let logouting = "正在退出"
    let networkError = "网络异常"
    let logoutFailed = "退出失败"
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
    let selectType = "选择类型"
    let selectHeadPortrait = "选择头像"
    let takePhotoOrSelectFromAlbum = "拍照或从相册选择"
    
    let inputServerUrl = "请输入服务器地址"
    let settingSuccess = "设置成功"
    let settingFailed = "设置失败"
}
