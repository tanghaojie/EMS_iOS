//
//  JTMediaPreview.swift
//  JTiOS
//
//  Created by JT on 2018/1/25.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTMediaPreview: UIView {
    
    private let minHeight: CGFloat = 1
    private let topSpace: CGFloat = 8
    private let bottomSpace: CGFloat = 16
    private let leftSpace: CGFloat = 0
    private let rightSpace: CGFloat = 0
    
    private var maxCount: Int = 9
    private var numberOfLine: Int = 4
    
    private let upDownBetweenSpace: CGFloat = 8
    private let leftRightBetweenSpace: CGFloat = 8

    private var datasViews: [UIView] = [UIView]()
    private var datasViewsCount: Int {
        get { return datasViewsColumnCount * datasViewsRowCount }
    }
    private var datasViewsColumnCount: Int {
        get { return numberOfLine }
    }
    private var datasViewsRowCount: Int {
        get {
            let rowCount = Int(ceil(CGFloat(datasCount) / CGFloat(datasViewsColumnCount)))
            return rowCount
        }
    }
    
    private var datas = [JTMediaPreviewData]()
    private var datasCount: Int {
        get { return datas.count }
    }
    private var full: Bool {
        get {
            if datasCount >= maxCount {
                return true
            } else {
                return false
            }
        }
    }
    var delegate: JTMediaPreviewDelegate?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        reload()
    }
    init() {
        super.init(frame: CGRect.zero)
        reload()
    }

}
extension JTMediaPreview {
    private func initDatasViews() {
        datasViews = [UIView]()
        for _ in 0 ..< datasViewsCount {
            datasViews.append(UIView())
        }
    }
    private func removeAllDatasViewsSubviews() {
        while (subviews.count > 0) {
            subviews.last?.removeFromSuperview()
        }
    }
    private func fullAfterAdded(count: Int) -> Bool {
        if datasCount + count >= maxCount {
            return true
        } else {
            return false
        }
    }
}

extension JTMediaPreview {
    
    private func showSubviews() {
        for rowNum in 0 ..< datasViewsRowCount {
            for columnNum in 0 ..< datasViewsColumnCount {
                subView(rowNum: rowNum, columnNum: columnNum)
            }
        }
        let index = datasViews.count - 1
        if index >= 0 {
            let lastView = datasViews[index]
            let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: lastView, attribute: .bottom, multiplier: 1, constant: bottomSpace)
            self.addConstraint(bottom)
        } else {
            let minH = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: minHeight)
            self.addConstraint(minH)
        }
    }
    private func subView(rowNum: Int, columnNum: Int) {
        let datasViewsindex = rowNum * datasViewsColumnCount + columnNum
        let view = datasViews[datasViewsindex]
        view.tag = datasViewsindex
        let topViewIndex = datasViewsindex - datasViewsColumnCount
        let topView = (topViewIndex < 0) ? nil : datasViews[topViewIndex]
        let leftView = (columnNum == 0) ? nil : datasViews[datasViewsindex - 1]
        
        if datasViewsColumnCount == 1 {
            JTAutoAverageRowSubviews.shareInstance.autoAverage1ColumnSubView(view: view, parentView: self, topSpace: topSpace, leftSpace: leftSpace, rightSpace: rightSpace, topView: topView, upDownBetweenSpace: upDownBetweenSpace)
        } else if datasViewsColumnCount == 2 {
            JTAutoAverageRowSubviews.shareInstance.autoAverage2ColumnSubViews(view: view, parentView: self, topSpace: topSpace, leftSpace: leftSpace, rightSpace: rightSpace, topView: topView, leftView: leftView, upDownBetweenSpace: upDownBetweenSpace, leftRightBetweenSpace: leftRightBetweenSpace)
        } else {
            let rowFirstViewIndex = datasViewsindex - columnNum
            let rowFirstView = datasViews[rowFirstViewIndex]
            JTAutoAverageRowSubviews.shareInstance.autoAverage3ColumnSubViews(view: view, parentView: self, topSpace: topSpace, leftSpace: leftSpace, rightSpace: rightSpace, rowFirstView: rowFirstView, topView: topView, leftView: leftView, upDownBetweenSpace: upDownBetweenSpace, leftRightBetweenSpace: leftRightBetweenSpace, isRowLastView: columnNum == datasViewsColumnCount - 1 )
        }
        guard datasViewsindex < datasCount else {
            view.isHidden = true
            return
        }
        let data = datas[datasViewsindex]
        addTapGestureRecognizer(view: view)
        showData(view: view, data: data)
    }

    private func showData(view: UIView, data: JTMediaPreviewData) {
        let imageView = data.imageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        let left = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([left, right, top, bottom])
    }

}

extension JTMediaPreview {
    private func addTapGestureRecognizer(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    @objc private func taped(t: UITapGestureRecognizer) {
        let view = t.view
        guard let v = view else { return }
        guard let d = delegate else { return }
        let tag = v.tag
        d.previewTapAction(index: tag, jtMediaPreview: self)
    }
}

extension JTMediaPreview {
    public func addData(data: JTMediaPreviewData) {
        if full {
            datas.removeFirst()
        }
        datas.append(data)
        reload()
    }
    public func addData(dataRange: [JTMediaPreviewData]) {
        let count = dataRange.count
        if count <= 0 { return }
        if fullAfterAdded(count: count) {
            let removeCount = count - (maxCount - datasCount)
            datas.removeFirst(removeCount)
        }
        datas.append(contentsOf: dataRange)
        reload()
    }
    public func setDataImage(at index: Int, image: UIImage) {
        guard index > -1 && index < datasCount else { return }
        let data = datas[index]
        data.image = image
    }
    public func removeData(at index: Int) {
        datas.remove(at: index)
        reload()
    }
    public func getData() -> [JTMediaPreviewData] {
        return datas
    }
    public func reload() {
        removeAllDatasViewsSubviews()
        initDatasViews()
        showSubviews()
    }
}

protocol JTMediaPreviewDelegate {
    func previewTapAction(index: Int, jtMediaPreview: JTMediaPreview)
}

