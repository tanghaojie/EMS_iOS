//
//  JTLocationManager.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class JTLocationManager: CLLocationManager {
    static let shareInstance = JTLocationManager()
    
    private override init(){
        super.init()
        self.requestAlwaysAuthorization()
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        self.pausesLocationUpdatesAutomatically = false
        if #available(iOS 9.0, *) {
            self.allowsBackgroundLocationUpdates = true
        }
    }
}
