//
//  TaskDetailListTableViewCell.swift
//  JTiOS
//
//  Created by JT on 2018/1/8.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import Alamofire
class TaskDetailListTableViewCell: UITableViewCell {
    
    private var full: UIView?
    private static let fullMinHeight: CGFloat = 10
    
    private var fullContent: UIView?
    private static let fullContentTop: CGFloat = 5
    private static let fullContentLeft: CGFloat = 0
    private static let fullContentBottom: CGFloat = -10
    private static let fullContentRight: CGFloat = 0
    
    private var top: UIView?
    private static let topMinHeight: CGFloat = 10
    
    private var topContent: UIView?
    private static let topContentTop: CGFloat = 2
    private static let topContentLeft: CGFloat = 8
    private static let topContentBottom: CGFloat = -2
    private static let topContentRight: CGFloat = -8
    
    private var topLabel: UILabel?
    
    private var main: UIView?
    private static let mainMinHeight: CGFloat = 10
    
    private var mainContent: UIView?
    private static let mainContentTop: CGFloat = 2
    private static let mainContentLeft: CGFloat = 8
    private static let mainContentBottom: CGFloat = -2
    private static let mainContentRight: CGFloat = -8
    
    private var content1: UIView?
    private static let content1MinHeight: CGFloat = 2
    private var content2: UIView?
    private static let content2MinHeight: CGFloat = 2
    private var content3: UIView?
    private static let content3MinHeight: CGFloat = 2
    private var content4: UIView?
    private static let content4MinHeight: CGFloat = 2
    private var content5: UIView?
    private static let content5MinHeight: CGFloat = 2
    private var content6: UIView?
    private static let content6MinHeight: CGFloat = 20
    
    private var content1Label1: UILabel?
    private static let content1Label1Width: CGFloat = 70
    private static let content1Label1Height: CGFloat = 21
    private var content1Label2: UILabel?
    private static let content1Label2ToLabel1Constant: CGFloat = 8
    private static let content1Label2MinHeight: CGFloat = 21
    
    private var content2Label1: UILabel?
    private static let content2Label1Width: CGFloat = 70
    private static let content2Label1Height: CGFloat = 21
    private var content2Label2: UILabel?
    private static let content2Label2ToLabel1Constant: CGFloat = 8
    private static let content2Label2MinHeight: CGFloat = 21
    
    private var content3Label1: UILabel?
    private static let content3Label1Width: CGFloat = 70
    private static let content3Label1Height: CGFloat = 21
    private var content3Label2: UILabel?
    private static let content3Label2ToLabel1Constant: CGFloat = 8
    private static let content3Label2MinHeight: CGFloat = 21
    
    private var content4Label1: UILabel?
    private static let content4Label1Width: CGFloat = 70
    private static let content4Label1Height: CGFloat = 21
    private var content4Label2: UILabel?
    private static let content4Label2ToLabel1Constant: CGFloat = 8
    private static let content4Label2MinHeight: CGFloat = 21
    
    private var content5Label1: UILabel?
    private static let content5Label1Width: CGFloat = 70
    private static let content5Label1Height: CGFloat = 21
    private var content5Label2: UILabel?
    private static let content5Label2ToLabel1Constant: CGFloat = 8
    private static let content5Label2MinHeight: CGFloat = 21
    
    private var content6JTMediaPreview: JTMediaPreview?
//    private var content6Label1: UILabel?
//    private static let content6Label1Width: CGFloat = 70
//    private static let content6Label1Height: CGFloat = 21
//    private var content6Label2: UILabel?
//    private static let content6Label2ToLabel1Constant: CGFloat = 8
//    private static let content6Label2MinHeight: CGFloat = 21
    
    private var bottom: UIView?
    private static let bottomMinHeight: CGFloat = 10
    
    private var bottomContent: UIView?
    private static let bottomContentTop: CGFloat = 2
    private static let bottomContentLeft: CGFloat = 8
    private static let bottomContentBottom: CGFloat = -2
    private static let bottomContentRight: CGFloat = -8
    
