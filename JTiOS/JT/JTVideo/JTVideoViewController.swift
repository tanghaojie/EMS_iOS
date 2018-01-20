//
//  JTVideoViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTVideoViewController: UIViewController {

    @IBOutlet weak var video: UIView!
    @IBOutlet weak var progress: UIView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var control: UIButton!
    @IBOutlet weak var save: UIButton!

    let captureSession = AVCaptureSession()
    let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
    let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
    let fileOutput = AVCaptureMovieFileOutput()
    var isRecording = false
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
    }
    
    @IBAction func backTouchUpInside(_ sender: Any) {
        backButtonAction()
    }
    @IBAction func controlTouchUpInside(_ sender: Any) {
        
    }
    @IBAction func saveTouchUpInside(_ sender: Any) {
        
    }
    
}
extension JTVideoViewController {
    private func setupUI() {
        addCapture()
        setupCaptureVideoPreviewLayer()
        setupButtons()
    }
    private func addCapture() {
        guard let vd = videoDevice, let videoInput = try? AVCaptureDeviceInput(device: vd) else {
            Alert.shareInstance.AlertWithUIAlertAction(view: self, title: Messager.shareInstance.cannotUseCamera, message: nil, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default) { [weak self] action in
                self?.dismiss(animated: true, completion: nil)
                }])
            return
        }
        guard let ad = audioDevice, let audioInput = try? AVCaptureDeviceInput(device: ad) else {
            Alert.shareInstance.AlertWithUIAlertAction(view: self, title: Messager.shareInstance.cannotUseMicrophone, message: nil, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default) { [weak self] action in
                self?.dismiss(animated: true, completion: nil)
                }])
            return
        }
        captureSession.addInput(videoInput)
        captureSession.addInput(audioInput);
        captureSession.addOutput(fileOutput)
        captureSession.startRunning()
    }
    private func setupCaptureVideoPreviewLayer() {
        let videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoLayer.frame = video.bounds
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        video.layer.addSublayer(videoLayer)
    }
    private func setupButtons() {
        video.bringSubview(toFront: back)
        video.bringSubview(toFront: control)
        video.bringSubview(toFront: save)
    }
}
