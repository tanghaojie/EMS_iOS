//
//  JTSelectLocationViewController.swift
//  JTiOS
//
//  Created by JT on 2018/2/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTSelectLocationViewController: UIViewController {

    private var mapView: AGSMapView!
    private var completeFunc: ((Double,Double) -> Void)?
    private let minScale: Double = 5300
    private let maxScale: Double = 2900
    
    init(_ complete: ((Double,Double) -> Void)? = nil){
        self.completeFunc = complete
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    deinit {
        print("----JTSelectLocationViewController")
    }

}
extension JTSelectLocationViewController {
    
    private func setupUI() {
        
        setupMapView()
        setupBackButton()
        setupLocationButton()
        setupCenterPoint()
        setupOKButton()
    }
    
    private func setupMapView() {
        SCGISUtility.registerESRI()
        mapView = AGSMapView()
        mapView.frame = view.frame
        mapView.layerDelegate = self
        mapView.gridLineWidth = 10
        mapView.maxScale = maxScale
        mapView.minScale = minScale
        addTilemapServerLayer(url: Mapservers.shareInstance.scgisTiledMap_DLG)
        view.addSubview(mapView)
    }
    private func addTilemapServerLayer(url:String) {
        let tilemap = SCGISTilemapServerLayer(serviceUrlStr: url, token: nil, cacheType: SCGISTilemapCacheTypeSqliteDB)
        if let t = tilemap {
            mapView.addMapLayer(t)
        }
    }

    private func setupLocationButton() {
        let wh: CGFloat = 50
        let btn = UIButton(frame: CGRect(x: mapView.frame.width - wh - 20, y: mapView.frame.height - wh - 20, width: wh, height: wh))
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        let img = Assets.shareInstance.location()
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc private func locationButtonClicked() {
        let location = mapView.locationDisplay.location
        if let loca = location {
            mapView.center(at: loca.point, animated: true)
        }
    }
    
    private func setupCenterPoint() {
        let w: CGFloat = 38
        let h: CGFloat  = 38
        let x = (mapView.frame.width - w) / 2
        let y = mapView.frame.height / 2 - h
        let imgView = UIImageView(frame: CGRect(x: x, y: y, width: w, height: h))
        imgView.image = Assets.shareInstance.point2()
        
        view.addSubview(imgView)
    }
    
    private func setupOKButton() {
        let w: CGFloat = 150
        let h: CGFloat = 50
        let x = (mapView.frame.width - w) / 2
        let y = mapView.frame.height - h - 20
        let btn = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
        btn.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        btn.backgroundColor = UIColor(red: 0, green: 94, blue: 149)
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        
        view.addSubview(btn)
    }
    
    @objc private func okButtonAction() {
        if let com = completeFunc {
            let p = mapView.toMapPoint(mapView.center)
            if let point = p {
                let latitude = point.y
                let longitude = point.x
                com(latitude,longitude)
                backButtonAction()
            }
        }
    }
    
}

extension JTSelectLocationViewController: AGSMapViewLayerDelegate {
    
    func mapViewDidLoad(_ mapView: AGSMapView!) {
        mapView.zoom(toScale: minScale, animated: true)
        mapView.locationDisplay.startDataSource()
        mapView.locationDisplay.autoPanMode = .default
    }
    
}
