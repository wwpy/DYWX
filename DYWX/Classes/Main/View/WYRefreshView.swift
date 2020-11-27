//
//  WYRefreshView.swift
//  DYWX
//
//  Created by 王武 on 2020/11/27.
//

import UIKit
import ESPullToRefresh

class WYRefreshView: WYBaseView {
    // MAKR:- 定义属性
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var duration: TimeInterval = 0.5
    public var trigger: CGFloat = 56.0
    public var executeIncremental: CGFloat = 56.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "img_mj_statePulling")
        
        return imageView
    }()

    override func wy_initWithAllView() {
        addSubview(imageView)
    }
}

// MAKE:- 遵守协议 ESRefreshProtocol ESRefreshAnimatorProtocol
extension WYRefreshView : ESRefreshProtocol, ESRefreshAnimatorProtocol {
    func refreshAnimationBegin(view: ESRefreshComponent) {
        imageView.center = self.center
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
            self.imageView.frame = CGRect(x: (self.bounds.size.width - 100.0) / 2.0, y: self.bounds.size.height - 50.0, width: 100.0, height: 50.0)
        } completion: { (finushed) in
            var images = [UIImage]()
            for idx in 0...19 {
                let imgName = String(format: "img_mj_stateRefreshing_%03d", idx)
                if let aImage = UIImage(named: imgName) {
                    images.append(aImage)
                }
            }
            self.imageView.animationDuration = 0.6
            self.imageView.animationRepeatCount = 0
            self.imageView.animationImages = images
            self.imageView.startAnimating()
        }

    }
    
    func refreshAnimationEnd(view: ESRefreshComponent) {
        imageView.stopAnimating()
        imageView.image = UIImage(named: "img_mj_statePulling")
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
            self.refresh(view: view, progressDidChange: 0.0)
        } completion: { (finished) in
            
        }
    }
    
    func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let p = max(0.0, min(1.0, progress))
        imageView.frame = CGRect(x: (self.bounds.size.width - 100.0) / 2.0, y: self.bounds.size.height - 50.0 * p, width: 100.0, height: 50.0 * p)
    }
    
    func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else { return }
        self.state = state
        
        switch state {
        case .pullToRefresh:
            var images = [UIImage]()
            for idx in 0...19 {
                let imgName = String(format: "img_mj_stateRefreshing_%03d", idx)
                if let aImage = UIImage(named: imgName) {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.6
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage(named: "img_mj_statePulling")
            imageView.startAnimating()
            break
        case .releaseToRefresh:
            var images = [UIImage]()
            for idx in 0...19 {
                let imgName = String(format: "img_mj_stateRefreshing_%03d", idx)
                if let aImage = UIImage(named: imgName) {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.6
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage(named: "img_mj_statePulling")
            imageView.startAnimating()
            
        default:
            break
        }
    }
    
}
