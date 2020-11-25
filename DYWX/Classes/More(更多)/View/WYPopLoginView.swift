//
//  WYPopLoginView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/25.
//

import UIKit

protocol WYPopLoginViewDelegate : class {
    func wy_goToLoginVC()
    func wy_goToRegisterVC()
}

class WYPopLoginView: WYBaseView {
    
    weak var delegate: WYPopLoginViewDelegate?
    // MARK:- 定义懒加载属性
    private lazy var bgView : UIView = UIView()
    private lazy var topImgV : UIImageView = UIImageView()
    private lazy var titleLab : UILabel = UILabel()
    private lazy var loginBtn : UIButton = UIButton()
    private lazy var registerBtn : UIButton = UIButton()
    private lazy var descLab : UILabel = UILabel()
    private lazy var otherLab : UILabel = UILabel()
    private lazy var closeBtn : UIButton = UIButton()
    
    private lazy var iconArr: [String] = {
        let iconArr = ["dy_share_to_weixin_normal","dy_share_to_qq_normal","dy_share_to_sina_normal"]
        return iconArr
    }()
    
    // MARK:- 重写
    override func wy_initWithAllView() {
        backgroundColor = colorWithRGBA(33, 33, 33, 0.5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(wy_HiddenLoginView))
        self.addGestureRecognizer(tap)
        self.isHidden = true
        
        setUpAllView()
    }
}

// MARK:- 设置 UI
extension WYPopLoginView {
    // 设置UI
    private func setUpAllView() {
        self.bgView = UIView.wy_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(kScreenW - Adapt(40))
            make.height.equalTo(kScreenH - Adapt(280))
        })
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(bgTapAction))
        self.bgView.addGestureRecognizer(bgTap)
        
        
    }
}

// MARK:- 弹框操作方法
extension WYPopLoginView {
    /// 隐藏弹框
    @objc func wy_HiddenLoginView() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0.0
            self.bgView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        } completion: { (isSuccess) in
            self.isHidden = true
        }
    }
    
    /// 显示弹框
    func wy_showLoginView() {
        self.alpha = 0.0
        self.isHidden = false
        self.bgView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
            self.bgView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    @objc private func bgTapAction() {
        
    }
}
