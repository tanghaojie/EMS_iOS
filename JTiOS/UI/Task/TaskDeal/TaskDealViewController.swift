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

    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var actualScrollView: UIView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var summary: UITextField!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var commit: UIButton!
    var jtMediaPicker: JTMediaPicker?
    private let navigationBarTitle: String = "任务处理"
    private let c = TaskDealC()
    private let vm  = TaskDealVM()
    private var taskId: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func locationTouchUpInside(_ sender: Any) {
        let vc = JTSelectLocationViewController() {
            [weak self] latitude, longitude in
            let geo = Object_Geometry()
            geo.type = "Point"
            let x: [Double] = [longitude, latitude]
            geo.coordinates = x as AnyObject
            self?.vm.location = geo
            self?.locationButton.setTitle("已选择位置", for: .normal)
        }
        self.present(vc, animated: true, completion: nil)
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
        setupJTMediaPicker()
        setupScrollViewHeight()
    }
    private func setupTextViewBorader() {
        content.layer.cornerRadius = 5
        content.layer.borderColor = UIColor(red: 200, green: 200, blue: 200).cgColor
        content.layer.borderWidth = 1;
    }
    private func setupScrollViewHeight() {
        //self.view.layoutIfNeeded()
        //let h = commit.frame.maxY
        //scrollViewHeight.constant = h + 20
        let svh = NSLayoutConstraint(item: actualScrollView, attribute: .bottom, relatedBy: .equal, toItem: commit, attribute: .bottom, multiplier: 1, constant: 20)
        actualScrollView.removeConstraint(scrollViewHeight)
        scrollView.addConstraint(svh)
    }
    private func setupJTMediaPicker() {
        jtMediaPicker = JTMediaPicker(
            maxCount: 9,
            numberOfLine: 4,
            addAction: { [weak self] in
                self?.showPictureAndVideoPicker()
            },
            tapAction: {
                index in
                
            },
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
extension TaskDealViewController {
    func setTaskId(taskId: Int) {
        self.taskId = taskId
    }
}
extension TaskDealViewController {
    func get() -> TaskDealVM {
        vm.address = address.text
        vm.content = content.text
        vm.summary = summary.text
        vm.pictureAndVideos = jtMediaPicker?.getData()
        if nil == vm.location {
            if let l = JTLocationManager.shareInstance.location {
                let c = l.coordinate
                let geo = Object_Geometry()
                geo.type = "Point"
                let x: [Double] = [c.longitude,c.latitude]
                geo.coordinates = x as AnyObject
                self.vm.location = geo
            }
        }
        return vm
    }
}
extension TaskDealViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func showPictureAndVideoPicker(){
        var vc: UIViewController? = self.navigationController
        if vc == nil { vc = self }
        let actionAlbum = UIAlertAction(title: Messager.shareInstance.album, style: .default) {
            [weak self] (action) -> Void in
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
                Alert.shareInstance.AlertWithUIAlertAction(viewController: xself, title: Messager.shareInstance.warning, message: Messager.shareInstance.cannotUseCamera, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
            }
        }
        let actionVideo = UIAlertAction(title: Messager.shareInstance.video, style: .default){ action in
            let sb = UIStoryboard(name: "JTVideo", bundle: nil)
            let jtvideo = sb.instantiateViewController(withIdentifier: "JTVideo") as? JTVideoViewController
            guard let video = jtvideo else { return }
            guard let viewController = vc else { return }
            video.compress = true
            video.delegate = self
            viewController.present(video, animated: true, completion: nil)
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
        
        guard var image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let jt = jtMediaPicker else { return }
        image = Compress.shareInstance.image(image: image)
        var data = UIImageJPEGRepresentation(image, 1)
        var imageExtension = ".jpeg"
        if data == nil {
            imageExtension = ".png"
            data = UIImagePNGRepresentation(image)
        }
        guard let d = data else { return }
        let temp = FileManage.shareInstance.tmpDir
        let dir = temp + "/\(FileManage.shareInstance.tmpImageSaveDir)"
        FileManage.shareInstance.createDirectory(path: dir)
        let filename = "\(UUID().uuidString + imageExtension)"
        let file = dir + "/\(filename)"
        let url = URL(fileURLWithPath: file)
        if FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.removeItem(at: url)
        }
        do {
            try d.write(to: url)
            let jtMediaPickerData = JTMediaPickerData(type: .Image, url: url)
            jt.addData(jtMediaPickData: jtMediaPickerData)
        } catch {
            let HUD = MBProgressHUD.showAdded(to: view, animated: true)
            HUD.bezelView.color = UIColor(red: 220, green: 220, blue: 220)
            HUD.label.text = Messager.shareInstance.saveImageFailed
            HUD.backgroundView.style = .solidColor
            HUD.removeFromSuperViewOnHide = true
            HUD.mode = .text
            HUD.hide(animated: true, afterDelay: 1.5)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension TaskDealViewController: JTVideoViewControllerDelegate {
    func didFinishRecordingVideo(videoFileUrl: URL) {
        guard let jt = jtMediaPicker else { return }
        let jtMediaPickerData = JTMediaPickerData(type: .Video, url: videoFileUrl)
        jt.addData(jtMediaPickData: jtMediaPickerData)
    }
    
}
