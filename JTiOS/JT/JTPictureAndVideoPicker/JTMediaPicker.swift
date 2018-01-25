//
//  JTMediaPicker.swift
//  JTiOS
//
//  Created by JT on 2018/1/20.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTMediaPicker: UIView {
    
    private let topSpace: CGFloat = 16
    private let bottomSpace: CGFloat = 16
    private let leftSpace: CGFloat = 12
    private let rightSpace: CGFloat = 12
    
    private var maxCount: Int = 9
    private var numberOfLine: Int = 3
    
    private let upDownBetweenSpace: CGFloat = 8
    private let leftRightBetweenSpace: CGFloat = 8
    
    private let addButtonAccessibilityIdentifier = "addButtonAccessibilityIdentifier"
    private var addAction: (() -> Void)?
    private var tapAction: (() -> Void)?
    private var deleteAction: ((Int) -> Void)?

    private lazy var addView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = addButtonAccessibilityIdentifier
        let addImage = UIImage(named: "add2")
        let imageView = UIImageView(image: addImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        let left = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([left, right, top, bottom])
        
        return view
    }()
    
    private lazy var playImage: UIImage? = {
        let image = UIImage(named: "play")
        return image
    }()

    private var datasViews: [UIView] = [UIView]()
    private var datasViewsCount: Int {
        get { return datasViewsColumnCount * datasViewsRowCount }
    }
    private var datasViewsColumnCount: Int {
        get { return numberOfLine }
    }
    private var datasViewsRowCount: Int {
        get {
            if full {
                let rowCount = Int(ceil(CGFloat(datasCount) / CGFloat(datasViewsColumnCount)))
                return rowCount
            } else {
                let rowCount = Int(ceil(CGFloat(datasCount + 1) / CGFloat(datasViewsColumnCount)))
                return rowCount
            }
        }
    }
    
    private var datas: [JTMediaPickerData] = [JTMediaPickerData]()
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        reload()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        reload()
    }
    init(maxCount: Int?, numberOfLine: Int?, addAction: (() -> Void)? = nil, tapAction: (() -> Void)? = nil, deleteAction: ((Int) -> Void)? = nil) {
        if let mc = maxCount, mc > 0 {
            self.maxCount = mc
        }
        if let nol = numberOfLine, nol > 0 {
            self.numberOfLine = nol
        }
        self.addAction = addAction
        self.tapAction = tapAction
        self.deleteAction = deleteAction
        super.init(frame: CGRect.zero)
        reload()
    }
}
extension JTMediaPicker {
    private func initDatasViews() {
        datasViews = [UIView]()
        for index in 0...datasViewsCount - 1 {
            if index == datasCount && !full {
                datasViews.append(addView)
            } else {
                datasViews.append(UIView())
            }
        }
    }
    private func removeAllSubviews() {
        while (subviews.count > 0) {
            subviews.last?.removeFromSuperview()
        }
    }
}

extension JTMediaPicker {
    
    private func showSubviews() {
        for rowNum in 0...datasViewsRowCount - 1 {
            for columnNum in 0...datasViewsColumnCount - 1 {
                subView(rowNum: rowNum, columnNum: columnNum)
            }
        }
        let lastView = datasViews[datasViews.count - 1]
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: lastView, attribute: .bottom, multiplier: 1, constant: bottomSpace)
        self.addConstraint(bottom)
    }
    private func subView(rowNum: Int, columnNum: Int) {
        let datasViewsindex = rowNum * datasViewsColumnCount + columnNum
        let view = datasViews[datasViewsindex]

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
        guard datasViewsindex < datasCount || addButtonAccessibilityIdentifier == view.accessibilityIdentifier else {
            view.isHidden = true
            return
        }
        view.tag = datasViewsindex
        addTapGestureRecognizer(view: view)
        addLongPressGestureRecognizer(view: view)
        var jtMediaPickerData: JTMediaPickerData? = nil
        if addButtonAccessibilityIdentifier != view.accessibilityIdentifier {
            jtMediaPickerData = datas[datasViewsindex]
        }
        showData(view: view, jtMediaPickerData: jtMediaPickerData)
    }
    
    private func showData(view: UIView, jtMediaPickerData: JTMediaPickerData?) {
        guard let data = jtMediaPickerData else { return }
        let type = data.type
        let url = data.url
        switch type {
        case .Image:
            showImageData(view: view, url: url)
        case .Video:
            showVideoData(view: view, url: url)
        }
    }
    private func showImageData(view: UIView, url: URL) {
        let image = UIImage(contentsOfFile: url.path)
        guard let img = image else { return }
        let imageView = UIImageView(image: img)
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
    private func showVideoData(view: UIView, url: URL) {
        let cover = getVideoCover(url: url)
        guard let img = cover else { return }
        let imageView = UIImageView(image: img)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        let left = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([left, right, top, bottom])
        
        setVideoCoverPlayImage(imageView: imageView)
    }
    private func setVideoCoverPlayImage(imageView: UIImageView) {
        let image = imageView.image
        guard let img = image else { return }
        let size = imageView.frame.width
        if let playImage = playImage {
            let w = img.size.width
            let h = img.size.height
            let len = size / 2
            let x = (w - len) / 2
            let y = (h - len) / 2
            UIGraphicsBeginImageContext(CGSize(width: w, height: h))
            img.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
            playImage.draw(in: CGRect(x: x, y: y, width: len, height: len))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            if let x = result { imageView.image = x }
            UIGraphicsEndImageContext()
        }
    }
    private func getVideoCover(url: URL, preferredTimescale: Int32 = 30) -> UIImage? {
        let asset = AVAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0, preferredTimescale)
        var actualTime = CMTimeMake(0, 0)
        let imageRef = try? generator.copyCGImage(at: time, actualTime: &actualTime)
        guard let iRef = imageRef else {
            return nil
        }
        return UIImage(cgImage: iRef)
    }
}

extension JTMediaPicker {
    private func addTapGestureRecognizer(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    @objc private func taped(t: UITapGestureRecognizer) {
        let view = t.view
        guard let v = view else { return }
        if addButtonAccessibilityIdentifier == v.accessibilityIdentifier {
            guard let action = addAction else { return }
            action()
        } else {
            guard let action = tapAction else { return }
            action()
        }
    }
    private func addLongPressGestureRecognizer(view: UIView) {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPress.minimumPressDuration = 0.8
        view.addGestureRecognizer(longPress)
    }
    @objc private func longPressed(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        guard longPressGestureRecognizer.state == UIGestureRecognizerState.began else { return }
        let view = longPressGestureRecognizer.view
        guard let v = view else { return }
        if addButtonAccessibilityIdentifier == v.accessibilityIdentifier { return }
        let tag = v.tag
        guard tag >= 0 && tag < datasCount else { return }
        guard let action = deleteAction else { return }
        action(tag)
    }
}

extension JTMediaPicker {
    public func addData(jtMediaPickData: JTMediaPickerData) {
        if !FileManager.default.fileExists(atPath: jtMediaPickData.url.path) { return }
        if full {
            datas.removeFirst()
        }
        datas.append(jtMediaPickData)
        reload()
    }
    public func removeData(at index: Int) {
        datas.remove(at: index)
        reload()
    }
    public func getData() -> [JTMediaPickerData] {
        return datas
    }
    public func reload() {
        removeAllSubviews()
        initDatasViews()
        showSubviews()
    }
}
