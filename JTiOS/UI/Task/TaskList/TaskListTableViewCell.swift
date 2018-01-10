//
//  WarningListTableViewCell.swift
//  JTiOS
//
//  Created by JT on 2017/12/25.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {
    
    private static let width: CGFloat = SystemInfo.shareInstance.ScreenWidth
    static let height: CGFloat = 160
    
    private static let paddingTop: CGFloat = 2
    private static let paddingLeft: CGFloat = 0
    private static let paddingBottom: CGFloat = 8
    private static let paddingRight: CGFloat = 0
    
    private static let topViewHeight: CGFloat = 38
    private static let topViewContentViewPaddingTop: CGFloat = 10
    private static let topViewContentViewPaddingLeft: CGFloat = 10
    private static let topViewContentViewPaddingBottom: CGFloat = 8
    private static let topViewContentViewPaddingRight: CGFloat = 10
    
    private static let bottomViewHeight: CGFloat = 30
    private static let bottomViewContentViewPaddingTop: CGFloat = 5
    private static let bottomViewContentViewPaddingLeft: CGFloat = 10
    private static let bottomViewContentViewPaddingBottom: CGFloat = 10
    private static let bottomViewContentViewPaddingRight: CGFloat = 10
    
    private static let mainViewContentViewPaddingTop: CGFloat = 0
    private static let mainViewContentViewPaddingLeft: CGFloat = 10
    private static let mainViewContentViewPaddingBottom: CGFloat = 0
    private static let mainViewContentViewPaddingRight: CGFloat = 10
    
    private static let mainViewContentViewTopHeight: CGFloat = 24
    
    private var fullView: UIView?
    private var itemView: UIView?
    
    private var topView: UIView?
    private var topViewContentView: UIView?
    
    private var bottomView: UIView?
    private var bottomViewContentView: UIView?
    
    private var mainView: UIView?
    private var mainViewContentView: UIView?
    
    private var mainViewContentViewTopView: UIView?
    private var mainViewContentViewTopView_1Per3View: UIView?
    private var mainViewContentViewTopView_2Per3View: UIView?
    private var mainViewContentViewTopView_3Per3View: UIView?
    private var mainViewContentViewTextView: UIView?
    
    private var topLabel: UILabel?
    private var bottomLabel: UILabel?
    private var mainTopLabel1: UILabel?
    private var mainTopLabel2: UILabel?
    private var mainTopLabel3: UILabel?
    private var mainTextView: UITextView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("--------WarningListTableViewCell-----------")
    }
}

