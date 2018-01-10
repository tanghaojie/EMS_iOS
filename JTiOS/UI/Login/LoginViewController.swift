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
                        if let navi = self?.navigationController {
                            navi.dismiss(animated: true, completion: nil)
                        } else {
                            self?.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        if let s = self {
                        Alert.shareInstance.AlertWithUIAlertAction(view: s, title: Messager.shareInstance.loginFailed, message: r.msg, uiAlertAction: [UIAlertAction(title: Messager.shareInstance.ok, style: UIAlertActionStyle.default, handler: nil)])
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
    }

}

extension LoginViewController {
    private func get(){
        self.vm.username = self.username.text
        self.vm.password = self.password.text
    }
}
