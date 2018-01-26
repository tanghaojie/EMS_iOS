//
//  JTAutoAverageSubview.swift
//  JTiOS
//
//  Created by JT on 2018/1/20.
//  Copyright © 2018年 JT. All rights reserved.
//

class JTAutoAverageRowSubviews {
    static let shareInstance = JTAutoAverageRowSubviews()
    private init() {}
    
    private func getTopViewLayoutConstraint(view: UIView, parentView: UIView, topSpace: CGFloat, topView: UIView? = nil, upDownBetweenSpace: CGFloat) -> NSLayoutConstraint {
        
        if let tv = topView {
            return NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: tv, attribute: .bottom, multiplier: 1, constant: upDownBetweenSpace)
        } else {
            return NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1, constant: topSpace)
        }
    }
    
    public func autoAverage1ColumnSubView(view: UIView, parentView: UIView, topSpace: CGFloat, leftSpace: CGFloat, rightSpace: CGFloat, topView: UIView? = nil, upDownBetweenSpace: CGFloat) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(view)
        
        let top = getTopViewLayoutConstraint(view: view, parentView: parentView, topSpace: topSpace, topView: topView, upDownBetweenSpace: upDownBetweenSpace)
        
        let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1, constant: leftSpace)
        let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1, constant: -rightSpace)
        
        let aspect = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        
        parentView.addConstraints([top, left, right])
        view.addConstraint(aspect)
    }
    
    public func autoAverage2ColumnSubViews(view: UIView, parentView: UIView, topSpace: CGFloat, leftSpace: CGFloat, rightSpace: CGFloat, topView: UIView? = nil, leftView: UIView? = nil, upDownBetweenSpace: CGFloat, leftRightBetweenSpace: CGFloat) {

        view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(view)
        
        if let lv = leftView {
            let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: lv, attribute: .width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: lv, attribute: .height, multiplier: 1, constant: 0)
            let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: lv, attribute: .centerY, multiplier: 1, constant: 0)
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: lv, attribute: .right, multiplier: 1, constant: leftRightBetweenSpace)
            let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1, constant: -rightSpace)
            
            parentView.addConstraints([width, height, centerY, left, right])
        } else {
            
            let top = getTopViewLayoutConstraint(view: view, parentView: parentView, topSpace: topSpace, topView: topView, upDownBetweenSpace: upDownBetweenSpace)
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1, constant: leftSpace)
            let aspect = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
            parentView.addConstraints([top, left])
            view.addConstraint(aspect)
        }
    }
    
    public func autoAverage3ColumnSubViews(view: UIView, parentView: UIView, topSpace: CGFloat, leftSpace: CGFloat, rightSpace: CGFloat, rowFirstView: UIView, topView: UIView? = nil, leftView: UIView? = nil, upDownBetweenSpace: CGFloat, leftRightBetweenSpace: CGFloat, isRowLastView: Bool) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(view)
        
        if let lv = leftView {
            if isRowLastView {
                
                let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: lv, attribute: .right, multiplier: 1, constant: leftRightBetweenSpace)
                
                let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1, constant: -rightSpace)
                
                let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: rowFirstView, attribute: .width, multiplier: 1, constant: 0)
                
                let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: rowFirstView, attribute: .height, multiplier: 1, constant: 0)
                
                let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: rowFirstView, attribute: .centerY, multiplier: 1, constant: 0)
                
                parentView.addConstraints([left, right, width, height, centerY])
                
            } else {
                
                let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: lv, attribute: .right, multiplier: 1, constant: leftRightBetweenSpace)
                
                let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: rowFirstView, attribute: .width, multiplier: 1, constant: 0)
                
                let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: rowFirstView, attribute: .height, multiplier: 1, constant: 0)
                let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: rowFirstView, attribute: .centerY, multiplier: 1, constant: 0)
                
                parentView.addConstraints([left, width, height, centerY])
            }
        } else {
            let top = getTopViewLayoutConstraint(view: view, parentView: parentView, topSpace: topSpace, topView: topView, upDownBetweenSpace: upDownBetweenSpace)
            
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1, constant: leftSpace)
            
            let aspect = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
            
            parentView.addConstraints([top, left])
            view.addConstraint(aspect)
        }
    }
    
}
