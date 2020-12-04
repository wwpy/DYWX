//
//  WYCarouselCell.swift
//  DYWX
//
//  Created by 王武 on 2020/11/30.
//

import UIKit

class WYCarouselCell: UICollectionViewCell {
    private lazy var imgV: UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = UIColor.lightGray
        
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightText
        
        self.contentView.addSubview(imgV)
        imgV.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configImageNameOrUrl(imgNameOrURL: String) {
        if imgNameOrURL.hasPrefix("http") {
            imgV.wy_setImage(urlStr: imgNameOrURL, placeholder: UIImage(named: ""))
        } else {
            imgV.image = UIImage(named: imgNameOrURL)
        }
    }
}
