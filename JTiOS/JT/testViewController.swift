//
//  testViewController.swift
//  JTiOS
//
//  Created by JT on 2018/1/25.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 50, y: 50, width: 30, height: 30))
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(x), for: .touchUpInside)
        view.addSubview(btn)

    }
    
    @objc func x() {
        backButtonAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let url = URL(string: "http://39.104.66.207:10064/EMSWeb/api/file/preview/2/94?filename=20180123175515_97f76fc9bfb6f171.jpeg")
        guard let u = url else { return }
        if let x = try? Foundation.Data.init(contentsOf: u) {
            if let img = UIImage(data: x) {
                let i = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
                i.image = img
                view.addSubview(i)
            }
        }
    }
 

}
