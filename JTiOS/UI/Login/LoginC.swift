//
//  C.swift
//  JTiOS
//
//  Created by JT on 2017/12/20.
//  Copyright © 2017年 JT. All rights reserved.
//

class LoginC {
    
    deinit {
        print("---LoginC-----")
    }
    
    private lazy var admin: LoginVM = {
        let admin = LoginVM()
        admin.username = "admin"
        admin.password = "******"
        return admin
    }()
    
    func hadLoggedin() -> Bool {
        if let sysUser = global_SystemUser, let online = sysUser.online, online {
            return true
        }
        return false
    }
    
    func autoLogin(loginFailedHandler: (()->Void)?) {
        if hadLoggedin() { return }
        let dispatchQueue = DispatchQueue(label: "queue_autoLogin")
        dispatchQueue.async {
            let dl = Data.shareInstance.GetData_Login()
            if let d = dl {
                let loginVM = LoginVM()
                loginVM.username = d.username
                loginVM.password = d.password
                let x = self.login(loginVM: loginVM, saveLoginInfo: false)
                if x.0 {
                    Config.getConfig()
                    return
                }
            }
            guard let handler = loginFailedHandler else { return }
            handler()
        }
    }
    
    func login(loginVM: LoginVM, saveLoginInfo: Bool = true) -> (Bool, String?) {
        global_SystemUser = nil
        var result:(success: Bool, msg: String?) = (true,nil)
        if loginVM == admin { return result }
        let jsonLogin = RequestJson_Login()
        jsonLogin.username = loginVM.username
        jsonLogin.password = loginVM.password
        let d = ServiceManager.shareInstance.sync_Json_Post(url: APIUrl.loginFullUrl, data: jsonLogin.toJSONString()?.utf8Encoded)
        let data = d.data
        let response = d.response
        let error = d.error
        if let e = error {
            let s = e.localizedDescription
            result.success = false
            result.msg = s
            return result
        }
        if let r = response {
            if let h = r as? HTTPURLResponse {
                if h.statusCode != 200 {
                    result.success = false
                    result.msg = Messager.shareInstance.failedHttpResponseStatusCode + String(h.statusCode)
                    return result
                } } }
        if let d = data {
            let str = String(data: d, encoding: .utf8)
            if let s = str {
                if let u = ResponseJson_Login(JSONString: s) {
                    if 0 == u.status {
                        if let l = u.data {
                            global_SystemUser = l
                            if saveLoginInfo {
                                saveInfo(loginVM: loginVM)
                            }
                        } else {
                            result.success = false
                            result.msg = Messager.shareInstance.unableParseJsonString2JsonObject
                        }
                    } else {
                        result.success = false
                        result.msg = u.msg
                    }
                } else {
                    result.success = false
                    result.msg = Messager.shareInstance.unableParseJsonString2JsonObject
                }
            } else {
                result.success = false
                result.msg = Messager.shareInstance.unableParseData2String
            }
        } else {
            result.success = false
            result.msg = Messager.shareInstance.wrongResponseData
        }
        return result
    }
    
    private func saveInfo(loginVM: LoginVM) {
        Data.shareInstance.ClearData_Login()
        Data.shareInstance.SaveData_Login(username: loginVM.username, password: loginVM.password)
    }
}
