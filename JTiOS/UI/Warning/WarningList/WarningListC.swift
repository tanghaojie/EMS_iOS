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
        requestData(pagenum: pagenum, pagesize: WarningListC.pagesize){ [weak self] (queryEventList: ResponseJson_QueryRelationEventList?, errorStr: String?) in
            if let e = errorStr {
                Handler(nil, e)
                return
            }
            guard let r = queryEventList else {
                Handler(nil, nil)
                return
            }
            if 0 != r.status {
                Handler(nil, r.msg)
                return
            }
            if let to = r.total { self?.total = to }
            guard let d = r.data else {
                Handler(nil, nil)
                return
            }
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
    
    func requestData(pagenum: Int, pagesize: Int = 10, Handler: @escaping (ResponseJson_QueryRelationEventList?, String?)-> Void ) {
        guard let uid = global_SystemUser?.id else {
            Handler(nil, Messager.shareInstance.notLogin)
            return
        }
        let request = RequestJson_QueryRelationEventList(createuid: uid, pagenum: pagenum)
        request.pagesize = pagesize
        ServiceManager.shareInstance.provider.request(.queryRelationEventList(object: request)) {
            result in
            switch result {
            case let .success(moyaResponse):
                guard 200 == moyaResponse.statusCode else {
                    Handler(nil, Messager.shareInstance.failedHttpResponseStatusCode)
                    return
                }
                guard let json = String(data: moyaResponse.data, encoding: .utf8) else {
                    Handler(nil, Messager.shareInstance.unableParseData2String)
                    return
                }
                guard let r = ResponseJson_QueryRelationEventList(JSONString: json) else {
                    Handler(nil, Messager.shareInstance.unableParseJsonString2JsonObject)
                    return
                }
                Handler(r, nil)
            case let .failure(error):
                Handler(nil, error.errorDescription)
            }
        }
    }
    
    func getFiles(e: Object_Event?, Handler: @escaping ([Object_File]?, String?)-> Void) {
        guard let count = e?.fcount, count > 0 else {
            Handler(nil, nil)
            return
        }
        guard let eid = e?.id else {
            Handler(nil, Messager.shareInstance.error)
            return
        }
        let request = RequestJson_QueryFile(frid: eid, typenum: FileTypenum.Event.rawValue)
        ServiceManager.shareInstance.provider_2s.request(.queryFile(json: request)) {
            result in
            switch result {
            case let .success(moyaResponse):
                guard 200 == moyaResponse.statusCode else {
                    Handler(nil, Messager.shareInstance.failedHttpResponseStatusCode)
                    return
                }
                guard let jsonStr = String(data: moyaResponse.data, encoding: .utf8) else {
                    Handler(nil, Messager.shareInstance.unableParseData2String)
                    return
                }
                guard let r = ResponseJson_QueryFile(JSONString: jsonStr) else {
                    Handler(nil, Messager.shareInstance.unableParseJsonString2JsonObject)
                    return
                }
                guard 0 == r.status else {
                    Handler(nil, r.msg)
                    return
                }
                Handler(r.data, nil)
            case let .failure(error):
                Handler(nil, error.errorDescription)
            }
        }
    }
    
}
