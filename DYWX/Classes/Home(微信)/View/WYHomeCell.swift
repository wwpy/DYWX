//
//  WYHomeCell.swift
//  DYWX
//
//  Created by 王武 on 2020/11/26.
//

import UIKit

class WYHomeCell: WYBaseTableCell {

    lazy var icon: UIImageView = UIImageView()
    lazy var titleLab: UILabel = UILabel()
    lazy var descLab: UILabel = UILabel()
    lazy var dateLab: UILabel = UILabel()

    override func wy_initWithView() {
        setUpAllView()
    }
}

// 设置U视图I
extension WYHomeCell {
    private func setUpAllView() {
        self.icon = UIImageView.wy_createImageView(imageName: "icon_myzone", contentMode: nil, supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(15))
            make.width.height.equalTo(Adapt(40))
        })
        self.titleLab = UILabel.wy_createLabel(text: "昵称", textColor: kMainTextColor, font: FontSize(14), supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(Adapt(15))
            make.left.equalTo(self.icon.snp.right).offset(Adapt(15))
        })
        self.descLab = UILabel.wy_createLabel(text: "消息", textColor: kMainTextColor, font: FontSize(12), supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(Adapt(40))
            make.left.equalTo(self.icon.snp.right).offset(Adapt(15))
        })
        self.dateLab = UILabel.wy_createLabel(text: "星期五", textColor: kMainTextColor, font: FontSize(10), supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(Adapt(15))
            make.right.equalTo(Adapt(-15))
//            make.width.equalTo(Adapt(80))
//            make.height.equalTo(Adapt(20))
        })
    }
}
