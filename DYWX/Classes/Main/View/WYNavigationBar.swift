//
//  WYNavigationBar.swift
//  DYWX
//
//  Created by 王武 on 2020/11/27.
//

import UIKit

class WYNavigationBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
        // 设置背景渐变
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        // 渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        // 渲染的终止位置
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        // 设置frame和插入view的layer
        gradientLayer.frame = frame
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MAKR:- 设置UI视图
extension WYNavigationBar {
    // 设置UI视图
    private func setUpAllView() {
        
    }
}
