//
//  WarningNavigationController.swift
//  JTiOS
//
//  Created by JT on 2017/12/25.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class WarningNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pushViewController(WarningListViewController(), animated: true)
    }
    
    deinit {
        print("--------WarningNavigationController-----------")
    }

}
