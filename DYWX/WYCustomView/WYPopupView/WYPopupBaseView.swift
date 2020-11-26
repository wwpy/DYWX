//
//  WYPopupBaseView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/26.
//

import UIKit

class WYPopupBaseView: UIView {
    // 定义一个无惨无返回值的闭包
    typealias CusHiddenBlock = () -> ()
    var cusBlock: CusHiddenBlock?
    
    // MARK:- 重写构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 回调给 popupView 隐藏视图
    @objc func wy_popupViewhiddenAction() {
        if cusBlock != nil {
            cusBlock!()
        }
    }

}
