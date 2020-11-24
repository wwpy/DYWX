//
//  WYBarButtonItem+Extension.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

extension UIBarButtonItem {
    // 类方法创建UIBarButtonItem
    class func createBarButton(_ normalImageName: String, _ highlightImageName: String, _ size: CGSize) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: normalImageName), for: .normal)
        btn.setImage(UIImage(named: highlightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    // 实例方法创建,便利构造函数: 1.必须使用 convenience 2.在构造函数中必须使用一个设计的构造函数self
    convenience init(normalImageName: String, highlightImageName: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: normalImageName), for: .normal)
        
        if highlightImageName != "" {
            btn.setImage(UIImage(named: highlightImageName), for: .highlighted)
        }
        
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
            btn.sizeToFit()
        }
        
        self.init(customView: btn)
    }
}
