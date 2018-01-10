//
//  JTTabbar.swift
//  JTiOS
//
//  Created by JT on 2017/12/19.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class JTTabbar: UIView {
    
    class Config {
        var text: String = ""
        var image: UIImage?
        var tap: (()->())?
        var backgroundColor: UIColor = UIColor.white
        var titleColor: UIColor = UIColor.black
    }
    
    private var configs: [Config]
    init(config: [Config], width: Int, height: Int){
        configs = config
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JTTabbar {
    
    private func setupUI(){
        let count = configs.count
        let W = frame.width/CGFloat(count)
        let H = frame.height
        for (index,config) in configs.enumerated(){
            let btn = UIButton(type: .system)
            btn.tag = index
            btn.setTitle(config.text, for: .normal)
            btn.backgroundColor = config.backgroundColor
            btn.setTitleColor(config.titleColor, for: .normal)
            
            if let i = config.image {
                btn.setImage(i, for: .normal)
            }
            btn.adjustsImageWhenDisabled = false
            btn.adjustsImageWhenHighlighted = false
            let x = CGFloat(index) * W
            btn.frame = CGRect(x: x, y: 0, width: W, height: H)
            btn.titleLabel?.lineBreakMode = .byCharWrapping
            self.addSubview(btn)
            btn.addTarget(self, action: #selector(self.buttonClick(btn:)), for: .touchUpInside)
        }
    }

    @objc private func buttonClick(btn : UIButton){
        let btnIndex = btn.tag
        if let tap = configs[btnIndex].tap {
            tap();
        }
    }

}
