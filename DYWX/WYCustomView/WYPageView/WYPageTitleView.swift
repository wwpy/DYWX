//
//  WYPageTitleView.swift
//  DYWX
//
//  Created by 王武 on 2020/12/4.
//

import UIKit

// 代理
protocol WYPageTitleViewDelegate : class {
    func pageTitleView(titleView: WYPageTitleView, selectedIndex index: Int)
}

class WYPageTitleView: UIView {
    // 代理协议
    weak var delegate: WYPageTitleViewDelegate?
    // 滚动 View
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        // 自动滚动最顶端
        scrollView.scrollsToTop = false
        // 下拉弹跳
        scrollView.bounces = false
        
        return scrollView
    }()
    // 底部滚动条
    private lazy var scrollLine: UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = option.kBotLineColor
        
        return scrollLine
    }()
    // 底部的分割线
    private lazy var bottomLine: UIView = {
        let botLine = UIView()
        let botH: CGFloat = 0.5
        botLine.backgroundColor = option.kBottomLineColor
        botLine.frame = CGRect(x: 0, y: frame.height-botH, width: frame.width, height: botH)
        
        return botLine
    }()
    // 页面UI参数
    private lazy var option: WYPageOptions = {
       let option = WYPageOptions()
        
        return option
    }()
    // 创建一个 lable 数组
    private lazy var titleLabs: [UILabel] = [UILabel]()
    // 标题
    private var titles: [String]
    // 索引
    private var currentIndex: Int = 0
    
    // MARK:- 构造函数
    init(frame: CGRect, titles: [String], options: WYPageOptions? = nil) {
        self.titles = titles
        super.init(frame: frame)
        
        if options != nil {
            self.option = options!
        }
        // 配置UI
        setUpAllView()
    }
    
    required init?(coder: NSCoder) {
        self.titles = [String]()
        super.init(coder: coder)
        self.option = WYPageOptions()
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLabelsLayout()
        setupBottomLineLayout()
    }
}

// MARK:- 配置UI
extension WYPageTitleView {
    private func setUpAllView() {
        // 添加 scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加对应的 title
        setUpTitleLabel()
        
        // 设置底线滚动的滑块
        setBottomMenuAndScrollLine()
        
        if option.kGradColors != nil {
            // 设置背景渐变
            let gradientLayer: CAGradientLayer = CAGradientLayer()
            gradientLayer.colors = option.kGradColors
            // 渲染的起始位置
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            // 渲染的终止位置
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
            // 设置frame和插入view的layer
            gradientLayer.frame = bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
        } else {
            scrollView.backgroundColor = option.kScrollViewBGColor
        }
    }
    
    private func setUpTitleLabel() {
        for (index,title) in titles.enumerated() {
            // 创建 label
            let lab = UILabel()
            lab.text = title
            lab.tag = index
            
            lab.font = option.kIsNormalFontBold ? BoldFontSize(option.kTitleFontSize) : FontSize(option.kTitleFontSize)
            lab.textColor = colorWithRGBA(option.kNormalColor.0, option.kNormalColor.1, option.kNormalColor.2, 1.0)
            lab.textAlignment = .center
            // 添加 lab
            scrollView.addSubview(lab)
            titleLabs.append(lab)
            // 添加点击事件
            lab.isUserInteractionEnabled = true // 响应objc_msgSend()消息事件
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLableClick(tapGesture:)))
            lab.addGestureRecognizer(tap)
        }
    }
    
    private func setBottomMenuAndScrollLine() {
        // 添加底部分割线 和 滚动线
        if option.kIsShowBottomBorderLine {
            addSubview(bottomLine)
        }
        // 如果没有就返回
        setUpBottomLine()
        
        guard let firstLab = titleLabs.first else { return }
        firstLab.textColor = colorWithRGBA(option.kSelectColor.0, option.kSelectColor.1, option.kSelectColor.2, 1.0)
        if option.kTitleSelectFontSize != nil {
            firstLab.font = BoldFontSize(option.kTitleSelectFontSize!)
        }
        adjustLabelPosition(firstLab)
    }
    
    func setUpBottomLine() {
        guard option.isShowBottomLine else { return }
        // 添加 srollLine
        scrollView.addSubview(scrollLine)
    }
}

