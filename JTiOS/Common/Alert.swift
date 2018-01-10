//
//  Alert.swift
//  JTiOS
//
//  Created by JT on 2017/12/22.
//  Copyright © 2017年 JT. All rights reserved.
//

class Alert {
    static let shareInstance = Alert()
    private init() {}
    
    public func AlertWithUIAlertAction(view: UIViewController, title: String, message: String?, uiAlertAction:  [UIAlertAction], preferredStyle: UIAlertControllerStyle = .alert, completion: (() -> Swift.Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for aa in uiAlertAction {
            alert.addAction(aa)
        }
        view.present(alert, animated: true, completion: completion)
    }
}
