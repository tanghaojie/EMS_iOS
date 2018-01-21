//
//  WarningReportC.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//

class WarningReportC {
    
    private func checkCreateEvent(vm: WarningReportVM) -> (Bool, String?) {
        if vm.name == nil || vm.name == "" {
            return (false, Messager.shareInstance.pleaseInputEventName)
        }
        if vm.type == nil {
            return (false, Messager.shareInstance.pleaseSelectEventType)
        }
        if vm.level == nil {
            return (false, Messager.shareInstance.pleaseSelectEventLevel)
        }
        if vm.location == nil {
            return (false, Messager.shareInstance.cannotGetLocationInfo)
        }
        return (true, nil)
    }
    
    func createEvent(vm: WarningReportVM, handler: ((Bool, String?, Int?) -> Void)? = nil) {
        let r: (pass: Bool, msg: String?) = checkCreateEvent(vm: vm)
        if !r.pass {
            if let h = handler {
                h(false, r.msg, nil)
            }
            return
        }
        let jsonCreateEvent = RequestJson_CreateEvent()
        jsonCreateEvent.createuid = global_SystemUser?.id
        jsonCreateEvent.eventname = vm.name
        jsonCreateEvent.typecode = vm.type?.code
        jsonCreateEvent.levelcode = vm.level?.code
        let str = vm.location?.JTGeometryString
        jsonCreateEvent.geometry = str
        jsonCreateEvent.address = vm.address
        jsonCreateEvent.sbtime = vm.date
        jsonCreateEvent.remark = vm.detail
        jsonCreateEvent.vt = 0
        
        ServiceManager.shareInstance.provider.request(.createEvent(json: jsonCreateEvent)) {
            result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if 200 != statusCode {
                    if let h = handler {
                        h(false, Messager.shareInstance.failedHttpResponseStatusCode, nil)
                    }
                    return
                }
                let data = moyaResponse.data
                let json = String(data: data, encoding: .utf8)
                guard let jsonStr = json else {
                    if let h = handler {
                        h(false, Messager.shareInstance.unableParseData2String, nil)
                    }
                    return
                }
                let res = ResponseJson_CreateEvent(JSONString: jsonStr)
                guard let r = res else {
                    if let h = handler {
                        h(false, Messager.shareInstance.unableParseJsonString2JsonObject, nil)
                    }
                    return
                }
                guard 0 == r.status else {
                    if let h = handler {
                        h(false, r.msg, nil)
                    }
                    return
                }
                if let h = handler {
                    h(true, nil, r.data?.id)
                    guard let media = vm.pictureAndVideos, media.count > 0, let eid = r.data?.id else { return }
                    let count = media.count
                    let typenum = FileTypenum.Event
                    for index in 0 ..< count {
                        let m = media[index]
                        if let image = m as? UIImage {
                            let data = UIImageJPEGRepresentation(image, 1)
                            let fileUrl = SystemFile.shareInstance.getFileURL(typenum: typenum, frid: Int64(eid), filename: "\(index).jpeg")
                            if let dd = data {
                                let _ = FileManage.shareInstance.saveFile(url: fileUrl, data: dd)
                            }
                        }
                    }
                    SystemFile.shareInstance.uploadFullDirectoryFiles(typenum: typenum, frid: eid)
                }
            case let .failure(error):
                if let h = handler {
                    h(false, error.errorDescription, nil)
                }
            }
        }
    }
}