// MARK:- layout
extension WYPageTitleView {
    private func setupLabelsLayout() {
        let labelH = frame.size.height
        let labelY: CGFloat = 0
        var labelW: CGFloat = 0
        var labelX: CGFloat = 0
        
        let count = titleLabs.count
        for (i, titleLabel) in titleLabs.enumerated() {
            if option.isTitleScrollEnable {
                labelW = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: titleLabel.font!], context: nil).width
                labelX = i == 0 ? option.kMarginW * 0.5 : (titleLabs[i-1].frame.maxX + option.kMarginW)
            } else if option.kItemWidth != 0 {
                labelW = option.kItemWidth
                labelX = labelW * CGFloat(i)
            } else {
                labelW = bounds.width / CGFloat(count)
                labelX = labelW * CGFloat(i)
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW+Adapt(10), height: labelH)
        }
        if option.isTitleScrollEnable {
            guard let titleLabel = titleLabs.last else { return }
            scrollView.contentSize.width = titleLabel.frame.maxX + option.kMarginW * 0.5
        }
    }
    
    private func setupBottomLineLayout() {
        guard titleLabs.count - 1 >= currentIndex else { return }
        let label = titleLabs[currentIndex]
        
        scrollLine.frame.origin.x = label.frame.origin.x
        scrollLine.frame.size.width = label.frame.width
        scrollLine.frame.size.height = option.kBotLineHeight
        scrollLine.frame.origin.y = self.bounds.height - option.kBotLineHeight
    }
    
    private func adjustLabelPosition(_ targetLabel: UILabel) {
        guard option.isTitleScrollEnable else { return }
        
        var offsetX =  targetLabel.center.x - bounds.width * 0.5
        
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

// MARK:- 对外暴露的方法
extension WYPageTitleView {
    func setPageTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 取得 label
        let sourceLab = titleLabs[sourceIndex]
        let targetLab = titleLabs[targetIndex]
        
        // 处理滑块
        let movtotalX = targetLab.frame.origin.x - sourceLab.frame.origin.x
        let movX = movtotalX * progress
        scrollLine.frame.origin.x = sourceLab.frame.origin.x + movX
        
        // 颜色的渐变
        // 取出颜色变化的范围
        let colorDelta = (option.kSelectColor.0 - option.kNormalColor.0, option.kSelectColor.1 - option.kNormalColor.1, option.kSelectColor.2 - option.kNormalColor.2)
        // 变化 sourceLab 的文字颜色
        sourceLab.textColor = colorWithRGBA(option.kSelectColor.0 - colorDelta.0 * progress, option.kSelectColor.1 - colorDelta.1 * progress, option.kSelectColor.2 - colorDelta.2 * progress, 1.0)
        // 变化 targetLab 的文字颜色
        targetLab.textColor = colorWithRGBA(option.kNormalColor.0 + colorDelta.0 * progress, option.kNormalColor.1 + colorDelta.1 * progress, option.kNormalColor.2 + colorDelta.2 * progress, 1.0)
        if option.kTitleSelectFontSize != nil {
            sourceLab.font = option.kIsNormalFontBold ? BoldFontSize(option.kTitleSelectFontSize! - (option.kTitleSelectFontSize! - option.kTitleFontSize) * progress) : FontSize(option.kTitleSelectFontSize! - (option.kTitleSelectFontSize! - option.kTitleFontSize) * progress)
            targetLab.font = BoldFontSize (option.kTitleSelectFontSize! + (option.kTitleSelectFontSize! - option.kTitleFontSize)  * progress)
            setupLabelsLayout()
            
            // 底部滚动条滚动
            adjustLabelPosition(targetLab)
            if option.isShowBottomLine {
                let deltaX = targetLab.frame.origin.x - sourceLab.frame.origin.x
                let deltaW = targetLab.frame.width - sourceLab.frame.width
                scrollLine.frame.origin.x = sourceLab.frame.origin.x + progress * deltaX
                scrollLine.frame.size.width = sourceLab.frame.width + progress * deltaW
            }
            // 记录最新的 index
            currentIndex = targetIndex
        }
    }
}

// MARK:- 监听Lable的点击
extension WYPageTitleView {
    @objc fileprivate func titleLableClick(tapGesture: UITapGestureRecognizer) {
        // 如果下标相同，不做处理
        if tapGesture.view?.tag == currentIndex {
            return
        }
        // 获取当前 label 的下标值
        let currentLab = tapGesture.view as? UILabel
        // 获取之前的 label
        let oldLab = titleLabs[currentIndex]
        // 切换文字颜色和字体大小
        currentLab?.textColor = colorWithRGBA(option.kSelectColor.0, option.kSelectColor.1, option.kSelectColor.2,  1.0)
        oldLab.textColor = colorWithRGBA(option.kNormalColor.0, option.kNormalColor.1, option.kNormalColor.2, 1.0)
        // 修改字体大小
        if option.kTitleSelectFontSize != nil {
            currentLab?.font = BoldFontSize(option.kTitleSelectFontSize!)
            oldLab.font = option.kIsNormalFontBold ? BoldFontSize(option.kTitleFontSize) : FontSize(option.kTitleFontSize)
            
            setupLabelsLayout()
        }
        // 保存最新 label 的下标值
        currentIndex = (currentLab?.tag)!
        // 滚动条位置发生改变
        let scrollLineX = CGFloat((currentLab?.tag)!) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        adjustLabelPosition(currentLab!)
        
        if option.isShowBottomLine {
            UIView.animate(withDuration: 0.25) {
                self.scrollLine.frame.origin.x = (currentLab?.frame.origin.x)!
                self.scrollLine.frame.size.width = (currentLab?.frame.width)!
            }
        }
        // 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
