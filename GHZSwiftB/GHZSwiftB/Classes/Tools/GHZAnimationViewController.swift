//
//  GHZAnimationViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//  设置添加到购物车的动画

import UIKit

class GHZAnimationViewController: GHZBaseViewController {

    
    var animationLayerArray :Array<CALayer>?
    var animationBigLayerArray :Array <CALayer>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     func addProductsAnimation(_ imageView:UIImageView)
    {
        if animationLayerArray == nil {
            animationLayerArray = Array()
        }
        let frame = imageView.convert(imageView.bounds, to: imageView)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        view.layer.addSublayer(transitionLayer)
        animationLayerArray?.append(transitionLayer)
        
        let p1 = transitionLayer.position
        let p3 = CGPoint(x: view.width * 5 / 8 - 6, y: self.view.layer.bounds.size.height - 40)
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath();
        path.moveTo(nil, x: p1.x, y: p1.y);
        path.addCurve(nil, cp1x: p1.x, cp1y: p1.y - 30, cp2x: p3.x, cp2y: p1.y - 30, endingAtX: p3.x, y: p3.y);
        positionAnimation.path = path;
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D:CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self;
        transitionLayer.add(groupAnimation, forKey: "cartParabola")
        
    }
    
    // MARK: - 添加商品到右下角购物车动画
    func addProductsToBigShopCarAnimation(imageView: UIImageView) {
        if animationBigLayerArray == nil {
            animationBigLayerArray = [CALayer]()
        }
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(transitionLayer)
        self.animationBigLayerArray?.append(transitionLayer)
        
        let p1 = transitionLayer.position;
        let p3 = CGPoint(x: view.width - 40, y:
            self.view.layer.bounds.size.height - 40);
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath();
        path.moveTo(nil, x: p1.x, y: p1.y);
        path.addCurve(nil, cp1x: p1.x, cp1y: p1.y - 30, cp2x: p3.x, cp2y: p1.y - 30, endingAtX: p3.x, y: p3.y);
        positionAnimation.path = path;
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D:CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self;
        
        transitionLayer.add(groupAnimation, forKey: "BigShopCarAnimation")
    }
    override func animationDidStop(_ anim : CAAnimation, finished flag : Bool)
    {
        if self.animationLayerArray?.count > 0 {
            let transitionLayer = animationLayerArray![0]
            transitionLayer.isHidden = true
            transitionLayer.removeFromSuperlayer()
            animationLayerArray?.removeFirst()
            view.layer.removeAnimation(forKey: "cartParabola")
        }
        if self.animationBigLayerArray?.count > 0 {
            let transitionLayer = animationBigLayerArray![0]
            transitionLayer.isHidden = true
            transitionLayer.removeFromSuperlayer()
            animationBigLayerArray?.removeFirst()
            view.layer.removeAnimation(forKey: "BigShopCarAnimation")
            
        }
    }
    
    
    
    
    
    
    
}
