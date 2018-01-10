//
//  TaskNavigationController.swift
//  JTiOS
//
//  Created by JT on 2018/1/3.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class TaskNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pushViewController(TaskListViewController(), animated: true)
    }
    
    deinit {
        print("--------TaskNavigationController-----------")
    }
}
