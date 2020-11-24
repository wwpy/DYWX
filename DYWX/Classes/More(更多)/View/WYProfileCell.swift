//
//  WYProfileCell.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYProfileCell: WYBaseTableCell {

    // MARK:- 懒加载属性
    lazy var icon: UIImageView = UIImageView()
    lazy var titleTab: UILabel = UILabel()
    private lazy var arroeIcon: UIImageView = UIImageView()
    private lazy var detailLab: UILabel = UILabel()
    
    override func wy_initWithView() {
        setUpAllView()
    }

}

// MAEK:- 设置UI
extension WYProfileCell {
    private func setUpAllView() {
        self.icon = UIImageView.wy_createImageView(imageName: "icon_accompany", supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(15))
            make.width.height.equalTo(Adapt(22))
        })
        
        self.titleTab = UILabel.wy_createLabel(text: "标题", textColor: kMainTextColor, font: FontSize(14), supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.icon.snp.right).offset(Adapt(15))
        })
        
        self.arroeIcon = UIImageView.wy_createImageView(imageName: "im_arrow_right", supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(Adapt(-15))
            make.width.equalTo(Adapt(6))
            make.height.equalTo(Adapt(10))
        })
        
        self.detailLab = UILabel.wy_createLabel(text: "副标题", textColor: kGrayTextColor, font: FontSize(12), supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.arroeIcon.snp.left).offset(Adapt(-15))
        })
    }
}
