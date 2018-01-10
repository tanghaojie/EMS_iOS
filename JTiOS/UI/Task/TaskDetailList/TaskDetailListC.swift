//
//  TaskDetailListC.swift
//  JTiOS
//
//  Created by JT on 2018/1/9.
//  Copyright © 2018年 JT. All rights reserved.
//
class TaskDetailListC {
    
//    var total = 0
//    var pagenum = 1
//    private static let pagesize = 7
//    var noMoreData = false
    
    func getData(id: Int, Handler: @escaping ([TaskDetailListTableViewCellVM]?, String?)-> Void) {
        requestQueryProcessList(id: id){ (queryProcessList: ResponseJson_QueryProcessList?, errorStr: String?) in
            if let e = errorStr {
                Handler(nil, e)
                return
            }
            if let r = queryProcessList {
                if 0 != r.status {
                    Handler(nil, r.msg)
                    return
                }
                if let d = r.data {
                    if d.count <= 0 {
                        Handler(nil, nil)
                        return
                    }
                    var vms: [TaskDetailListTableViewCellVM] = [TaskDetailListTableViewCellVM]()
                    for x in d {
                        let vm = TaskDetailListTableViewCellVM(data: x)
                        vms.append(vm)
                    }
                    Handler(vms, nil)
                    return
                }
            }
            Handler(nil, nil)
        }
    }
    
    private func requestQueryProcessList(id: Int, Handler: @escaping (ResponseJson_QueryProcessList?, String?)-> Void ) {
        let jsonQueryTaskList = RequestJson_QueryProcessList()
        jsonQueryTaskList.id = id
        ServiceManager.shareInstance.provider.request(.queryProcessList(json: jsonQueryTaskList)) { result in
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
                let res = ResponseJson_QueryProcessList(JSONString: jsonStr)
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
    
}
