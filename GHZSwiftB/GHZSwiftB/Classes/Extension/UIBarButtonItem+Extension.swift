//
//  UIBarButtonItem+Extension.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
enum ItemButtonType: Int {
    case Left = 0
    case Right = 1
}
extension UIBarButtonItem
{
    class func barButton(title: String , titleColor: UIColor , image: UIImage , highLightImage: UIImage ,target: AnyObject , action: Selector , type: ItemButtonType) -> UIBarButtonItem {
        var button = UIButton()
        if type == ItemButtonType.Left {
            button = ItemLeftButton(type: UIButtonType.custom)
        }else
        {
            button = ItemRightButton(type: UIButtonType.custom)
        }
        
        button.setImage(image, for: UIControlState())
        button.setTitle(title, for: UIControlState())
        button.setImage(highLightImage, for: UIControlState.highlighted)
        button.setTitleColor(titleColor, for: UIControlState())
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return UIBarButtonItem(customView: button)
    }
    class func barButton (image: UIImage , target:AnyObject , action:Selector) -> UIBarButtonItem{
        let button = ItemLeftImageButton(type: .custom)
        button.setImage(image, for: UIControlState())
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        button.imageView?.contentMode = UIViewContentMode.center
        return UIBarButtonItem(customView: button)
    }
    class func barButton (title: String , titleColor: UIColor , targer: AnyObject , action: Selector ) -> UIBarButtonItem
    {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(titleColor, for: UIControlState())
        button.addTarget(targer, action: action, for: UIControlEvents.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if title.characters.count == 2 {
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
        }
        return UIBarButtonItem(customView: button)
    }

}



