//
//  WYBaseView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/25.
//

import UIKit

class WYBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kWhite
        // 设置UI
        wy_initWithAllView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func wy_initWithAllView() {
        
    }
    
}
