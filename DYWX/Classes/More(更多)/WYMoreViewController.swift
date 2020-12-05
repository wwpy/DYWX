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
        let controllers =
            [WYClassifyViewController(),WYRecommendViewController(),WYAllViewController(),WYLOLViewController(),WYDQSViewController(),WYWZRYViewController(),WYQQCarViewController()]
        
        return controllers
    }()
    // 标题 View
    private lazy var pageTitleView: WYPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCateTitleH)
        let option = WYPageOptions()
        option.kGradColors = kGradientColors
        option.kBotLineColor = kWhite
        option.kNormalColor = (220,220,220)
        option.kSelectColor = (250,250,250)
        option.kTitleSelectFontSize = 14
        option.isShowBottomLine = false
        option.kIsShowBottomBorderLine = false
        let pageTitleView = WYPageTitleView(frame: frame, titles: titles, options: option)
        pageTitleView.delegate = self
        
        return pageTitleView
    }()
    // 内容 View
    private lazy var pageContentView: WYPageContentView = {[weak self] in
        let height: CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
        let frame = CGRect(x: 0, y: kCateTitleH, width: kScreenW, height: height)
        
        let contentView = WYPageContentView(frame: frame, childVCs: controllers, parentViewController: self)
        contentView.delegate = self
        
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAllView()
    }

}

// NARK:- 设置UI
extension WYMoreViewController {
    // 设置UI
    private func setUpAllView() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // 不需要调整 scrollview 的内边距
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(statusView)
        // 添加导航栏
        setUpNavigation()
        // 添加标题栏
        setUpPageTitleAndContentView()
    }
    
    private func setUpPageTitleAndContentView() {
        // 添加 TitleView
        view.addSubview(pageTitleView)
        // 添加 COntentView
        view.addSubview(pageContentView)
    }
}

//
extension WYMoreViewController {
    override func rightItemClick() {
        super.rightItemClick()
    }
}

// MARK:- 遵守 PageTitleViewDelegate
extension WYMoreViewController : WYPageTitleViewDelegate, WYPageContentViewDelegate {
    func pageTitleView(titleView: WYPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
    func wy_pageContentView(contentView: WYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
    
}
