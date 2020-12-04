//
//  WYCarouselView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/29.
//

import UIKit

public enum WYPageControlPosition {
    case center
    case left
    case right
}

/// Style
public enum WYPageControlStyle {
    case none       // 不显示 PageControl
    case system     // 系统样式
    case image      // 图片样式
}

@objc protocol WYCarouselViewDelegate {
    // 选中事件
    @objc optional func wy_carouseView(_ carouseView: WYCarouselView, didSelectedItemIndex didSeltedIndex: NSInteger)
    // 滚动事件
    @objc optional func wy_carouseView(_ carouseView: WYCarouselView, scrollTo scrollIndex: NSInteger)
}

/// 自定义数据源协议，必须实现 wy_carouseViewDataScoure 方法
@objc protocol WYCarouseViewDataScoure {
    /// 自定义数据源方法
    ///
    /// - Parameters:
    ///   - contentView: CollectionView
    ///   - indexPath:  索引 indexPath
    /// - Returns:  继承ZJBaseCarouselCell的cell
    @objc func wy_carouseViewDataScoure(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> WYBaseCarouseCell
}

class WYCarouselView: UIView {

    /// 图片地址或名称
    var imageNameOrURL: [String] = []{
        didSet {
            self.datas = imageNameOrURL as [AnyObject]
        }
    }
    var dataArray: [AnyObject] = []{
        didSet {
            let array = dataArray
            self.datas = array as [AnyObject]
            
            if datas.count > 1 && isAutoScroll && isInfiniteLoop {
                startTimer()
            }
        }
    }
    var datas: [AnyObject] = []{
        didSet {
            allItemCount = isInfiniteLoop ? datas.count * 10 : datas.count
            // 图片大于一张允许滚动，小于一张禁止滚动
//            collectionView
        }
    }
    // 时间选择器
    private var timer: Timer!
    
    /// 代理
    weak var delegae: WYCarouselViewDelegate?
    /// 自定义数据源协议
    weak var dataScoure: WYCarouseViewDataScoure?
    /// Item 总数量
    private var allItemCount: NSInteger! = 1
    
    /// 自动滚动 默认开启
    var isAutoScroll: Bool = true {
        didSet {
            cancelTimer()
            // 如果关闭无限循环，则不进行计时器的操作，否则每次滚动到最后一张就不在进行了
            if isAutoScroll && isInfiniteLoop {
                startTimer()
            }
        }
    }
    /// 滚动间隔时间，默认2秒
    var autoScrollTimeInterval: Double = 2.0 {
        didSet {
            // 开启自动滚动
            isAutoScroll = true
        }
    }
    // 最大伸展空间(防止出现问题，可外部设置)，用于反向滑动的时候，需要知道最大的contentSize
    private var maxSwipeSize: CGFloat = 0
    // 占位图
    var placeHolderViewImage: UIImage! = UIImage(named: "")
    // 是否开启无限循环，默认 true 开启
    var isInfiniteLoop: Bool = true
    // 滚动方向，默认为水平方向
    var scrollDirection: UICollectionView.ScrollDirection? = .horizontal {
        didSet {
            layout.scrollDirection = scrollDirection!
            if scrollDirection == .horizontal {
                position = .centeredHorizontally
            } else {
                position = .centeredVertically
            }
        }
    }
    // Collection滚动方向
    var position: UICollectionView.ScrollPosition = .centeredHorizontally
    /// UICollectionViewFlowout
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    // cell 的标识符 ID
    private let kIdentifier: String = "WYCarouselCell"
    // UICollectionView
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = kWhite
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(WYBaseCarouseCell.self, forCellWithReuseIdentifier: WYBaseCarouseCell.identifier())
        collectionView.register(WYCarouselCell.self, forCellWithReuseIdentifier: kIdentifier)
        
        return collectionView
    }()
    /// 自定义 UICollectionCell 继承 WYBaseCarouselCell
    var customCellClass: WYBaseCarouselCell.Type = WYBaseCarouselCell.self {
        didSet {
            collectionView.register(customCellClass, forCellWithReuseIdentifier: customCellClass.identifier())
        }
    }
    
    // MAKR:- pageControl
    private var pageControl: UIPageControl?
    /// pageControl 样式，默认为系统样式
    var pageStyle: WYPageControlStyle = .system
    /// pageControl 高度，默认为  10
    var pageControlHeight: CGFloat = 10
    /// pageControlTintColor 默认颜色
    var pageControlTintColor: UIColor = UIColor.lightGray
    /// pageControlCurrentPageColor 滚动到的索引点颜色
    var pageControlCurrentPageColor: UIColor = UIColor.red
    /// pageControlPosition
    var pageControlPosition: ZJPageControlPosition = .center
    /// 默认图片
    var pageControlNormalImage: UIImage? = nil
    /// 滚到到的图片
    var pageControlCurrentImage: UIImage? = nil
    /// pageControl 图片的宽
    var pageControlImageVWidth : CGFloat? = 10
    /// pageControl 图片的高
    var pageControlImageVHeight: CGFloat? = 0
    /// pageControl 图片的圆角大小
    var pageControlImageVCornerRadius : CGFloat? = 0
    
    /// Bottom 距离底边的距离
    var pageControlBottom: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 自定义 PageControlView
    var customPageControl: UIView?
    
    
}

// MAKR:- UICollectionView
extension WYCarouselView {
    
}

// MAKR: 定时器
extension WYCarouselView {
    // 开启定时器
    private func startTimer() {
        
    }
    // 取消定时器
    private func cancelTimer() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
}

// MAKR:- 遵守UICollectionViewDelegate,UICollectionViewDataSource协议与数据源
extension WYCarouselView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItemCount == 0 ? 1 : allItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dataSource != nil {
            // 自定义数据源协议
            guard datas.count > 0 else {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: WYBaseCarouselCell.identifier(), for: indexPath)
                return item
            }
        }
    }
    
    
}
