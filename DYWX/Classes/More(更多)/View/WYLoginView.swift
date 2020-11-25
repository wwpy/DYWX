//
//  WYLoginView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/25.
//

import UIKit
import RxSwift

enum WYLoginType {
    case WYLogin
    case WYRegister
}

private let mobileNumLength = 11
private let minPwdLength = 6

class WYLoginView: WYBaseView {

    var type: WYLoginType? = .WYLogin
    
    // 地区
    private lazy var areaView: UIView = UIView()
    private lazy var areaLab: UILabel = UILabel()
    private lazy var areaImgV: UIImageView = UIImageView()
    private lazy var areaNameLab: UILabel = UILabel()
    // 手机
    private lazy var mobileView: UIView = UIView()
    private lazy var mobileBtn: UIButton = UIButton()
    private lazy var mobileTF: UITextField = UITextField()
    private lazy var mobileValid : UILabel = UILabel()
    // 密码
    private lazy var pwdView : UIView = UIView()
    private lazy var pwdImgV : UIImageView = UIImageView()
    private lazy var pwdTF : UITextField = UITextField()
    private lazy var pwdValid : UILabel = UILabel()
    // 验证码
    private lazy var codeView : UIView = UIView()
    private lazy var codeImgV : UIImageView = UIImageView()
    private lazy var codeTF : UITextField = UITextField()
    private lazy var codeBtn : UIButton = UIButton()
    
    // 登录或注册按钮
    lazy var actionBtn: UIButton = UIButton()
    // 忘记密码按钮
    private lazy var forgetBtn: UIButton = UIButton()
    // 验证码登录按钮
    private lazy var codeLoginBtn: UIButton = UIButton()
    // 快速注册按钮
    private lazy var quickRegisterBtn : UIButton = UIButton()
    // 马上登录按钮
    private lazy var nowLoginBtn : UIButton = UIButton()

    private lazy var bag : DisposeBag = DisposeBag()
    
    // MARK:- 自定义初始化方法
    init(frame: CGRect, viewType: WYLoginType) {
        self.type = viewType
        super.init(frame: frame)
        
        // 设置UI
        setUpAllView()
        // textfield 的验证
        textFieldvalid()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI
extension WYLoginView {
    // 设置UI
    private func setUpAllView() {
        backgroundColor = kBGGrayColor
        
        areaView = UIView.wy_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.left.equalTo(Adapt(20))
            make.right.equalTo(Adapt(-20))
            make.top.equalTo(Adapt(20))
            make.height.equalTo(Adapt(40))
        })
        areaView.layer.cornerRadius = 5
    }
}

// MARK: 操作方法
extension WYLoginView {
    // textfield 的验证
    private func textFieldvalid() {
        // 获取输入手机号的状态
//        let mobileLengValid = mobileTF.rx.base.text?
//            .map { $0.hashValue == mobileNumLength }
            
            
    }
}
