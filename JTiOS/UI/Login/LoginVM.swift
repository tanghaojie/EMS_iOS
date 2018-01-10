//
//  Login.swift
//  JTiOS
//
//  Created by JT on 2017/12/20.
//  Copyright © 2017年 JT. All rights reserved.
//

class LoginVM {
    var username: String?
    var password: String?
    
    static func ==(x: LoginVM, y: LoginVM) -> Bool {
        if(x.username == y.username && x.password == y.password) {
            return true
        }
        return false
    }
}
