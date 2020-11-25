//
//  WYLoginViewController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/25.
//

import UIKit
import RxSwift

class WYLoginViewController: WYBaseViewController {
    private lazy var bag: DisposeBag = DisposeBag()
    private lazy var loginView: WYLoginView = {
        let loginView = WYLoginView(frame: CGRect.zero, viewType: WYLoginType.WYLogin)
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
