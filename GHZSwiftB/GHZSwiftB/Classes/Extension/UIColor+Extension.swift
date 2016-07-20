//
//  UIColor+Extension.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
extension UIColor
{
    class func customColorWithFloat(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    class func randomColor()-> UIColor {
        return UIColor.customColorWithFloat(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)), a: 1.0)
        
    }
}
