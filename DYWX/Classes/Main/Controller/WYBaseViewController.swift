//
//  WYBaseViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYBaseViewController: UIViewController {
    // MARK:- 懒加载属性
    /// 状态栏的背景色
    lazy var statusView: UIView = {
       let view = UIView()
        view.backgroundColor = kMainOrangeColor
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kStatuHeight)
        // 设置背景渐变
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        // 渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        // 渲染的终止位置
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        // 设置frame和插入view的layer
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return view
    }()

    // MARK：- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = kWhite
        automaticallyAdjustsScrollViewInsets = true
    }
    
}

// MARK:- 配置 NavigationBar
extension WYBaseViewController {
    @objc func setUpNavigation() {
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // 左边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_user_normal"), style: .done, target: self, action: #selector(self.leftItemClick))
        // 右边的按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "viewHistoryIcon"), style: .done, target: self, action: #selector(self.rightItemClick))
        
        let searchView = WYMoreSearchView()
        searchView.layer.cornerRadius = 5
        searchView.backgroundColor = kSearchBGColor
        navigationItem.titleView = searchView
        searchView.snp.makeConstraints { (make) in
            make.center.equalTo((navigationItem.titleView?.snp.center)!)
            make.width.equalTo((AdaptW(230)))
            make.height.equalTo(33)
        }
    }
    
    @objc func leftItemClick() {
        self.navigationController?.pushViewController(WYProfileViewController(), animated: true)
    }
    
    @objc func rightItemClick() {
        // WYPopupView 自定义视图
        let customView = WYCustomView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let popView = WYPopupView(size: CGSize(width: 250, height: 200), customView: customView, style: .WYPopTransition)
        
        popView.wy_showPopView()
    }
}
