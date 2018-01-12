//
//  MainViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var hasCheckLogin = false
    @IBOutlet weak var mapView: AGSMapView!
    @IBOutlet weak var bottomTabbar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JTLocationManager.shareInstance.startUpdatingLocation()
        JTLocationManager.shareInstance.startUpdatingHeading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
        addLayer()
        
        if !hasCheckLogin {
            checkLogin()
            hasCheckLogin = true
        }
    }
    
}

extension MainViewController {
    private func setupUI() {
        setupMapView()
        setupTabbar()
        setupLocationButton(view: mapView)
        setupAddEventButton(view: mapView)
    }
    
    private func setupMapView() {
        SCGISUtility.registerESRI()
        mapView.layerDelegate = self
        mapView.gridLineWidth = 10
    }
    
    private func setupTabbar() {
        
        let config1 = JTTabbar.Config()
        config1.text = "预警"
        config1.titleColor = UIColor(red: 247, green: 33, blue: 0)
        config1.tap = showWarning
        
        let config2 = JTTabbar.Config()
        config2.text = "任务"
        config2.titleColor = UIColor(red: 0, green: 0, blue: 0)
        config2.tap = showTask
        
        let config3 = JTTabbar.Config()
        config3.text = "我的"
        config3.titleColor = UIColor(red: 6, green: 111, blue: 165)
        config3.tap = showMy
        
        let x = [config1, config2, config3]
        let tabbar = JTTabbar(config: x, width: Int(bottomTabbar.frame.width), height: Int(bottomTabbar.frame.height))
        bottomTabbar.addSubview(tabbar)
    }
    
    private func setupAddEventButton(view: UIView) {
        let btn = UIButton(frame: CGRect(x: view.frame.width - 20 - 60, y: 100, width: 60, height: 60))
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        let img = UIImage(named: "add")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
        view.addSubview(btn)
        view.bringSubview(toFront: btn)
    }
    @objc private func addButtonTouchUpInside() {
        showWarningReport()
    }
    
    private func setupLocationButton(view : UIView) {
        let btn = UIButton(frame: CGRect(x: view.frame.width - 20 - 40, y: view.frame.height - 40 - 20, width: 40, height: 40))
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        let img = UIImage(named: "location")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
        view.addSubview(btn)
        view.bringSubview(toFront: btn)
    }
    
    @objc private func locationButtonClicked() {
        let location = JTLocationManager.shareInstance.location
        if let l = location {
            let point = AGSPoint(location: l)
            mapView.center(at: point, animated: true)
            mapView.locationDisplay.autoPanMode = .default
        }
    }
}

extension MainViewController {
    
    private func showWarningReport() {
        let sb = UIStoryboard(name: "WarningReport", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WarningReportNavigationController")
        JTCheckLoginPresent(vc: vc)
    }
    
    private func showWarning() {
        let vc = WarningNavigationController()
        JTCheckLoginPresent(vc: vc)
    }
    
    private func showTask() {
        let vc = TaskNavigationController()
        JTCheckLoginPresent(vc: vc)
    }
    
    private func showMy() {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HomeNavigationController")
        present(vc, animated: true, completion: nil)
    }
    
}
extension MainViewController: AGSMapViewLayerDelegate {
    
    func mapViewDidLoad(_ mapView: AGSMapView!) {
        let map = mapView.mapLayers[0] as! AGSTiledLayer
        let envelop = map.initialEnvelope
        mapView.zoom(to: envelop, animated: false)
        mapView.locationDisplay.startDataSource()
        mapView.locationDisplay.autoPanMode = .default
    }
    
    private func addLayer() {
        addTilemapServerLayer(url: Mapservers.shareInstance.scgisTiledMap_DLG)
    }
    
    private func addTilemapServerLayer(url:String) {
        let tilemap = SCGISTilemapServerLayer(serviceUrlStr: url, token: nil, cacheType: SCGISTilemapCacheTypeSqliteDB)
        if let t = tilemap {
            mapView.addMapLayer(t)
        }
    }
}
