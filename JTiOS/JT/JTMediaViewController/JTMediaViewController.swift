//
//  JTMediaViewController.swift
//  JTiOS
//
//  Created by JT on 2018/2/2.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTMediaViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var pageControl: UIPageControl?
    var index: Int
    var cellDatas: [JTMediaCollectionViewCellDatas]
    
    private let CellWithReuseIdentifier = "JT"

    init(index: Int = 0, cellDatas: [JTMediaCollectionViewCellDatas]) {
        self.index = index
        self.cellDatas = cellDatas
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.cellDatas = [JTMediaCollectionViewCellDatas]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    deinit {
        print("--------JTMediaViewController-----------")
    }
}
extension JTMediaViewController {
    private func setupUI() {
        setup()
        setupCollectionView()
        setupPageControl()
    }
    private func setup() {
        view.backgroundColor = UIColor.black
        automaticallyAdjustsScrollViewInsets = false
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.view.bounds.size
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        guard let cv = collectionView else { return }
        cv.register(JTMediaCollectionViewCell.self, forCellWithReuseIdentifier: CellWithReuseIdentifier)
        cv.backgroundColor = .black
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        view.addSubview(cv)
        let indexPath = IndexPath(item: index, section: 0)
        cv.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    private func setupPageControl() {
        pageControl = UIPageControl()
        guard let pc = pageControl else { return }
        pc.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 20)
        pc.numberOfPages = cellDatas.count
        pc.isUserInteractionEnabled = false
        pc.currentPage = index
        view.addSubview(pc)
    }
}

extension JTMediaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellWithReuseIdentifier, for: indexPath)
        if let c = cell as? JTMediaCollectionViewCell {
            let i = indexPath.row
            c.setDatas(data: cellDatas[i])
            c.delegate = self
        }
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let i = indexPath.row
        pageControl?.currentPage = i
        guard let c = cell as? JTMediaCollectionViewCell else { return }
        c.reshowData()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let c = cell as? JTMediaCollectionViewCell else { return }
        c.cancell()
    }

}
extension JTMediaViewController: JTMediaCollectionViewCellDelegate {
    internal func tap() {
        if let cv = collectionView {
            for cell in cv.visibleCells {
                guard let c = cell as? JTMediaCollectionViewCell else { continue }
                c.cancell()
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
