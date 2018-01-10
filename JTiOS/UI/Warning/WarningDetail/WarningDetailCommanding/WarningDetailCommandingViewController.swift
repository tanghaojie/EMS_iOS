//
//  WarningDetailCommandingViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/2.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MBProgressHUD

class WarningDetailCommandingViewController: UIViewController {

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
    @IBOutlet weak var emergencyPlan: UIButton!
    @IBOutlet weak var implementationPlan: UIButton!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var commandTime: UILabel!
    @IBOutlet weak var bottomView: UIView!
    private var vm: WarningDetailCommandingVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setVM()
    }
    
    @IBAction func pointTouchUpInside(_ sender: Any) {
        JTTemp_NotOpen()
    }
    @IBAction func emergencyPlanTouchUpInside(_ sender: Any) {
        JTTemp_NotOpen()
    }
    @IBAction func implementationPlanTouchUpInside(_ sender: Any) {
        JTTemp_NotOpen()
    }
}
extension WarningDetailCommandingViewController {
    private func setupUI() {
        setupBackButton()
        
        setupScrollViewHeight()
    }
    private func setupScrollViewHeight() {
        self.view.layoutIfNeeded()
        let h = bottomView.frame.maxY
        scrollViewHeight.constant = h + 20
    }
}
extension WarningDetailCommandingViewController {
    func set(vm: WarningDetailCommandingVM) {
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
            //emergencyPlan.setTitle(vm.emergencyPlan, for: .normal)
            //implementationPlan.setTitle(vm.implementationPlan, for: .normal)
            startTime.text = vm.startTime?.toJTFormateString
            commandTime.text = vm.commandTime?.toJTFormateString
        }
    }
}
