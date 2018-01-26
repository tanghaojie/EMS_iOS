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
    
    //private var defaultData: TaskDetailListTableViewCellVM?
    private var cellVM: [TaskDetailListTableViewCellVM] = [TaskDetailListTableViewCellVM]()
    private let c = TaskDetailListC()
    private let task: Object_Task
    //private let taskId: Int
    private let navigationBarTitle: String = "任务详情"
    
//    init(id: Int) {
//        taskId = id
//        super.init(nibName: nil, bundle: nil)
//    }
    init(object_Task: Object_Task) {
        task = object_Task
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
    
    private func setupUI() {
        setupBackButton()
        setupTitle(title: navigationBarTitle)
        setupTableView()
        setupRefreshHeader()
        setupRightBarButton()
        
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
        //tableView.register(TaskDetailListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
    private func setupRightBarButton() {
        let img = UIImage(named: "addTaskDeal")?.withRenderingMode(.alwaysOriginal)
        let rightBtn = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem = rightBtn
    }
}
extension TaskDetailListViewController {

    private func renew() {
        let obj = Object_QueryProcessList()
        obj.address = task.address
        obj.content = task.content
        obj.endtime = task.endtime
        //obj.files =
        obj.finish = task.finish
        obj.geometry = task.geometry
        //obj.id
        obj.leaderuids = task.leaderuids
        obj.opuid = task.opuid
        obj.personuids = task.personuids
        obj.realname = task.realname
        obj.remark = task.remark
        obj.starttime = task.starttime
        obj.statecode = task.statecode
        obj.statecode_alias = task.statecode_alias
        obj.summary = task.summary
        obj.tid = task.id
        let taskDetailListTableViewCellVM = TaskDetailListTableViewCellVM(data: obj)
        cellVM = [TaskDetailListTableViewCellVM]()
        cellVM.append(taskDetailListTableViewCellVM)
    }
    
    private func loadData() {
        guard let taskId = task.id else { return }
        c.getData(id: taskId) { [weak self] (vms: [TaskDetailListTableViewCellVM]?, error: String?) in
            if let e = error, let s = self {
                s.endRefreshing()
                Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.error, message: e, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                return
            }
            if let vms = vms {
                self?.cellVM.append(contentsOf: vms)
            }
            self?.tableView.reloadData()
            self?.endRefreshing()
        }
    }
    
    @objc private func headerRefresh() {
        renew()
        loadData()
    }
    
    @objc private func rightBarButtonClicked() {
        let sb = UIStoryboard(name: "TaskDeal", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TaskDeal")
        if let v = vc as? TaskDealViewController {
            guard let taskId = task.id else { return }
            v.setTaskId(taskId: taskId)
            navigationController?.pushViewController(v, animated: true)
        }
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
        var cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            cell = TaskDetailListTableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
            if let mCell = cell as? TaskDetailListTableViewCell {
                let vm = cellVM[indexPath.row]
                mCell.set(vm: vm)
            }
            cell?.selectionStyle = .none
        }
        return cell!
    }
}

