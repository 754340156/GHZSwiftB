//
//  GHZCustomButton.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZCustomButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: 0, y: height - 15, width: width, height: (titleLabel?.height)!)
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect(x: 0, y: 0, width: width, height: height - 15)
        imageView?.contentMode = UIViewContentMode.center
        
    }
}
class ItemLeftButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: -15, y: height - 15, width: width - 15, height: (titleLabel?.height)!)
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect(x: -15, y: 0, width: width - 15, height: height - 15)
        imageView?.contentMode = UIViewContentMode.center
    }
}
class ItemRightButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: 15, y: height - 15, width: width + 15, height: (titleLabel?.height)!)
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect(x: 15, y: 0, width: width + 15, height: height - 15)
        imageView?.contentMode = UIViewContentMode.center
    }
}
class ItemLeftImageButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = bounds
        imageView?.frame.origin.x = -15
        
    }
}
class LeftImageRightTextButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        imageView?.contentMode = UIViewContentMode.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x: 0, y: (height - (imageView?.size.height)!) * 0.5, width: (imageView?.size.width)!, height: (imageView?.size.height)!)
        titleLabel?.frame = CGRect(x: (imageView?.size.width)! + 10, y: 0, width: width - (imageView?.size.width)! - 10, height: height)
    }
}
