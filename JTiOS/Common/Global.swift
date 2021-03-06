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
    func containsCaseInsensitive(other: String) -> Bool {
        return self.range(of: other, options: .caseInsensitive, range: nil, locale: nil) != nil
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
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateTimeFormate
        return dateFormatter
    }()
    static var JTDateFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateFormate
        return dateFormatter
    }()
}
extension UIViewController {
    internal func setupBackButton() {
        let img = UIImage(named: "leftArrow")?.withRenderingMode(.alwaysOriginal)
        if let _ = navigationController {
            let leftBtn = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonAction))
            navigationItem.leftBarButtonItem = leftBtn;
        } else {
            let backBtn = UIButton(frame: CGRect(x: 15, y: 25, width: 80, height: 80))
            backBtn.setImage(img, for: .normal)
            backBtn.contentVerticalAlignment = .top
            backBtn.contentHorizontalAlignment = .left
            backBtn.addTarget(self, action: #selector(backButtonAction), for: UIControlEvents.touchUpInside)
            view.addSubview(backBtn)
        }
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
enum FileTypenum: Int {
    case HeadPortrait = 1
    case Event = 2
    case Task = 3
    case Deal = 4
}
enum ImagePrefix: String {
    case Origin = ""
    case Minimum = "m"      // 80 * 80
    case HeadProtrait = "l" //180 * 180
}
var global_TodayStartDate: Date? = {
    let date = Date()
    let cal = Calendar.current
    var dateComponents = cal.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    dateComponents.hour = 0
    dateComponents.minute = 0
    dateComponents.second = 0
    return cal.date(from: dateComponents)
}()
let global_DateTimeFormate = "yyyy-MM-dd HH:mm:ss"
let global_DateFormate = "yyyyMMdd"
var global_SystemUser: Object_LoginResponseUser?
var global_SystemAllConfig: [Object_GetGroupConfig]?
var global_TestAPISuccess: Bool = false {
    didSet {
        if !global_TestAPISuccess {
            global_SystemUser = nil
            guard let cookies = HTTPCookieStorage.shared.cookies else { return }
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
}


