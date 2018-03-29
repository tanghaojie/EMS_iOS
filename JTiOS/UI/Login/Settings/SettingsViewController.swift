//
//  SettingsViewController.swift
//  JTiOS
//
//  Created by JT on 2018/3/28.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD

class SettingsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        scrollView.mj_header.beginRefreshing()
    }

    @IBAction func okTouchUpInSide(_ sender: Any) {
        guard let url = urlTextField.text, url != "" else {
            let x = MBProgressHUD.showAdded(to: view, animated: true)
            x.bezelView.color = UIColor(red: 120, green: 120, blue: 120)
            x.label.text = Messager.shareInstance.inputServerUrl
            x.backgroundView.style = .solidColor
            x.removeFromSuperViewOnHide = true
            x.mode = .text
            x.hide(animated: true, afterDelay: 1)
            return
        }
        let oldUrl = APIUrl.baseUrl
        APIUrl.baseUrl = url
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.label.text = Messager.shareInstance.wait
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = true
        HUD.minShowTime = 1
        HUD.show(animated: true)
        APIUrl.checkAPIStatus() {
            [weak self] result in
            DispatchQueue.main.async { HUD.hide(animated: true) }
            guard let this = self else { return }
            if result {
                Data.shareInstance.SaveData_Settings(apiBaseUrl: APIUrl.baseUrl)
                let x = MBProgressHUD.showAdded(to: this.view, animated: true)
                x.bezelView.color = UIColor(red: 120, green: 120, blue: 120)
                x.label.text = Messager.shareInstance.settingSuccess
                x.backgroundView.style = .solidColor
                x.removeFromSuperViewOnHide = true
                x.mode = .text
                x.hide(animated: true, afterDelay: 1)
            } else {
                APIUrl.baseUrl = oldUrl
                let x = MBProgressHUD.showAdded(to: this.view, animated: true)
                x.bezelView.color = UIColor(red: 120, green: 120, blue: 120)
                x.label.text = Messager.shareInstance.settingFailed
                x.backgroundView.style = .solidColor
                x.removeFromSuperViewOnHide = true
                x.mode = .text
                x.hide(animated: true, afterDelay: 1)
            }
            this.scrollView.mj_header.beginRefreshing()
        }
    }
    
}
extension SettingsViewController {
    private func setupUI() {
        setupBackButton()
        setupRefreshHeader()
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
}
extension SettingsViewController {
    @objc private func headerRefresh() {
        APIUrl.getBaseUrl()
        urlTextField.text = APIUrl.baseUrl
        scrollView.mj_header.endRefreshing()
    }
}
