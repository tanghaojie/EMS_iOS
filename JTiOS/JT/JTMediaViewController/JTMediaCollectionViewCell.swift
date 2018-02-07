//
//  JTMediaCollectionViewCell.swift
//  JTiOS
//
//  Created by JT on 2018/2/2.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

protocol JTMediaCollectionViewCellDelegate: NSObjectProtocol {
    func tap()
}
class JTMediaCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: JTMediaCollectionViewCellDelegate?
    var scrollView: UIScrollView?
    var imageView: UIImageView?
    var player: AVPlayer?
    var btn: UIButton?
    
    var tapSingle: UITapGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("--------JTMediaCollectionViewCell-----------")
    }
}
extension JTMediaCollectionViewCell {
    private func setupUI() {
        setupTap()
    }
    private func setupTap() {
        tapSingle = UITapGestureRecognizer(target: self, action: #selector(tapSingle(_:)))
        guard let t = tapSingle else { return }
        t.numberOfTapsRequired = 1
        t.numberOfTouchesRequired = 1
        contentView.addGestureRecognizer(t)
    }
    @objc private func tapSingle(_ ges:UITapGestureRecognizer){
        delegate?.tap()
    }
}
extension JTMediaCollectionViewCell {
    private func setupUI_Image() {
        setupScrollView()
        setupImageView()
        setupDoubleTap()
    }
    private func setupScrollView() {
        scrollView = UIScrollView(frame: contentView.bounds)
        guard let sv = scrollView else { return }
        contentView.addSubview(sv)
        sv.delegate = self
        sv.maximumZoomScale = 3.0
        sv.minimumZoomScale = 1.0
    }
    private func setupImageView() {
        imageView = UIImageView()
        guard let iv = imageView else { return }
        guard let sv = scrollView else { return }
        iv.frame = sv.bounds
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFit
        sv.addSubview(iv)
    }
    private func setupDoubleTap() {
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(tapDouble(_:)))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        tapSingle?.require(toFail: tapDouble)
        imageView?.addGestureRecognizer(tapDouble)
    }
    @objc private func tapDouble(_ ges:UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5, animations: {
            [weak self] in
            guard let s = self else { return }
            guard let sv = s.scrollView else { return }
            if sv.zoomScale == 1.0 {
                sv.zoomScale = 3.0
            } else {
                sv.zoomScale = 1.0
            }
        })
    }
}
extension JTMediaCollectionViewCell: UIScrollViewDelegate {
    internal func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    internal func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var x = scrollView.center.x
        var y = scrollView.center.y
        x = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : x
        y = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height / 2 : y
        imageView?.center = CGPoint(x: x, y: y)
    }
}
extension JTMediaCollectionViewCell {
    private func setupUI_Video() {
        setupAVPlayer()
        setupPlayButton()
    }
    private func setupAVPlayer() {
        player = AVPlayer()
        let layer = AVPlayerLayer(player: player)
        layer.frame = contentView.frame
        contentView.layer.addSublayer(layer)
    }
    private func setupPlayButton() {
        let w: CGFloat = 40
        let h: CGFloat = 40
        let frame = contentView.frame
        let x = (frame.width - w) / 2
        let y = (frame.height - h) / 2
        btn = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
        guard let b = btn else { return }
        let btnImage = Assets.shareInstance.play()
        b.setImage(btnImage, for: .normal)
        contentView.addSubview(b)
        contentView.bringSubview(toFront: b)
        b.addTarget(self, action: #selector(playButtonTouchUpInside), for: .touchUpInside)
    }
    @objc private func playButtonTouchUpInside() {
        if let rate = player?.rate, rate == 0 {
            play()
        } else {
            pause()
        }
    }
    private func play() {
        player?.play()
        let btnImage = Assets.shareInstance.pause()
        btn?.setImage(btnImage, for: .normal)
    }
    private func pause() {
        player?.pause()
        let btnImage = Assets.shareInstance.play()
        btn?.setImage(btnImage, for: .normal)
    }
}
extension JTMediaCollectionViewCell {
    private func setData(data: JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellData) {
        switch data.type {
        case .Image:
            setDataImage(url: data.url)
        case .Video:
            setDataVideo(url: data.url)
        case .Unknown:
            setDataUnknown()
        case .VideoCover:
            setDataVideoCover()
        }
    }
    private func removeAll() {
        while (contentView.subviews.count > 0) {
            contentView.subviews.last?.removeFromSuperview()
        }
        contentView.layer.sublayers?.removeAll()
    }
    private func setDataImage(url: URL?) {
        guard let url = url else { return }
        guard let data = try? Foundation.Data.init(contentsOf: url) else { return }
        guard let image = UIImage(data: data) else { return }
        removeAll()
        setupUI_Image()
        guard let iv = imageView else { return }
        iv.image = image
    }
    private func setDataVideo(url: URL?) {
        guard let url = url else { return }
        let playItem = AVPlayerItem(url: url)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playItem)
        removeAll()
        setupUI_Video()
        guard let p = player else { return }
        p.replaceCurrentItem(with: playItem)
    }
    @objc func playerItemDidReachEnd(notification: Notification){
        player?.seek(to: kCMTimeZero, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        let btnImage = Assets.shareInstance.play()
        btn?.setImage(btnImage, for: .normal)
    }
    private func setDataUnknown() {
        guard let image = Assets.shareInstance.unknownFile() else { return }
        removeAll()
        setupUI_Image()
        guard let iv = imageView else { return }
        iv.image = image
    }
    private func setDataVideoCover() {
        guard let image = Assets.shareInstance.play3() else { return }
        removeAll()
        setupUI_Image()
        guard let iv = imageView else { return }
        iv.image = image
    }
}
extension JTMediaCollectionViewCell {
    public func setDatas(data: JTMediaCollectionViewCellDatas) {
        if let d = data.data {
            setData(data: d)
            return
        }
        if let d = data.previewData {
            setData(data: d)
            if let nd = data.needData {
                nd({
                    [weak self] r in
                    data.data = r
                    self?.setData(data: r)
                })
            }
        }
    }
    
}
