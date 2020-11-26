//
//  WYHomeViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYHomeViewController: WYBaseViewController {
    // MARK:- 数据
    private let names: [String] = [
        "我的等级","我的空间","我的粉丝徽章","小姐姐特权","我的积分",
        "游戏中心","我的竞猜","金牌玩家","主播招募","排行榜",
        "我的视频","视频收益","视频收藏","我的账户","免流量特权",
        "关注管理","开播提醒"
    ]
    private let avatar: [String] = [
        "icon_my_level","icon_myzone","icon_fans_badge","icon_little_sister","icon_point",
        "icon_gamecenter","icon_guess","icon_accompany",
        "icon_anchor_recruit","icon_rank_morefrag",
        "icon_my_video","icon_video_income","icon_collection",
        "icon_account","icon_free","icon_focus","icon_remind"
    ]
    private let titles : [[String]] = [["我的等级","我的空间","我的粉丝徽章","小姐姐特权","我的积分"],
                                     ["游戏中心","我的竞猜","金牌玩家"],
                                     ["主播招募","排行榜"],
                                     ["我的视频","视频收益","视频收藏"],
                                     ["我的账户","免流量特权"],
                                     ["关注管理","开播提醒"]]
    private let icons : [[String]] = [["icon_my_level","icon_myzone","icon_fans_badge","icon_little_sister","icon_point"],
                                       ["icon_gamecenter","icon_guess","icon_accompany"],
                                       ["icon_anchor_recruit","icon_rank_morefrag"],
                                       ["icon_my_video","icon_video_income","icon_collection"],
                                       ["icon_account","icon_free"],
                                       ["icon_focus","icon_remind"]]
    // 懒加载控件
    lazy var searchView: WYSearchView = {
       let searchView = WYSearchView()
        searchView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 44)
        searchView.layer.cornerRadius = 5
        searchView.backgroundColor = kSearchBGColor
        
        
        return searchView
    }()
    private lazy var mainTable: UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .grouped)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(WYHomeCell.self, forCellReuseIdentifier: WYHomeCell.identifier())
        mainTable.separatorStyle = .none
        mainTable.estimatedSectionHeaderHeight = 0
        mainTable.estimatedSectionFooterHeight = 0
        mainTable.estimatedRowHeight = 0
        mainTable.backgroundColor = kBGGrayColor
        
        return mainTable
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

extension WYHomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WYHomeCell.identifier(), for: indexPath) as! WYHomeCell
        
        return cell
    }
    
    
}
