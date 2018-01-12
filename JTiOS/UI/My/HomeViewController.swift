//
//  HomeViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MJRefresh
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
    
    private var x = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        scrollView.mj_header.beginRefreshing()
    }
    
    @IBAction func loginTouchUpInside(_ sender: Any) {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginNavigationController")
        present(vc, animated: true, completion: nil)
    }
    @IBAction func logoutTouchUpInside(_ sender: Any) {
        let HUD = showProgressHUD(msg: Messager.shareInstance.logouting)
        c.logout() { [weak self] (success: Bool, msg: String?) in
            HUD.hide(animated: true)
            if !success {
                if let s = self {
                 Alert.shareInstance.AlertWithUIAlertAction(view: s, title: Messager.shareInstance.logoutFailed, message: msg, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                }
                return
            }
            self?.scrollView.mj_header.beginRefreshing()
        }
    }
    
}
extension HomeViewController {
    private func setup() {
        setupBackButton()
        setupClearCache()
        loginButtonHide()
        logoutButtonHide()
        setupRefreshHeader()
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
    private func setHeadProtrait() {
        headProtrait.image = UIImage(named: "defaultHead")
    }
}
extension HomeViewController {
    
    private func checkLoginState() {
        c.loginState() { [weak self] (hadLogin: Bool, msg: String?) in
            self?.logInOutButtonUI(isLogin: hadLogin)
            if hadLogin {
                self?.setName(name: global_SystemUser?.realname)
            } else {
                
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
        JTTemp_NotOpen()
        clearCacheActivityIndicator.stopAnimating()
    }
    
}
