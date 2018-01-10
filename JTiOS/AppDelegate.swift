//
//  AppDelegate.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Data.shareInstance.saveContext()
    }
}

