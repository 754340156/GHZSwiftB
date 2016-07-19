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
