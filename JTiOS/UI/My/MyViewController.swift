//
//  MyViewController.swift
//  MyFramework
//
//  Created by JT on 2017/7/20.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    private var tableView: UITableView?
    private var headPotraitImageView: UIImageView?
    private var cacheLabel: UILabel?

    private let tableViewHeaderHeight: CGFloat = 200
    private let tableViewHeaderImageWH: CGFloat = 160
    private let tableViewSectionHeaderHeight: CGFloat = 20
    private let tableViewRowHeight: CGFloat = 40
    private let navigationBarTitle = "我的"
    private let cellReuseIdentifier = "myTableViewCell"
    private let c = MyC()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        guard let tv = tableView else { return }
        tv.delegate = self
        tv.dataSource = self
    }
}
extension MyViewController {
    private func checkLoginState() {
        c.loginState() { (success: Bool, msg: String?) in
            guard success else {
            
                return
            }
            
        }
    }
}

extension MyViewController {

    private func setupUI() {
        setupBackButton()
        setupTitle(title: navigationBarTitle)
        setupTableView()
        setupHeadPortrait()
    }

    private func setupTableView() {
        tableView = UITableView()
        guard let tv = tableView else { return }
        tv.frame = view.frame
        tv.showsHorizontalScrollIndicator = false
        tv.showsVerticalScrollIndicator = false
        tv.bounces = true
        tv.alwaysBounceVertical = true
        tv.alwaysBounceHorizontal = false
        tv.scrollsToTop = true
        tv.keyboardDismissMode = .onDrag
        tv.tableFooterView = UIView()
        tv.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tv.tableHeaderView = setupTableViewHeaderView()
        view.addSubview(tv)
    }

    private func setupTableViewHeaderView() -> UIView {
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: tableViewHeaderHeight))
        headView.backgroundColor = .white
        return headView
    }
    
    private func setupHeadPortrait() {
        headPotraitImageView = UIImageView(frame: CGRect(x: (SystemInfo.shareInstance.ScreenWidth - tableViewHeaderImageWH) / 2, y: (tableViewHeaderHeight - tableViewHeaderImageWH) / 2, width: tableViewHeaderImageWH, height: tableViewHeaderImageWH))
        guard let hv = headPotraitImageView else { return }
        hv.backgroundColor = UIColor.gray
        hv.contentMode = .scaleAspectFill
        hv.layer.masksToBounds = true
        hv.layer.cornerRadius = tableViewHeaderImageWH / 2
        hv.layer.borderWidth = 2
        hv.layer.borderColor = UIColor.gray.cgColor
        hv.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headPotraitImageViewAction))
        tapGestureRecognizer.cancelsTouchesInView = false
        hv.addGestureRecognizer(tapGestureRecognizer)
        tableView?.tableHeaderView?.addSubview(hv)
    }
    private func setupCacheView() -> UIView {
        let w = SystemInfo.shareInstance.ScreenWidth
        let h = tableViewRowHeight
        let view = UIView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        
        let marginLeft: CGFloat = 20
        let marginRight: CGFloat = 20
        let lw = (w - marginLeft - marginRight) / 2
        let label = UILabel(frame: CGRect(x: marginLeft, y: 0, width: lw, height: h))
        label.textAlignment = .center
        label.text = "清楚缓存"
        view.addSubview(label)
        
        let lx = marginLeft + lw
        cacheLabel = UILabel(frame: CGRect(x: lx, y: 0, width: lw, height: h))
        if let cl = cacheLabel {
            cl.textAlignment = .center
            view.addSubview(cl)
        }
        
        return view
    }

}
extension MyViewController {
    @objc internal func headPotraitImageViewAction() {
        
    }
}
extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewSectionHeaderHeight
    }

    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowHeight
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 0
        }
        return 2
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        return cell
    }
}
