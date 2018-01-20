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
    @IBOutlet weak var selectViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!

    var jtMediaPicker: JTMediaPicker?
    
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
        JTTemp_NotOpen()
    }
    @IBAction func nowTouchUpInside(_ sender: Any) {
        datePicker.maximumDate = Date()
        datePicker.date = Date()
    }
    @IBAction func commitTouchUpInside(_ sender: Any) {
        get()
        let HUD = showProgressHUD(msg: Messager.shareInstance.eventCreating)
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
        setupJTMediaPicker()
    }
    private func setupJTMediaPicker() {
        jtMediaPicker = JTMediaPicker(
            maxCount: 9,
            numberOfLine: 3,
            addAction: { [weak self] in
                self?.showPictureAndVideoPicker()
            },
            tapAction: nil,
            deleteAction: { [weak self] index in
                let actionController = UIAlertController(title: Messager.shareInstance.warning, message: Messager.shareInstance.ifDelete, preferredStyle: .alert)
                let actionDel = UIAlertAction(title: Messager.shareInstance.delete, style: .default){ action in
                    guard let jt = self?.jtMediaPicker else { return }
                    jt.removeData(at: index)
                }
                let actionCancel = UIAlertAction(title: Messager.shareInstance.cancel, style: .cancel, handler: nil)
                actionController.addAction(actionDel)
                actionController.addAction(actionCancel)
                var vc: UIViewController? = self?.navigationController
                if vc == nil { vc = self }
                vc?.present(actionController, animated: true, completion: nil)
        })
        guard let jt = jtMediaPicker else { return }
        
        //jt.backgroundColor = .red
        jt.translatesAutoresizingMaskIntoConstraints = false
        selectView.addSubview(jt)
        
        let left = NSLayoutConstraint(item: jt, attribute: .left, relatedBy: .equal, toItem: selectView, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: jt, attribute: .right, relatedBy: .equal, toItem: selectView, attribute: .right, multiplier: 1, constant: 0)
        let topContraint = NSLayoutConstraint(item: jt, attribute: .top, relatedBy: .equal, toItem: selectView, attribute: .top, multiplier: 1, constant: 0)
        let h = NSLayoutConstraint(item: selectView, attribute: .height, relatedBy: .equal, toItem: jt, attribute: .height, multiplier: 1, constant: 0)
        selectView.removeConstraint(selectViewHeight)
        selectView.addConstraints([left, right, topContraint, h])
    }
    private func setupTextViewBorader() {
        detailTextView.layer.cornerRadius = 5
        detailTextView.layer.borderColor = UIColor(red: 200, green: 200, blue: 200).cgColor
        detailTextView.layer.borderWidth = 1;
    }
    private func setupDatePicker() {
        datePicker.maximumDate = Date()
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
        //self.vm.pictureAndVideos = jtPictureAndVideoPicker?.getData()
    }
}
extension WarningReportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func showPictureAndVideoPicker(){
        var vc: UIViewController? = self.navigationController
        if vc == nil { vc = self }
        let actionAlbum = UIAlertAction(title: Messager.shareInstance.album, style: .default){ [weak self] (action) -> Void in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            guard let viewController = vc else { return }
            viewController.present(picker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: Messager.shareInstance.camera, style: .default){ [weak self] (action) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                guard let viewController = vc else { return }
                viewController.present(picker, animated: true, completion: nil)
            } else {
                guard let xself = self else { return }
                Alert.shareInstance.AlertWithUIAlertAction(view: xself, title: Messager.shareInstance.warning, message: Messager.shareInstance.cannotUseCamera, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
            }
        }
        let actionVideo = UIAlertAction(title: Messager.shareInstance.video, style: .default){ action in
            let sb = UIStoryboard(name: "JTVideo", bundle: nil)
            let jtvideo = sb.instantiateViewController(withIdentifier: "JTVideo")
            guard let viewController = vc else { return }
            viewController.present(jtvideo, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: Messager.shareInstance.cancel, style: .cancel, handler: nil)
        let actionController = UIAlertController(title: Messager.shareInstance.selectType, message: Messager.shareInstance.takePhotoOrSelectFromAlbum, preferredStyle: .actionSheet)
        actionController.addAction(actionAlbum)
        actionController.addAction(actionCamera)
        actionController.addAction(actionVideo)
        actionController.addAction(actionCancel)
        guard let viewController = vc else { return }
        viewController.present(actionController, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let jt = jtMediaPicker else { return }
        jt.addData(anyObject: image)
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


