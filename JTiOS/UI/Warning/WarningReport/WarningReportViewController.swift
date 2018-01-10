//
//  WarningReportViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit
import MBProgressHUD

class WarningReportViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var selectView: UIView!
    
    private let vm = WarningReportVM()
    private let c = WarningReportC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func typeTouchUpInside(_ sender: Any) {
        let sb = UIStoryboard(name: "JTPickerStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "JTPickerStoryboard")
        if let jtvc = vc as? JTPickerViewController {
            let c = Config(typename: Config.EventTypeName)
            guard let cc = c.getGroupConfig else { return }
            guard let list = cc.list else { return }
            if list.count <= 0 { return }
            var member: [DisplayValueObject] = [DisplayValueObject]()
            for l in list {
                let m = DisplayValueObject()
                m.display = l.alias ?? ""
                m.value = l
                member.append(m)
            }
            jtvc.setup(member: member){ [weak self] (member: DisplayValueObject) in
                if let x = member.value as? Object_GetGroupConfig {
                    self?.vm.type = x
                    self?.typeButton.setTitle(x.alias, for: .normal)
                }
            }
            present(jtvc, animated: true, completion: nil)
        }
    }
    @IBAction func levelTouchUpInside(_ sender: Any) {
        let sb = UIStoryboard(name: "JTPickerStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "JTPickerStoryboard")
        if let jtvc = vc as? JTPickerViewController {
            let c = Config(typename: Config.EventLevelName)
            guard let cc = c.getGroupConfig else { return }
            guard let list = cc.list else { return }
            if list.count <= 0 { return }
            var member: [DisplayValueObject] = [DisplayValueObject]()
            for l in list {
                let m = DisplayValueObject()
                m.display = l.alias ?? ""
                m.value = l
                member.append(m)
            }
            jtvc.setup(member: member){ [weak self] (member: DisplayValueObject) in
                if let x = member.value as? Object_GetGroupConfig {
                    self?.vm.level = x
                    self?.levelButton.setTitle(x.alias, for: .normal)
                }
            }
            present(jtvc, animated: true, completion: nil)
        }
    }
    @IBAction func locationTouchUpInside(_ sender: Any) {
        
    }
    @IBAction func nowTouchUpInside(_ sender: Any) {
        datePicker.maximumDate = Date()
        datePicker.date = Date()
    }
    @IBAction func commitTouchUpInside(_ sender: Any) {
        get()
        let HUD = showProgressHUD()
        c.createEvent(vm: vm) { [weak self] (success, msg, id) in
            HUD.hide(animated: true)
            if success {
                self?.backButtonAction()
                return
            }
            if let s = self {
                Alert.shareInstance.AlertWithUIAlertAction(view: s, title: Messager.shareInstance.createEventFailed, message: msg, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
            }
        }
        
    }
}

extension WarningReportViewController {
    private func setupUI() {
        setupDatePicker()
        setupBackButton()
        setupTextViewBorader()
    }
    private func setupTextViewBorader() {
        detailTextView.layer.cornerRadius = 5
        detailTextView.layer.borderColor = UIColor(red: 200, green: 200, blue: 200).cgColor
        detailTextView.layer.borderWidth = 1;
    }
    private func setupDatePicker() {
        datePicker.maximumDate = Date()
    }
    private func showProgressHUD() -> MBProgressHUD {
        let view: UIView
        if let navi = self.navigationController {
            view = navi.view
        } else {
            view = self.view
        }
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.label.text = Messager.shareInstance.eventCreating
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = false
        HUD.minShowTime = 1
        HUD.show(animated: true)
        return HUD
    }
}
extension WarningReportViewController {
    func get() {
        self.vm.name = nameTextField.text
        //self.vm.type
        //self.vm.level
        if nil == self.vm.location {
            if let l = JTLocationManager.shareInstance.location {
                let c = l.coordinate
                let geo = Object_Geometry()
                geo.type = "Point"
                let x: [Double] = [c.longitude,c.latitude]
                geo.coordinates = x as AnyObject
                self.vm.location = geo
            }
        }
        self.vm.address = addressTextField.text
        self.vm.date = datePicker.date.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
        self.vm.detail = detailTextView.text
    }
}
