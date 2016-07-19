//
//  GHZHomeHotIconImageView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZHomeHotIconImageView: UIView {

    private var imageView:UIImageView?
    private var label:UILabel?
    private var placeHolderImage:UIImage?
    var model: Activities?{
        didSet{
            label?.text = model?.name
            imageView?.sd_setImage(with: URL(string: (model?.img!)!), placeholderImage: placeHolderImage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.isUserInteractionEnabled = false
        imageView?.contentMode = UIViewContentMode.center
        addSubview(imageView!)
        label = UILabel()
        label?.textAlignment = NSTextAlignment.center
        label?.font = UIFont.systemFont(ofSize: 12)
        label?.textColor = UIColor.black()
        label?.isUserInteractionEnabled = false
        addSubview(label!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 5, y: 5, width: width - 15, height: height - 30)
        label?.frame = CGRect(x: 5, y: height - 25, width: (imageView?.width)!, height: 20)
    }
    convenience init(frame: CGRect ,placeHolderImage:UIImage) {
        self.init(frame:frame)
        self.placeHolderImage = placeHolderImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
