//
//  Global.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//
import MBProgressHUD
extension UIColor{
    convenience init(red : CGFloat, green : CGFloat, blue : CGFloat){
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
extension String {
    var utf8Encoded: Foundation.Data {
        return data(using: .utf8)!
    }
    var toJTFormateDate: Date? {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(identifier: "UTC")
        //dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateTimeFormate
        return dateFormatter.date(from: self)
    }
}
extension Date {
    var toJTFormateString: String {
        return DateFormatter.JTDateFormatter.string(from: self)
    }
}
extension DateFormatter {
    static var JTDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateTimeFormate
        return dateFormatter
    }()
}
extension UIViewController {
    internal func setupBackButton() {
        let img = UIImage(named: "leftArrow")?.withRenderingMode(.alwaysOriginal)
        let leftBtn = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonAction))
        navigationItem.leftBarButtonItem = leftBtn;
    }
    @objc internal func backButtonAction() {
        if let navi = navigationController {
            if navi.viewControllers.first == self {
                navi.dismiss(animated: true, completion: nil)
            } else {
                navi.popViewController(animated: true)
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    internal func JTCheckLoginPresent(vc: UIViewController) {
        let loginC = LoginC()
        if !loginC.hadLoggedin() {
            let sb = UIStoryboard(name: "Login", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LoginNavigationController")
            present(vc, animated: true, completion: nil)
            return
        }
        present(vc, animated: true, completion: nil)
    }
    internal func checkLogin() {
        let loginC = LoginC()
        if !loginC.hadLoggedin() {
            loginC.autoLogin{ [weak self] in
                let sb = UIStoryboard(name: "Login", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "LoginNavigationController")
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    internal func JTTemp_NotOpen() {
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor(red: 220, green: 220, blue: 220)
        HUD.label.text = Messager.shareInstance.notOpen
        HUD.backgroundView.style = .solidColor
        HUD.removeFromSuperViewOnHide = false
        HUD.mode = .text
        HUD.hide(animated: true, afterDelay: 1)
    }
    internal func showProgressHUD(msg: String = "") -> MBProgressHUD {
        let view: UIView
        if let navi = self.navigationController {
            view = navi.view
        } else {
            view = self.view
        }
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.bezelView.color = UIColor.clear
        HUD.label.text = msg
        HUD.backgroundView.style = .blur
        HUD.removeFromSuperViewOnHide = false
        HUD.minShowTime = 1
        HUD.show(animated: true)
        return HUD
    }
    internal func setupTitle(title: String) {
        navigationItem.title = title
    }
}
enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
}
let global_DateTimeFormate = "yyyy-MM-dd HH:mm:ss"
var global_SystemUser: Object_LoginResponseUser?
var global_SystemAllConfig: [Object_GetGroupConfig]?


