//
//  TaskDealViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/10.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MBProgressHUD
class TaskDealViewController: UIViewController {

    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var summary: UITextField!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var commit: UIButton!
    private let navigationBarTitle: String = "任务处理"
    private let c = TaskDealC()
    private var taskId: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func locationTouchUpInside(_ sender: Any) {
        JTTemp_NotOpen()
    }
    @IBAction func commitTouchUpInside(_ sender: Any) {
        let vm = get()
        let HUD = showProgressHUD(msg: Messager.shareInstance.taskDealCreating)
        c.createProcessExecute(vm: vm, tid: taskId) { [weak self] (success, msg, id) in
            HUD.hide(animated: true)
            if !success {
                guard let s = self else { return }
                Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.createTaskDealFailed, message: msg, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                return
            }
            self?.backButtonAction()
        }
    }
}
extension TaskDealViewController {
    private func setupUI() {
        setupBackButton()
        setupTextViewBorader()
        setupTitle(title: navigationBarTitle)
        
        setupScrollViewHeight()
    }
    private func setupTextViewBorader() {
        content.layer.cornerRadius = 5
        content.layer.borderColor = UIColor(red: 200, green: 200, blue: 200).cgColor
        content.layer.borderWidth = 1;
    }
    private func setupScrollViewHeight() {
        self.view.layoutIfNeeded()
        let h = commit.frame.maxY
        scrollViewHeight.constant = h + 20
    }
}
extension TaskDealViewController {
    func setTaskId(taskId: Int) {
        self.taskId = taskId
    }
}
extension TaskDealViewController {
    func get() -> TaskDealVM {
        let vm  = TaskDealVM()
        vm.address = address.text
        vm.content = content.text
        vm.summary = summary.text
//        if nil == self.vm.location {
//            if let l = JTLocationManager.shareInstance.location {
//                let c = l.coordinate
//                let geo = Object_Geometry()
//                geo.type = "Point"
//                let x: [Double] = [c.longitude,c.latitude]
//                geo.coordinates = x as AnyObject
//                self.vm.location = geo
//            }
//        }
        return vm
    }
}
