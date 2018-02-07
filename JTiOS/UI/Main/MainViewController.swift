//
//  MainViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainViewController: UIViewController {
    
    private var hasCheckLogin = false
    @IBOutlet weak var mapView: AGSMapView!
    @IBOutlet weak var bottomTabbar: UIView!
    private var uploadLocationButton: UIButton?
    fileprivate var timer1s: Timer?
    fileprivate var timer10s: Timer?
    private var isUploadPoints: Bool = false {
        didSet {
            if isUploadPoints {
                let img = Assets.shareInstance.uploadingLocation()
                uploadLocationButton?.setImage(img, for: .normal)
                startUploadLocation()
            } else {
                let img = Assets.shareInstance.uploadLocation()
                uploadLocationButton?.setImage(img, for: .normal)
                stopUploadLocation()
            }
        }
    }
    private var uploadPoints = [Object_Point]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addLayer()
        JTLocationManager.shareInstance.startUpdatingLocation()
        JTLocationManager.shareInstance.startUpdatingHeading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        setupUploadPointButton(view: mapView)
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
    private func setupUploadPointButton(view: UIView) {
        uploadLocationButton = UIButton(frame: CGRect(x: view.frame.width - 20 - 60, y: 180, width: 60, height: 60))
        guard let btn = uploadLocationButton else { return }
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(uploadPointButtonTouchUpInside), for: .touchUpInside)
        view.addSubview(btn)
        view.bringSubview(toFront: btn)
        isUploadPoints = false
    }
    @objc private func addButtonTouchUpInside() {
        showWarningReport()
    }
    @objc private func uploadPointButtonTouchUpInside() {
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = false
        HUD.minShowTime = 0.8
        HUD.show(animated: true)
        
        if !isUploadPoints {
            LoginC().hadLoggedinWithState(handler: {
                [weak self] (isLogin, msg) in
                HUD.hide(animated: true)
                if isLogin {
                    self?.isUploadPoints = true
                } else {
                    self?.showLogin()
                }
            })
        } else {
            HUD.hide(animated: true)
            isUploadPoints = false
        }
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
        
//        let sb = UIStoryboard(name: "test", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "test")
//        self.present(vc, animated: true, completion: nil)
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
    
    private func showLogin() {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginNavigationController")
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
extension MainViewController {
    
    private func startUploadLocation() {
        uploadPoints.removeAll()
        timer1s = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timer1Fire), userInfo: nil, repeats: true)
        timer10s = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(timer10Fire), userInfo: nil, repeats: true)
    }
    
    private func stopUploadLocation() {
        timer1s?.invalidate()
        timer10s?.invalidate()
    }
    
    private func getUploadPoints() -> [Object_Point] {
        let count = uploadPoints.count
        guard count > 0 else { return [Object_Point]() }
        
        var data = [Object_Point]()
        for _ in 0 ..< count {
            let first = uploadPoints.removeFirst()
            data.append(first)
        }
        uploadPoints.removeAll()
        return data
    }
    
    @objc private func timer10Fire() {
        let data = getUploadPoints()
        guard let uid = global_SystemUser?.id else {
            isUploadPoints = false
            return
        }
        let r = RequestJson_UploadPoints(uid: uid, tnum: Date(), points: data)
        ServiceManager.shareInstance.provider.request(.uploadPoints(object: r)) {
            _ in
        }
    }
    
    @objc private func timer1Fire() {
        guard isUploadPoints, let l = JTLocationManager.shareInstance.location else { return }
        guard let today = global_TodayStartDate else {
            exit(0)
        }
        let t = Int64(Date().timeIntervalSince(today))
        let point = Object_Point(x: l.coordinate.longitude, y: l.coordinate.latitude, t: t)
        uploadPoints.append(point)
    }
    
}
