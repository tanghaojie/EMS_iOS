//
//  WarningListViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/25.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit
import MJRefresh

class TaskListViewController: UIViewController {
    
    private var tableView: UITableView!
    private var tableViewHeader: MJRefreshNormalHeader!
    private var tableViewFooter: MJRefreshAutoGifFooter!
    private let cellReuseIdentifier = "taskTableViewCell"
    
    private var cellVM: [TaskListTableViewCellVM] = [TaskListTableViewCellVM]()
    private let c = TaskListC()
    private let navigationBarTitle = "任务"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        print("--------WarningListViewController-----------")
    }
}

extension TaskListViewController {
    
    fileprivate func setupUI() {
        setupBackButton()
        setupTitle(title: navigationBarTitle)
        setupTableView()
        setupRefreshHeader()
        setupRefreshFooter()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.mj_header.beginRefreshing()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.frame = view.frame
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = true
        tableView.alwaysBounceVertical = true
        tableView.alwaysBounceHorizontal = false
        tableView.scrollsToTop = true
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(TaskListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(tableView)
    }
    private func setupRefreshHeader() {
        let header = MJRefreshNormalHeader()
        header.backgroundColor = UIColor(red: 190, green: 190, blue: 190)
        tableViewHeader = header
        tableViewHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = tableViewHeader
        tableViewHeader.setTitle("下拉刷新", for: .idle)
        tableViewHeader.setTitle("释放刷新", for: .pulling)
        tableViewHeader.setTitle("刷新中...", for: .refreshing)
        tableViewHeader.lastUpdatedTimeLabel.text = "上次刷新"
        tableViewHeader.activityIndicatorViewStyle = .gray
    }
    private func setupRefreshFooter() {
        let footer = MJRefreshAutoGifFooter()
        footer.backgroundColor = UIColor(red: 190, green: 190, blue: 190)
        tableViewFooter = footer
        tableViewFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        tableView.mj_footer = tableViewFooter
        tableViewFooter.setTitle("加载更多", for: .idle)
        tableViewFooter.setTitle("释放以加载更多", for: .pulling)
        tableViewFooter.setTitle("加载中...", for: .refreshing)
        tableViewFooter.setTitle("没有更多数据", for: .noMoreData)
    }
    private func endRefreshing() {
        self.tableView.mj_header.endRefreshing()
        if self.tableView.mj_footer.state != .noMoreData {
            self.tableView.mj_footer.endRefreshing()
        }
    }
}

extension TaskListViewController {
    
    private func renew() {
        c.total = 0
        c.pagenum = 1
        cellVM = [TaskListTableViewCellVM]()
        self.tableView.mj_footer.state = .idle
        self.tableView.reloadData()
    }
    
    private func loadData() {
        c.getData() { [weak self] (vms: [TaskListTableViewCellVM]?, error: String?) in
            if let e = error, let s = self {
                s.endRefreshing()
                Alert.shareInstance.AlertWithUIAlertAction(view: s, title: Messager.shareInstance.error, message: e, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                return
            }
            if let vms = vms {
                if let nomore =  self?.c.noMoreData , nomore {
                    self?.tableView.mj_footer.state = .noMoreData
                }
                self?.cellVM.append(contentsOf: vms)
                self?.tableView.reloadData()
            }
            self?.endRefreshing()
        }
    }
    
    @objc private func headerRefresh() {
        renew()
        loadData()
    }
    
    @objc private func footerRefresh() {
        loadData()
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TaskListTableViewCell
        let vm = cellVM[indexPath.row]
        cell.set(vm: vm)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TaskListTableViewCell.height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = cellVM[indexPath.row]
        let data = vm.data
        if let id = data?.id {
            let list = TaskDetailListViewController(id: id)
            navigationController?.pushViewController(list, animated: true)
        }
    }
}
