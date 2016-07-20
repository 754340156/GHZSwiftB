//
//  UIImage+Extension.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit


extension UIImage
{
    //根据颜色生成图片
    class func imageWithColor(color: UIColor, size: CGSize, alpha: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let ref = UIGraphicsGetCurrentContext()
        ref!.setAlpha(alpha)
        ref!.setFillColor(color.cgColor)
        ref!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //把图片会知道view上
    class func createImageFromView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContext(view.bounds.size);
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!
    }
    //画圆
    func imageClipOvalImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ctx!.addEllipse(inRect: rect)
        ctx!.clip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