extension TaskListTableViewCell {
    private func setupUI() {
        setupFullView()
        setupItemView()
        setupTop()
        setupBottom()
        setupMain()
    }
    private func setupTop() {
        setupTopView()
        setupTopViewContentView()
        setupTopLabel()
    }
    private func setupBottom() {
        setupBottomView()
        setupBottomViewContent()
        setupBottomLabel()
    }
    private func setupMain() {
        setupMainView()
        setupMainViewContentView()
        setupMainViewContentViewTopView()
        setupMainViewContentViewTopView_3SubView()
        
        setupMainTopLabel1()
        setupMainTopLabel2()
        setupMainTopLabel3()
        setupMainViewContentViewTextView()
        setupMainTextView()
    }
    private func setupFullView() {
        fullView = UIView(frame: CGRect(x: 0, y: 0, width: TaskListTableViewCell.width, height: WarningListTableViewCell.height))
        guard let fv = fullView else { return }
        fv.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        contentView.addSubview(fv)
    }
    private func setupItemView() {
        guard let fv = fullView else { return }
        let fvW = fv.frame.width
        let fvH = fv.frame.height
        let w = fvW - TaskListTableViewCell.paddingLeft - TaskListTableViewCell.paddingRight
        let h = fvH - TaskListTableViewCell.paddingTop - TaskListTableViewCell.paddingBottom
        itemView = UIView(frame: CGRect(x: TaskListTableViewCell.paddingLeft, y: TaskListTableViewCell.paddingTop, width: w, height: h))
        guard let iv = itemView else { return }
        iv.backgroundColor = UIColor(red: 255, green: 255, blue: 255)
        fv.addSubview(iv)
    }
    private func setupTopView() {
        guard let iv = itemView else { return }
        let ivW = iv.frame.width
        topView = UIView(frame: CGRect(x: 0, y: 0, width: ivW, height: TaskListTableViewCell.topViewHeight))
        guard let tv = topView else { return }
        iv.addSubview(tv)
    }
    private func setupTopViewContentView() {
        guard let tv = topView else { return }
        let tvW = tv.frame.width
        let tvH = tv.frame.height
        let w = tvW - TaskListTableViewCell.topViewContentViewPaddingLeft - TaskListTableViewCell.topViewContentViewPaddingRight
        let h = tvH - TaskListTableViewCell.topViewContentViewPaddingTop - TaskListTableViewCell.topViewContentViewPaddingBottom
        topViewContentView = UIView(frame: CGRect(x: TaskListTableViewCell.topViewContentViewPaddingLeft, y: TaskListTableViewCell.topViewContentViewPaddingTop, width: w, height: h))
        guard let tvcv = topViewContentView else { return }
        tv.addSubview(tvcv)
    }
    private func setupTopLabel() {
        guard let tvcv = topViewContentView else { return }
        let w = tvcv.frame.width
        let h = tvcv.frame.height
        topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h))
        guard let tl = topLabel else { return }
        tl.font = UIFont.boldSystemFont(ofSize: 20)
        tl.textColor = UIColor(red: 64, green: 64, blue: 64)
        tvcv.addSubview(tl)
    }
    private func setupBottomView() {
        guard let iv = itemView else { return }
        let ivW = iv.frame.width
        let ivH = iv.frame.height
        let y = ivH - TaskListTableViewCell.bottomViewHeight
        bottomView = UIView(frame: CGRect(x: 0, y: y, width: ivW, height: TaskListTableViewCell.bottomViewHeight))
        guard let bv = bottomView else { return }
        iv.addSubview(bv)
    }
    private func setupBottomViewContent() {
        guard let bv = bottomView else { return }
        let bvW = bv.frame.width
        let bvH = bv.frame.height
        let w = bvW - TaskListTableViewCell.bottomViewContentViewPaddingLeft - TaskListTableViewCell.bottomViewContentViewPaddingRight
        let h = bvH - TaskListTableViewCell.bottomViewContentViewPaddingTop - TaskListTableViewCell.bottomViewContentViewPaddingBottom
        bottomViewContentView = UIView(frame: CGRect(x: TaskListTableViewCell.bottomViewContentViewPaddingLeft, y: TaskListTableViewCell.bottomViewContentViewPaddingTop, width: w, height: h))
        guard let bvcv = bottomViewContentView else { return }
        bv.addSubview(bvcv)
    }
    private func setupBottomLabel() {
        guard let bvcv = bottomViewContentView else { return }
        let w = bvcv.frame.width
        let h = bvcv.frame.height
        bottomLabel = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h))
        guard let bl = bottomLabel else { return }
        bl.font = UIFont.systemFont(ofSize: 16)
        bl.textColor = UIColor(red: 155, green: 155, blue: 155)
        bvcv.addSubview(bl)
    }
    private func setupMainView() {
        guard let iv = itemView else { return }
        let ivW = iv.frame.width
        let ivH = iv.frame.height
        var topH: CGFloat = 0
        if let tv = topView {
            topH = tv.frame.height
        }
        var bottomH: CGFloat = 0
        if let bv = bottomView {
            bottomH = bv.frame.height
        }
        let h = ivH - topH - bottomH
        mainView = UIView(frame: CGRect(x: 0, y: topH, width: ivW, height: h))
        guard let mv = mainView else { return }
        iv.addSubview(mv)
    }
    private func setupMainViewContentView() {
        guard let mv = mainView else { return }
        let mvW = mv.frame.width
        let mvH = mv.frame.height
        let w = mvW - TaskListTableViewCell.mainViewContentViewPaddingLeft - TaskListTableViewCell.mainViewContentViewPaddingRight
        let h = mvH - TaskListTableViewCell.mainViewContentViewPaddingTop - TaskListTableViewCell.mainViewContentViewPaddingBottom
        mainViewContentView = UIView(frame: CGRect(x: TaskListTableViewCell.mainViewContentViewPaddingLeft, y: TaskListTableViewCell.mainViewContentViewPaddingTop, width: w, height: h))
        guard let mvcv = mainViewContentView else { return }
        mv.addSubview(mvcv)
    }
    private func setupMainViewContentViewTopView() {
        guard let mvcv = mainViewContentView else { return }
        let mvcvW = mvcv.frame.width
        mainViewContentViewTopView = UIView(frame: CGRect(x: 0, y: 0, width: mvcvW, height: TaskListTableViewCell.mainViewContentViewTopHeight))
        guard let mvcvtv = mainViewContentViewTopView else { return }
        mvcv.addSubview(mvcvtv)
    }
    private func setupMainViewContentViewTopView_3SubView() {
        guard let t = mainViewContentViewTopView else { return }
        let tW = t.frame.width
        let tH = t.frame.height
        let subViewW = tW / 3
        mainViewContentViewTopView_1Per3View = UIView(frame: CGRect(x: 0, y: 0, width: subViewW * 2, height: tH))
        mainViewContentViewTopView_2Per3View = UIView(frame: CGRect(x: subViewW, y: 0, width: 0, height: tH))
        mainViewContentViewTopView_3Per3View = UIView(frame: CGRect(x: subViewW * 2, y: 0, width: subViewW, height: tH))
        if let v1 = mainViewContentViewTopView_1Per3View {
            t.addSubview(v1)
        }
        if let v2 = mainViewContentViewTopView_2Per3View {
            t.addSubview(v2)
        }
        if let v3 = mainViewContentViewTopView_3Per3View {
            t.addSubview(v3)
        }
    }
    private func setupMainTopLabel1() {
        guard let v1 = mainViewContentViewTopView_1Per3View else { return }
        let w = v1.frame.width
        let h = v1.frame.height
        mainTopLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h))
        guard let l1 = mainTopLabel1 else { return }
        l1.font = UIFont.systemFont(ofSize: 16)
        l1.textColor = UIColor(red: 155, green: 155, blue: 155)
        v1.addSubview(l1)
    }
    private func setupMainTopLabel2() {
        guard let v2 = mainViewContentViewTopView_2Per3View else { return }
        let w = v2.frame.width
        let h = v2.frame.height
        mainTopLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h))
        guard let l2 = mainTopLabel2 else { return }
        l2.font = UIFont.systemFont(ofSize: 16)
        l2.textColor = UIColor(red: 155, green: 155, blue: 155)
        v2.addSubview(l2)
    }
    private func setupMainTopLabel3() {
        guard let v3 = mainViewContentViewTopView_3Per3View else { return }
        let w = v3.frame.width
        let h = v3.frame.height
        mainTopLabel3 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h))
        guard let l3 = mainTopLabel3 else { return }
        l3.font = UIFont.systemFont(ofSize: 16)
        l3.textColor = UIColor(red: 155, green: 155, blue: 155)
        l3.textAlignment = .right
        v3.addSubview(l3)
    }
    private func setupMainViewContentViewTextView() {
        guard let v = mainViewContentView else { return }
        let vW = v.frame.width
        let vH = v.frame.height
        var tH: CGFloat = 0
        if let t = mainViewContentViewTopView {
            tH = t.frame.height
        }
        let h = vH - tH
        mainViewContentViewTextView = UIView(frame: CGRect(x: 0, y: tH, width: vW, height: h))
        guard let mvv = mainViewContentViewTextView else { return }
        v.addSubview(mvv)
    }
    private func setupMainTextView() {
        guard let mvv = mainViewContentViewTextView else { return }
        let w = mvv.frame.width
        let h = mvv.frame.height
        mainTextView = UITextView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        guard let mvvtv = mainTextView else { return }
        mvvtv.isEditable = false
        mvvtv.isScrollEnabled = false
        mvvtv.isUserInteractionEnabled = false
        mvvtv.textContainer.lineFragmentPadding = 0
        mvvtv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        mvvtv.font = UIFont.systemFont(ofSize: 16)
        mvvtv.textColor = UIColor(red: 84, green: 84, blue: 84)
        mvv.addSubview(mvvtv)
    } 
}

extension TaskListTableViewCell {
    func set(vm: TaskListTableViewCellVM) {
        topLabel?.text = vm.topLabel
        bottomLabel?.text = vm.bottomLabel?.toJTFormateString
        mainTopLabel1?.text = vm.mainContentTopLabel1
        //mainTopLabel2?.text = vm.mainContentTopLabel2
        mainTopLabel3?.text = vm.mainContentTopLabel3
        mainTextView?.text = vm.mainContentText
    }
}
