//
//  WYHomeViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYHomeViewController: WYBaseViewController {
    
    // 懒加载控件
    private lazy var searchView: WYSearchView = {
       let searchView = WYSearchView()
        searchView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(44))
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
        // 导航栏
        setUpNavigation()
        // 配置UI视图
        setUpAllView()
    }
    
    // 重写导航栏
    override func setUpNavigation() {
        self.title = "微信(3)"
        self.tabBarItem.title = "微信"
        self.tabBarItem.badgeValue = "3"
        self.tabBarItem.badgeColor = kRed
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 添加右边按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightItemClick))
    }
}

// MAKR:- 配置UI视图
extension WYHomeViewController {
    private func setUpAllView() {
//        view.addSubview(searchView)
        // 添加tableView
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
//        mainTable.tableHeaderView = searchView
    }
}

extension WYHomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WYHomeCell.identifier(), for: indexPath) as! WYHomeCell
        cell.titleLab.text = "昵称\(indexPath.row)"
        
        cell.selectionStyle = .default
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Adapt(50)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = kBGGrayColor
        
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTable.deselectRow(at: indexPath, animated: true)
    }
    
}
