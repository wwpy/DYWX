//
//  WYMoreViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

// 是否隐藏导航栏
private var isNavHidden : Bool = false

class WYMoreViewController: WYBaseViewController {
    // 标题数组
    private lazy var titles : [String] = ["分类","推荐","全部","LOL","绝地求生","王者荣耀","QQ飞车"]
    // 控制器数组
    private lazy var controllers: [UIViewController] = {
        let controllers = [UIViewController]()
        
        return controllers
    }()

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
