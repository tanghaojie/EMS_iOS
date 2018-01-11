//
//  WarningDetailStartedViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/2.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class WarningDetailWaitTodoViewController: UIViewController {
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var trend: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var measure: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var bottomView: UIView!
    private var vm: WarningDetailWaitTodoVM?
    private let navigationBarTitle = "预警详情"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setVM()
    }
    @IBAction func pointTouchUpInside(_ sender: Any) {
        JTTemp_NotOpen()
    }
}
extension WarningDetailWaitTodoViewController {
    private func setupUI() {
        setupBackButton()
        setupTitle(title: navigationBarTitle)
        
        setupScrollViewHeight()
    }
    private func setupScrollViewHeight() {
        self.view.layoutIfNeeded()
        let h = bottomView.frame.maxY
        scrollViewHeight.constant = h + 20
    }
}
extension WarningDetailWaitTodoViewController {
    func set(vm: WarningDetailWaitTodoVM) {
        self.vm = vm
    }
    private func setVM() {
        if let vm = self.vm {
            status.text = vm.status
            name.text = vm.name
            type.text = vm.type
            level.text = vm.level
            time.text = vm.time?.toJTFormateString
            address.text = vm.address
            trend.text = vm.trend
            reason.text = vm.reason
            measure.text = vm.measure
            startTime.text = vm.startTime?.toJTFormateString
        }
    }
}
