//
//  WarningDetailStartedViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/2.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class WarningDetailWaitTodoViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var actualScrollView: UIView!
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
    var jtMediaPreview: JTMediaPreview?
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
        setupJTMediaPreview()
        
        setupScrollViewHeight()
    }
    private func setupScrollViewHeight() {
        let svh = NSLayoutConstraint(item: actualScrollView, attribute: .bottom, relatedBy: .equal, toItem: bottomView, attribute: .bottom, multiplier: 1, constant: 20)
        actualScrollView.removeConstraint(scrollViewHeight)
        scrollView.addConstraint(svh)
    }
    private func setupJTMediaPreview() {
        jtMediaPreview = JTMediaPreview()
        guard let jt = jtMediaPreview else { return }
        jt.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(jt)
        
        let left = NSLayoutConstraint(item: jt, attribute: .left, relatedBy: .equal, toItem: bottomView, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: jt, attribute: .right, relatedBy: .equal, toItem: bottomView, attribute: .right, multiplier: 1, constant: 0)
        let topContraint = NSLayoutConstraint(item: jt, attribute: .top, relatedBy: .equal, toItem: bottomView, attribute: .top, multiplier: 1, constant: 0)
        
        let h = NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: jt, attribute: .height, multiplier: 1, constant: 0)
        bottomView.removeConstraint(bottomViewHeight)
        bottomView.addConstraints([left, right, topContraint, h])
    }
}
extension WarningDetailWaitTodoViewController {
    func set(vm: WarningDetailWaitTodoVM) {
        self.vm = vm
    }
    private func setVM() {
        guard let vm = self.vm else { return }
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
        jtMediaPreview?.setFilesToJTMediaPreview(datas: vm.files)
    }
    
}
