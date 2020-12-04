//
//  WYPageOptions.swift
//  DYWX
//
//  Created by 王武 on 2020/11/29.
//

import UIKit

public class WYPageOptions {
    // 选项宽度
    public var kItemWidth: CGFloat = 40
    // 定义颜色 默认为选中颜色 (red,green,blue)
    public var kNormalColor: (CGFloat, CGFloat, CGFloat) = (99, 99, 99)
    // 选中选颜色
    public var kSelectColor: (CGFloat, CGFloat, CGFloat) = (200, 33, 33)
    // label间距
    public var kMarginW: CGFloat = Adapt(20)
    // 是否允许标题滚动
    public var isTitleScrollEnable: Bool = true
    // 底部滚动线的高度
    public var kBottomLineHeight: CGFloat = 3
    // 默认字体的Font大小
    public var kTitleFontSize: CGFloat = 13
    // 默认文字是否加粗
    public var kIsNormalFontBold: Bool = false
    // 选中的文本Font大小
    public var kTitleSelectFontSize: CGFloat? = nil
    // 底部滚动线的颜色
    public var kBotLineColor: UIColor = UIColor.orange
    // 是否显示滚动线
    public var isShowBottomLine: Bool = true
    // scrollView 的背景颜色
    public var kScrollViewBGColor: UIColor = kWhite
    // scrollView 的背景渐变色
    public var kGradColors: [CGColor]? = nil
    // 是否显示底部的分割线
    public var kIsShowBottomBorderLine: Bool = true
    // 底部分割线的颜色
    public var kBottomLineColor: UIColor = UIColor.gray
}