    private var bottomLabel1: UILabel?
    private var bottomLabel2: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("--------TaskDetailListTableViewCell-----------")
    }
}
extension TaskDetailListTableViewCell {
    private func setupUI() {
        setupFullView()
        setupTopView()
        setupMainView()
        setupBottomView()
    }
    private func setupFullView() {
        setupFull()
        setupFullContent()
    }
    private func setupTopView() {
        setupTop()
        setupTopContent()
        setupTopLabel()
    }
    private func setupMainView() {
        setupMain()
        setupMainContent()
        setupContent1()
        setupContent2()
        setupContent3()
        setupContent4()
        setupContent5()
        setupContent6()
        
        setupContent1Label1Label2()
        setupContent2Label1Label2()
        setupContent3Label1Label2()
        setupContent4Label1Label2()
        setupContent5Label1Label2()
        setupContent6JTMediaPreview()
    }
    private func setupBottomView() {
        setupBottom()
        setupBottomContent()
        setupBottomLabel1()
        setupBottomLabel2()
    }
    private func setupFull() {
        full = UIView()
        guard let v = full else { return }
        v.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        v.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(v)
        let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0)
        let topContraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let bottomContraint = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        contentView.addConstraints([left, right, topContraint, bottomContraint])
        let minHeight = NSLayoutConstraint(item: v, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.fullMinHeight)
        v.addConstraint(minHeight)
    }
    private func setupFullContent() {
        guard let f = full else { return }
        fullContent = UIView()
        guard let v = fullContent else { return }
        v.backgroundColor = UIColor(red: 255, green: 255, blue: 255)
        v.translatesAutoresizingMaskIntoConstraints = false
        f.addSubview(v)
        let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: f, attribute: .left, multiplier: 1, constant: TaskDetailListTableViewCell.fullContentLeft)
        let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: f, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.fullContentRight)
        let topConstraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: f, attribute: .top, multiplier: 1, constant: TaskDetailListTableViewCell.fullContentTop)
        let bottomConstraint = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: f, attribute: .bottom, multiplier: 1, constant: TaskDetailListTableViewCell.fullContentBottom)
        f.addConstraints([left, right, topConstraint, bottomConstraint])
    }
    private func setupTop() {
        guard let fc = fullContent else { return }
        top = UIView()
        guard let t = top else { return }
        //t.backgroundColor = UIColor.green
        t.translatesAutoresizingMaskIntoConstraints = false
        fc.addSubview(t)
        let left = NSLayoutConstraint(item: t, attribute: .left, relatedBy: .equal, toItem: fc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: t, attribute: .right, relatedBy: .equal, toItem: fc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: t, attribute: .top, relatedBy: .equal, toItem: fc, attribute: .top, multiplier: 1, constant: 0)
        fc.addConstraints([left, right, topConstraint])
        let minHeight = NSLayoutConstraint(item: t, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.topMinHeight)
        t.addConstraint(minHeight)
    }
    private func setupTopContent() {
        guard let t = top else { return }
        topContent = UIView()
        guard let v = topContent else { return }
        //v.backgroundColor = UIColor(red: 176, green: 231, blue: 198)
        v.translatesAutoresizingMaskIntoConstraints = false
        t.addSubview(v)
        let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: t, attribute: .left, multiplier: 1, constant: TaskDetailListTableViewCell.topContentLeft)
        let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: t, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.topContentRight)
        let topConstraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: t, attribute: .top, multiplier: 1, constant: TaskDetailListTableViewCell.topContentTop)
        let bottomConstraint = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: t, attribute: .bottom, multiplier: 1, constant: TaskDetailListTableViewCell.topContentBottom)
        t.addConstraints([left, right, topConstraint, bottomConstraint])
    }
    private func setupTopLabel() {
        guard let tc = topContent else { return }
        topLabel = UILabel()
        topLabel?.numberOfLines = 1
        topLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        topLabel?.text = " "
        guard let t = topLabel else { return }
        t.translatesAutoresizingMaskIntoConstraints = false
        tc.addSubview(t)
        let left = NSLayoutConstraint(item: t, attribute: .left, relatedBy: .equal, toItem: tc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: t, attribute: .right, relatedBy: .equal, toItem: tc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: t, attribute: .top, relatedBy: .equal, toItem: tc, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: t, attribute: .bottom, relatedBy: .equal, toItem: tc, attribute: .bottom, multiplier: 1, constant: 0)
        tc.addConstraints([left, right, topConstraint, bottomConstraint])
    }
    
    private func setupMain() {
        guard let fc = fullContent else { return }
        main = UIView()
        guard let v = main else { return }
        //v.backgroundColor = UIColor.blue
        guard let t = top else { return }
        v.translatesAutoresizingMaskIntoConstraints = false
        fc.addSubview(v)
        let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: fc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: fc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: t, attribute: .bottom, multiplier: 1, constant: 0)
        fc.addConstraints([left, right, topConstraint])
        let minHeight = NSLayoutConstraint(item: v, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.mainMinHeight)
        v.addConstraint(minHeight)
    }
    private func setupMainContent() {
        guard let m = main else { return }
        mainContent = UIView()
        guard let v = mainContent else { return }
        //v.backgroundColor = UIColor(red: 57, green: 186, blue: 232)
        v.translatesAutoresizingMaskIntoConstraints = false
        m.addSubview(v)
        let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: m, attribute: .left, multiplier: 1, constant: TaskDetailListTableViewCell.mainContentLeft)
        let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: m, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.mainContentRight)
        let topConstraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: m, attribute: .top, multiplier: 1, constant: TaskDetailListTableViewCell.mainContentTop)
        let bottomConstraint = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: m, attribute: .bottom, multiplier: 1, constant: TaskDetailListTableViewCell.mainContentBottom)
        m.addConstraints([left, right, topConstraint, bottomConstraint])
    }
    private func setupContent1() {
        guard let mc = mainContent else { return }
        content1 = UIView()
        guard let c = content1 else { return }
        c.translatesAutoresizingMaskIntoConstraints = false
        mc.addSubview(c)
        let left = NSLayoutConstraint(item: c, attribute: .left, relatedBy: .equal, toItem: mc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: c, attribute: .right, relatedBy: .equal, toItem: mc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: c, attribute: .top, relatedBy: .equal, toItem: mc, attribute: .top, multiplier: 1, constant: 0)
        mc.addConstraints([left, right, topConstraint])
        let minHeight = NSLayoutConstraint(item: c, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content1MinHeight)
        c.addConstraint(minHeight)
    }
    private func setupContent2() {
        guard let mc = mainContent else { return }
        content2 = UIView()
        guard let c = content2 else { return }
        guard let c1 = content1 else { return }
        c.translatesAutoresizingMaskIntoConstraints = false
        mc.addSubview(c)
        let left = NSLayoutConstraint(item: c, attribute: .left, relatedBy: .equal, toItem: mc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: c, attribute: .right, relatedBy: .equal, toItem: mc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: c, attribute: .top, relatedBy: .equal, toItem: c1, attribute: .bottom, multiplier: 1, constant: 0)
        mc.addConstraints([left, right, topConstraint])
        let minHeight = NSLayoutConstraint(item: c, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content2MinHeight)
        c.addConstraint(minHeight)
    }
    private func setupContent3() {
        guard let mc = mainContent else { return }
        content3 = UIView()
        guard let c = content3 else { return }
        guard let c2 = content2 else { return }
        c.translatesAutoresizingMaskIntoConstraints = false
        mc.addSubview(c)
        let left = NSLayoutConstraint(item: c, attribute: .left, relatedBy: .equal, toItem: mc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: c, attribute: .right, relatedBy: .equal, toItem: mc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: c, attribute: .top, relatedBy: .equal, toItem: c2, attribute: .bottom, multiplier: 1, constant: 0)
        mc.addConstraints([left, right, topConstraint])
        let minHeight = NSLayoutConstraint(item: c, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content3MinHeight)
        c.addConstraint(minHeight)
    }
    private func setupContent4() {
        guard let mc = mainContent else { return }
        content4 = UIView()
        guard let c = content4 else { return }
        guard let c3 = content3 else { return }
        c.translatesAutoresizingMaskIntoConstraints = false
        mc.addSubview(c)
        let left = NSLayoutConstraint(item: c, attribute: .left, relatedBy: .equal, toItem: mc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: c, attribute: .right, relatedBy: .equal, toItem: mc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: c, attribute: .top, relatedBy: .equal, toItem: c3, attribute: .bottom, multiplier: 1, constant: 0)
        mc.addConstraints([left, right, topConstraint])
        let minHeight = NSLayoutConstraint(item: c, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content4MinHeight)
        c.addConstraint(minHeight)
    }
    private func setupContent5() {
        guard let mc = mainContent else { return }
        content5 = UIView()
        guard let c = content5 else { return }
        guard let c4 = content4 else { return }
        c.translatesAutoresizingMaskIntoConstraints = false
        mc.addSubview(c)
        let left = NSLayoutConstraint(item: c, attribute: .left, relatedBy: .equal, toItem: mc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: c, attribute: .right, relatedBy: .equal, toItem: mc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: c, attribute: .top, relatedBy: .equal, toItem: c4, attribute: .bottom, multiplier: 1, constant: 0)
        mc.addConstraints([left, right, topConstraint])
        let minHeight = NSLayoutConstraint(item: c, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content5MinHeight)
        c.addConstraint(minHeight)
    }
    private func setupContent6() {
        guard let mc = mainContent else { return }
        content6 = UIView()
        content6?.backgroundColor = UIColor(red: 136, green: 255, blue: 255)
        guard let c = content6 else { return }
        guard let c5 = content5 else { return }
        c.translatesAutoresizingMaskIntoConstraints = false
        mc.addSubview(c)
        let left = NSLayoutConstraint(item: c, attribute: .left, relatedBy: .equal, toItem: mc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: c, attribute: .right, relatedBy: .equal, toItem: mc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: c, attribute: .top, relatedBy: .equal, toItem: c5, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: c, attribute: .bottom, relatedBy: .equal, toItem: mc, attribute: .bottom, multiplier: 1, constant: 0)
        mc.addConstraints([left, right, topConstraint, bottomConstraint])
        let minHeight = NSLayoutConstraint(item: c, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content6MinHeight)
        c.addConstraint(minHeight)
    }
   
    private func setupContent1Label1Label2() {
        guard let c1 = content1 else { return }
        content1Label1 = UILabel()
        content1Label1?.text = "负责人员"
        content1Label1?.font = UIFont.boldSystemFont(ofSize: 17)
        content1Label2 = UILabel()
        content1Label2?.numberOfLines = 0
        guard let l1 = content1Label1 else { return }
        guard let l2 = content1Label2 else { return }
        
        l1.translatesAutoresizingMaskIntoConstraints = false
        l2.translatesAutoresizingMaskIntoConstraints = false
        c1.addSubview(l1)
        c1.addSubview(l2)
        
        let left = NSLayoutConstraint(item: l1, attribute: .left, relatedBy: .equal, toItem: c1, attribute: .left, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: l1, attribute: .top, relatedBy: .equal, toItem: c1, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: l1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content1Label1Width)
        let height = NSLayoutConstraint(item: l1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content1Label1Height)
        c1.addConstraints([left, topConstraint])
        l1.addConstraints([width, height])
        
        let left2 = NSLayoutConstraint(item: l2, attribute: .left, relatedBy: .equal, toItem: l1, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.content1Label2ToLabel1Constant)
        let right2 = NSLayoutConstraint(item: l2, attribute: .right, relatedBy: .equal, toItem: c1, attribute: .right, multiplier: 1, constant: 0)
        let top2 = NSLayoutConstraint(item: l2, attribute: .top, relatedBy: .equal, toItem: l1, attribute: .top, multiplier: 1, constant: 0)
        let bottom2 = NSLayoutConstraint(item: l2, attribute: .bottom, relatedBy: .equal, toItem: c1, attribute: .bottom, multiplier: 1, constant: 0)
        c1.addConstraints([left2, right2, top2, bottom2])
        let height2 = NSLayoutConstraint(item: l2, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content1Label2MinHeight)
        l2.addConstraint(height2)
    }
    private func setupContent2Label1Label2() {
        guard let c2 = content2 else { return }
        content2Label1 = UILabel()
        content2Label1?.text = "现场人员"
        content2Label1?.font = UIFont.boldSystemFont(ofSize: 17)
        content2Label2 = UILabel()
        content2Label2?.numberOfLines = 0
        guard let l1 = content2Label1 else { return }
        guard let l2 = content2Label2 else { return }
        
        l1.translatesAutoresizingMaskIntoConstraints = false
        l2.translatesAutoresizingMaskIntoConstraints = false
        c2.addSubview(l1)
        c2.addSubview(l2)
        
        let left = NSLayoutConstraint(item: l1, attribute: .left, relatedBy: .equal, toItem: c2, attribute: .left, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: l1, attribute: .top, relatedBy: .equal, toItem: c2, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: l1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content2Label1Width)
        let height = NSLayoutConstraint(item: l1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content2Label1Height)
        c2.addConstraints([left, topConstraint])
        l1.addConstraints([width, height])
        
        let left2 = NSLayoutConstraint(item: l2, attribute: .left, relatedBy: .equal, toItem: l1, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.content2Label2ToLabel1Constant)
        let right2 = NSLayoutConstraint(item: l2, attribute: .right, relatedBy: .equal, toItem: c2, attribute: .right, multiplier: 1, constant: 0)
        let top2 = NSLayoutConstraint(item: l2, attribute: .top, relatedBy: .equal, toItem: l1, attribute: .top, multiplier: 1, constant: 0)
        let bottom2 = NSLayoutConstraint(item: l2, attribute: .bottom, relatedBy: .equal, toItem: c2, attribute: .bottom, multiplier: 1, constant: 0)
        c2.addConstraints([left2, right2, top2, bottom2])
        let height2 = NSLayoutConstraint(item: l2, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content2Label2MinHeight)
        l2.addConstraint(height2)
    }
    private func setupContent3Label1Label2() {
        guard let c3 = content3 else { return }
        content3Label1 = UILabel()
        content3Label1?.text = "地点"
        content3Label1?.font = UIFont.boldSystemFont(ofSize: 17)
        content3Label2 = UILabel()
        content3Label2?.numberOfLines = 0
        guard let l1 = content3Label1 else { return }
        guard let l2 = content3Label2 else { return }
        
        l1.translatesAutoresizingMaskIntoConstraints = false
        l2.translatesAutoresizingMaskIntoConstraints = false
        c3.addSubview(l1)
        c3.addSubview(l2)
        
        let left = NSLayoutConstraint(item: l1, attribute: .left, relatedBy: .equal, toItem: c3, attribute: .left, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: l1, attribute: .top, relatedBy: .equal, toItem: c3, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: l1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content3Label1Width)
        let height = NSLayoutConstraint(item: l1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content3Label1Height)
        c3.addConstraints([left, topConstraint])
        l1.addConstraints([width, height])
        
        let left2 = NSLayoutConstraint(item: l2, attribute: .left, relatedBy: .equal, toItem: l1, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.content3Label2ToLabel1Constant)
        let right2 = NSLayoutConstraint(item: l2, attribute: .right, relatedBy: .equal, toItem: c3, attribute: .right, multiplier: 1, constant: 0)
        let top2 = NSLayoutConstraint(item: l2, attribute: .top, relatedBy: .equal, toItem: l1, attribute: .top, multiplier: 1, constant: 0)
        let bottom2 = NSLayoutConstraint(item: l2, attribute: .bottom, relatedBy: .equal, toItem: c3, attribute: .bottom, multiplier: 1, constant: 0)
        c3.addConstraints([left2, right2, top2, bottom2])
        let height2 = NSLayoutConstraint(item: l2, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content3Label2MinHeight)
        l2.addConstraint(height2)
    }
    private func setupContent4Label1Label2() {
        guard let c4 = content4 else { return }
        content4Label1 = UILabel()
        content4Label1?.text = "内容"
        content4Label1?.font = UIFont.boldSystemFont(ofSize: 17)
        content4Label2 = UILabel()
        content4Label2?.numberOfLines = 0
        guard let l1 = content4Label1 else { return }
        guard let l2 = content4Label2 else { return }
        
        l1.translatesAutoresizingMaskIntoConstraints = false
        l2.translatesAutoresizingMaskIntoConstraints = false
        c4.addSubview(l1)
        c4.addSubview(l2)
        
        let left = NSLayoutConstraint(item: l1, attribute: .left, relatedBy: .equal, toItem: c4, attribute: .left, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: l1, attribute: .top, relatedBy: .equal, toItem: c4, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: l1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content4Label1Width)
        let height = NSLayoutConstraint(item: l1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content4Label1Height)
        c4.addConstraints([left, topConstraint])
        l1.addConstraints([width, height])
        
        let left2 = NSLayoutConstraint(item: l2, attribute: .left, relatedBy: .equal, toItem: l1, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.content4Label2ToLabel1Constant)
        let right2 = NSLayoutConstraint(item: l2, attribute: .right, relatedBy: .equal, toItem: c4, attribute: .right, multiplier: 1, constant: 0)
        let top2 = NSLayoutConstraint(item: l2, attribute: .top, relatedBy: .equal, toItem: l1, attribute: .top, multiplier: 1, constant: 0)
        let bottom2 = NSLayoutConstraint(item: l2, attribute: .bottom, relatedBy: .equal, toItem: c4, attribute: .bottom, multiplier: 1, constant: 0)
        c4.addConstraints([left2, right2, top2, bottom2])
        let height2 = NSLayoutConstraint(item: l2, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content4Label2MinHeight)
        l2.addConstraint(height2)
    }
    private func setupContent5Label1Label2() {
        guard let c5 = content5 else { return }
        content5Label1 = UILabel()
        content5Label1?.text = "备注"
        content5Label1?.font = UIFont.boldSystemFont(ofSize: 17)
        content5Label2 = UILabel()
        content5Label2?.numberOfLines = 0
        guard let l1 = content5Label1 else { return }
        guard let l2 = content5Label2 else { return }
        
        l1.translatesAutoresizingMaskIntoConstraints = false
        l2.translatesAutoresizingMaskIntoConstraints = false
        c5.addSubview(l1)
        c5.addSubview(l2)
        
        let left = NSLayoutConstraint(item: l1, attribute: .left, relatedBy: .equal, toItem: c5, attribute: .left, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: l1, attribute: .top, relatedBy: .equal, toItem: c5, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: l1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content5Label1Width)
        let height = NSLayoutConstraint(item: l1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content5Label1Height)
        c5.addConstraints([left, topConstraint])
        l1.addConstraints([width, height])
        
        let left2 = NSLayoutConstraint(item: l2, attribute: .left, relatedBy: .equal, toItem: l1, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.content5Label2ToLabel1Constant)
        let right2 = NSLayoutConstraint(item: l2, attribute: .right, relatedBy: .equal, toItem: c5, attribute: .right, multiplier: 1, constant: 0)
        let top2 = NSLayoutConstraint(item: l2, attribute: .top, relatedBy: .equal, toItem: l1, attribute: .top, multiplier: 1, constant: 0)
        let bottom2 = NSLayoutConstraint(item: l2, attribute: .bottom, relatedBy: .equal, toItem: c5, attribute: .bottom, multiplier: 1, constant: 0)
        c5.addConstraints([left2, right2, top2, bottom2])
        let height2 = NSLayoutConstraint(item: l2, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.content5Label2MinHeight)
        l2.addConstraint(height2)
    }
    
    private func setupContent6JTMediaPreview() {
        guard let c6 = content6 else { return }
        content6JTMediaPreview = JTMediaPreview()
        content6JTMediaPreview?.backgroundColor = .red
        guard let jt = content6JTMediaPreview else { return }
        jt.translatesAutoresizingMaskIntoConstraints = false
        c6.addSubview(jt)
        
        let left = NSLayoutConstraint(item: jt, attribute: .left, relatedBy: .equal, toItem: c6, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: jt, attribute: .right, relatedBy: .equal, toItem: c6, attribute: .right, multiplier: 1, constant: 0)
        let topContraint = NSLayoutConstraint(item: jt, attribute: .top, relatedBy: .equal, toItem: c6, attribute: .top, multiplier: 1, constant: 0)
        
        let h = NSLayoutConstraint(item: c6, attribute: .height, relatedBy: .equal, toItem: jt, attribute: .height, multiplier: 1, constant: 0)
        c6.addConstraints([left, right, topContraint, h])
    }
    
    private func setupBottom() {
        guard let fc = fullContent else { return }
        bottom = UIView()
        guard let v = bottom else { return }
        guard let m = main else { return }
        v.translatesAutoresizingMaskIntoConstraints = false
        fc.addSubview(v)
        let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: fc, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: fc, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: m, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: fc, attribute: .bottom, multiplier: 1, constant: 0)
        fc.addConstraints([left, right, topConstraint, bottomConstraint])
        let minHeight = NSLayoutConstraint(item: v, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: TaskDetailListTableViewCell.bottomMinHeight)
        v.addConstraint(minHeight)
    }
    private func setupBottomContent() {
        guard let b = bottom else { return }
        bottomContent = UIView()
        guard let v = bottomContent else { return }
        v.translatesAutoresizingMaskIntoConstraints = false
        b.addSubview(v)
        let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: b, attribute: .left, multiplier: 1, constant: TaskDetailListTableViewCell.bottomContentLeft)
        let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: b, attribute: .right, multiplier: 1, constant: TaskDetailListTableViewCell.bottomContentRight)
        let topConstraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: b, attribute: .top, multiplier: 1, constant: TaskDetailListTableViewCell.bottomContentTop)
        let bottomConstraint = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: b, attribute: .bottom, multiplier: 1, constant: TaskDetailListTableViewCell.bottomContentBottom)
        b.addConstraints([left, right, topConstraint, bottomConstraint])
    }
    private func setupBottomLabel1() {
        guard let bc = bottomContent else { return }
        bottomLabel1 = UILabel()
        bottomLabel1?.font = UIFont.systemFont(ofSize: 16)
        bottomLabel1?.textColor = UIColor(red: 155, green: 155, blue: 155)
        bottomLabel1?.text = " "
        guard let b = bottomLabel1 else { return }
        b.translatesAutoresizingMaskIntoConstraints = false
        bc.addSubview(b)
        let left = NSLayoutConstraint(item: b, attribute: .left, relatedBy: .equal, toItem: bc, attribute: .left, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: b, attribute: .width, relatedBy: .equal, toItem: bc, attribute: .width, multiplier: 0.5, constant: 0)
        let topConstraint = NSLayoutConstraint(item: b, attribute: .top, relatedBy: .equal, toItem: bc, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: b, attribute: .bottom, relatedBy: .equal, toItem: bc, attribute: .bottom, multiplier: 1, constant: 0)
        bc.addConstraints([left, width, topConstraint, bottomConstraint])
    }
    private func setupBottomLabel2() {
        guard let bc = bottomContent else { return }
        bottomLabel2 = UILabel()
        bottomLabel2?.font = UIFont.systemFont(ofSize: 16)
        bottomLabel2?.textColor = UIColor(red: 155, green: 155, blue: 155)
        bottomLabel2?.text = " "
        bottomLabel2?.textAlignment = .right
        guard let b = bottomLabel2 else { return }
        b.translatesAutoresizingMaskIntoConstraints = false
        bc.addSubview(b)
        let right = NSLayoutConstraint(item: b, attribute: .right, relatedBy: .equal, toItem: bc, attribute: .right, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: b, attribute: .width, relatedBy: .equal, toItem: bc, attribute: .width, multiplier: 0.5, constant: 0)
        let topConstraint = NSLayoutConstraint(item: b, attribute: .top, relatedBy: .equal, toItem: bc, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: b, attribute: .bottom, relatedBy: .equal, toItem: bc, attribute: .bottom, multiplier: 1, constant: 0)
        bc.addConstraints([right, width, topConstraint, bottomConstraint])
    }
    
}
extension TaskDetailListTableViewCell {
    func set(vm: TaskDetailListTableViewCellVM) {
        topLabel?.text = vm.topLabel
        bottomLabel1?.text = vm.bottomLabel1
        bottomLabel2?.text = vm.bottomLabel2?.toJTFormateString
        if let l = vm.leaderuids { content1Label2?.text = getUIDsNames(UIDs: l) }
        if let l = vm.personuids { content2Label2?.text = getUIDsNames(UIDs: l) }
        content3Label2?.text = vm.address
        content4Label2?.text = vm.content
        content5Label2?.text = vm.remark
        guard let files = vm.files else { return }
        let count = files.count
        guard count > 0 else { return }
        guard let uid = global_SystemUser?.id else {
            //do something
            return
        }
        
        let jtMediaPreviewDatas = [JTMediaPreviewData].init(repeating: JTMediaPreviewData(), count: count)
        content6JTMediaPreview?.addData(dataRange: jtMediaPreviewDatas)
        for index in 0 ..< count {
            let file = files[index]
            guard let contentType = file.contenttype, let filename = file.path else { continue }
            if contentType.containsCaseInsensitive(other: "image") {
                setImagePreview(index: index, uid: uid, filename: filename)
            } else if contentType.containsCaseInsensitive(other: "video") {
                
            } else {
                
            }
        }
    }
    
