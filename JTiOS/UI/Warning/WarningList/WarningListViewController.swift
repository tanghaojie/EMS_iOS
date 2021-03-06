//
//  WarningListViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/25.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD

class WarningListViewController: UIViewController {
    
    private var tableView: UITableView!
    private var tableViewHeader: MJRefreshNormalHeader!
    private var tableViewFooter: MJRefreshAutoGifFooter!
    private let cellReuseIdentifier = "warningTableViewCell"
    
    private var cellVM: [WarningListTableViewCellVM] = [WarningListTableViewCellVM]()
    private let c = WarningListC()
    private let navigationBarTitle = "预警"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        print("--------WarningListViewController-----------")
    }
}

extension WarningListViewController {
    
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
        tableView.register(WarningListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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

extension WarningListViewController {
    
    private func renew() {
        c.total = 0
        c.pagenum = 1
        cellVM = [WarningListTableViewCellVM]()
        self.tableView.mj_footer.state = .idle
        self.tableView.reloadData()
    }
    
    private func loadData() {
        c.getData() { [weak self] (vms: [WarningListTableViewCellVM]?, error: String?) in
            if let e = error, let s = self {
                s.endRefreshing()
                Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.error, message: e, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                return
            }
            if let vms = vms {
                if let nomore =  self?.c.noMoreData , nomore {
                    self?.tableView.mj_footer.state = .noMoreData
                }
                self?.cellVM.append(contentsOf: vms)
                self?.tableView.reloadData()
                self?.endRefreshing()
            }
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

extension WarningListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! WarningListTableViewCell
        let vm = cellVM[indexPath.row]
        cell.set(vm: vm)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(WarningListTableViewCell.height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = cellVM[indexPath.row]
        let data = vm.data
        let status = data?.statecode_alias
        if status == "指挥中" {
            setCommanding(data: data)
        } else if status == "已取消" {
            setCanceled(data: data)
        } else if status == "已结束" {
            setEnded(data: data)
        } else if status == "待处理" {
            setWaitTodo(data: data)
        } else if status == "预警中" {
            setWarning(data: data)
        }
    }
    private func queryFiles(e: Object_Event?, handler: @escaping ([Object_File]?) -> Void) {
        let view: UIView
        if let navi = self.navigationController {
            view = navi.view
        } else {
            view = self.view
        }
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = false
        HUD.minShowTime = 0.5
        HUD.show(animated: true)
        c.getFiles(e: e) {
            [weak self] files, msg in
            DispatchQueue.main.async {
                HUD.hide(animated: true)
                if let m = msg, let s = self {
                    Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.networkError, message: m, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                    return
                }
                handler(files)
            }
        }
    }
    private func setCommanding(data: Object_Event?) {
        let sb = UIStoryboard(name: "WarningDetailCommanding", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WarningDetailCommanding")
        guard let v = vc as? WarningDetailCommandingViewController else { return }
        let vvm = WarningDetailCommandingVM()
        vvm.address = data?.address
        vvm.commandTime = data?.zhtime?.toJTFormateDate
        //vvm.emergencyPlan
        //vvm.implementationPlan
        vvm.level = data?.levelcode_alias
        //vvm.measure = data.
        vvm.name = data?.eventname
        //vvm.reason = data.
        vvm.startTime = data?.cltime?.toJTFormateDate
        vvm.status = data?.statecode_alias
        vvm.time = data?.sbtime?.toJTFormateDate
        //vvm.trend =
        vvm.type = data?.typecode_alias
        if let geo = data?.geometry {
            if let t = geo.type, t.uppercased() == "POINT", let p = geo.coordinates {
                if let x = p as? [Double] {
                    if x.count == 2 {
                        let lo = CLLocation(latitude: x[1], longitude: x[0])
                        vvm.point = AGSPoint(location: lo)
                    }
                }
            }
        }

        queryFiles(e: data) {
            [weak self] files in
            vvm.files = files
            v.set(vm: vvm)
            self?.navigationController?.pushViewController(v, animated: true)
        }
    }
    private func setCanceled(data: Object_Event?) {
        let sb = UIStoryboard(name: "WarningDetailCanceled", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WarningDetailCanceled")
        guard let v = vc as? WarningDetailCanceledViewController else { return }
        let vvm = WarningDetailCanceledVM()
        vvm.address = data?.address
        vvm.cancelTime = data?.cltime?.toJTFormateDate
        vvm.level = data?.levelcode_alias
        //vvm.measure =
        vvm.name = data?.eventname
        //vvm.reason
        vvm.status = data?.statecode_alias
        vvm.time = data?.sbtime?.toJTFormateDate
        //vvm.trend
        vvm.type = data?.typecode_alias
        if let geo = data?.geometry {
            if let t = geo.type, t.uppercased() == "POINT", let p = geo.coordinates {
                if let x = p as? [Double] {
                    if x.count == 2 {
                        let lo = CLLocation(latitude: x[1], longitude: x[0])
                        vvm.point = AGSPoint(location: lo)
                    }
                }
            }
        }
        
        queryFiles(e: data) {
            [weak self] files in
            vvm.files = files
            v.set(vm: vvm)
            self?.navigationController?.pushViewController(v, animated: true)
        }
    }
    private func setEnded(data: Object_Event?) {
        let sb = UIStoryboard(name: "WarningDetailEnded", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WarningDetailEnded")
        guard let v = vc as? WarningDetailEndedViewController else { return }
        let vvm = WarningDetailEndedVM()
        vvm.address = data?.address
        vvm.commandTime = data?.zhtime?.toJTFormateDate
        //vvm.emergencyPlan =
        vvm.endTime = data?.jstime?.toJTFormateDate
        //vvm.implementationPlan =
        vvm.level = data?.levelcode_alias
        //vvm.measure =
        vvm.name = data?.eventname
        //vvm.reason =
        vvm.startTime = data?.cltime?.toJTFormateDate
        vvm.status = data?.statecode_alias
        vvm.time = data?.createtime?.toJTFormateDate
        //vvm.trend =
        vvm.type = data?.typecode_alias
        if let geo = data?.geometry {
            if let t = geo.type, t.uppercased() == "POINT", let p = geo.coordinates {
                if let x = p as? [Double] {
                    if x.count == 2 {
                        let lo = CLLocation(latitude: x[1], longitude: x[0])
                        vvm.point = AGSPoint(location: lo)
                    }
                }
            }
        }
        
        queryFiles(e: data) {
            [weak self] files in
            vvm.files = files
            v.set(vm: vvm)
            self?.navigationController?.pushViewController(v, animated: true)
        }
    }
    private func setWaitTodo(data: Object_Event?) {
        let sb = UIStoryboard(name: "WarningDetailWaitTodo", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WarningDetailWaitTodo")
        guard let v = vc as? WarningDetailWaitTodoViewController else { return }
        let vvm = WarningDetailWaitTodoVM()
        vvm.address = data?.address
        vvm.level = data?.levelcode_alias
        //vvm.measure =
        vvm.name = data?.eventname
        //vvm.reason =
        vvm.startTime = data?.cltime?.toJTFormateDate
        vvm.status = data?.statecode_alias
        vvm.time = data?.createtime?.toJTFormateDate
        //vvm.trend =
        vvm.type = data?.typecode_alias
        if let geo = data?.geometry {
            if let t = geo.type, t.uppercased() == "POINT", let p = geo.coordinates {
                if let x = p as? [Double] {
                    if x.count == 2 {
                        let lo = CLLocation(latitude: x[1], longitude: x[0])
                        vvm.point = AGSPoint(location: lo)
                    }
                }
            }
        }
        
        queryFiles(e: data) {
            [weak self] files in
            vvm.files = files
            v.set(vm: vvm)
            self?.navigationController?.pushViewController(v, animated: true)
        }
    }
    private func setWarning(data: Object_Event?) {
        let sb = UIStoryboard(name: "WarningDetailWarning", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WarningDetailWarning")
        guard let v = vc as? WarningDetailWarningViewController else { return }
        let vvm = WarningDetailWarningVM()
        vvm.address = data?.address
        vvm.level = data?.levelcode_alias
        vvm.name = data?.eventname
        vvm.status = data?.statecode_alias
        vvm.time = data?.createtime?.toJTFormateDate
        vvm.type = data?.typecode_alias
        if let geo = data?.geometry {
            if let t = geo.type, t.uppercased() == "POINT", let p = geo.coordinates {
                if let x = p as? [Double] {
                    if x.count == 2 {
                        let lo = CLLocation(latitude: x[1], longitude: x[0])
                        vvm.point = AGSPoint(location: lo)
                    }
                }
            }
        }
        
        queryFiles(e: data) {
            [weak self] files in
            vvm.files = files
            v.set(vm: vvm)
            self?.navigationController?.pushViewController(v, animated: true)
        }
    }
}
