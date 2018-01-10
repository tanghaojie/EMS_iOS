//
//  WarningListC.swift
//  JTiOS
//
//  Created by JT on 2017/12/25.
//  Copyright © 2017年 JT. All rights reserved.
//

import Foundation
class TaskListC {
    
    var total = 0
    var pagenum = 1
    private static let pagesize = 7
    var noMoreData = false
    
    func getData(Handler: @escaping ([TaskListTableViewCellVM]?, String?)-> Void) {
        requestTask(pagenum: pagenum, pagesize: TaskListC.pagesize){ [weak self] (queryTaskList: ResponseJson_QueryTaskList?, errorStr: String?) in
            if let e = errorStr {
                Handler(nil, e)
                return
            }
            if let r = queryTaskList {
                if 0 != r.status {
                    Handler(nil, r.msg)
                    return
                }
                if let to = r.total { self?.total = to }
                if let d = r.data {
                    if d.count <= 0 {
                        Handler(nil, nil)
                        return
                    }
                    self?.pagenum += 1
                    if let tot = self?.total, let num = self?.pagenum {
                        let page = ceil(Double(tot) / Double(TaskListC.pagesize))
                        if Double(num) > page { self?.noMoreData = true }
                        else { self?.noMoreData = false}
                    }
                    var vms: [TaskListTableViewCellVM] = [TaskListTableViewCellVM]()
                    for x in d {
                        let eid = x.eid
                        if let e = eid {
                            self?.requestEvent(id: e) { (event: ResponseJson_QueryEventInfo?, errorS: String?) in
                                if let err = errorS {
                                    Handler(nil, err)
                                    return
                                }
                                guard let ev = event else {
                                    Handler(nil, Messager.shareInstance.wrongResponseData)
                                    return
                                }
                                if 0 != ev.status {
                                    Handler(nil, ev.msg)
                                    return
                                }
                                x.event = ev.data
                            }
                        }
                        let vm = TaskListTableViewCellVM()
                        vm.bottomLabel = x.starttime?.toJTFormateDate
                        vm.data = x
                        vm.mainContentText = x.content
                        vm.mainContentTopLabel1 = x.event?.eventname
                        vm.mainContentTopLabel3 = x.statecode_alias
                        vm.topLabel = x.summary
                        vms.append(vm)
                    }
                    Handler(vms, nil)
                    return
                }
            }
            Handler(nil, nil)
        }
    }
    
    private func requestTask(pagenum: Int, pagesize: Int = 10, Handler: @escaping (ResponseJson_QueryTaskList?, String?)-> Void ) {
        let jsonQueryTaskList = RequestJson_QueryTaskList()
        jsonQueryTaskList.pagenum = pagenum
        jsonQueryTaskList.pagesize = pagesize
        ServiceManager.shareInstance.provider.request(.queryTaskList(json: jsonQueryTaskList)) { result in
            var errorDescription: String?
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if 200 != statusCode {
                    errorDescription = Messager.shareInstance.failedHttpResponseStatusCode
                    Handler(nil, errorDescription)
                    return
                }
                let data = moyaResponse.data
                let json = String(data: data, encoding: .utf8)
                guard let jsonStr = json else {
                    errorDescription = Messager.shareInstance.unableParseData2String
                    Handler(nil, errorDescription)
                    return
                }
                let res = ResponseJson_QueryTaskList(JSONString: jsonStr)
                guard let r = res else {
                    errorDescription = Messager.shareInstance.unableParseJsonString2JsonObject
                    Handler(nil, errorDescription)
                    return
                }
                Handler(r, nil)
            case let .failure(error):
                errorDescription = error.errorDescription
                Handler(nil, errorDescription)
            }
        }
    }
    
    private func requestEvent(id: Int, Handler: @escaping (ResponseJson_QueryEventInfo?, String?)-> Void ) {
        let json = RequestJson_QueryEventInfo()
        json.id = id
        let dd = ServiceManager.shareInstance.sync_Json_Post(url: APIUrl.queryEventInfoFullUrl, data: json.toJSONString()?.utf8Encoded)
        let data = dd.data
        let response = dd.response
        let error = dd.error
        if let e = error {
            let s = e.localizedDescription
            Handler(nil, s)
            return
        }
        if let r = response {
            if let h = r as? HTTPURLResponse {
                if 200 != h.statusCode {
                    Handler(nil, Messager.shareInstance.failedHttpResponseStatusCode + String(h.statusCode))
                    return
                } } }
        guard let d = data else {
            Handler(nil, Messager.shareInstance.wrongResponseData)
            return
        }
        let str = String(data: d, encoding: .utf8)
        guard let s = str else {
            Handler(nil, Messager.shareInstance.unableParseData2String)
            return
        }
        guard let u = ResponseJson_QueryEventInfo(JSONString: s) else {
            Handler(nil, Messager.shareInstance.unableParseJsonString2JsonObject)
            return
        }
        Handler(u, nil)
    }
    
}
