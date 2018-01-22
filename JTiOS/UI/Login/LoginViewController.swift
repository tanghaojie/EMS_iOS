//
//  LoginViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/20.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {
    
    private let vm = LoginVM()
    private let c = LoginC()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    public var loginSuccessHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func loginTouchUpInside(_ sender: Any) {
        let view: UIView
        if let navi = self.navigationController {
            view = navi.view
        } else {
            view = self.view
        }
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.label.text = Messager.shareInstance.logining
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = false
        HUD.minShowTime = 1
        HUD.show(animated: true)
        
        get()
        
        let dispatchQueue = DispatchQueue(label: "queue_login")
        dispatchQueue.async { [weak self] in
            let result: (success: Bool,msg: String?)? = self?.c.login(loginVM: (self?.vm)!)
            DispatchQueue.main.async {
                HUD.hide(animated: true)
                if let r = result {
                    if(r.success) {
                        if let h = self?.loginSuccessHandler {
                            h()
                        }
                        if let navi = self?.navigationController {
                            navi.dismiss(animated: true, completion: nil)
                        } else {
                            self?.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        if let s = self {
                        Alert.shareInstance.AlertWithUIAlertAction(viewController: s, title: Messager.shareInstance.loginFailed, message: r.msg, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
                        }
                    }
                }
            }
        }
    }

}

extension LoginViewController {
    private func setupUI() {
        setupBackButton()
        setMemoriedData()
    }
    private func setMemoriedData() {
        guard let d = Data.shareInstance.GetData_Login() else { return }
        set(username: d.username, password: d.password)
    }
}

extension LoginViewController {
    private func get() {
        vm.username = username.text
        vm.password = password.text
    }
    private func set(username: String?, password: String?) {
        self.username.text = username
        self.password.text = password
    }
}
