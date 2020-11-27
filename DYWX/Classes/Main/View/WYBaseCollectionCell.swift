//
//  WYBaseCollectionCell.swift
//  DYWX
//
//  Created by 王武 on 2020/11/27.
//

import UIKit

class WYBaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = kWhite
        
        wy_initWithView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MAKE:- 初始化视图
extension WYBaseCollectionCell {
    public func wy_initWithView() {
        
    }
}

// MAKE:- 自定义类方法
extension WYBaseCollectionCell {
    public class func itemHeight() -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    public class func itemHeightWithModel(model: Any) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    public class func idenifier() -> String {
        let name: AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
    }
}
