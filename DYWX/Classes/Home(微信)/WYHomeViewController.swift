//
//  WYHomeViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYHomeViewController: WYBaseViewController {
    // 懒加载控件
    lazy var searchView: WYSearchView = {
       let searchView = WYSearchView()
        searchView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 44)
        searchView.layer.cornerRadius = 5
        searchView.backgroundColor = kSearchBGColor
        
        
        return searchView
    }()
    
    // MARK:- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI
        setUpAllUIView()
    }

}

// MARK:- 设置UI
extension WYHomeViewController {
    // 设置UI
    private func setUpAllUIView() {
        // 设置状态栏
//        view.addSubview(statusView)
        // 导航栏
        setUpNavigation()
        // 添加搜索栏
        view.addSubview(searchView)
    }
    
    // 重写导航栏
    override func setUpNavigation() {
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 添加右边按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightItemClick))
    }
}
