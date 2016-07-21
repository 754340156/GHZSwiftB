//
//  GHZAddressTitleView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZAddressTitleView: UIView {
    
    private let leftLabel = UILabel()
    private let titleLabel = UILabel()
    private let allowBlackImageView = UIImageView(image: #imageLiteral(resourceName: "allowBlack"))
    
    //动态计算宽度
    var addressTitleViewWidth : CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leftLabel.text = "配送至"
        leftLabel.textColor = UIColor.black()
        leftLabel.layer.borderWidth = 0.5
        leftLabel.layer.borderColor = UIColor.black().cgColor
        leftLabel.font = UIFont.systemFont(ofSize: 10)
        leftLabel.sizeToFit()
        leftLabel.textAlignment = NSTextAlignment.center
        leftLabel.frame = CGRect(x: 0, y: (frame.size.height - leftLabel.height - 2) * 0.5, width: leftLabel.frame.size.width + 6, height: leftLabel.frame.size.height + 2)
        addSubview(leftLabel)
        
        
        titleLabel.textColor = UIColor.black()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        if let address = GHZUserInfo.sharedUserInfo.defaultAdress() {
            if address.address?.characters.count > 0 {
                let addressStr = address.address
                if addressStr?.components(separatedBy: " ").count > 1 {
                    titleLabel.text = addressStr?.components(separatedBy: " ")[0]
                }else
                {
                    titleLabel.text = addressStr
                }
                
            }else
            {
                titleLabel.text = "未知区域"
            }
        }else
        {
            titleLabel.text = "未知区域"
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: leftLabel.frame.maxX + 4, y: 0, width: titleLabel.width, height: frame.height)
        addSubview(titleLabel)
        allowBlackImageView.frame = CGRect(x: titleLabel.frame.maxX + 4, y: (frame.size.height - 6) * 0.5, width: 10, height: 6)
        addSubview(allowBlackImageView)
        addressTitleViewWidth = allowBlackImageView.frame.maxX
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(title : String)  {
        let addressStr = title
        if addressStr.components(separatedBy: " ").count > 1 {
            titleLabel.text = addressStr.components(separatedBy: " ")[0]
        }else
        {
            titleLabel.text = addressStr
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: leftLabel.frame.maxX + 4, y: 0, width: titleLabel.width, height: frame.height)
        allowBlackImageView.frame = CGRect(x: titleLabel.frame.maxX + 4, y: (frame.size.height - allowBlackImageView.height) * 0.5, width: allowBlackImageView.width, height: allowBlackImageView.height)
        addressTitleViewWidth = allowBlackImageView.frame.maxX
        
    }
    
}
