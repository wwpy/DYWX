//
//  WYNavigationController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true // 跳转之后隐藏
        }
        
        super.pushViewController(viewController, animated: true)
    }

}
