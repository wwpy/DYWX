//
//  WYHomeCell.swift
//  DYWX
//
//  Created by 王武 on 2020/11/26.
//

import UIKit

class WYHomeCell: WYBaseTableCell {

    private lazy var icon: UIImageView = UIImageView()
    private lazy var titleLab: UILabel = UILabel()
    private lazy var descLab: UILabel = UILabel()
    private lazy var dateLab: UILabel = UILabel()

    override func wy_initWithView() {
        setUpAllView()
    }
}

// 设置U视图I
extension WYHomeCell {
    private func setUpAllView() {
        self.icon = UIImageView.wy_createImageView(imageName: "icon_accompany", contentMode: nil, supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(15))
            make.width.height.equalTo(Adapt(22))
        })
    }
}
