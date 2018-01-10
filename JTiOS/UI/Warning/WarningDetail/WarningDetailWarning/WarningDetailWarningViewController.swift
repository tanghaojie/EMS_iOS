//
//  WarningDetailWaitTodoViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/29.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class WarningDetailWarningViewController: UIViewController {
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var bottomView: UIView!
    private var vm: WarningDetailWarningVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setVM()
    }
    
    @IBAction func pointTouchUpInside(_ sender: Any) {
        JTTemp_NotOpen()
    }

}
extension WarningDetailWarningViewController {
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
extension WarningDetailWarningViewController {
    func set(vm: WarningDetailWarningVM) {
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
        }
    }
}
