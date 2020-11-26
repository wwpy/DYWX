//
//  WYAlertController.swift
//  DYWX
//
//  Created by 王武 on 2020/11/26.
//

import UIKit

class WYAlertController {
    /// 弹框
    static func wy_showAlertView(currentController: UIViewController, title: String, message: String
                                 , confirmTitle: String, cancelTitle: String,
                                 confirmHandle: @escaping (UIAlertAction) -> Void, cancelHandle: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // 取消按钮
        let cancel = UIAlertAction(title: cancelTitle, style: .default) { (action) in
            cancelHandle(action)
        }
        // 确定按钮
        let confirm = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirmHandle(action)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        currentController.present(alert, animated: true, completion: nil)
    }
    ///
    static func wy_showSheetView(currentController: UIViewController, title: String, message: String, actionArray: [String],
                                 confirmTitle:String, cancelTitle: String,
                                 actionHandle: @escaping (UIAlertAction) -> Void, cancelHandle: @escaping (UIAlertAction) -> Void) {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionArray.forEach { (item) in
            let action = UIAlertAction(title: item, style: .default) { (action) in
                actionHandle(action)
            }
            sheet.addAction(action)
        }
        // 取消按钮
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelHandle(action)
        }
        sheet.addAction(cancel)
        
        currentController.present(sheet, animated: true, completion: nil)
    }
}
