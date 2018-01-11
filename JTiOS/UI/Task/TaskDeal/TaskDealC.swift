//
//  TaskDealC.swift
//  JTiOS
//
//  Created by JT on 2018/1/11.
//  Copyright © 2018年 JT. All rights reserved.
//
class TaskDealC {
    private func checkCreateEvent(vm: TaskDealVM) -> (Bool, String?) {
//        if vm.address == nil || vm.address == "" {
//            return (false, Messager.shareInstance.pleaseInputEventName)
//        }
        return (true, nil)
    }
    
    func createProcessExecute(vm: TaskDealVM, tid: Int, handler: ((Bool, String?, Int?) -> Void)? = nil) {
        let r: (pass: Bool, msg: String?) = checkCreateEvent(vm: vm)
        if !r.pass {
            if let h = handler {
                h(false, r.msg, nil)
            }
            return
        }
        if tid <= 0 {
            if let h = handler {
                h(false, Messager.shareInstance.error + " " + Messager.shareInstance.tryAgain, nil)
            }
            return
        }
        guard let uid = global_SystemUser?.id else {
            if let h = handler {
                h(false, Messager.shareInstance.notLogin, nil)
            }
            return
        }
        let requestJson = RequestJson_CreateProcessExecute(tid: tid, opuid: uid, startTime: Date())
        requestJson.address = vm.address
        requestJson.content = vm.content
        requestJson.summary = vm.summary
        requestJson.starttime = Date()
        ServiceManager.shareInstance.provider.request(.createProcessExecute(json: requestJson)) {
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
                let res = ResponseJson_CreateProcessExecute(JSONString: jsonStr)
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
                }
            case let .failure(error):
                if let h = handler {
                    h(false, error.errorDescription, nil)
                }
            }
        }
    }
}
