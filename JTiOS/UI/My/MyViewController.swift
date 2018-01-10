////
////  MyViewController.swift
////  MyFramework
////
////  Created by JT on 2017/7/20.
////  Copyright © 2017年 JT. All rights reserved.
////
//
//import UIKit
//
//class MyViewController: UIViewController {
//
//    private var tableView: UITableView!
//    private var cacheSizeLabel: UILabel!
//    private var cacheActivityIndicatorView: UIActivityIndicatorView!
//    private var headPotraitImageView: UIImageView!
//
//    private let tableViewHeaderHeight: CGFloat = 200
//    private let tableViewHeaderImageWH: CGFloat = 180
//    private let tableViewRowHeight: CGFloat = 40
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//    }
//
//
//}
//
//extension MyViewController {
//
//    fileprivate func setupUI() {
//        setupBackButton()
//        setupTitle()
//        setupTableView()
//        setupSuperViewJT()
//    }
//
//    private func setupTableView() {
//        tableView = UITableView()
//        tableView.frame = view.frame
//        tableView.showsHorizontalScrollIndicator = false
//        tableView.showsVerticalScrollIndicator = false
//        tableView.bounces = true
//        tableView.alwaysBounceVertical = true
//        tableView.alwaysBounceHorizontal = false
//        tableView.scrollsToTop = true
//        tableView.keyboardDismissMode = .onDrag
//        registCell()
//        tableView.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
//        tableView.tableHeaderView = setupTableViewHeaderView()
//        view.addSubview(tableView)
//    }
//
//    private func setupTableViewHeaderView() -> UIView {
//        let headView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: tableViewHeaderHeight))
//        headView.backgroundColor = .white
//        headPotraitImageView = UIImageView(frame: CGRect(x: (SystemInfo.sharedInstance.ScreenWidth - tableViewHeaderImageWH) / 2, y: (tableViewHeaderHeight - tableViewHeaderImageWH) / 2, width: tableViewHeaderImageWH, height: tableViewHeaderImageWH))
//        headPotraitImageView?.contentMode = .scaleAspectFill
//        headPotraitImageView?.layer.masksToBounds = true
//        headPotraitImageView?.layer.cornerRadius = tableViewHeaderImageWH / 2
//        headPotraitImageView?.layer.borderWidth = 2
//        headPotraitImageView?.layer.borderColor = UIColor.gray.cgColor
//        headPotraitImageView?.isUserInteractionEnabled = true
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headPotraitAction))
//        tapGestureRecognizer.cancelsTouchesInView = false
//        headPotraitImageView?.addGestureRecognizer(tapGestureRecognizer)
//
//        headView.addSubview(headPotraitImageView!)
//
//        HeadPortrait()
//
//        return headView
//    }
//
//    @objc internal func headPotraitAction() {
//        addImageAction()
//    }
//
//    private func setupBackButton(){
//        let img = UIImage(named: "leftArrow")?.withRenderingMode(.alwaysOriginal)
//        let leftBtn = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonAction))
//        self.navigationItem.leftBarButtonItem = leftBtn;
//    }
//
//    @objc func backButtonAction(){
//        let navi = self.navigationController
//        navi?.dismiss(animated: true, completion: nil)
//    }
//
//    private func setupTitle() {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
//        navigationItem.titleView = view
//        let wid : CGFloat = 75.0
//        let hei : CGFloat = 44.0
//        let x : CGFloat = 22.5
//        let y : CGFloat = 0
//        let titleLabel = UILabel()
//        titleLabel.frame = CGRect(x: x, y: y, width: wid, height: hei)
//        titleLabel.text = "我的"
//        titleLabel.textAlignment = .center
//
//        titleLabel.textColor = .white
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
//
//        view.addSubview(titleLabel)
//    }
//
//}
//
//extension MyViewController {
//
//    fileprivate func HeadPortrait() {
////        Image.instance.getImageInfo(prid: (loginInfo?.userId)!, typenum: 0, useSmallPic: true) { [weak self] (image,index) in
////            DispatchQueue.main.async {
////                self?.headPotraitImageView?.image = image
////            }
////        }
//    }
//
//    private func getCacheSize(complete: @escaping (CGFloat) -> Void) {
//        DispatchQueue.global().async {
//            let fileManager = FileManager.default
//            var directoryEnumerator = fileManager.enumerator(atPath: cachePath!)
//            var isDir = ObjCBool(true)
//            var total: CGFloat = 0
//            while let path = directoryEnumerator?.nextObject() as? String {
//                isDir = ObjCBool(true)
//                let nFull = cachePath?.appending("/\(path)")
//                guard let full = nFull else { continue }
//                guard fileManager.fileExists(atPath: full, isDirectory: &isDir) else { continue }
//                guard !isDir.boolValue else { continue }
//                let nAttributes = try? fileManager.attributesOfItem(atPath: full)
//                guard let attributes = nAttributes else { continue }
//                let size = attributes[FileAttributeKey.size]
//                if let s = size {
//                    total += s as! CGFloat
//                }
//            }
//            directoryEnumerator = nil
//            complete(total)
//        }
//    }
//
//    fileprivate func getCacheAndShowUI() {
//        getCacheSize() { [weak self] (size) in
//            let sizeM = size / 1024 / 1024
//            DispatchQueue.main.async {
//                if sizeM >= 0 {
//                    self?.cacheActivityIndicatorView.isHidden = true
//                    self?.cacheActivityIndicatorView.stopAnimating()
//                    self?.cacheSizeLabel.text = "\(Int(sizeM)) M"
//                    self?.cacheSizeLabel.isHidden = false
//                } else {
//                    self?.cacheActivityIndicatorView.isHidden = true
//                    self?.cacheActivityIndicatorView.stopAnimating()
//                    self?.cacheSizeLabel.text = "0 M"
//                    self?.cacheSizeLabel.isHidden = false
//                }
//            }
//        }
//    }
//
//}
//
//extension MyViewController: UITableViewDelegate, UITableViewDataSource {
//
//    fileprivate func registCell() {
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//
//    internal func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return nil
//    }
//
//    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return self.tableViewRowHeight
//    }
//
//    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return self.tableViewRowHeight
//    }
//
//    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        case 1:
//            return 1
//        default:
//            return 0
//        }
//    }
//
//    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//
//        if indexPath.section == 0 && indexPath.row == 0 {
//            let x: CGFloat = 20
//            let h: CGFloat = 40
//            let w: CGFloat = (kScreenWidth - CGFloat(x * 2)) / 2
//            let y = (self.tableViewRowHeight - h) / 2
//            let x2 = x + w
//            let cacheTextLabel = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
//            cacheTextLabel.text = "清除缓存"
//            cacheTextLabel.textColor = UIColor(red: 64, green: 64, blue: 64)
//
//            self.cacheSizeLabel = UILabel(frame: CGRect(x: x2, y: y, width: w, height: h))
//            self.cacheSizeLabel.textColor = UIColor(red: 113, green: 122, blue: 132)
//            self.cacheSizeLabel.textAlignment = NSTextAlignment.right
//
//            self.cacheActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//            self.cacheActivityIndicatorView.frame = cacheSizeLabel.frame
//            self.cacheActivityIndicatorView.startAnimating()
//            self.cacheSizeLabel.isHidden = true
//
//            cell?.addSubview(cacheTextLabel)
//            cell?.addSubview(cacheSizeLabel)
//            cell?.addSubview(cacheActivityIndicatorView)
//            cell?.selectionStyle = UITableViewCellSelectionStyle.none
//
//            getCacheAndShowUI()
//        } else if indexPath.section == 1 && indexPath.row == 0 {
//            cell?.backgroundColor = UIColor(red: 247, green: 33, blue: 0)
//            cell?.textLabel?.text = "退出账号"
//            cell?.textLabel?.textAlignment = NSTextAlignment.center
//            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//            cell?.textLabel?.textColor = .white
//            cell?.selectionStyle = UITableViewCellSelectionStyle.none
//        }
//        return cell!
//    }
//
//    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 && indexPath.row == 0 {
//            let actionController = UIAlertController(title: "警告", message: "确认清除缓存？", preferredStyle: .alert)
//            let actionConfirm = UIAlertAction(title: "确认", style: .default){ [weak self] (_) -> Void in
//
//                self?.cacheSizeLabel.isHidden = true
//                self?.cacheActivityIndicatorView.isHidden = false
//                self?.cacheActivityIndicatorView.startAnimating()
//
//                DispatchQueue.global().async { [weak self] in
//                    let fileManager = FileManager.default
//                    let cache = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
//                    let nSubPaths = fileManager.subpaths(atPath: cache!)
//                    if let subPaths = nSubPaths {
//                        for subPath in subPaths {
//                            let full = cache?.appending("/\(subPath)")
//                            if fileManager.fileExists(atPath: full!) {
//                                try? fileManager.removeItem(atPath: full!)
//                            }
//                        }
//                    }
//                    DispatchQueue.main.async { [weak self] in
//                        self?.getCacheAndShowUI()
//                    }
//                }
//            }
//            let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//            actionController.addAction(actionCancel)
//            actionController.addAction(actionConfirm)
//            self.navigationController?.present(actionController, animated: true, completion: nil)
//        } else if indexPath.section == 1 && indexPath.row == 0 {
//
//            var urlRequest = URLRequest(url: URL(string: url_Logout)!)
//            urlRequest.timeoutInterval = TimeInterval(kMoreShortTimeoutInterval)
//            urlRequest.httpMethod = HttpMethod.Post.rawValue
//            urlRequest.httpShouldHandleCookies = true
//            var jsonDic = Dictionary<String,Any>()
//            jsonDic["id"] = loginInfo?.userId
//            let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
//            urlRequest.httpBody = jsonData
//            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//
//            var response : URLResponse?
//            let data = try? NSURLConnection.sendSynchronousRequest(urlRequest, returning: &response)
//            guard let _ = response else {
//                AlertWithNoButton(view: self, title: "退出失败，请重试", message: nil, preferredStyle: .alert, showTime: 1)
//                return
//            }
//            if data == nil || data!.isEmpty {
//                AlertWithNoButton(view: self, title: "退出失败，请重试", message: nil, preferredStyle: .alert, showTime: 1)
//                return
//            }
//
//            let json = JSON(data : data!)
//            let nStatus = json["status"].int
//            let nMsg = json["msg"].string
//
//            guard let status = nStatus else {
//                AlertWithNoButton(view: self, title: "退出失败，请重试", message: nMsg, preferredStyle: .alert, showTime: 1)
//                return
//            }
//            if status != 0 {
//                AlertWithNoButton(view: self, title: "退出失败，请重试", message: nMsg, preferredStyle: .alert, showTime: 1)
//                return
//            }
//
//            weak var view = self.presentingViewController
//            weak var main = view as? MainViewController
//            main?.selfDismiss()
//            main = nil
//        }
//    }
//
//}
//
//extension MyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    fileprivate func addImageAction(){
//        let picker = UIImagePickerController()
//        picker.delegate = self
//
//        let actionController = UIAlertController(title: "提示", message: "拍照/相册选择", preferredStyle: .actionSheet)
//        let actionAlbum = UIAlertAction(title: "相册", style: .default){ [weak self] (action) -> Void in
//            picker.sourceType = .savedPhotosAlbum
//            self?.navigationController?.present(picker, animated: true, completion: nil)
//        }
//        let actionCamera = UIAlertAction(title: "拍照", style: .default){ [weak self] (action) -> Void in
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                picker.sourceType = .camera
//                self?.navigationController?.present(picker, animated: true, completion: nil)
//            } else {
//                if let xself = self {
//                    AlertWithNoButton(view: xself, title: "", message: "不支持拍照", preferredStyle: .alert, showTime: 1)
//                }
//            }
//        }
//        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//
//        actionController.addAction(actionAlbum)
//        actionController.addAction(actionCamera)
//        actionController.addAction(actionCancel)
//
//        self.navigationController?.present(actionController, animated: true, completion: nil)
//    }
//
//    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let date = getDateFormatter(dateFormatter: "yyyy-MM-dd+HH:mm:ss").string(from: Date().addingTimeInterval(kTimeInteval))
//        let compressedImage = Image.instance.compressImage(originalImg: image, resolution: 300)
//        if let cImg = compressedImage {
//            Image.instance.uploadImages(images: [cImg], prid: "\(loginInfo?.userId ?? -1)", typenum: "0", actualtime: date){ [weak self] (prid) in
//                self?.HeadPortrait()
//            }
//        } else {
//            AlertWithUIAlertAction(view: self, title: msg_UploadFailed, message: "", preferredStyle: UIAlertControllerStyle.alert, uiAlertAction: UIAlertAction(title: msg_OK, style: .default, handler: nil))
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//}
//
