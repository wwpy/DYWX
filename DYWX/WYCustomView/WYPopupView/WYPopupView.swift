//
//  WYPopupView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/26.
//

import UIKit

enum WYPopupAnimationStyle {
    case WYPopTransition    // 移动
    case WYRotation         // 旋转
    case WYPopupSacle       // 缩放动画
    case WYAlpha            // 渐变
}

class WYPopupView: UIView {
    // MAKE:- 定义属性
    /// 动画样式
    var popupStyle: WYPopupAnimationStyle? = .WYPopupSacle
    /// 自定义 View
    lazy var customView: WYPopupBaseView = {
       let customView = WYPopupBaseView()
        customView.backgroundColor = kWhite
        customView.layer.cornerRadius = 5
        
        return customView
    }()
    /// 是否点击透明背景层隐藏视图，默认为 true
    var isBGClickAction: Bool = true
    /// 动画时间
    var durationTime: Double = 0.25
    /// 背景透明度
    var bgAlpha: CGFloat = 0.5
    /// 视图尺寸
    var cusViewSize: CGSize
    
    // MARK:- 自定义构造函数
    init(size: CGSize, customView: WYPopupBaseView? = nil, style: WYPopupAnimationStyle) {
        cusViewSize = size
        super.init(frame: UIScreen.main.bounds)
        popupStyle = style
        self.isHidden = true
        self.backgroundColor = colorWithRGBA(33, 33, 33, bgAlpha)
        self.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        if customView != nil {
            assert((customView?.isKind(of: WYPopupBaseView.self))!, "customView 必须继承WYPopupBaseView")
            self.customView = customView!
        }
        UIApplication.shared.keyWindow?.addSubview(self)
        // 背景透明层点击事件
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(wy_bgViewTap))
        self.addGestureRecognizer(bgTap)
        // 设置UI和size大小
        setUpAllView(size: size)
        // 背景层点击事件
        // 自定义视图点击事件，默认不做处理
        let cusTap = UITapGestureRecognizer(target: self, action: #selector(wy_cusTap))
        self.customView.addGestureRecognizer(cusTap)
        
        // customView的点击事件，隐藏弹框
        self.customView.cusBlock = { [weak self] in
            print("customView点击事件,隐藏弹窗")
            self?.wy_dissmissPopView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI
extension WYPopupView {
    private func setUpAllView(size: CGSize) {
        self.addSubview(customView)
        
        customView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
    }
}

// MARK:- 遵守协议 WYPopupViewDelegate
extension WYPopupView : WYPopupViewDelegate {
    // 显示弹框
    func wy_showPopView() {
        self.alpha = 0.0
        self.isHidden = false
        
        switch popupStyle {
        case .WYPopTransition?:
            self.customView.transform.concatenating(CGAffineTransform(translationX: 0, y: -(kScreenH-self.cusViewSize.height)/2))
            UIView.animate(withDuration: durationTime) {
                self.alpha = 1.0
                self.customView.transform = self.customView.transform.concatenating(CGAffineTransform(translationX: 0, y: (kScreenH-self.cusViewSize.height)/2+50))
            } completion: { (isSuccess) in
                UIView.animate(withDuration: self.durationTime/2) {
                    self.customView.transform.concatenating(CGAffineTransform(translationX: 0, y: -50))
                }
            }
            break
        case .WYRotation?:
            self.alpha = 1.0
            // 旋转缩放动画使用 CABasicAnimation 基本动画实现
            let scaleAnima = CABasicAnimation(keyPath: "transform.scale")
            // 02 -> 1.0
            scaleAnima.toValue = 1.0
            scaleAnima.fromValue = 0.2
            
            let rotaAnima = CABasicAnimation(keyPath: "transform.rotation.z")
            rotaAnima.toValue = Double.pi * 2
            // 组动画
            let groupAnima = CAAnimationGroup()
            groupAnima.animations = [scaleAnima, rotaAnima]
            groupAnima.duration = durationTime * 2
            // 添加到 layer 上
            self.customView.layer.add(groupAnima, forKey: "groupAnimation")
            break
        case .WYPopupSacle?:
            self.customView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: durationTime) {
                self.alpha = 1.0
                self.customView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            break
        case .WYAlpha?:
            self.customView.alpha = 0.0
            UIView.animate(withDuration: durationTime) {
                self.alpha = 1.0
                self.customView.alpha = 1.0
            }
            break
        default:
            break
        }
    }
    // 隐藏弹框
    @objc func wy_dissmissPopView() {
        switch popupStyle {
        case .WYPopTransition?:
            UIView.animate(withDuration: durationTime) {
                self.alpha = 0.0
                self.customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            } completion: { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            break
        case .WYRotation?:
            
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 0.0
                self.customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            
            break
        case .WYPopupSacle?:
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 0.0
                self.customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            break
        case .WYAlpha?:
            UIView.animate(withDuration: durationTime, animations: {
                self.customView.alpha = 0.0
            }) { (isSccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            break
        default:
            break
        }
    }
}

// MARK:- 操作事件
extension WYPopupView {
    @objc private func wy_bgViewTap() {
        guard isBGClickAction else {
            return
        }
        self.wy_dissmissPopView()
    }
    
    @objc private  func wy_cusTap() {
        
    }
}
