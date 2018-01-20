//
//  JTPictureAndAVPicker.swift
//  JTiOS
//
//  Created by JT on 2018/1/19.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTPictureAndVideoPicker: UIView {
    
    private var selfH: NSLayoutConstraint!
    private var dataViews: [UIView]?
    private var data: [AnyObject] = [AnyObject]()
    private let spaceSize: CGFloat = 8
    private let columnCount: Int = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}
extension JTPictureAndVideoPicker {
    private func setupUI() {
        setupJTPictureAndVideoPicker()
        
        data = [AnyObject]()
        data.append("0" as AnyObject)
        data.append("1" as AnyObject)
        data.append("2" as AnyObject)
        
        reload()
    }
    private func setupJTPictureAndVideoPicker() {
        translatesAutoresizingMaskIntoConstraints = false
        selfH = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        addConstraint(selfH)
    }
}
extension JTPictureAndVideoPicker {
    private func reload() {
        removeAll()
        initDataViews()
        initSubViews()
    }
    private func init1ColumnSubView(index: Int, rowNum: Int, columnNum: Int, views: [UIView]) -> UIView {
        let view = views[index]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let top = getTopViewLayoutConstraint(view: view, views: views, index: index, rowNum: rowNum)
        let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: spaceSize)
        let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -spaceSize)
        let aspect = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        
        self.addConstraints([top, left, right])
        view.addConstraint(aspect)
        
        return view
    }
    private func init2ColumnSubView(index: Int, rowNum: Int, columnNum: Int, views: [UIView]) -> UIView  {
        let view = views[index]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        if columnNum == 0 {
            let top = getTopViewLayoutConstraint(view: view, views: views, index: index, rowNum: rowNum)
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: spaceSize)
            let aspect = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
            
            self.addConstraints([top, left])
            view.addConstraint(aspect)
        } else {
            let leftView = views[index + 1]
            let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: leftView, attribute: .width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: leftView, attribute: .height, multiplier: 1, constant: 0)
            let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: leftView, attribute: .centerY, multiplier: 1, constant: 0)
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: spaceSize)
            let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -spaceSize)
            
            self.addConstraints([width, height, centerY, left, right])
        }
        return view
    }
    private func initGreaterThan2ColumnSubView(index: Int, rowNum: Int, columnNum: Int, views: [UIView]) -> UIView  {
        let view = views[index]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        if columnNum == 0 {
            let top = getTopViewLayoutConstraint(view: view, views: views, index: index, rowNum: rowNum)
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: spaceSize)
            let aspect = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
            
            self.addConstraints([top, left])
            view.addConstraint(aspect)
        } else if columnNum == columnCount - 1 {
            let firstView = views[index + columnNum]
            let leftView = views[index + 1]
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: spaceSize)
            let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -spaceSize)
            let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: firstView, attribute: .width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: firstView, attribute: .height, multiplier: 1, constant: 0)
            let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: firstView, attribute: .centerY, multiplier: 1, constant: 0)
            
            self.addConstraints([left, right, width, height, centerY])
        } else {
            let firstView = views[index + columnNum]
            let leftView = views[index + 1]
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: spaceSize)
            let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: firstView, attribute: .width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: firstView, attribute: .height, multiplier: 1, constant: 0)
            let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: firstView, attribute: .centerY, multiplier: 1, constant: 0)
            
            self.addConstraints([left, width, height, centerY])
        }
        return view
    }
    private func getTopViewLayoutConstraint(view: UIView, views: [UIView], index: Int, rowNum: Int) -> NSLayoutConstraint {
        if rowNum == 0 {
            return NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: spaceSize)
        }
        let topView = views[index + columnCount]
        return NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: spaceSize)
    }
    private func initSubViews() {
        guard let views = dataViews else { return }
        let count = views.count
        guard count > 0 else { return }
        guard columnCount > 0 else { return }
        let rowCount = count / columnCount
        let dataCount = getDataCount()
        
        for r in 0...rowCount - 1 {
            for c in 0...columnCount - 1 {
                let index = count - 1 - r * columnCount - c
                let view: UIView
                if columnCount == 1 {
                    view = init1ColumnSubView(index: index, rowNum: r, columnNum: c, views: views)
                } else if columnCount == 2 {
                    view = init2ColumnSubView(index: index, rowNum: r, columnNum: c, views: views)
                } else {
                    view = initGreaterThan2ColumnSubView(index: index, rowNum: r, columnNum: c, views: views)
                }
                if index == 0 {
                    let yy = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: spaceSize)
                    self.addConstraint(yy)
                }
                view.backgroundColor = .green
                
                let usageIndex = dataCount - count + index
                guard usageIndex >= 0 else {
                    view.isHidden = true
                    continue
                }
                
                let d = data[usageIndex]
                let l = UILabel()
                l.text = d as? String
                l.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(l)
                    
                let left = NSLayoutConstraint(item: l, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
                let right = NSLayoutConstraint(item: l, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
                let top = NSLayoutConstraint(item: l, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
                let bottom = NSLayoutConstraint(item: l, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
                view.addConstraints([left, right, top, bottom])
            }
        }
    }
    private func initDataViews() {
        let rowCount = getRowCount()
        let sum = rowCount * columnCount
        dataViews = [UIView]()
        for _ in 0 ..< sum {
            dataViews?.append(UIView())
        }
    }
    private func getRowCount() -> Int {
        let count = getDataCount()
        let rowCount = Int(ceil(CGFloat(count) / CGFloat(columnCount)))
        return rowCount
    }
    private func getDataCount() -> Int {
        return data.count
    }
    private func removeAll() {
        while (subviews.count > 0) {
            subviews.last?.removeFromSuperview()
        }
    }
}
