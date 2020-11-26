//
//  WYTabBarController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加所有子控制器
        setUpChilds()
        // 设置图片和文字选中时的颜色 必须设置（系统默认选中蓝色）
        self.tabBar.tintColor = UIColor.green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard tabBar.items!.count > 0 else { return }
        
        if tabBar.items![0].title == "微信" {
            tabBar.items![0].badgeValue = "3"
            if #available(iOS 10.0, *) {
                tabBar.items![0].badgeColor = UIColor.red
            } else {
                // todo:
            }
        }
    }

}

// MARK:- 添加tabar控制器
extension WYTabBarController {
    /// 添加所有子控制器
    private func setUpChilds() {
        setUpChild(WYHomeViewController(), "微信", "index", "index-select")
        setUpChild(WYMailViewController(), "通讯录", "mail", "mail-select")
        setUpChild(WYFindViewController(), "发现", "find", "find-select")
        setUpChild(WYMyViewController(), "我", "my", "my-select")
        setUpChild(WYMoreViewController(), "更多", "more", "more-select")
    }
    
    /// 设置子控制器
    private func setUpChild(_ controller: UIViewController, _ title: String, _ normalImage: String, _ selectedImage: String) {
        // 设置导航栏文字
        controller.tabBarItem.title = title
        // 设置选中&未选中图片
        controller.tabBarItem.image = UIImage(named: normalImage)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        // 设置 NavigationController
        let nav = WYNavigationController(rootViewController: controller)
        // 设置导航栏文字
        controller.title = title
        
        self.addChild(nav)
    }
}
