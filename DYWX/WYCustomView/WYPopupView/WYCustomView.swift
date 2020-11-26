//
//  WYCustomView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/26.
//

import UIKit

class WYCustomView: WYPopupBaseView {

    // MARK:- 重写构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        self.layer.cornerRadius = 5
        let btn = UIButton.wy_createButton(title: "自定义弹框,点击关闭", titleStatu: .normal, imageName: nil, imageStatu: nil, supView: self) { (make) in
            make.center.equalTo(self.snp.center)
        }
        // 添加 wy_popupViewhiddenAction 事件, 点击隐藏视图
        btn.addTarget(self, action: #selector(wy_popupViewhiddenAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
