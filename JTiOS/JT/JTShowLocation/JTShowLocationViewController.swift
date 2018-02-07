//
//  JTShowLocationViewController.swift
//  JTiOS
//
//  Created by JT on 2018/2/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTShowLocationViewController: UIViewController {

    private var mapView: AGSMapView!
    private let graphicslayer = AGSGraphicsLayer()
    private let point: AGSPoint
    
    init(_ point: AGSPoint){
        self.point = point
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setPictureMarkerSymbol()
    }
    
    deinit {
        print("----JTShowLocationViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapView.zoom(toScale: 10000, withCenter: point, animated: true)
    }
}
extension JTShowLocationViewController {
    
    private func setupUI() {
        setupMapView()
        setupBackButton()
        setupLocationButton()
    }
    
    private func setupMapView() {
        SCGISUtility.registerESRI()
        mapView = AGSMapView()
        mapView.frame = view.frame
        mapView.locationDisplay.startDataSource()
        mapView.gridLineWidth = 10
        graphicslayer.isVisible = true
        mapView.layerDelegate = self
        
        addTilemapServerLayer(url: Mapservers.shareInstance.scgisTiledMap_DLG)
        
        mapView.addMapLayer(graphicslayer)
        
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
    
    private func setPictureMarkerSymbol() {
        let pictureMarkerSymbol = AGSPictureMarkerSymbol()
        pictureMarkerSymbol.image = Assets.shareInstance.point2()
        let graphic = AGSGraphic(geometry: point, symbol: pictureMarkerSymbol, attributes: nil)
        graphicslayer.addGraphic(graphic)
    }
    
}

extension JTShowLocationViewController: AGSMapViewLayerDelegate {
    
    internal func mapViewDidLoad(_ mapView: AGSMapView!) {
        mapView.locationDisplay.startDataSource()
        mapView.locationDisplay.autoPanMode = .off
        //mapView.zoom(toScale: 10000, withCenter: point, animated: true)
    }
    
}
