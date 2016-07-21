//
//  GHZLoadProgressView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
//加动画
class GHZLoadProgressView: UIView {
    //加载进度条的宽度
    var ProgressViewWidth: CGFloat = 0
    override var  frame: CGRect
    {
        willSet{
            if self.frame.size.width == ProgressViewWidth {
                self.isHidden = true
            }
            super.frame = frame
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ProgressViewWidth = frame.size.width
        backgroundColor = GHZNavigationYellowColor
        self.frame.size.width = 0
    }
    //MARK: 开始加载进度条
    func startLoadProgressView()  {
        self.frame.size.width = 0
        isHidden = false
        weak var weakSelf = self
        UIView.animate(withDuration: 0.4, animations: { 
            weakSelf?.frame.size.width = (weakSelf?.ProgressViewWidth)! * 0.6
            }) { (finish) in
                if finish
                {
                    let time = DispatchTime.now() + Double(Int64(0.4 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.after(when: time, execute: {
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            weakSelf!.frame.size.width = weakSelf!.ProgressViewWidth * 0.8
                        })
                    })
                }
        }
    }
    //MARK: 结束加载进度条
    func endLoadProgressView()  {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.2, animations: { 
            weakSelf?.frame.size.width = (weakSelf?.ProgressViewWidth)!
            }) { (finish) in
              weakSelf?.isHidden = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
