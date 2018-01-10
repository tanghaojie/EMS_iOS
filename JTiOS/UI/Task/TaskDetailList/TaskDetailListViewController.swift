//
//  TaskDetailListViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/8.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MJRefresh

class TaskDetailListViewController: UIViewController {
    
    private var tableView: UITableView!
    private var tableViewHeader: MJRefreshNormalHeader!
    private let cellReuseIdentifier = "taskDetailListTableViewCell"
    
    private var cellVM: [TaskDetailListTableViewCellVM] = [TaskDetailListTableViewCellVM]()
    private let c = TaskDetailListC()
    private let taskId: Int
    
    init(id: Int) {
        taskId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        print("--------TaskDetailListViewController-----------")
    }

}
extension TaskDetailListViewController {
    
    fileprivate func setupUI() {
        setupBackButton()
        setupTitle()
        setupTableView()
        setupRefreshHeader()
        
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
        tableView.backgroundColor = UIColor(red: 78, green: 128, blue: 152)
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(TaskDetailListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
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
    private func endRefreshing() {
        self.tableView.mj_header.endRefreshing()
    }
    private func setupTitle() {
        navigationItem.title = "任务详情"
    }
}
extension TaskDetailListViewController {

    private func renew() {
        cellVM = [TaskDetailListTableViewCellVM]()
    }
    
    private func loadData() {
        c.getData(id: taskId) { [weak self] (vms: [TaskDetailListTableViewCellVM]?, error: String?) in
            if let e = error, let s = self {
                s.endRefreshing()
                Alert.shareInstance.AlertWithUIAlertAction(view: s, title: Messager.shareInstance.error, message: e, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                return
            }
            if let vms = vms {
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
}
extension TaskDetailListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TaskDetailListTableViewCell
        let vm = cellVM[indexPath.row]
        cell.set(vm: vm)
        cell.selectionStyle = .none
        return cell
    }
}
