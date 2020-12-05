//
//  WYPageContentView.swift
//  DYWX
//
//  Created by 王武 on 2020/12/4.
//

import UIKit

protocol WYPageContentViewDelegate : class {
    func wy_pageContentView(contentView: WYPageContentView,
                            progress: CGFloat,
                            sourceIndex: Int,
                            targetIndex: Int)
}
/// 自定义数据源协议，必须实现wy_pageControlViewDataSource
@objc protocol WYPageControlViewDataSource : class {
    @objc func wy_pageControlViewDataSource(contentView: WYPageContentView, cellForItemAt indexPath: IndexPath) -> WYBasePageControlCell
}

private let ContentCellID = "ContentCellID"

class WYPageContentView: UIView {

    // 代理协议
    weak var delegate: WYPageContentViewDelegate?
    // 自定义数据源协议
    weak var dataSource: WYPageControlViewDataSource?
    // 禁止点击的时候走代理的方法
    private var isForbidScrollDelegate: Bool = false
    // 控制器数组
    private var childVCs: [UIViewController]
    // 父控制器 weak 修饰，防止循环引用
    private weak var parentViewController: UIViewController?
    // 滑动偏移量
    private var startOffsetX: CGFloat = 0
    
    // MARK:- 懒加载属性
    private lazy var layout: UICollectionViewFlowLayout = {
        // 创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    // collectionView 容器
    private lazy var collectionView: UICollectionView = { [weak self] in
        // 创建 UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = kWhite
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // MARK:- 构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshCollectionView(height: CGFloat) {
        collectionView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
        layout.itemSize = collectionView.frame.size
    }
}

// MARK:- 设置UI
extension WYPageContentView {
    private func setUpView() {
        // 将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            self.parentViewController?.addChild(childVC)
        }
        // 添加 UICollectionView 存放子控制器的 View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 遵守协议
extension WYPageContentView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dataSource != nil {
            // 自定义 cell 继承 WYBasePageControlCell
            let item = dataSource?.wy_pageControlViewDataSource(contentView: self, cellForItemAt: indexPath)
            return item!
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        cell.backgroundColor = kWhite
        
        return cell
    }
    
    // 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 记录是否需要禁止执行的代理方法
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 判断是点击事件还是滑动，点击事件不走下面的计算，滑动走下面的计算
        if isForbidScrollDelegate {
            return
        }
        // 获取需要的数据资源
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算 progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 2.计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 3.计算 targetIndex
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            // 4.完全划过去 progress = 1
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {
            // 1.计算 progress
            progress = 1  - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            // 2.计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            // 3.计算 sourceIndex
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVCs.count  {
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.wy_pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension WYPageContentView {
    // 切换控制器
    func setCurrentIndex(currentIndex: Int) {
        // 记录是否需要禁止执行的代理方法
        isForbidScrollDelegate = true
        // 滚到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
