//
//  WYBaseCarouseCell.swift
//  DYWX
//
//  Created by 王武 on 2020/11/29.
//

import UIKit

class WYBaseCarouselCell: UICollectionViewCell {
    // MAKR:- 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = kWhite
        
        wy_initWithView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func wy_initWithView() {
        
    }
    
}

// MAKR:- 自定义类方法
extension WYBaseCarouselCell {
    public class func itemHeight() -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
    public class func itemHeightWithModel(model: Any) -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
    public class func identifier() -> String {
        let name: AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
    }
}
