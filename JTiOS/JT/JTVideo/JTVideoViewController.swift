//
//  JTVideoViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MBProgressHUD

class JTVideoViewController: UIViewController {

    @IBOutlet weak var video: UIView!
    @IBOutlet weak var fullProgress: UIView!
    @IBOutlet weak var progress: UIView!
    @IBOutlet weak var progressWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var control: UIButton!
    @IBOutlet weak var save: UIButton!
    private var timer: Timer?
    
    var delegate: JTVideoViewControllerDelegate?
    var saveToAlbum: Bool = false
    var compress: Bool = true

    private let captureSession = AVCaptureSession()
    private let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
    private let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
    private let fileOutput = AVCaptureMovieFileOutput()
    private var isRecording = false
    private let maxRecordedDuration: Double = 15
    private let timerTimeInterval: TimeInterval = 0.5
    private var timerTime: Double = 0
    private var saveUrl: URL?

    private let videoDirName = "JT_Video_Temp_Directory_123"
    private let videoExtension = ".mp4"
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
    }
    
    @IBAction func backTouchUpInside(_ sender: Any) {
        backButtonAction()
    }
    @IBAction func controlTouchUpInside(_ sender: Any) {
        view.isUserInteractionEnabled = false
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
        view.isUserInteractionEnabled = true
    }
    @IBAction func saveTouchUpInside(_ sender: Any) {
        view.isUserInteractionEnabled = false
        if let url = saveUrl {
            if FileManager.default.fileExists(atPath: url.path) {
                if compress {
                    Compressing(oldUrl: url) {
                        [weak self] success, newUrl in
                        if success {
                            self?.finish(url: newUrl)
                        } else {
                            guard let s = self else { return }
                            Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.warning, message: Messager.shareInstance.compressFailed, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                        }
                    }
                } else {
                    finish(url: url)
                }
            } else {
                Alert.shareInstance.AlertWithUIAlertAction(viewController: self, title: Messager.shareInstance.warning, message: Messager.shareInstance.pleaseTakeVideo, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
            }
        } else {
            Alert.shareInstance.AlertWithUIAlertAction(viewController: self, title: Messager.shareInstance.warning, message: Messager.shareInstance.pleaseTakeVideo, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
        }
        view.isUserInteractionEnabled = true
    }
    deinit {
        print("--------JTVideoViewController-----------")
    }
}
extension JTVideoViewController {
    private func startRecording() {
        let temp = FileManage.shareInstance.tmpDir
        let dir = temp + "/\(videoDirName)"
        FileManage.shareInstance.createDirectory(path: dir)
        let filename = "\(UUID().uuidString + videoExtension)"
        let file = dir + "/\(filename)"
        let url = URL(fileURLWithPath: file)
        if FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.removeItem(at: url)
        }
        fileOutput.startRecording(to: url, recordingDelegate: self)
        isRecording = true
    }
    private func stopRecording() {
        fileOutput.stopRecording()
        isRecording = false
    }
}
extension JTVideoViewController: AVCaptureFileOutputRecordingDelegate {
    internal func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {

        isRecording = true
        saveUrl = nil
        setupTimer()
        setupUIButtons(isStarted: isRecording)
    }
    internal func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {

        isRecording = false
        tearDownTimer()
        setupUIButtons(isStarted: isRecording)
        if FileManager.default.fileExists(atPath: outputFileURL.path) {
            showTextHUD(text: Messager.shareInstance.videoFinish)
            saveUrl = outputFileURL
        } else {
            showTextHUD(text: Messager.shareInstance.videoFailed)
            saveUrl = nil
        }
    }
}
extension JTVideoViewController {
    private func setupUI() {
        control.isUserInteractionEnabled = false
        addCapture()
        setupCaptureVideoPreviewLayer()
        setupButtons()
        setupUIButtons(isStarted: isRecording)
        control.isUserInteractionEnabled = true
    }
    private func addCapture() {
        guard let vd = videoDevice, let videoInput = try? AVCaptureDeviceInput(device: vd) else {
            Alert.shareInstance.AlertWithUIAlertAction(viewController: self, title: Messager.shareInstance.cannotUseCamera, message: nil, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default) { [weak self] action in
                self?.dismiss(animated: true, completion: nil)
                }])
            return
        }
        guard let ad = audioDevice, let audioInput = try? AVCaptureDeviceInput(device: ad) else {
            Alert.shareInstance.AlertWithUIAlertAction(viewController: self, title: Messager.shareInstance.cannotUseMicrophone, message: nil, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default) { [weak self] action in
                self?.dismiss(animated: true, completion: nil)
                }])
            return
        }
        captureSession.addInput(videoInput)
        captureSession.addInput(audioInput);
        fileOutput.maxRecordedDuration = CMTime(seconds: maxRecordedDuration, preferredTimescale: 30)
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
    private func setupTimer() {
        timerTime = 0
        timer = Timer.scheduledTimer(timeInterval: timerTimeInterval, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }
    private func tearDownTimer() {
        timer?.invalidate()
    }
    @objc private func timerTick() {
        timerTime += timerTimeInterval
        let percent = Int(ceil(100 / (maxRecordedDuration - 0.2) * timerTime))
        setupProgress(percent: percent)
    }
    private func setupProgress(percent: Int) {
        var p = percent
        if p < 0 { p = 0 }
        if p > 100 { p = 100 }
        let now = fullProgress.frame.width / 100 * CGFloat(p)
        progressWidthConstraint.constant = now
    }
    private func setupUIButtons(isStarted: Bool) {
        if isStarted {
            control.backgroundColor = .red
            control.setTitle("停止", for: .normal)
            back.isUserInteractionEnabled = false
            save.isUserInteractionEnabled = false
        } else {
            control.backgroundColor = .green
            control.setTitle("开始", for: .normal)
            back.isUserInteractionEnabled = true
            save.isUserInteractionEnabled = true
        }
    }
    private func showTextHUD(text: String) {
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor(red: 220, green: 220, blue: 220)
        HUD.label.text = text
        HUD.backgroundView.style = .solidColor
        HUD.removeFromSuperViewOnHide = true
        HUD.mode = .text
        HUD.hide(animated: true, afterDelay: 1.5)
    }
    private func Compressing(oldUrl: URL, handler: ((Bool, URL) -> Void)? = nil) {
        var newUrl = oldUrl
        let pathExtension = newUrl.pathExtension
        newUrl.deleteLastPathComponent()
        newUrl.appendPathComponent(UUID().uuidString + "." + pathExtension)
        
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.label.text = Messager.shareInstance.compressing
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = false
        HUD.minShowTime = 1
        HUD.show(animated: true)
        Compress.shareInstance.video(inUrl: oldUrl, outUrl: newUrl) {
            status in
            let _ = FileManage.shareInstance.delete(url: oldUrl)
            DispatchQueue.main.async {
                HUD.hide(animated: true)
                switch status {
                case .completed:
                    if let h = handler { h(true, newUrl) }
                default:
                    if let h = handler { h(false, newUrl) }
                }
            }
        }
    }
    private func finish(url: URL) {
        if saveToAlbum {
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)
        }
        delegate?.didFinishRecordingVideo(videoFileUrl: url)
        backButtonAction()
    }
}

public protocol JTVideoViewControllerDelegate {
    func didFinishRecordingVideo(videoFileUrl: URL)
}
