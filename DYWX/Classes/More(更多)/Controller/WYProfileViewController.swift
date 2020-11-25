//
//  WYProfileViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYProfileViewController: WYBaseViewController {
    // MARK:- 定义属性
    private let titles: [[String]] = [["我的等级","我的空间","我的粉丝徽章","小姐姐特权","我的积分"],
                                      ["游戏中心","我的竞猜","金牌玩家"],
                                      ["主播招募","排行榜"],
                                      ["我的视频","视频收益","视频收藏"],
                                      ["我的账户","免流量特权"],
                                      ["关注管理","开播提醒"]]
    private let icons: [[String]] =
        [["icon_my_level","icon_myzone","icon_fans_badge","icon_little_sister","icon_point"],
                                           ["icon_gamecenter","icon_guess","icon_accompany"],
                                           ["icon_anchor_recruit","icon_rank_morefrag"],
                                           ["icon_my_video","icon_video_income","icon_collection"],
                                           ["icon_account","icon_free"],
                                           ["icon_focus","icon_remind"]]
    // 头部视图
    private lazy var headerView: WYProfileHeadView = {
       let headeView = WYProfileHeadView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(240)))
        headeView.delegate = self
        
        return headeView
    }()
    // 登录弹框
    private lazy var loginView: WYPopLoginView = {
        let loginView = WYPopLoginView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
        loginView.delegate = self
        
        return loginView
    }()
    // 主
    private lazy var mainTable: UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .grouped)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(WYProfileCell.self, forCellReuseIdentifier: WYProfileCell.identifier())
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

        setUpAllView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK:- 设置UI
extension WYProfileViewController {
    fileprivate func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        mainTable.tableHeaderView = headerView
    }
}

// MARK:- 遵守协议 UITableViewDelegate & UITableViewDataSource
extension WYProfileViewController : UITableViewDelegate, UITableViewDataSource {
    /// 节的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
    }
    /// 每个节的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles[section].count
    }
    /// cell 设置内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WYProfileCell.identifier(), for: indexPath) as! WYProfileCell
        
        cell.icon.image = UIImage(named: self.icons[indexPath.section][indexPath.row])
        cell.titleTab.text = self.titles[indexPath.section][indexPath.row]
        cell.selectionStyle = .default
        
        return cell
    }
    /// 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Adapt(50)
    }
    /// 选中操作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTable.deselectRow(at: indexPath, animated: true)
    }
    /// 先执行heightForHeaderInSection，再执行viewForHeaderInSection 先执行高度，再执行视图
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(10)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = kBGGrayColor
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
// MARK:- 遵守协议 WYProfileHeadViewDelegate
extension WYProfileViewController : WYProfileHeadViewDelegate {
    func wy_loginBtnAction(sender: UIButton) {
        UIApplication.shared.keyWindow?.addSubview(self.loginView)
        self.loginView.wy_showLoginView()
    }
}
// MARK:- 遵守协议 ZJPopLoginViewDelegate
extension WYProfileViewController : WYPopLoginViewDelegate {
    func wy_goToLoginVC() {
//        let nav = WYNavigationController(rootViewController: WYLoginViewController())
//        self.present(nav, animated: true, completion: nil)
    }
    
    func wy_goToRegisterVC() {
//        let nav = WYNavigationController(rootViewController: WYRegisterViewController())
//        self.present(nav, animated: true, completion: nil)
    }
}
