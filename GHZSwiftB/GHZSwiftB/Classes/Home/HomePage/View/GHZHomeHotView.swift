//
//  GHZHomeHotView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZHomeHotView: UIView {
    
    private let iconWidth = (GHZScreenWidth - 2 * HotViewMargin) / 4
    private let iconHeight:CGFloat = 80.0
    var clickIcon:((index:Int) -> Void)?
    private var rows: Int = 0
        {
            willSet {
                bounds = CGRect(x: 0, y: 0, width: GHZScreenWidth, height: iconHeight * CGFloat(newValue))
            }
    }
    var headerData :HeadData?
        {
        didSet{
            if self.headerData?.icons?.count > 0
            {
                if (self.headerData?.icons?.count)! % 4 != 0 {
                    self.rows = (self.headerData?.icons?.count)! / 4 + 1
                }else
                {
                    self.rows = (self.headerData?.icons?.count)! / 4
                }
                var iconx: CGFloat = 0
                var icony: CGFloat = 0
                for i in 0..<(self.headerData?.icons?.count)! {
                    iconx = CGFloat(i % 4) * iconWidth + HotViewMargin
                    icony = iconHeight * CGFloat(i / 4)
                    let icon = GHZHomeHotIconImageView(frame: CGRect(x: iconx, y: icony, width: iconWidth, height: iconHeight), placeHolderImage: #imageLiteral(resourceName: "icon_icons_holder"))
                    icon.tag = i
                    icon.model = (self.headerData?.icons?[i])!
                    let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("clickIconImageView:")))
                    icon.addGestureRecognizer(tap)
                    addSubview(icon)
                }
            }
        }
    }
    
    //MARK: 点击了热门按钮
    func clickIconImageView(tap:UITapGestureRecognizer) {
        if clickIcon != nil {
            self.clickIcon!(index:(tap.view?.tag)!)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect , clickIcon:((index:Int) -> Void)) {
        self.init(frame:frame)
        self.clickIcon = clickIcon
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
