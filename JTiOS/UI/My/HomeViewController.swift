//
//  HomeViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD
class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var headProtrait: UIImageView!
    @IBOutlet weak var clearCache: UIView!
    @IBOutlet weak var clearCacheActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var loginHeight: NSLayoutConstraint!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var logoutHeight: NSLayoutConstraint!
    
    private let c = HomeC()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        scrollView.mj_header.beginRefreshing()
    }
    
    @IBAction func loginTouchUpInside(_ sender: Any) {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "LoginNavigationController") as? LoginNavigationController {
            if vc.viewControllers.count > 0 {
                if let v = vc.viewControllers[0] as? LoginViewController {
                    v.loginSuccessHandler = { [weak self] in
                        if let s = self {
                            s.scrollView.mj_header.beginRefreshing()
                        }
                    }
                }
            }
            present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func logoutTouchUpInside(_ sender: Any) {
        let HUD = showProgressHUD(msg: Messager.shareInstance.logouting)
        c.logout() { [weak self] (success: Bool, msg: String?) in
            HUD.hide(animated: true)
            if !success {
                if let s = self {
                 Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.logoutFailed, message: msg, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                }
                return
            }
            self?.scrollView.mj_header.beginRefreshing()
        }
    }
    
}
extension HomeViewController {
    private func setup() {
        loginButtonHide()
        logoutButtonHide()
        setupBackButton()
        setupClearCache()
        setupRefreshHeader()
        setupHeadPortraitTapGestureRecognizer()
    }
    private func setupHeadPortraitTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setHeadPortraitAction))
        tapGestureRecognizer.cancelsTouchesInView = false
        headProtrait.addGestureRecognizer(tapGestureRecognizer)
    }
    private func setupClearCache() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clearCacheAction))
        tapGestureRecognizer.cancelsTouchesInView = false
        clearCache.addGestureRecognizer(tapGestureRecognizer)
    }
    private func setupRefreshHeader() {
        let header = MJRefreshNormalHeader()
        header.backgroundColor = UIColor(red: 190, green: 190, blue: 190)
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("释放刷新", for: .pulling)
        header.setTitle("刷新中...", for: .refreshing)
        header.lastUpdatedTimeLabel.text = "上次刷新"
        header.activityIndicatorViewStyle = .gray
        scrollView.mj_header = header
    }
    private func loginButtonHide(hide: Bool = true){
        if hide {
            login.setTitle(nil, for: .normal)
            login.isUserInteractionEnabled = false
            loginHeight.constant = 0
        } else {
            login.setTitle("登录", for: .normal)
            login.isUserInteractionEnabled = true
            loginHeight.constant = 30
        }
    }
    private func logoutButtonHide(hide: Bool = true){
        if hide {
            logout.setTitle(nil, for: .normal)
            logout.isUserInteractionEnabled = false
            logoutHeight.constant = 0
        } else {
            logout.setTitle("退出", for: .normal)
            logout.isUserInteractionEnabled = true
            logoutHeight.constant = 30
        }
    }
    private func logInOutButtonUI(isLogin: Bool = false) {
        loginButtonHide(hide: isLogin)
        logoutButtonHide(hide: !isLogin)
    }
    private func setName(name: String? = nil) {
        self.name.text = name
    }
    private func setDefaultHeadProtrait() {
        headProtrait.image = UIImage(named: "defaultHead")
    }
}
extension HomeViewController {
    
    private func checkLoginState() {
        c.loginState() { [weak self] (hadLogin: Bool, msg: String?) in
            self?.logInOutButtonUI(isLogin: hadLogin)
            self?.setName(name: global_SystemUser?.realname)
            if hadLogin {
                self?.c.getHeadPortrait() {
                    success, data, msg in
                    if success {
                        guard let d = data, let img = UIImage(data: d)  else {
                            self?.setDefaultHeadProtrait()
                            return
                        }
                        self?.headProtrait.image = img
                    } else {
                        guard let s = self else { return }
                        let HUD = MBProgressHUD.showAdded(to: s.view, animated: true)
                        HUD.bezelView.color = UIColor(red: 220, green: 220, blue: 220)
                        HUD.label.text = Messager.shareInstance.networkError + (msg ?? "")
                        HUD.backgroundView.style = .solidColor
                        HUD.removeFromSuperViewOnHide = true
                        HUD.mode = .text
                        HUD.hide(animated: true, afterDelay: 1)
                    }
                }
            } else {
                self?.setDefaultHeadProtrait()
            }
        }
        scrollView.mj_header.endRefreshing()
    }
    
    @objc private func headerRefresh() {
        loginButtonHide()
        logoutButtonHide()
        setName()
        checkLoginState()
    }
    
    @objc private func clearCacheAction() {
        clearCacheActivityIndicator.startAnimating()
    
        let cache = FileManage.shareInstance.cacheDir
        let temp = FileManage.shareInstance.tmpDir
        let dirs = [cache, temp]
        for dir in dirs {
            let subPaths = FileManager.default.subpaths(atPath: dir)
            guard let subs = subPaths else { return }
            for sub in subs {
                let full = dir.appending("/\(sub)")
                try? FileManager.default.removeItem(atPath: full)
            }
        }
        
        Data.shareInstance.ClearData_Login()

        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor(red: 120, green: 120, blue: 120)
        HUD.label.text = Messager.shareInstance.clearCacheSuccess
        HUD.backgroundView.style = .solidColor
        HUD.removeFromSuperViewOnHide = false
        HUD.mode = .text
        HUD.hide(animated: true, afterDelay: 1)

        clearCacheActivityIndicator.stopAnimating()
    }
    @objc private func setHeadPortraitAction() {
        showImagePicker()
    }
    
    
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func showImagePicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        let actionAlbum = UIAlertAction(title: Messager.shareInstance.album, style: .default){ [weak self] (action) -> Void in
            picker.sourceType = .savedPhotosAlbum
            self?.navigationController?.present(picker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: Messager.shareInstance.camera, style: .default){ [weak self] (action) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                self?.navigationController?.present(picker, animated: true, completion: nil)
            } else {
                if let xself = self {
                    Alert.shareInstance.AlertWithUIAlertAction(viewController: xself, title: Messager.shareInstance.warning, message: Messager.shareInstance.cannotUseCamera, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                }
            }
        }
        let actionCancel = UIAlertAction(title: Messager.shareInstance.cancel, style: .cancel, handler: nil)
        let actionController = UIAlertController(title: Messager.shareInstance.selectHeadPortrait, message: Messager.shareInstance.takePhotoOrSelectFromAlbum, preferredStyle: .actionSheet)
        actionController.addAction(actionAlbum)
        actionController.addAction(actionCamera)
        actionController.addAction(actionCancel)
        self.navigationController?.present(actionController, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.label.text = Messager.shareInstance.uploading
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = true
        HUD.minShowTime = 1
        HUD.show(animated: true)
        c.uploadHeadPortrait(image: image) {
            [weak self] success, msg, _ in
            DispatchQueue.main.async {
                HUD.hide(animated: true)
                if success {
                    self?.headProtrait.image = image
                } else {
                    if let s = self {
                        Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.uploadFailed, message: msg, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                    }
                }
            }
        }
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