    private func setImagePreview(index: Int, uid: Int, filename: String) {
        let fileTypenum = FileTypenum.Task
        let imagePrefix = ImagePrefix.Minimum
        let url = SystemFile.shareInstance.getFileURL(typenum: fileTypenum, frid: Int64(uid), filename: imagePrefix.rawValue + filename)
        if FileManage.shareInstance.fileExist(atPath: url.path) {
            addFileImageToJTMediaPreview(url: url, index: index)
        } else {
            let req = RequestObject_FileDownload(typenum: fileTypenum, frid: uid, filename: filename, prefix: imagePrefix, destination: { temporaryUrl, response in
                return (url, DownloadRequest.DownloadOptions.removePreviousFile)
            })
            WebFile.shareInstance.saveFile(requestObject: req) {
                [weak self] success, msg in
                if success {
                    self?.addFileImageToJTMediaPreview(url: url, index: index)
                } else {
                    
                }
            }
        }
    }
    private func addFileImageToJTMediaPreview(url: URL, index: Int) {
        let image = UIImage(contentsOfFile: url.path)
        guard let img = image else {
            //do something
            return
        }
        content6JTMediaPreview?.setDataImage(at: index, image: img)
    }
    
    private func getUIDsNames(UIDs: [Object_Uid]) -> String {
        var s = ""
        for uid in UIDs {
            if let r = uid.realname {
                if s.count > 0{
                    s += "," + r
                } else {
                    s += r
                }
            }
        }
        return s
    }
    
}

