//
//  WYBaseTableCell.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

class WYBaseTableCell: UITableViewCell {
    
    // MARK:- 自定义构造函数
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .none
        self.contentView.backgroundColor = kWhite
        
        wy_initWithView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 配置子控件
    public func wy_initWithView(){
        
    }
    
    // MARK:- 系统函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// 自定义类方法
extension WYBaseTableCell {
    public class func cellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public class func cellHeightWithModel(model: Any) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public class func identifier() -> String {
        let name: AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
    }
}
