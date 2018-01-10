//
//  WarningListC.swift
//  JTiOS
//
//  Created by JT on 2017/12/25.
//  Copyright © 2017年 JT. All rights reserved.
//

import Foundation
class WarningListC {
    
    var total = 0
    var pagenum = 1
    private static let pagesize = 7
    var noMoreData = false
    
    func getData(Handler: @escaping ([WarningListTableViewCellVM]?, String?)-> Void) {
        requestData(pagenum: pagenum, pagesize: WarningListC.pagesize){ [weak self] (queryEventList: ResponseJson_QueryEventList?, errorStr: String?) in
            if let e = errorStr {
                Handler(nil, e)
                return
            }
            if let r = queryEventList {
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
                        let page = ceil(Double(tot) / Double(WarningListC.pagesize))
                        if Double(num) > page { self?.noMoreData = true }
                        else { self?.noMoreData = false}
                    }
                    var vms: [WarningListTableViewCellVM] = [WarningListTableViewCellVM]()
                    for x in d {
                        let vm = WarningListTableViewCellVM()
                        vm.bottomLabel = x.createtime?.toJTFormateDate
                        vm.mainContentText = x.remark
                        vm.mainContentTopLabel1 = x.typecode_alias
                        vm.mainContentTopLabel2 = x.levelcode_alias
                        vm.mainContentTopLabel3 = x.statecode_alias
                        vm.topLabel = x.eventname
                        vm.data = x
                        vms.append(vm)
                    }
                    Handler(vms, nil)
                    return
                }
            }
            Handler(nil, nil)
        }
    }
    
    func requestData(pagenum: Int, pagesize: Int = 10, Handler: @escaping (ResponseJson_QueryEventList?, String?)-> Void ) {
        let jsonQueryEventList = RequestJson_QueryEventList()
        jsonQueryEventList.pagenum = pagenum
        jsonQueryEventList.pagesize = pagesize
        ServiceManager.shareInstance.provider.request(.queryEventList(json: jsonQueryEventList)) { result in
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
                let res = ResponseJson_QueryEventList(JSONString: jsonStr)
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
