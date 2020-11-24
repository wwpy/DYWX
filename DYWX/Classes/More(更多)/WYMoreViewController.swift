//
//  WYMoreViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYMoreViewController: WYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAllView()
    }

}

// NARK:- 设置UI
extension WYMoreViewController {
    // 设置UI
    fileprivate func setUpAllView() {
        view.addSubview(statusView)
        // 添加导航栏
        setUpNavigation()
    }
}
